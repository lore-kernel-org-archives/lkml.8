Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7BC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBE1206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cL9Qls0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBTNPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:15:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50850 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBTNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:15:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so1961076wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XbSocyvlHYbidOLh4UOVd5RVPSZd3HbLsAjRlUOFqzE=;
        b=cL9Qls0rrY+UzGeBw0dqcz5IcrwkrepfPyKpcfyhixITUM1d5/ShOLtYyv9e2ht9re
         vNF4EHS1lout8tWKpDNYeE1wRWJUB1sne2NqK/Fp8QN4MgqLCzv/LyFVKSl2MdP7TfsB
         jFYPfRkh6ytqAY8bNihNOxsftGETYTp9skzjC6gCf6wScN7+DVr3ntlwNTnbiS/vsVrq
         RW6sXB8KpGLV3EjfZJLIAAN+AZLCNu9ksf6Vt5nE4aSeDTxWlB0KqxTWvlA1uAqcXnQm
         31OCyhy4DJ6uyFnqeGplku3fQIs7GQi4AbO0uQU83nieE6vYGS8SxvvzL18IuhEZ+PGC
         aTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XbSocyvlHYbidOLh4UOVd5RVPSZd3HbLsAjRlUOFqzE=;
        b=UpfmAuV4Xwez6SLKDRBWmHg/BKAIE+gc8WvAcT7BeYfy+XYkBTC6LytxEpPUJup+0a
         hl82O2MyjG+6Q10iS9uzspjAOKaQijoCG2ji4s0LcOR99FDdsAhG68dBjviOnYQoiNqO
         7o0JXRpNDdWqrqJ0N75GSl0QCnQcXWvVScncd8NjVgHMSjveTosm3wW25OMdzR9nPkWa
         Ca+k+T07U4ixeiKYJtoHDh37pz7FYTeQG5g9GXXCEQtGtc4DsOEqgvLbQFL3QuAP31nl
         oef4PSFpegm/DG+G2sXai/bL8tztb6ItOzKVDTFzOkG6I2ephtKh4+fg1ps4zM8S8QHL
         o5DQ==
X-Gm-Message-State: APjAAAUyg24aqqnWAGyRcGxT3VkkgQKvR5cSa+wNR5dB4nbTU1HAXg/b
        UGD5wjRAP3tM4K3LYA3ykitmlg==
X-Google-Smtp-Source: APXvYqxJi6xwPPsEIzGnzgqipWlqaAxHhHMEH+ezeWOrFPemY21Bt4/b8HeNAvszDL/6lNpuF+oXFQ==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4468157wml.71.1582204535329;
        Thu, 20 Feb 2020 05:15:35 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d204sm4382774wmd.30.2020.02.20.05.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 05:15:34 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH RESEND] pinctrl: meson-gxl: fix GPIOX sdio pins
Date:   Thu, 20 Feb 2020 14:15:12 +0100
Message-Id: <1582204512-7582-1-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the gxl driver, the sdio cmd and clk pins are inverted. It has not caused
any issue so far because devices using these pins always take both pins
so the resulting configuration is OK.

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---

Hi Linus,

Sorry for the the bad formatting of the first patch, this one should be fine.

Thanks

Nicolas

 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 1b6e8646700f..2ac921c83da9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -147,8 +147,8 @@ static const unsigned int sdio_d0_pins[]	= { GPIOX_0 };
 static const unsigned int sdio_d1_pins[]	= { GPIOX_1 };
 static const unsigned int sdio_d2_pins[]	= { GPIOX_2 };
 static const unsigned int sdio_d3_pins[]	= { GPIOX_3 };
-static const unsigned int sdio_cmd_pins[]	= { GPIOX_4 };
-static const unsigned int sdio_clk_pins[]	= { GPIOX_5 };
+static const unsigned int sdio_clk_pins[]	= { GPIOX_4 };
+static const unsigned int sdio_cmd_pins[]	= { GPIOX_5 };
 static const unsigned int sdio_irq_pins[]	= { GPIOX_7 };
 
 static const unsigned int nand_ce0_pins[]	= { BOOT_8 };
-- 
2.7.4

