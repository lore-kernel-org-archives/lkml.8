Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC57C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4892166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MuTDr2+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEAV5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgEAV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:57:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F316C061A0C;
        Fri,  1 May 2020 14:57:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so1378677wmg.1;
        Fri, 01 May 2020 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeCJAhwRsYVxYzeo62O1bYkDk1apTyT1HdK24IWP4Fk=;
        b=MuTDr2+2DQBHsrpjMQthLR/Bz409Aar9bo8FDua4h2bu8tJg18r6nXJFs/VY8o5xiC
         MEu3OaFM0ItCRBVcDasFGSinNIYW6sfKDcBg7V8uO+fYnqJ4BpYpkQqGQA+u62O5uoRB
         +/47Bh3V63s1jj81/t6ZQfqPeTqcD4x63yWs5jvXNAIzFowOWGozXWpzCxS34ZROLuTZ
         a5WeERqfWz0ui64H/xLvVqyrHU58cht/aJxjOK8eQ6DZZwDSnbpLBZWHQufy930CPI3L
         F1pLCgdcD8ceCgZEEi2a3rUqRbQbI8YGFJhAccqSUPewzHSNFC9DVcTfT3Qyl6E5yYoH
         lK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeCJAhwRsYVxYzeo62O1bYkDk1apTyT1HdK24IWP4Fk=;
        b=UCRFixFT+Vf5+IvA8ka2KBfQ1qrspcNA5F99jbEseU8R2RLWWCWJnKVO/Ecyu9mEJm
         IoGm3c+rJMqIoc+C1XHMBY+mGBAThV4pe6rKvbtl9w9lWajS3iIR4e31gKyIYKWm+bCa
         0bB0sAd4xDeEGGH8UrmPyYZlFZVJ6XDqQkPw5MJetBgpTBEaH0R/KVk6rYIa0Qy3qSLq
         mDwWp4sv8i0PwFALOe06wkOG8ef9f87wO2+B+Mzs2Mxzly40FqJPU/Fd0fDoszcTUIMf
         8Qh0OnwWmf/mSsZxYEAHuOtniTAqYDz7iBu0BmBULJteAi4AlRhtD51omppfcB6SQyct
         ri0A==
X-Gm-Message-State: AGi0PuZDXafVRoM7bqiVlV+C5nhsA+rw33W6V0ZQPTS3xK3XmMWzPRGv
        9CBp9ZpIu1JA7KcXV+C5EC8=
X-Google-Smtp-Source: APiQypLJWmvp14R+a/AtW56ASJefOAyOcJNiQNBB7+Ntawn8Bd5VJ1Hj08P37W+9ac39QOhMNpr2ZQ==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr1501227wmd.148.1588370258953;
        Fri, 01 May 2020 14:57:38 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b66sm1373412wmh.12.2020.05.01.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:57:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] clk: meson: meson8b: Don't rely on u-boot to init all GP_PLL registers
Date:   Fri,  1 May 2020 23:57:17 +0200
Message-Id: <20200501215717.735393-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all u-boot versions initialize the HHI_GP_PLL_CNTL[2-5] registers.
In that case all HHI_GPLL_PLL_CNTL[1-5] registers are 0x0 and when
booting Linux the PLL fails to lock.
The initialization sequence from u-boot is:
- put the PLL into reset
- write 0x59C88000 to HHI_GP_PLL_CNTL2
- write 0xCA463823 to HHI_GP_PLL_CNTL3
- write 0x0286A027 to HHI_GP_PLL_CNTL4
- write 0x00003000 to HHI_GP_PLL_CNTL5
- set M, N, OD and the enable bit
- take the PLL out of reset
- check if it has locked
- disable the PLL

In Linux we already initialize M, N, OD, the enable and the reset bits.
Also the HHI_GP_PLL_CNTL[2-5] registers with these magic values (the
exact meaning is unknown) so the PLL can lock when the vendor u-boot did
not initialize these registers yet.

Fixes: b882964b376f21 ("clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Jerome, this one is also not critical because we don't enable the VPU
yet. So I based this on commit 16afd70af5b21b ("clk: meson: meson8b:
Make the CCF use the glitch-free VPU mux").


 drivers/clk/meson/meson8b.c | 9 +++++++++
 drivers/clk/meson/meson8b.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 811af1c11456..edc09d050ecf 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1918,6 +1918,13 @@ static struct clk_regmap meson8b_mali = {
 	},
 };
 
+static const struct reg_sequence meson8m2_gp_pll_init_regs[] = {
+	{ .reg = HHI_GP_PLL_CNTL2,	.def = 0x59c88000 },
+	{ .reg = HHI_GP_PLL_CNTL3,	.def = 0xca463823 },
+	{ .reg = HHI_GP_PLL_CNTL4,	.def = 0x0286a027 },
+	{ .reg = HHI_GP_PLL_CNTL5,	.def = 0x00003000 },
+};
+
 static const struct pll_params_table meson8m2_gp_pll_params_table[] = {
 	PLL_PARAMS(182, 3),
 	{ /* sentinel */ },
@@ -1951,6 +1958,8 @@ static struct clk_regmap meson8m2_gp_pll_dco = {
 			.width   = 1,
 		},
 		.table = meson8m2_gp_pll_params_table,
+		.init_regs = meson8m2_gp_pll_init_regs,
+		.init_count = ARRAY_SIZE(meson8m2_gp_pll_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "gp_pll_dco",
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 94ce3ef0c1d5..cd38ae2a9cb5 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -20,6 +20,10 @@
  * [0] http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
  */
 #define HHI_GP_PLL_CNTL			0x40  /* 0x10 offset in data sheet */
+#define HHI_GP_PLL_CNTL2		0x44  /* 0x11 offset in data sheet */
+#define HHI_GP_PLL_CNTL3		0x48  /* 0x12 offset in data sheet */
+#define HHI_GP_PLL_CNTL4		0x4C  /* 0x13 offset in data sheet */
+#define HHI_GP_PLL_CNTL5		0x50  /* 0x14 offset in data sheet */
 #define HHI_VIID_CLK_DIV		0x128 /* 0x4a offset in data sheet */
 #define HHI_VIID_CLK_CNTL		0x12c /* 0x4b offset in data sheet */
 #define HHI_GCLK_MPEG0			0x140 /* 0x50 offset in data sheet */
-- 
2.26.2

