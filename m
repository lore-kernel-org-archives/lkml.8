Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB8C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672C021D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3FGV2jB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgAQWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:51:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:51:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so24209048wrh.5;
        Fri, 17 Jan 2020 14:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DBsPSSqYKmu847AC4mw5h2lhLIA5doaDQKnFj+vKRMQ=;
        b=e3FGV2jBEclU6HtGO0zCnUgNZeNr0qOEn9L9Orb5v702oLz/Q/4LNhkZ+YMU3QUq10
         V/vwwbD5DQi3W56ObHNhzKATtHciyomjuqGXjFjVF8YEY9man6rX4lAaW9LFTRQr5dlS
         YCjXHc7OQBJAWf1tdNba9iVog/jZlOPPbXKEbV9cMFMKi8sktHXRTXbimeJqC/BlbaQb
         9N8HLtfMBeroIsvNSpi9SZT3fp/h4jR6RQYJZOm3gXgzGDSJW8XDgqEn/Hx5Brnar41L
         B7TVBpprksdZ8j+WBnMgGUNG28DnB+ueVCgMPV2gh9zW0/q2/rDp4tha+V59w1mlh1C1
         qXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DBsPSSqYKmu847AC4mw5h2lhLIA5doaDQKnFj+vKRMQ=;
        b=c+yrWNUn2rwsUxhcT1hLHUmo/8k2amfW2B86neuQNgZZgiKnOQr1yipXxQV/aE3Ma4
         boR2tya2d5NqlgBx7hC8IiYhm+PYYm2aXyJEAP/7NEqRwQdceKd2niapMIb9t9Q+fFCB
         m/9+tWFTPIzYm+nzRcIuwu+bXL/qXsqT7ldyaajI/xObPWJNemkuJdmdC3B1pmL5W1av
         fm3rqyKj2Z+j1ykD3mDRPzNfsO0Spig3knUowacIRt9mpyjLmVnkEUvLsf2JlDRKoGUc
         tdgC7BPSaS2JwiTpFRNzYsDZgAA43B3jbZycT0bzTImjMOrFeQ7NWg9f+XQvAH9S55tv
         cVUg==
X-Gm-Message-State: APjAAAWyDAVM/bw7zWqZpNK4F/XJrsVuFxR1+sq75HmpEP8EosKrHZQ8
        9y2n8g706LArW5kGddSPFUk=
X-Google-Smtp-Source: APXvYqzxcuFWQTeilgYG6LhmXyFhj8YGLBNvFtZPeFGVWheTsgi/86apqWThW7VhO0UEoHPmQ+2snA==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr5554706wrm.324.1579301506172;
        Fri, 17 Jan 2020 14:51:46 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l3sm32829387wrt.29.2020.01.17.14.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:51:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, rob@landley.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
        geert@linux-m68k.org, andre.przywara@arm.com,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        ryabinin.a.a@gmail.com
Subject: [PATCH v7 2/7] ARM: Add TTBR operator for kasan_init
Date:   Fri, 17 Jan 2020 14:48:34 -0800
Message-Id: <20200117224839.23531-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117224839.23531-1-f.fainelli@gmail.com>
References: <20200117224839.23531-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abbott Liu <liuwenliang@huawei.com>

The purpose of this patch is to provide set_ttbr0/get_ttbr0 to
kasan_init function. This makes use of the CP15 definitions added in the
previous patch.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cp15.h | 50 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/hyp/cp15-sr.c  | 12 ++++-----
 arch/arm/kvm/hyp/switch.c   |  6 ++---
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 89b6663f2863..0bd8287b39fa 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -42,6 +42,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/stringify.h>
+
 #if __LINUX_ARM_ARCH__ >= 4
 #define vectors_high()	(get_cr() & CR_V)
 #else
