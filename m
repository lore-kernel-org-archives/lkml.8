Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F617C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456CE2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824182;
	bh=2qitLLezr2UjIB2vLsXLPOmzr97R3cyIBcTQTL+j+xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dw5xQ/k1kCfNihEc52X234Hc4Lrn06XA6lv1L8Opy/r+ZnyAez8bhaVMv4KwP6Z3Y
	 GmFGMsvvmg99tVOOKRYUg3M00lOfWlcva/ZYqKIt1mMmR1QizrH4f2b4zt1T7LYjT3
	 Pp1+zk2TyXmMrQ4b3NmdTXf8s5ypGV78Md3unR48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgERRth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgERRtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C976320657;
        Mon, 18 May 2020 17:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824175;
        bh=2qitLLezr2UjIB2vLsXLPOmzr97R3cyIBcTQTL+j+xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWy+gCZjG3l6rxBk16FAhpGhMdDVSxOBU6OG46qFOydY55ySdf0nJVqLZCA8krNoB
         ofNX+fCnJegvFYMG/1t5VHD+G//qRSmD0Le4zqVRUlu9jL+LJvWjrVw0BJw1TvfexO
         BULywGBYUPKGUtgsgbE0DAp12SUJtifKNfgqZVCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4.14 101/114] x86/unwind/orc: Fix error handling in __unwind_start()
Date:   Mon, 18 May 2020 19:37:13 +0200
Message-Id: <20200518173519.747046062@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 71c95825289f585014fe9741b051d32a7a916680 upstream.

The unwind_state 'error' field is used to inform the reliable unwinding
code that the stack trace can't be trusted.  Set this field for all
errors in __unwind_start().

Also, move the zeroing out of the unwind_state struct to before the ORC
table initialization check, to prevent the caller from reading
uninitialized data if the ORC table is corrupted.

Fixes: af085d9084b4 ("stacktrace/x86: add function for detecting reliable stack traces")
Fixes: d3a09104018c ("x86/unwinder/orc: Dont bail on stack overflow")
Fixes: 98d0c8ebf77e ("x86/unwind/orc: Prevent unwinding before ORC initialization")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/unwind_orc.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -505,23 +505,23 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
-	if (!orc_init)
-		goto done;
-
 	memset(state, 0, sizeof(*state));
 	state->task = task;
 
+	if (!orc_init)
+		goto err;
+
 	/*
 	 * Refuse to unwind the stack of a task while it's executing on another
 	 * CPU.  This check is racy, but that's ok: the unwinder has other
 	 * checks to prevent it from going off the rails.
 	 */
 	if (task_on_another_cpu(task))
-		goto done;
+		goto err;
 
 	if (regs) {
 		if (user_mode(regs))
-			goto done;
+			goto the_end;
 
 		state->ip = regs->ip;
 		state->sp = kernel_stack_pointer(regs);
@@ -554,6 +554,7 @@ void __unwind_start(struct unwind_state
 		 * generate some kind of backtrace if this happens.
 		 */
 		void *next_page = (void *)PAGE_ALIGN((unsigned long)state->sp);
+		state->error = true;
 		if (get_stack_info(next_page, state->task, &state->stack_info,
 				   &state->stack_mask))
 			return;
@@ -579,8 +580,9 @@ void __unwind_start(struct unwind_state
 
 	return;
 
-done:
+err:
+	state->error = true;
+the_end:
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
-	return;
 }
 EXPORT_SYMBOL_GPL(__unwind_start);


