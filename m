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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7BC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA30222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrCFH1Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgAQWvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:51:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51594 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:51:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so8909888wmd.1;
        Fri, 17 Jan 2020 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2nRYyxjPyQF3IQbPCKoaUguo6CO4aiwXRtlS8UQpy4=;
        b=mrCFH1GwjEvP5rc4v6hfkWt1VfevjpOfR8mWd7KchYIl22HwQ1k5jnY973BNjzhZa/
         quqliCkrWY2K7omPvj0n0iomDfOi4N3Uhdn0cGmGqyUeieTfmmXhs5PpOufb9tQDcqp7
         gxbRyGLGA4E+XxDhB6wwZBSI9E1c6gopwT5B9zOZxWWfR6L4j4B2fCdKgocUB1cSiuKT
         0TqwLD0aT9GJxcKhh2P/PZdN54PZ/QNETl2ElMPzy+2uL8dOnxeQMsxm7UOeDq6XrWN7
         KhGAdw+of0JMHR0qWJMcjKO8G7O1v9dzAs5bVBvo4cOtAshz7nRnK83G7bwcvJ6N25kM
         T0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2nRYyxjPyQF3IQbPCKoaUguo6CO4aiwXRtlS8UQpy4=;
        b=UVlQl2wO1SZXpaLVXA+7seNVhJHVm4L9M5Qkqi7brxUAmPBiAQ3gNCl9sr/pEnyHWn
         xA2Yqnq4CDs6WmfrtlDAYpRoonD0PpwiF8hji0ATEzoMhiGav3OE+EZ88WnhIZxlg4UM
         aFI2hBjo3FDnZkZtRjytgQX1rQeCE3XlYax4dUOnIxlzZvOKFr3jBgSzGQSqt7AbZPCW
         4sAfusJLMgs6QomYzaEp7eYtVHe/ty9bF9VsZrhheMiO0j7YqZyhSxxI7jGcC5etrVn7
         5wCXV6DVky7ZNKKwIEpsRbTfjf0mmO7bD2b18DkXS9ITl+VsBf1mN3hznmNewJLuuWG5
         PTqA==
X-Gm-Message-State: APjAAAVABbnHCuq2lUg0MmPR5chB6MlQizWnA9Y18jDaO1fo6iPGBOQB
        rGAT9pI+i17ZWf2CS3DjnU8=
X-Google-Smtp-Source: APXvYqzk6ElFxJJj9rYsDdIiJandeO9CA/171N8ngvBFdCN+IeYqvKr6jMTgzHZBja9vKBJOsMFBUg==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr6975350wma.34.1579301499190;
        Fri, 17 Jan 2020 14:51:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l3sm32829387wrt.29.2020.01.17.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:51:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, liuwenliang@huawei.com, rob@landley.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        yamada.masahiro@socionext.com, tglx@linutronix.de,
        thgarnie@google.com, dhowells@redhat.com, geert@linux-m68k.org,
        andre.przywara@arm.com, julien.thierry@arm.com, drjones@redhat.com,
        philip@cog.systems, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, ryabinin.a.a@gmail.com
Subject: [PATCH v7 1/7] ARM: Moved CP15 definitions from kvm_hyp.h to cp15.h
Date:   Fri, 17 Jan 2020 14:48:33 -0800
Message-Id: <20200117224839.23531-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117224839.23531-1-f.fainelli@gmail.com>
References: <20200117224839.23531-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to add specific accessor functions for TTBR which are
32-bit/64-bit appropriate, move all CP15 register definitions into
cp15.h where they belong.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cp15.h    | 57 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/kvm_hyp.h | 54 --------------------------------
 2 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index d2453e2d3f1f..89b6663f2863 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -70,6 +70,63 @@
 
 #define CNTVCT				__ACCESS_CP15_64(1, c14)
 
