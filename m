Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC3C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D05C2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJfohwtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGRUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGRUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:10:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF07C0619D2;
        Sat, 18 Jul 2020 13:10:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q2so1008640qkc.8;
        Sat, 18 Jul 2020 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfCfI9Ry75jIS0L/AMZU07uS7wzGWMcWBCKEzsuKDmw=;
        b=BJfohwtAWZYl+V/uOHQpuI6c80rvv4c/VWAzTk7/5Cwaeov80khoFC6+OIuRNT15ei
         FCwDNd3ketUB2X2JE/zpWPJdZaNhK4id8NP/bLUbkC5hAMlfv1yVLDIxr6m2MpETrdmT
         jlsJkhkBru5VOIwwhpEouIJtA4TT54TwBazZd8fOmavtS+U5dO8udi0q3omo9Srp76Lh
         ZbugOIaW7bPnKYOu1hcWg4codNGrglaYtaHiN0dojjd8JSggp5XHmfvMtjweZyK7riND
         ARgGklsTKQAYn+TM+M254/VB4w4brQbuy0v+NAgZ3SZalap4xr68tx+e61TGICYdIT4m
         9tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfCfI9Ry75jIS0L/AMZU07uS7wzGWMcWBCKEzsuKDmw=;
        b=LUMZEHFGqOn1y6Y+NKQ2lQzIMHLZ0MoYLN5w30uNbxHFp1idG/AOebrj31KFbybPmV
         Dzj73LTuz03HUjR4hlNA0WxTvgbsgyiOliQ1SIoBnhkNc4Xz9OivFsqMgtjAOYA6UwyN
         zISXQQC35xlPtocrRZRYvBo+MyirSV9FIP2t1Hdaddia75gKCaE1JQRjfzl7ix70z0de
         Gcz7NeanssmUtg19XH7HvojO8cEbkNfsVgFcNDz1iMhAv4xgDPddHeNFFM83L1R4qjin
         wwDRhuvdIk/Z8yGBl2e2dwid7DGIAa2fEqJ6drpaLK1gWZms1cFYqbAM0YJIxh7uVytY
         Ob3A==
X-Gm-Message-State: AOAM533Z0yWvoGJUtBIIrGG9jNCa/R+reBkkXxUGu6mqHyVDtjAetPbc
        Q2WTByQ/eqes+6DIg7TeQJ4=
X-Google-Smtp-Source: ABdhPJxSg+ZIn5RKcVAYAYCk2vFVoyC3hKZRN4xqtTX769Xev4mHOCrXI+AgMs37AA7VtTV3up+i5g==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr15314073qke.65.1595103045341;
        Sat, 18 Jul 2020 13:10:45 -0700 (PDT)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l3sm14436287qtn.69.2020.07.18.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:10:44 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] parisc: add support for cmpxchg on u8 pointers
Date:   Sat, 18 Jul 2020 16:10:21 -0400
Message-Id: <20200718201021.23918-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test bot reported[1] that using set_mask_bits on a u8 causes
the following issue on parisc:

	hppa-linux-ld: drivers/phy/ti/phy-tusb1210.o: in function `tusb1210_probe':
	>> (.text+0x2f4): undefined reference to `__cmpxchg_called_with_bad_pointer'
	>> hppa-linux-ld: (.text+0x324): undefined reference to `__cmpxchg_called_with_bad_pointer'
	hppa-linux-ld: (.text+0x354): undefined reference to `__cmpxchg_called_with_bad_pointer'

Add support for cmpxchg on u8 pointers.

[1] https://lore.kernel.org/patchwork/patch/1272617/#1468946

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 arch/parisc/include/asm/cmpxchg.h |  2 ++
 arch/parisc/lib/bitops.c          | 12 ++++++++++++
 2 files changed, 14 insertions(+)

Hi,

This was reported by the kernel test bot on an architecture I can't
really test on. I was only able to make sure this builds, nothing more.

Should I also add __cmpxchg_u8 in the cmpxchg_local switch case?

There are one or two minor cleanups we can do around that patch, but
because of my limited testing options, I kept the changes to a minimum.

If there's interest, I can include these in follow up patches:
- update __cmpxchg_u32 to use u32 instead of unsigned int for
  consistency
- add support for __cmpxchg_u16

Thanks,
Liam

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index ab5c215cf46c..068958575871 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -60,6 +60,7 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 extern unsigned long __cmpxchg_u32(volatile unsigned int *m, unsigned int old,
 				   unsigned int new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
+extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -71,6 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 #endif
 	case 4: return __cmpxchg_u32((unsigned int *)ptr,
 				     (unsigned int)old, (unsigned int)new_);
+	case 1: return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
 	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index 70ffbcf889b8..2e4d1f05a926 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -79,3 +79,15 @@ unsigned long __cmpxchg_u32(volatile unsigned int *ptr, unsigned int old, unsign
 	_atomic_spin_unlock_irqrestore(ptr, flags);
 	return (unsigned long)prev;
 }
+
+u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
+{
+	unsigned long flags;
+	u8 prev;
+
+	_atomic_spin_lock_irqsave(ptr, flags);
+	if ((prev = *ptr) == old)
+		*ptr = new;
+	_atomic_spin_unlock_irqrestore(ptr, flags);
+	return prev;
+}

base-commit: 6cf7ccba29dcf39ab27630c383a3844078a6d5cd
-- 
2.27.0

