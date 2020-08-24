Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A752074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258795;
	bh=2AQn8L2byVDK/1u38HJmyd1CH4K+ROmfP9MbOEZp2rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJzHmQ88xzZ3zlmSTi6gNb8+oJ9Vd6IRnNduzFRvKo1V/j6L3UjVPtwDuhzz33pap
	 dS08TvWWyML3yN8wI8+IDBRiZw2zNJEqPOGgfXXQeYDJ0b+P37BRYnDfJA6YpXjEef
	 PkcNUNGDPN7fKH1eHU3ZVsKTKzvEj2DkZajif85g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHXIqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbgHXIqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:46:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422182075B;
        Mon, 24 Aug 2020 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258780;
        bh=2AQn8L2byVDK/1u38HJmyd1CH4K+ROmfP9MbOEZp2rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2RqR9xFzsI9aO+7oBQMflphAV3Isip/Qm6ZxmFDDxIJIYXPqhtlea89F586MMnc1
         IO70xJjW+nXJty7vXgsCQ2Q4E9JH7uCwQxm/z/+uFO088HqY9rXcNAX+v0HScr6DPr
         /ULT1yb+JfTWR7YNAosfiKA0tabMD+PUb6/pgkxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/107] perf probe: Fix memory leakage when the probe point is not found
Date:   Mon, 24 Aug 2020 10:29:39 +0200
Message-Id: <20200824082405.726152209@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 12d572e785b15bc764e956caaa8a4c846fd15694 ]

Fix the memory leakage in debuginfo__find_trace_events() when the probe
point is not found in the debuginfo. If there is no probe point found in
the debuginfo, debuginfo__find_probes() will NOT return -ENOENT, but 0.

Thus the caller of debuginfo__find_probes() must check the tf.ntevs and
release the allocated memory for the array of struct probe_trace_event.

The current code releases the memory only if the debuginfo__find_probes()
hits an error but not checks tf.ntevs. In the result, the memory allocated
on *tevs are not released if tf.ntevs == 0.

This fixes the memory leakage by checking tf.ntevs == 0 in addition to
ret < 0.

Fixes: ff741783506c ("perf probe: Introduce debuginfo to encapsulate dwarf information")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/159438668346.62703.10887420400718492503.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index dc9d495e3d6ab..849d8d2e5976b 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1362,7 +1362,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	tf.ntevs = 0;
 
 	ret = debuginfo__find_probes(dbg, &tf.pf);
-	if (ret < 0) {
+	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
 		zfree(tevs);
-- 
2.25.1



