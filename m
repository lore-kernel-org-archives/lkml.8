Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A73C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E852206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPWSSTXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ui2A5+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgGANdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbgGANdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A880C08C5DC;
        Wed,  1 Jul 2020 06:33:18 -0700 (PDT)
Date:   Wed, 01 Jul 2020 13:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593610395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYp0fsYwx46bcChLn02U2uuM+hLz6G0PqagZOiJL7Vs=;
        b=rPWSSTXQcMLR+EeUu6ltNt96ItLDtLcuS22nzXuGPA2Tmgq06Vaqt7rLTS8StUpCx6kf1R
        gknZf1RHwwrCyIXu7bGjbvKy7qmJEgKsg3BYV26/IOYRPACW3w1G436Gj9tqMvAXqCHq/W
        DUs2dBesGppMb8uyUdT3PiLcIpprW6Key1Et5Qk4bvbvChSTRj49aB1DtJ7fURLRZDSrh3
        Pvzcb6CiKHRhW/s47k24/urK3Kwvk06uMw+XQLm/0I6hpkppcmmK1AhI+eqd3X0pjYdC9N
        JVffgCykrc9b8oBy8BtkARTtlTOrWq63UxzqQUu93mJnybp5xhAxb/hP4YCGvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593610395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYp0fsYwx46bcChLn02U2uuM+hLz6G0PqagZOiJL7Vs=;
        b=7ui2A5+Jbqz/+0IXeFMWQ7aAuMTbV2a/NJQtRcnVSzBPoFsm+/u1Dj+C9p6w2cOfMlLNxq
        5YB9B4fdyQjWkQDA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/fsgsbase: Fix Xen PV support
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
References: <f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159361039503.4006.17824211510339513520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     d029bff60aa6c7eab281d52602b6a7a971615324
Gitweb:        https://git.kernel.org/tip/d029bff60aa6c7eab281d52602b6a7a971615324
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:24:30 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 15:27:20 +02:00

x86/fsgsbase: Fix Xen PV support

On Xen PV, SWAPGS doesn't work.  Teach __rdfsbase_inactive() and
__wrgsbase_inactive() to use rdmsrl()/wrmsrl() on Xen PV.  The Xen
pvop code will understand this and issue the correct hypercalls.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/f07c08f178fe9711915862b656722a207cd52c28.1593192140.git.luto@kernel.org

---
 arch/x86/kernel/process_64.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cb8e37d..e14476f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -163,9 +163,15 @@ static noinstr unsigned long __rdgsbase_inactive(void)
 
 	lockdep_assert_irqs_disabled();
 
-	native_swapgs();
-	gsbase = rdgsbase();
-	native_swapgs();
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		gsbase = rdgsbase();
+		native_swapgs();
+	} else {
+		instrumentation_begin();
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		instrumentation_end();
+	}
 
 	return gsbase;
 }
@@ -182,9 +188,15 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
 {
 	lockdep_assert_irqs_disabled();
 
-	native_swapgs();
-	wrgsbase(gsbase);
-	native_swapgs();
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		wrgsbase(gsbase);
+		native_swapgs();
+	} else {
+		instrumentation_begin();
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		instrumentation_end();
+	}
 }
 
 /*
