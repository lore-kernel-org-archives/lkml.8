Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508C3206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuCbFSda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHHXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86EC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g19so2932563plq.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUClg0Ab3PAbyali4oeRGxLd2RFA9V86+bFEaSSoP8M=;
        b=CuCbFSda2k00D2H+3Z+R8PT84kfgbVCLlRX1YnJ8p771P5IYTMsidR/avBaiql1QGd
         fVXYzw75ID2BHZJ5dxgMMzbKoorKBFGTp9Hijy8WtknZz23Lu6GdbGzWfki5P8PNYcMc
         BWfQNsGJ/qeJjGR0KQ1Qrke7RIh8ZeE0+16PusQk6u51G43w7jr5hnKYTaQQwcxuQnr1
         edoyGd5f4xGTYicVhrsFm7wW8XYBp/LWGvKrQ3bXaUVZiBvHLZQxCV5vkyhcM64qBdEU
         puF3qBGMAf/jjwq42lzcz/mKKBuErPwa660BEGHgnupdLDvSdLzIwMnVpdeabmO0LauE
         PzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUClg0Ab3PAbyali4oeRGxLd2RFA9V86+bFEaSSoP8M=;
        b=RE3EAzmQMGbNFakYWUaiuRbTFkEjjZUqToXCXlFyGkg6BWW3e+Ni2cy3xnegbAtazx
         DFUHR2xNutsXAJQBEkzbErcoj42NRhKK3ld8XzN5Bi0dC4UO2DeA7RBfSGDG27A39nKG
         kzyI4veh5A7utFs/8Fi1OBWlRXts9NXsRXcKApbRg19B7wmV145/n4WADAXNLyJhn7nv
         KN0Jd7aY9H6UXK5HMOzqq71+gkp1Mg6aZ2sq2f/G5nz6wdCSwwz0/KpiJ8lr9J0GV9pi
         shThlo4S3y5Av8+6NA+PIU4ESd32VJQBGV8LFMmPkHxFy1U0DjT0xGFeNU+f71vcFBv/
         TwFQ==
X-Gm-Message-State: AOAM533lnMkAR+saN0pGFOLSygUyGyToSUP/jWaDZtd+gxrza7A2i2gW
        8b1sXYKinJ8irV0IbObiejYuL73W
X-Google-Smtp-Source: ABdhPJznLA/fpRtrAm+qFhG2P2/pkoj7aAK9w08KqxK1aSNxBkVliD6R49ubIAmsqje0RC7RsnZ4DA==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr17486186plb.297.1596928035836;
        Sat, 08 Aug 2020 16:07:15 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id f17sm17651595pfq.67.2020.08.08.16.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:07:15 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 5/6] openrisc: signal: Fix sparse address space warnings
Date:   Sun,  9 Aug 2020 08:06:46 +0900
Message-Id: <20200808230647.833047-6-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
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
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Changes since v2:
 - Remove __force in cast suggested by Luc Van Oostenryck

 arch/openrisc/kernel/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4f0754874d78..97804f21a40c 100644
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
+	if (((unsigned long)frame) & 3)
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

