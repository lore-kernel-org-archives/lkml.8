Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE424685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685899;
	bh=m8ipr9+0MDwOb4v+qrzFhrfPIvmXiJ/RP17Uky4V/LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjYo89SrQEkLZDcG5rXrSPY+MrBCB0UrC0U+bwFAAtQz2B/haO9NjQKoghQty/Ycn
	 wtDg0hbAEtmVVzK4msfo1rpEwNV72Fa0HisbTgtoatDMt+HWcIV2/0isBtJ0swLSdh
	 4E9TX3xSjAEwSa204VtiCn9vBap7JMccNrPoLCvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgAVJiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732891AbgAVJiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:38:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5E124686;
        Wed, 22 Jan 2020 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685894;
        bh=m8ipr9+0MDwOb4v+qrzFhrfPIvmXiJ/RP17Uky4V/LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMCLzQbEHOwzSdH6eMBPViYeqQdrLzz9QA0fzj00rchtdxbq2Hobidql/q8fPoqh7
         ndhsyjPzgPWGlNn+qG0EUkQ//Gc5F1N4M2OA1LXMFL1TraS/eAh/3ywHIpxX24t7xd
         mHrnEBmzAIpbh4wi9hEbAn0V8PfJ5gzdAUXiTuuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.14 25/65] perf report: Fix incorrectly added dimensions as switch perf data file
Date:   Wed, 22 Jan 2020 10:29:10 +0100
Message-Id: <20200122092754.455714615@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

commit 0feba17bd7ee3b7e03d141f119049dcc23efa94e upstream.

We observed an issue that was some extra columns displayed after switching
perf data file in browser. The steps to reproduce:

1. perf record -a -e cycles,instructions -- sleep 3
2. perf report --group
3. In browser, we use hotkey 's' to switch to another perf.data
4. Now in browser, the extra columns 'Self' and 'Children' are displayed.

The issue is setup_sorting() executed again after repeat path, so dimensions
are added again.

This patch checks the last key returned from __cmd_report(). If it's
K_SWITCH_INPUT_DATA, skips the setup_sorting().

Fixes: ad0de0971b7f ("perf report: Enable the runtime switching of perf data file")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191220013722.20592-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-report.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -742,6 +742,7 @@ int cmd_report(int argc, const char **ar
 	struct stat st;
 	bool has_br_stack = false;
 	int branch_mode = -1;
+	int last_key = 0;
 	bool branch_call_mode = false;
 	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
 	const char * const report_usage[] = {
@@ -1048,7 +1049,8 @@ repeat:
 	else
 		use_browser = 0;
 
-	if (setup_sorting(session->evlist) < 0) {
+	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
 		if (field_order)
@@ -1108,6 +1110,7 @@ repeat:
 	ret = __cmd_report(&report);
 	if (ret == K_SWITCH_INPUT_DATA) {
 		perf_session__delete(session);
+		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
 	} else
 		ret = 0;