+#define TTBR0_32	__ACCESS_CP15(c2, 0, c0, 0)
+#define TTBR1_32	__ACCESS_CP15(c2, 0, c0, 1)
+#define PAR_32		__ACCESS_CP15(c7, 0, c4, 0)
+#define TTBR0_64	__ACCESS_CP15_64(0, c2)
+#define TTBR1_64	__ACCESS_CP15_64(1, c2)
+#define PAR_64		__ACCESS_CP15_64(0, c7)
+#define VTTBR		__ACCESS_CP15_64(6, c2)
+#define CNTP_CVAL      __ACCESS_CP15_64(2, c14)
+#define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
+#define CNTVOFF		__ACCESS_CP15_64(4, c14)
+
+#define MIDR		__ACCESS_CP15(c0, 0, c0, 0)
+#define CSSELR		__ACCESS_CP15(c0, 2, c0, 0)
+#define VPIDR		__ACCESS_CP15(c0, 4, c0, 0)
+#define VMPIDR		__ACCESS_CP15(c0, 4, c0, 5)
+#define SCTLR		__ACCESS_CP15(c1, 0, c0, 0)
+#define CPACR		__ACCESS_CP15(c1, 0, c0, 2)
+#define HCR		__ACCESS_CP15(c1, 4, c1, 0)
+#define HDCR		__ACCESS_CP15(c1, 4, c1, 1)
+#define HCPTR		__ACCESS_CP15(c1, 4, c1, 2)
+#define HSTR		__ACCESS_CP15(c1, 4, c1, 3)
+#define TTBCR		__ACCESS_CP15(c2, 0, c0, 2)
+#define HTCR		__ACCESS_CP15(c2, 4, c0, 2)
+#define VTCR		__ACCESS_CP15(c2, 4, c1, 2)
+#define DACR		__ACCESS_CP15(c3, 0, c0, 0)
+#define DFSR		__ACCESS_CP15(c5, 0, c0, 0)
+#define IFSR		__ACCESS_CP15(c5, 0, c0, 1)
+#define ADFSR		__ACCESS_CP15(c5, 0, c1, 0)
+#define AIFSR		__ACCESS_CP15(c5, 0, c1, 1)
+#define HSR		__ACCESS_CP15(c5, 4, c2, 0)
+#define DFAR		__ACCESS_CP15(c6, 0, c0, 0)
+#define IFAR		__ACCESS_CP15(c6, 0, c0, 2)
+#define HDFAR		__ACCESS_CP15(c6, 4, c0, 0)
+#define HIFAR		__ACCESS_CP15(c6, 4, c0, 2)
+#define HPFAR		__ACCESS_CP15(c6, 4, c0, 4)
+#define ICIALLUIS	__ACCESS_CP15(c7, 0, c1, 0)
+#define BPIALLIS	__ACCESS_CP15(c7, 0, c1, 6)
+#define ICIMVAU		__ACCESS_CP15(c7, 0, c5, 1)
+#define ATS1CPR		__ACCESS_CP15(c7, 0, c8, 0)
+#define TLBIALLIS	__ACCESS_CP15(c8, 0, c3, 0)
+#define TLBIALL		__ACCESS_CP15(c8, 0, c7, 0)
+#define TLBIALLNSNHIS	__ACCESS_CP15(c8, 4, c3, 4)
+#define PRRR		__ACCESS_CP15(c10, 0, c2, 0)
+#define NMRR		__ACCESS_CP15(c10, 0, c2, 1)
+#define AMAIR0		__ACCESS_CP15(c10, 0, c3, 0)
+#define AMAIR1		__ACCESS_CP15(c10, 0, c3, 1)
+#define VBAR		__ACCESS_CP15(c12, 0, c0, 0)
+#define CID		__ACCESS_CP15(c13, 0, c0, 1)
+#define TID_URW		__ACCESS_CP15(c13, 0, c0, 2)
+#define TID_URO		__ACCESS_CP15(c13, 0, c0, 3)
+#define TID_PRIV	__ACCESS_CP15(c13, 0, c0, 4)
+#define HTPIDR		__ACCESS_CP15(c13, 4, c0, 2)
+#define CNTKCTL		__ACCESS_CP15(c14, 0, c1, 0)
+#define CNTP_CTL	__ACCESS_CP15(c14, 0, c2, 1)
+#define CNTV_CTL	__ACCESS_CP15(c14, 0, c3, 1)
+#define CNTHCTL		__ACCESS_CP15(c14, 4, c1, 0)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)
diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
index 40e9034db601..f6635bd63ff0 100644
--- a/arch/arm/include/asm/kvm_hyp.h
+++ b/arch/arm/include/asm/kvm_hyp.h
@@ -25,60 +25,6 @@
 	__val;							\
 })
 
