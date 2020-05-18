Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CD920674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824007;
	bh=0ASyik1bakUhJoWujJbdgcwUggN/kSU0IrhuWHkjudE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvdmHjhO8Cs74ahGR5Eg92cuy/Gs67v52T21loUYC/qHMTIXNtbUdvhvHCrSaorJj
	 2i1IP3mThhiBxgkwwfUpK8FGgYTrGOVNISBZ1Scpa5mpYtUbaO6XkTPJb1uUmx6pBe
	 IvLPXtaVq+W1D1LLbDS1u+of6JNvvXQs0Nvtr2U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgERRqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgERRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3C920674;
        Mon, 18 May 2020 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823999;
        bh=0ASyik1bakUhJoWujJbdgcwUggN/kSU0IrhuWHkjudE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcAB0eZ4W6pM8EKBcqivNSR+gW1qFdwkxxaLfmJXT5Q75IvaIlQYtz6Ao8BajiNQK
         pFtpjBIcZB+SQmYYRjbdJwK/q9t7eipAThKmUfLxqDbrEZlOqQZBsIuVq3U76N1hcR
         BqN8ixkSmb/E+99+DZ6IiFyC+SfHy/emaz3bOuGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Jann Horn <jannh@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH 4.14 030/114] x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
Date:   Mon, 18 May 2020 19:36:02 +0200
Message-Id: <20200518173509.213180999@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

commit f977df7b7ca45a4ac4b66d30a8931d0434c394b1 upstream.

The LEAQ instruction in rewind_stack_do_exit() moves the stack pointer
directly below the pt_regs at the top of the task stack before calling
do_exit(). Tell the unwinder to expect pt_regs.

Fixes: 8c1f75587a18 ("x86/entry/64: Add unwind hint annotations")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/68c33e17ae5963854916a46f522624f8e1d264f2.1587808742.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1649,7 +1649,7 @@ ENTRY(rewind_stack_do_exit)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
-	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
+	UNWIND_HINT_REGS
 
 	call	do_exit
 END(rewind_stack_do_exit)


