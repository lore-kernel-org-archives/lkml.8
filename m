Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE07C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21DA208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RZe84KTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgBTUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:45:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51667 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgBTUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:44:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so1836wmi.1;
        Thu, 20 Feb 2020 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n76MR2hfIZsf6g57SD/GC8wwOFNZ4gbM6KJt3yOpBLs=;
        b=RZe84KTgVDumaVTivMwcyl7kEwDt57yX76+EH+ZLQWwRzv5k62azpHW8GqTx8mxI5J
         6d86J/N/tD47TrjzY+73UOYpQtyxsiHyf/yJ2PAbvRbUgF4WGlHmAwxGRofiMzBIfWmu
         DajDDq/fyp1k7BZfgCAdwxbHMfLZDowqN2cq23QtzZkTbeMw66pO0GdihywqH6QEC4LI
         W/C3nTVpiEI4DWCMfTY8/yGtanqaqmcWk9EqVf+SKkCo+CAiF39bmSCyuPXOucKkcvc6
         9BqwCvhOH5psaYpONEy2grDTT/ygotPLzUdunW6SVTK8+dcLurn4nftvXiPC+pd1vuuM
         yTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n76MR2hfIZsf6g57SD/GC8wwOFNZ4gbM6KJt3yOpBLs=;
        b=c+798zZHLvXHnD3IlxbFlaXVbhJsptzJwNDGRTZ0wwWX5ss6AnqQipmd2aWJjsMSXO
         LAOT3dHDz+b5KQbwSeGWkMZryI0xqjsDxlBr109xuJnf8lLjur6AkfaOCptB0p5HI2OL
         D4DyEw4Hc9+8GfMRgjuiPlwxPi4iUVwFUShkqh9g9WqY1GIJaX0kDJ3kwIVAjtxb4wsq
         mkeGcSWPAmtYHeLPsA09EUwCsgIZEUD+MyMZFN1azUF+vxG8sJ5rXFPSZQkR44AYTt+Z
         en0yczjTxBUiN2DmS09zEOHQzjfFotmVIqZoJDQ1ljNesM+V4Y3/ga2MfSXKfV7g9R1h
         FxOQ==
X-Gm-Message-State: APjAAAW1lP9eQBAkcTB8tSgmNGcUSXqiWVaLSwSyYpUDM2BMWMlI1D6b
        6SX4DOwRPh8zPFoUo1a8obw=
X-Google-Smtp-Source: APXvYqxch3aaikANJA018nryWRbnsmAci2QcLCKH9CNx4CfFPp5Gcf4OfNOPQkVxewFpcm91NxbQvg==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr6326147wmi.20.1582231497318;
        Thu, 20 Feb 2020 12:44:57 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r6sm902544wrp.95.2020.02.20.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:44:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] clk: meson: meson8b: set audio output clock hierarchy
Date:   Thu, 20 Feb 2020 21:44:33 +0100
Message-Id: <20200220204433.67113-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aiu devices peripheral clocks needs the aiu and aiu_glue clocks to
operate. Reflect this hierarchy in the clock tree.

Fixes: e31a1900c1ff73 ("meson: clk: Add support for clock gates")
Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This takes Jerome's patch for GXBB and ports it to the Meson8* SoCs.
Hence the Suggested-by.


 drivers/clk/meson/meson8b.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9fd31f23b2a9..34a70c4b4899 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2605,14 +2605,6 @@ static MESON_GATE(meson8b_spi, HHI_GCLK_MPEG0, 30);
 static MESON_GATE(meson8b_i2s_spdif, HHI_GCLK_MPEG1, 2);
 static MESON_GATE(meson8b_eth, HHI_GCLK_MPEG1, 3);
 static MESON_GATE(meson8b_demux, HHI_GCLK_MPEG1, 4);
-static MESON_GATE(meson8b_aiu_glue, HHI_GCLK_MPEG1, 6);
-static MESON_GATE(meson8b_iec958, HHI_GCLK_MPEG1, 7);
-static MESON_GATE(meson8b_i2s_out, HHI_GCLK_MPEG1, 8);
-static MESON_GATE(meson8b_amclk, HHI_GCLK_MPEG1, 9);
-static MESON_GATE(meson8b_aififo2, HHI_GCLK_MPEG1, 10);
-static MESON_GATE(meson8b_mixer, HHI_GCLK_MPEG1, 11);
-static MESON_GATE(meson8b_mixer_iface, HHI_GCLK_MPEG1, 12);
-static MESON_GATE(meson8b_adc, HHI_GCLK_MPEG1, 13);
 static MESON_GATE(meson8b_blkmv, HHI_GCLK_MPEG1, 14);
 static MESON_GATE(meson8b_aiu, HHI_GCLK_MPEG1, 15);
 static MESON_GATE(meson8b_uart1, HHI_GCLK_MPEG1, 16);
@@ -2659,6 +2651,19 @@ static MESON_GATE(meson8b_vclk2_vencl, HHI_GCLK_OTHER, 25);
 static MESON_GATE(meson8b_vclk2_other, HHI_GCLK_OTHER, 26);
 static MESON_GATE(meson8b_edp, HHI_GCLK_OTHER, 31);
 
+/* AIU gates */
+#define MESON_AIU_GLUE_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &meson8b_aiu_glue.hw)
+
+static MESON_PCLK(meson8b_aiu_glue, HHI_GCLK_MPEG1, 6, &meson8b_aiu.hw);
+static MESON_AIU_GLUE_GATE(meson8b_iec958, HHI_GCLK_MPEG1, 7);
+static MESON_AIU_GLUE_GATE(meson8b_i2s_out, HHI_GCLK_MPEG1, 8);
+static MESON_AIU_GLUE_GATE(meson8b_amclk, HHI_GCLK_MPEG1, 9);
+static MESON_AIU_GLUE_GATE(meson8b_aififo2, HHI_GCLK_MPEG1, 10);
+static MESON_AIU_GLUE_GATE(meson8b_mixer, HHI_GCLK_MPEG1, 11);
+static MESON_AIU_GLUE_GATE(meson8b_mixer_iface, HHI_GCLK_MPEG1, 12);
+static MESON_AIU_GLUE_GATE(meson8b_adc, HHI_GCLK_MPEG1, 13);
+
 /* Always On (AO) domain gates */
 
 static MESON_GATE(meson8b_ao_media_cpu, HHI_GCLK_AO, 0);
-- 
2.25.1