@@ -129,6 +131,54 @@
 
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
+static inline void set_par(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, PAR_64);
+	else
+		write_sysreg(val, PAR_32);
+}
+
+static inline u64 get_par(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(PAR_64);
+	else
+		return read_sysreg(PAR_32);
+}
+
+static inline void set_ttbr0(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, TTBR0_64);
+	else
+		write_sysreg(val, TTBR0_32);
+}
+
+static inline u64 get_ttbr0(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(TTBR0_64);
+	else
+		return read_sysreg(TTBR0_32);
+}
+
+static inline void set_ttbr1(u64 val)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		write_sysreg(val, TTBR1_64);
+	else
+		write_sysreg(val, TTBR1_32);
+}
+
+static inline u64 get_ttbr1(void)
+{
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return read_sysreg(TTBR1_64);
+	else
+		return read_sysreg(TTBR1_32);
+}
+
 static inline unsigned long get_cr(void)
 {
 	unsigned long val;
diff --git a/arch/arm/kvm/hyp/cp15-sr.c b/arch/arm/kvm/hyp/cp15-sr.c
index e6923306f698..b2b9bb0a08b8 100644
--- a/arch/arm/kvm/hyp/cp15-sr.c
+++ b/arch/arm/kvm/hyp/cp15-sr.c
@@ -19,8 +19,8 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 	ctxt->cp15[c0_CSSELR]		= read_sysreg(CSSELR);
 	ctxt->cp15[c1_SCTLR]		= read_sysreg(SCTLR);
 	ctxt->cp15[c1_CPACR]		= read_sysreg(CPACR);
-	*cp15_64(ctxt, c2_TTBR0)	= read_sysreg(TTBR0);
-	*cp15_64(ctxt, c2_TTBR1)	= read_sysreg(TTBR1);
+	*cp15_64(ctxt, c2_TTBR0)	= read_sysreg(TTBR0_64);
+	*cp15_64(ctxt, c2_TTBR1)	= read_sysreg(TTBR1_64);
 	ctxt->cp15[c2_TTBCR]		= read_sysreg(TTBCR);
 	ctxt->cp15[c3_DACR]		= read_sysreg(DACR);
 	ctxt->cp15[c5_DFSR]		= read_sysreg(DFSR);
@@ -29,7 +29,7 @@ void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 	ctxt->cp15[c5_AIFSR]		= read_sysreg(AIFSR);
 	ctxt->cp15[c6_DFAR]		= read_sysreg(DFAR);
 	ctxt->cp15[c6_IFAR]		= read_sysreg(IFAR);
-	*cp15_64(ctxt, c7_PAR)		= read_sysreg(PAR);
+	*cp15_64(ctxt, c7_PAR)		= read_sysreg(PAR_64);
 	ctxt->cp15[c10_PRRR]		= read_sysreg(PRRR);
 	ctxt->cp15[c10_NMRR]		= read_sysreg(NMRR);
 	ctxt->cp15[c10_AMAIR0]		= read_sysreg(AMAIR0);
@@ -48,8 +48,8 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->cp15[c0_CSSELR],	CSSELR);
 	write_sysreg(ctxt->cp15[c1_SCTLR],	SCTLR);
 	write_sysreg(ctxt->cp15[c1_CPACR],	CPACR);
-	write_sysreg(*cp15_64(ctxt, c2_TTBR0),	TTBR0);
-	write_sysreg(*cp15_64(ctxt, c2_TTBR1),	TTBR1);
+	write_sysreg(*cp15_64(ctxt, c2_TTBR0),	TTBR0_64);
+	write_sysreg(*cp15_64(ctxt, c2_TTBR1),	TTBR1_64);
 	write_sysreg(ctxt->cp15[c2_TTBCR],	TTBCR);
 	write_sysreg(ctxt->cp15[c3_DACR],	DACR);
 	write_sysreg(ctxt->cp15[c5_DFSR],	DFSR);
@@ -58,7 +58,7 @@ void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->cp15[c5_AIFSR],	AIFSR);
 	write_sysreg(ctxt->cp15[c6_DFAR],	DFAR);
 	write_sysreg(ctxt->cp15[c6_IFAR],	IFAR);
-	write_sysreg(*cp15_64(ctxt, c7_PAR),	PAR);
+	write_sysreg(*cp15_64(ctxt, c7_PAR),	PAR_64);
 	write_sysreg(ctxt->cp15[c10_PRRR],	PRRR);
 	write_sysreg(ctxt->cp15[c10_NMRR],	NMRR);
 	write_sysreg(ctxt->cp15[c10_AMAIR0],	AMAIR0);
diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 1efeef3fd0ee..581277ef44d3 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -123,12 +123,12 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 	if (!(hsr & HSR_DABT_S1PTW) && (hsr & HSR_FSC_TYPE) == FSC_PERM) {
 		u64 par, tmp;
 
-		par = read_sysreg(PAR);
+		par = read_sysreg(PAR_64);
 		write_sysreg(far, ATS1CPR);
 		isb();
 
-		tmp = read_sysreg(PAR);
-		write_sysreg(par, PAR);
+		tmp = read_sysreg(PAR_64);
+		write_sysreg(par, PAR_64);
 
 		if (unlikely(tmp & 1))
 			return false; /* Translation failed, back to guest */
-- 
2.17.1

