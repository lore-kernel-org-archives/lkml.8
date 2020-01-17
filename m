Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11DC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101512072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAQPID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:08:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56526 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:08:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isTE7-0002eh-OF; Fri, 17 Jan 2020 16:07:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6E8501C19E6;
        Fri, 17 Jan 2020 16:07:59 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:07:59 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] lib/vdso: Make __arch_update_vdso_data() logic
 understandable
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114185946.656652824@linutronix.de>
References: <20200114185946.656652824@linutronix.de>
MIME-Version: 1.0
Message-ID: <157927367926.396.7299991507019936952.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9a6b55ac4a44060bcb782baf002859b2a2c63267
Gitweb:        https://git.kernel.org/tip/9a6b55ac4a44060bcb782baf002859b2a2c63267
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 14 Jan 2020 19:52:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jan 2020 15:53:50 +01:00

lib/vdso: Make __arch_update_vdso_data() logic understandable

The function name suggests that this is a boolean checking whether the
architecture asks for an update of the VDSO data, but it works the other
way round. To spare further confusion invert the logic.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200114185946.656652824@linutronix.de

---
 arch/arm/include/asm/vdso/vsyscall.h | 4 ++--
 include/asm-generic/vdso/vsyscall.h  | 4 ++--
 kernel/time/vsyscall.c               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index c4166f3..cff87d8 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -34,9 +34,9 @@ struct vdso_data *__arm_get_k_vdso_data(void)
 #define __arch_get_k_vdso_data __arm_get_k_vdso_data
 
 static __always_inline
-int __arm_update_vdso_data(void)
+bool __arm_update_vdso_data(void)
 {
-	return !cntvct_ok;
+	return cntvct_ok;
 }
 #define __arch_update_vdso_data __arm_update_vdso_data
 
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index ce41032..cec543d 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,9 +12,9 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 #endif /* __arch_get_k_vdso_data */
 
 #ifndef __arch_update_vdso_data
-static __always_inline int __arch_update_vdso_data(void)
+static __always_inline bool __arch_update_vdso_data(void)
 {
-	return 0;
+	return true;
 }
 #endif /* __arch_update_vdso_data */
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 5ee0f77..f0aab61 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -84,7 +84,7 @@ void update_vsyscall(struct timekeeper *tk)
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec;
 
-	if (__arch_update_vdso_data()) {
+	if (!__arch_update_vdso_data()) {
 		/*
 		 * Some architectures might want to skip the update of the
 		 * data page.
