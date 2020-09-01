Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E542C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCCA20866
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIAJQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:16:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:43991 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgIAJQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:16:57 -0400
IronPort-SDR: zrGLjmyPgckUoXn88l/bZVn14Cr5dlIayoGO5fjPXxNj3F5kkVAWMMN6eFBL4GjoVOToFpdLqG
 oPiZHkR9ZbAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144822918"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="144822918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 02:16:56 -0700
IronPort-SDR: Oz1m7qzTotfs0rTVoLBMxMajC8WpaVm2W+PN5ACwHrBpXuZ47pQlLayhVgtMcESdrVo6YKUvGx
 DO3qptCGP9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="283343284"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2020 02:16:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     peterz@infradead.org, rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, mbenes@suse.cz,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix missing synchronize_rcu() removing trampoline from kallsyms
Date:   Tue,  1 Sep 2020 12:16:17 +0300
Message-Id: <20200901091617.31837-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add synchronize_rcu() after list_del_rcu() in
ftrace_remove_trampoline_from_kallsyms() to protect readers of
ftrace_ops_trampoline_list (in ftrace_get_trampoline_kallsym)
which is used when kallsyms is read.

Fixes: fc0ea795f53c8d ("ftrace: Add symbols for ftrace trampolines")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 275441254bb5..4e64367c9774 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
 {
 	lockdep_assert_held(&ftrace_lock);
 	list_del_rcu(&ops->list);
+	synchronize_rcu();
 }
 
 /*
-- 
2.17.1

