Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7723119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+mFfU3n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TosHXgtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgHFRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:13:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgHFRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:03 -0400
Date:   Thu, 06 Aug 2020 17:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/zdo6N3kr6DwXPfg4F5UGxVXyrpPOOGwsHDs97g2I4=;
        b=2+mFfU3njFmL3l5dT7cX2MUSyLPXOwaND6Pn93DWxCr4BNfKd/8pU6PEcTdParl9Bd4vfN
        fweYOIajGt6fL4fAU2eCAicyxdOwcAE8Esi0JX16LfAb1vjVQCJ0zYpq+XldJwQEG2bY13
        v1fxmkR+az/QkBUVG/CfRkVyGuCH3VDtVVAMBoS15qrHxpSjHIcd976YxPK3tmA4wqfrvf
        3s00/b+/cbudVTAj5I5yKhDfyf1UJF05cidP+KHkuOijPnwoFBs6FffJKm3+7CyShy5aOj
        nKdGJiPNxjn22XWeawNScwApbiOsyb4XQbOGGm1SMzKvapgY67E7j/DmhdDX6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/zdo6N3kr6DwXPfg4F5UGxVXyrpPOOGwsHDs97g2I4=;
        b=TosHXgtWzY4CxwZWNRoZnAvUVfxakvzK0R70YJhLD717j/YklCEArBcWaLkK8VvAZAgsuS
        pwMuYZCnfaLZhKDA==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] lib/vdso: Allow to add architecture-specific vdso data
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804150124.41692-2-svens@linux.ibm.com>
References: <20200804150124.41692-2-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <159673380055.3192.7751211345799683003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     d60d7de3e16d7cea998bad17d87366a359625894
Gitweb:        https://git.kernel.org/tip/d60d7de3e16d7cea998bad17d87366a359625894
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 04 Aug 2020 17:01:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 Aug 2020 10:57:30 +02:00

lib/vdso: Allow to add architecture-specific vdso data

The initial assumption that all VDSO related data can be completely generic
does not hold. S390 needs architecture specific storage to access the clock
steering information.

Add struct arch_vdso_data to the vdso data struct. For architectures which
do not need extra data this defaults to an empty struct. Architectures
which require it, enable CONFIG_ARCH_HAS_VDSO_DATA and provide their
specific struct in asm/vdso/data.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200804150124.41692-2-svens@linux.ibm.com

---
 arch/Kconfig            |  3 +++
 include/vdso/datapage.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index a112448..b44dd6b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -975,6 +975,9 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config ARCH_HAS_VDSO_DATA
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index ee810ca..73eb622 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,12 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+#include <asm/vdso/data.h>
+#else
+struct arch_vdso_data {};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -64,6 +70,8 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -97,6 +105,8 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
+
+	struct arch_vdso_data	arch_data;
 };
 
 /*
