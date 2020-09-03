Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F4C2D0E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351BC2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1i4ipnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICUlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgICUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47946C061249;
        Thu,  3 Sep 2020 13:30:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so4148542wmk.1;
        Thu, 03 Sep 2020 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzSizsn0JK1opavfeNDCJSC51EiA+520JWwYUTToFg8=;
        b=B1i4ipnViNrUEV2JHX8TUYJ3Z0gwvr/GwZEih3uo/PltUB7AlyF9ndTBtShkSn+gJg
         2OjNSLNClUh9Ic3lCV65+aG6L+ulDpX5Qh9bAEeHpqjv2V29KnHcj3N9sl234yaGX1vX
         OnTlhWoigt5UsIgpBVpyv6sibbZJWSITViQwbhoQdH7dZRoo1nEXEmpRq9Pdzy9bPhPN
         0zCF385PLtbxl0l/6NDEbHH1xO+kQ0QgouvCpdSYChZe1D6vhg+S491ZR1wr4OK7sNDV
         K6ujaMiPGauLpXatRIoeFxman5CJHybeZL1tenav9IwZ5419uEXT1Lxa+RKgfE4mwyqd
         UcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzSizsn0JK1opavfeNDCJSC51EiA+520JWwYUTToFg8=;
        b=RhKEWCgbCQv6nbzV9CgaZSTM6W1gAoZjBPNtQaY2jr+Njnht5xx4oumRQMdMk5mZ0Y
         q7dx7JANNUrrhic+WFDRuuyjdC+bJakk+nbdupEIa5Fiy2hjIuzMR6vXHjUQrCDBbfkR
         MPJq3nIYQme9im6VrF4bwaPq/ab2DBce68Lp+kD63Ek2Pg2tlxhus26CSltP5mLfe9tH
         MfZJ/jnY1rv6Cd1pVS9XmJqy2b196ShEOmTmXOeMwDsqR8bkucplGxEKzl7f5VyDAN8v
         VwqrqdFAsoz00AG0kSfYzZ+nXUlEaKmQQpkQAwoLlIU1UGK9GWW3XAkzLDs8elWaJcHr
         vx/g==
X-Gm-Message-State: AOAM533Yw/GWEJxFUU6kWckibkv79ZTvjOnl6O/+HwJ1CCLBSQq8FiqH
        cMVu696W5Ht/1Ma0JNiNJrFHWokCYJfObQ==
X-Google-Smtp-Source: ABdhPJzdWnGyw9y0NOy0KkQZDlOL6GQL1RBDwzjesZGtBXIRxrFg1/S9SqdPLKpYayoQlmlIk++8TA==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4427918wmi.105.1599165051810;
        Thu, 03 Sep 2020 13:30:51 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:51 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 07/20] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Thu,  3 Sep 2020 22:30:21 +0200
Message-Id: <20200903203034.1057334-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index df73cd5751c0..aa162e76d671 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1135,12 +1135,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

