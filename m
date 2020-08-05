Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DC8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2632F2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/ZPtDUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHEVID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:08:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8EC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:08:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so25394226pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emsoU0j9Bl5DmKGC3Jly3v8Cf8b0+9+ogMOi2z5kCao=;
        b=i/ZPtDUCWZAIAdcwQvrCvN2Un3k+q0ErDtw6lGd2cPk/VYIqEiospgkVHOsFOE+W2g
         Mxlv/xM8nBJFoIwg2VKuH/PL1U98P47K/pOm2JUKY5sKfwRUDuu1kwv4ZfYV4EeZ2Vnd
         RoM4ADJ0VwjJeNid9DFEIWVeLMgBSsPjaIxqFrx/mJUsmYNW0gBJc9hzbAUjAeiwxmlN
         6QiBy05CjddBo2llCvwkEAPE3vpR/JaoUkTbN1kAbZpuBoFxWYK1gD0M4yMxRwOlHHK1
         4QKH+ydHflipvPtnDx3hk/1iUjQbdfnyFdn2onNFD6hP1DsyIdyKTTbHut+Tum8YFhJd
         ujSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emsoU0j9Bl5DmKGC3Jly3v8Cf8b0+9+ogMOi2z5kCao=;
        b=LDOMY1rumvxYPnq0EArDzFa6sChy9tfCQUT5K4rQ8+1TezreX13nj3ZZWWSJ+/00qB
         kD0QNA8sVHR7/smnXwD0zFvo99T4otcbcTmEm0e6A8Ey+CzG32QAVV4rtatIjl+BQpiM
         /XvFl1QFN9nfTexP6Z0cRPRfpBO6sgx7ChQY1tar0Rn/CMXqlSDVszbcSTkPkPGbWs2N
         RTPtEdl6wMxrErHLSejQVRAG/scqAk/AJonvRUe6x232Tr3hsMUW1VKZDGtJb32pvVCd
         qDbLzBY7PplmVlqf3T3dtbh0MK+odnsooXvTZjGSOvee86TYGU5snSanDmOjdpFejk7q
         sM/Q==
X-Gm-Message-State: AOAM533O9xXqV7oYJK9bJc5S0tYr3x8SlQlFptJazNZ26lh7f5qha2qk
        Chqt11Tmqn7ZjPoxt9WSoi7Xvj9M
X-Google-Smtp-Source: ABdhPJy1xsCpFS3hKHUyrJ+cvVJjJfKNHUdhY20ixjiZffmi1XNvMG8r1Yzyb+ynM6EAYJqjV1/dZg==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr4527559pgv.436.1596661680036;
        Wed, 05 Aug 2020 14:08:00 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id t17sm4370665pgu.30.2020.08.05.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:59 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 5/6] openrisc: signal: Fix sparse address space warnings
Date:   Thu,  6 Aug 2020 06:07:24 +0900
Message-Id: <20200805210725.310301-6-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __user annotations in signal.c were mostly missing.  The missing
annotations caused the warnings listed below.  This patch fixes them up
by adding the __user annotations.

arch/openrisc/kernel/signal.c:71:38: warning: incorrect type in initializer (different address spaces)
arch/openrisc/kernel/signal.c:71:38:    expected struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:71:38:    got struct rt_sigframe [noderef] __user *
arch/openrisc/kernel/signal.c:82:14: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:82:14:    expected void const volatile [noderef] __user *
arch/openrisc/kernel/signal.c:82:14:    got struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:84:37: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:84:37:    expected void const [noderef] __user *from
arch/openrisc/kernel/signal.c:84:37:    got struct sigset_t *
arch/openrisc/kernel/signal.c:89:39: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:89:39:    expected struct sigcontext [noderef] __user *sc
arch/openrisc/kernel/signal.c:89:39:    got struct sigcontext *
arch/openrisc/kernel/signal.c:92:31: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:92:31:    expected struct sigaltstack const [noderef] [usertype] __user *
arch/openrisc/kernel/signal.c:92:31:    got struct sigaltstack *
arch/openrisc/kernel/signal.c:158:15: warning: incorrect type in assignment (different address spaces)
arch/openrisc/kernel/signal.c:158:15:    expected struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:158:15:    got void [noderef] __user *
arch/openrisc/kernel/signal.c:160:14: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:160:14:    expected void const volatile [noderef] __user *
arch/openrisc/kernel/signal.c:160:14:    got struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:165:46: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:165:46:    expected struct siginfo [noderef] [usertype] __user *to
arch/openrisc/kernel/signal.c:165:46:    got struct siginfo *
arch/openrisc/kernel/signal.c:170:33: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:170:33:    expected struct sigaltstack [noderef] [usertype] __user *
arch/openrisc/kernel/signal.c:170:33:    got struct sigaltstack *
arch/openrisc/kernel/signal.c:171:40: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:171:40:    expected struct sigcontext [noderef] __user *sc
arch/openrisc/kernel/signal.c:171:40:    got struct sigcontext *
arch/openrisc/kernel/signal.c:173:32: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:173:32:    expected void [noderef] __user *to
arch/openrisc/kernel/signal.c:173:32:    got struct sigset_t *

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4f0754874d78..7ce0728412f6 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -68,7 +68,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 
 asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
 {
-	struct rt_sigframe *frame = (struct rt_sigframe __user *)regs->sp;
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)regs->sp;
 	sigset_t set;
 
 	/*
@@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
 	 * then frame should be dword aligned here.  If it's
 	 * not, then the user is trying to mess with us.
 	 */
-	if (((long)frame) & 3)
+	if (((__force unsigned long)frame) & 3)
 		goto badframe;
 
 	if (!access_ok(frame, sizeof(*frame)))
@@ -151,7 +151,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
-	struct rt_sigframe *frame;
+	struct rt_sigframe __user *frame;
 	unsigned long return_ip;
 	int err = 0;
 
@@ -181,10 +181,10 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		l.ori r11,r0,__NR_sigreturn
 		l.sys 1
 	 */
-	err |= __put_user(0xa960,             (short *)(frame->retcode + 0));
-	err |= __put_user(__NR_rt_sigreturn,  (short *)(frame->retcode + 2));
-	err |= __put_user(0x20000001, (unsigned long *)(frame->retcode + 4));
-	err |= __put_user(0x15000000, (unsigned long *)(frame->retcode + 8));
+	err |= __put_user(0xa960,             (short __user *)(frame->retcode + 0));
+	err |= __put_user(__NR_rt_sigreturn,  (short __user *)(frame->retcode + 2));
+	err |= __put_user(0x20000001, (unsigned long __user *)(frame->retcode + 4));
+	err |= __put_user(0x15000000, (unsigned long __user *)(frame->retcode + 8));
 
 	if (err)
 		return -EFAULT;
-- 
2.26.2