-#define TTBR0		__ACCESS_CP15_64(0, c2)
-#define TTBR1		__ACCESS_CP15_64(1, c2)
-#define VTTBR		__ACCESS_CP15_64(6, c2)
-#define PAR		__ACCESS_CP15_64(0, c7)
-#define CNTP_CVAL	__ACCESS_CP15_64(2, c14)
-#define CNTV_CVAL	__ACCESS_CP15_64(3, c14)
-#define CNTVOFF		__ACCESS_CP15_64(4, c14)
-
-#define MIDR		__ACCESS_CP15(c0, 0, c0, 0)
-#define CSSELR		__ACCESS_CP15(c0, 2, c0, 0)
-#define VPIDR		__ACCESS_CP15(c0, 4, c0, 0)
-#define VMPIDR		__ACCESS_CP15(c0, 4, c0, 5)
-#define SCTLR		__ACCESS_CP15(c1, 0, c0, 0)
-#define CPACR		__ACCESS_CP15(c1, 0, c0, 2)
-#define HCR		__ACCESS_CP15(c1, 4, c1, 0)
-#define HDCR		__ACCESS_CP15(c1, 4, c1, 1)
-#define HCPTR		__ACCESS_CP15(c1, 4, c1, 2)
-#define HSTR		__ACCESS_CP15(c1, 4, c1, 3)
-#define TTBCR		__ACCESS_CP15(c2, 0, c0, 2)
-#define HTCR		__ACCESS_CP15(c2, 4, c0, 2)
-#define VTCR		__ACCESS_CP15(c2, 4, c1, 2)
-#define DACR		__ACCESS_CP15(c3, 0, c0, 0)
-#define DFSR		__ACCESS_CP15(c5, 0, c0, 0)
-#define IFSR		__ACCESS_CP15(c5, 0, c0, 1)
-#define ADFSR		__ACCESS_CP15(c5, 0, c1, 0)
-#define AIFSR		__ACCESS_CP15(c5, 0, c1, 1)
-#define HSR		__ACCESS_CP15(c5, 4, c2, 0)
-#define DFAR		__ACCESS_CP15(c6, 0, c0, 0)
-#define IFAR		__ACCESS_CP15(c6, 0, c0, 2)
-#define HDFAR		__ACCESS_CP15(c6, 4, c0, 0)
-#define HIFAR		__ACCESS_CP15(c6, 4, c0, 2)
-#define HPFAR		__ACCESS_CP15(c6, 4, c0, 4)
-#define ICIALLUIS	__ACCESS_CP15(c7, 0, c1, 0)
-#define BPIALLIS	__ACCESS_CP15(c7, 0, c1, 6)
-#define ICIMVAU		__ACCESS_CP15(c7, 0, c5, 1)
-#define ATS1CPR		__ACCESS_CP15(c7, 0, c8, 0)
-#define TLBIALLIS	__ACCESS_CP15(c8, 0, c3, 0)
-#define TLBIALL		__ACCESS_CP15(c8, 0, c7, 0)
-#define TLBIALLNSNHIS	__ACCESS_CP15(c8, 4, c3, 4)
-#define PRRR		__ACCESS_CP15(c10, 0, c2, 0)
-#define NMRR		__ACCESS_CP15(c10, 0, c2, 1)
-#define AMAIR0		__ACCESS_CP15(c10, 0, c3, 0)
-#define AMAIR1		__ACCESS_CP15(c10, 0, c3, 1)
-#define VBAR		__ACCESS_CP15(c12, 0, c0, 0)
-#define CID		__ACCESS_CP15(c13, 0, c0, 1)
-#define TID_URW		__ACCESS_CP15(c13, 0, c0, 2)
-#define TID_URO		__ACCESS_CP15(c13, 0, c0, 3)
-#define TID_PRIV	__ACCESS_CP15(c13, 0, c0, 4)
-#define HTPIDR		__ACCESS_CP15(c13, 4, c0, 2)
-#define CNTKCTL		__ACCESS_CP15(c14, 0, c1, 0)
-#define CNTP_CTL	__ACCESS_CP15(c14, 0, c2, 1)
-#define CNTV_CTL	__ACCESS_CP15(c14, 0, c3, 1)
-#define CNTHCTL		__ACCESS_CP15(c14, 4, c1, 0)
-
 #define VFP_FPEXC	__ACCESS_VFP(FPEXC)
 
 /* AArch64 compatibility macros, only for the timer so far */
-- 
2.17.1

