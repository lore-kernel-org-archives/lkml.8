Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6778B20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465031;
	bh=AviOQAwt76TQyzxVk0GuHDNspXCn0OKJCjcTl6g8b68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYQvKNylkvILXQsTAk4kASCLK0XrDo9a56hZoGG23ppT25FKjhGHkxzj940TN2EU2
	 T/aWgeP2r332Z8d9+aFqPfIm0TMWEj0IpVk3H8SuTF8503TPYM7rNHUBhk0R8NhkRY
	 1sRB9GMUepzDKRfv4N8EuDiAnKW4Mn9kubs3l+yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbgF2VKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729899AbgF2TAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24598254FA;
        Mon, 29 Jun 2020 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446057;
        bh=AviOQAwt76TQyzxVk0GuHDNspXCn0OKJCjcTl6g8b68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbLGvdMQVWQmf2FxZYT8A04xbHTPVxLmeUnDRWb9zP6Ri6PGK8TMbibOxv1PO+Ln2
         2GCvEhdYdjoOBwBazZI8rNSBxgiffizbp/0+VimNL/Zqi66KBzoRtTnA4d6HSx45nA
         H2GL5g2PZuprdwh45YqivxJWtdjBt6fAanmqZ1Ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gaurav Singh <gaurav1086@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 057/135] perf report: Fix NULL pointer dereference in hists__fprintf_nr_sample_events()
Date:   Mon, 29 Jun 2020 11:51:51 -0400
Message-Id: <20200629155309.2495516-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Singh <gaurav1086@gmail.com>

[ Upstream commit 11b6e5482e178055ec1f2444b55f2518713809d1 ]

The 'evname' variable can be NULL, as it is checked a few lines back,
check it before using.

Fixes: 9e207ddfa207 ("perf report: Show call graph from reference events")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f256fac1e7225..74dd196acdac3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -334,8 +334,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	if (evname != NULL)
 		ret += fprintf(fp, " of event '%s'", evname);
 
-	if (symbol_conf.show_ref_callgraph &&
-	    strstr(evname, "call-graph=no")) {
+	if (symbol_conf.show_ref_callgraph && evname && strstr(evname, "call-graph=no")) {
 		ret += fprintf(fp, ", show reference callgraph");
 	}
 
-- 
2.25.1

