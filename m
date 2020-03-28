Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA76C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D762082E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1LGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:06:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgC1LGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9I9-0003tF-Qo; Sat, 28 Mar 2020 12:06:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 760DF1C0470;
        Sat, 28 Mar 2020 12:06:17 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:17 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] generic arch_futex_atomic_op_inuser() doesn't
 need access_ok()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357704.28353.3797286562782090252.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a251b2d513ea4116ddb5487610e4b4048c7aa397
Gitweb:        https://git.kernel.org/tip/a251b2d513ea4116ddb5487610e4b4048c7aa397
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Tue, 18 Feb 2020 12:19:23 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:55 -04:00

generic arch_futex_atomic_op_inuser() doesn't need access_ok()

uses get_user() and put_user() for memory accesses

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-generic/futex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 3eab7ba..f4c3470 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -33,8 +33,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	int oldval, ret;
 	u32 tmp;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
 	preempt_disable();
 
 	ret = -EFAULT;
