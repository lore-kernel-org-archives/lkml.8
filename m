Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BE7206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UsBnokNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgFOHZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgFOHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:25:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so15932434wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=riWUhes2igXDR1qy3tIwXdTKD/88c/mEkuTa2CTN1Fc=;
        b=UsBnokNl/Yq0JY0JNS/habrt/+H73fsN8s1N8S5KGit+QOQUwDPt3UmYscMHwWsDNb
         obuvppWJJZs85SdFEjXzA4q0RSR2i52ZDyD99PKLS+TCU8w6uWmY+xJZlqeYU8+tPmFH
         2Flx4pCh4WYCCPRJ6tLoEs0txtyQvCAzJpTObafIoKwIy2Dc6fBqvNBfgc1D641Fq+Mo
         14y0k7ohgjZUmDqGmZHMJYSdCKD7ITUZY6vq0SSUZV0rlOgj5IGckFUA+WYA0iruYDrc
         NCMLjmbcrPC1Vvdeuj1E9j+QtuIQ2Z4kvd8aeu9L2I92+HY1LDS1GRK0LztD/zdaprKt
         q54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=riWUhes2igXDR1qy3tIwXdTKD/88c/mEkuTa2CTN1Fc=;
        b=LKLio9SF3UTTufaWVg/mfZBSQoJGIDdlhJMZWx6Av/bQhHIJ1irDhS4AllClx6DPfb
         pevhJC7ZJhK8ijR/eia2cj3aX6dei9X4Rg8jkM/Ql2D+wfYc7CFiFm7z2UqrrantumCY
         Sk7+emLxkm3bb8nmD8nQClHU6QZilVoVUVxUOIdgrqCMMdcAmqHHENiVxXspnvMAv9lf
         p7c5GrEfMDoo/ZEGquKrbJrav+QtgciQBalADc5vIisEyTG7Q51BqYrphHrV5Vhu5FnK
         RbSAEoNbHI164KP6o9zcKU7EOANMEwtAomCH3g/UFgE1uM1TbYyKNVAK831pOVY/HyU2
         xXGQ==
X-Gm-Message-State: AOAM532D8TGYL+m4d4b8VrzCwNES9rxxxecvx6AQhcxtCT2HJXhAkGCF
        z4iperoYIgLemp/U/GasrpJuLQ==
X-Google-Smtp-Source: ABdhPJz0NWTTJnLBf/N86Ovvv7TmRNIqU7u+c4PneWxjJscFwsutPoI3C/HXFRCthAGa5V03GZ9fHQ==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr26237625wrw.379.1592205909803;
        Mon, 15 Jun 2020 00:25:09 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j4sm22585124wma.7.2020.06.15.00.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 00:25:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regmap: remove stray space
Date:   Mon, 15 Jun 2020 09:25:07 +0200
Message-Id: <20200615072507.11303-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are two spaces between arguments in regmap_fields_update_bits_base()
so remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Mark,

I noticed this while writing the previous patch, so I guess we can fix it.

Bart

 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c472f624382d..b99c47ed48fe 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2031,7 +2031,7 @@ EXPORT_SYMBOL_GPL(regmap_field_update_bits_base);
  * A value of zero will be returned on success, a negative errno will
  * be returned in error cases.
  */
-int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
+int regmap_fields_update_bits_base(struct regmap_field *field, unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force)
 {
-- 
2.26.1

