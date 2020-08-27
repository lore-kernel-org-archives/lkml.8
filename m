Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A76F20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x1wTFYtm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DfhyC5qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgH0H40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgH0Hy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB39C061233;
        Thu, 27 Aug 2020 00:54:28 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muwxljKPcH7yFUrgGdQBS4yosChBDD0Ci9MC+fydsx4=;
        b=x1wTFYtmLeej9R/WP6RnV4WBeGtVWdBcPGwD1iViHM7n3RNtfP33cFGCzNMcqb4R5BeGjI
        2hBNPTmQI+qluYRrpxV4LWB+92vOy5IuWAhWaRNhqIOrYIU0i5PPdm+fsY7EiKYqt/IC30
        qAfQ0qWZU/CfUH74ng6EQY5Db9u18qpjzpMD7o+Bu65RO+wvH/biNU+UZxakBKdfej2SpV
        UMLAMrg7mGvpTq25UZeqhF3rI4cf4OJzfp/zE/Ri7663f1iSw//gGZMkduUwtkoUvATUFw
        VOHmcwomisnT7dTOB+9FlDm4pTOGJU5QruwpDo6Rhf4ozEdDkyZf8+pDeNVYmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muwxljKPcH7yFUrgGdQBS4yosChBDD0Ci9MC+fydsx4=;
        b=DfhyC5qQn2bZIvojBG82YPw5DNrFcM+GBDW/2d9SVlCy5A9fGqt6zaXd6pg+y9uUWcLm1k
        CO6QOBm5pvtACnCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/entry: Remove unused THUNKs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.487040689@infradead.org>
References: <20200821085348.487040689@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486683.20229.8545737026225498617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7da93f379330f2be1122ca7f54ab1eb44ef9aa59
Gitweb:        https://git.kernel.org/tip/7da93f379330f2be1122ca7f54ab1eb44ef9aa59
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Aug 2020 19:28:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:54 +02:00

x86/entry: Remove unused THUNKs

Unused remnants

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.487040689@infradead.org
---
 arch/x86/entry/thunk_32.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 3a07ce3..f1f96d4 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,11 +29,6 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
