Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DABC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587E624670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgANTt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:49:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44693 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgANTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBO-0005ZC-VQ; Tue, 14 Jan 2020 20:48:59 +0100
Message-Id: <20200114185946.656652824@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:38 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [patch 01/15] lib/vdso: Make __arch_update_vdso_data() logic understandable
References: <20200114185237.273005683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name suggests that this is a boolean checking whether the
architecture asks for an update of the VDSO data, but it works the other
way round. To spare further confusion invert the logic.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h |    4 ++--
 include/asm-generic/vdso/vsyscall.h  |    4 ++--
 kernel/time/vsyscall.c               |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -34,9 +34,9 @@ struct vdso_data *__arm_get_k_vdso_data(
 #define __arch_get_k_vdso_data __arm_get_k_vdso_data
 
 static __always_inline
-int __arm_update_vdso_data(void)
+bool __arm_update_vdso_data(void)
 {
-	return !cntvct_ok;
+	return cntvct_ok;
 }
 #define __arch_update_vdso_data __arm_update_vdso_data
 
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,9 +12,9 @@ static __always_inline struct vdso_data
 #endif /* __arch_get_k_vdso_data */
 
 #ifndef __arch_update_vdso_data
-static __always_inline int __arch_update_vdso_data(void)
+static __always_inline bool __arch_update_vdso_data(void)
 {
-	return 0;
+	return true;
 }
 #endif /* __arch_update_vdso_data */
 
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -84,7 +84,7 @@ void update_vsyscall(struct timekeeper *
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec;
 
-	if (__arch_update_vdso_data()) {
+	if (!__arch_update_vdso_data()) {
 		/*
 		 * Some architectures might want to skip the update of the
 		 * data page.

