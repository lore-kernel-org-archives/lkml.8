Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF322073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtBwOWCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCFP0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:26:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33530 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:26:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id x7so2858889wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONRnUi9jCMqmOjWyWhiAOr6JoGLpum+q//SeY+50q00=;
        b=EtBwOWCB8Ya/o0z2Yco05wvblUtQI2zyqVRqZpCasqMRRE4gDV0h7u2++BIVbdj+Mn
         DKBCtp5W397rvpQ8Qdy3ZioawfGcJRWi3SdTdgY2QXHLdR0YnPv1imeM/i+MO6jYw/n3
         dlrIbUH43oAWu0uNMi4LgUn7ncSRN9eCtnWeMivh+k63vtvd+XveKjqU+46wxfATiQGq
         CDb/fdJSdcLW7DGOTToq4sILmAbrOA76IzusUbKITanbGVXJOr7dWUQMupaAU/6gcwHV
         uqF8/hC9iNSZ+WYW3i1fx4UFgu6XzEUtVcUKYLx2JYumzdteBFq8tPUPlt3PpFPFn8+E
         fZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONRnUi9jCMqmOjWyWhiAOr6JoGLpum+q//SeY+50q00=;
        b=E2LWRoi+sfw9//q1BhPepYJpd++b+r9MK0YhcJ4E18CkIMrT8NcgFZ8BzGNq7GHasb
         WG+wY9uv8a/jqxd6qK/vRyxIYROlG8zpX2RC3Nac0E21mbp570qaDU7EceQlghdQZSR/
         1HvTDJotizrUXv/clXS/G4hKwegCPDkhlUWqk5gdHjFjaoAd5xf/VTTqtWNzqKR/upLn
         EODDeXrioNyyHyfWfQgBH1ua1PNcXdTn6Fr0YHGQysSPSD5quU89U5igWTXbprf2LSIa
         /awiDB0WyfdL8z2DX19G67wZkvPUIIRPtqw0FMyCqToHl7bTXXZrnxNbMEVKKVGP4N/S
         2O+Q==
X-Gm-Message-State: ANhLgQ1ps2+3UP28LQ+FHFu+2lqwkLEQyavMAO1dZm5OQ2tTmTgudaCJ
        EcXiFi8OPSRlxTUabJ8rg0jdGg==
X-Google-Smtp-Source: ADFU+vvm+PP7qjGjgcl5L4VdutX0/oiHXqeGOVQ/NtI7UQPw+oZlGMEa5zIUH/oKXKZzohqiAUPqSg==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr4488258wrr.244.1583508398849;
        Fri, 06 Mar 2020 07:26:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id i14sm1902968wmb.25.2020.03.06.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 07:26:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: wcd9335: fix address map representation
Date:   Fri,  6 Mar 2020 15:26:33 +0000
Message-Id: <20200306152633.25836-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slimbus addresses are 16 bit wide, masking page numbers
to wcd register at offset of 12 will limit the number for pages.
So it becomes impossible to write to page 0x10 registers.
Remove masking 0x800 (slimbus address range) from register address
and making use of window parameters in regmap config should fix it
and also will represent the registers exactly inline with Datasheet.

Remove this unnessary masking and make the registers be inline
with datasheet.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 18 +++++++++---------
 sound/soc/codecs/wcd9335.h |  7 ++++---
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f11ffa28683b..700cc1212770 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4926,11 +4926,11 @@ static const struct regmap_range_cfg wcd9335_ranges[] = {
 		.name = "WCD9335",
 		.range_min =  0x0,
 		.range_max =  WCD9335_MAX_REGISTER,
-		.selector_reg = WCD9335_REG(0x0, 0),
+		.selector_reg = WCD9335_SEL_REGISTER,
 		.selector_mask = 0xff,
 		.selector_shift = 0,
-		.window_start = 0x0,
-		.window_len = 0x1000,
+		.window_start = 0x800,
+		.window_len = 0x100,
 	},
 };
 
@@ -4968,12 +4968,12 @@ static const struct regmap_range_cfg wcd9335_ifc_ranges[] = {
 	{
 		.name = "WCD9335-IFC-DEV",
 		.range_min =  0x0,
-		.range_max = WCD9335_REG(0, 0x7ff),
-		.selector_reg = WCD9335_REG(0, 0x0),
-		.selector_mask = 0xff,
+		.range_max = WCD9335_MAX_REGISTER,
+		.selector_reg = WCD9335_SEL_REGISTER,
+		.selector_mask = 0xfff,
 		.selector_shift = 0,
-		.window_start = 0x0,
-		.window_len = 0x1000,
+		.window_start = 0x800,
+		.window_len = 0x400,
 	},
 };
 
@@ -4981,7 +4981,7 @@ static struct regmap_config wcd9335_ifc_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.can_multi_write = true,
-	.max_register = WCD9335_REG(0, 0x7FF),
+	.max_register = WCD9335_MAX_REGISTER,
 	.ranges = wcd9335_ifc_ranges,
 	.num_ranges = ARRAY_SIZE(wcd9335_ifc_ranges),
 };
diff --git a/sound/soc/codecs/wcd9335.h b/sound/soc/codecs/wcd9335.h
index 4d9be2496c30..72060824c743 100644
--- a/sound/soc/codecs/wcd9335.h
+++ b/sound/soc/codecs/wcd9335.h
@@ -8,9 +8,9 @@
  * in slimbus mode the reg base starts from 0x800
  * in i2s/i2c mode the reg base is 0x0
  */
-#define WCD9335_REG(pg, r)	((pg << 12) | (r) | 0x800)
+#define WCD9335_REG(pg, r)	((pg << 8) | (r))
 #define WCD9335_REG_OFFSET(r)	(r & 0xFF)
-#define WCD9335_PAGE_OFFSET(r)	((r >> 12) & 0xFF)
+#define WCD9335_PAGE_OFFSET(r)	((r >> 8) & 0xFF)
 
 /* Page-0 Registers */
 #define WCD9335_PAGE0_PAGE_REGISTER		WCD9335_REG(0x00, 0x000)
@@ -600,7 +600,8 @@
 #define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE	BIT(0)
 #define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_DISABLE	0
 #define WCD9335_CDC_TOP_TOP_CFG1	WCD9335_REG(0x0d, 0x082)
-#define WCD9335_MAX_REGISTER	WCD9335_REG(0x80, 0x0FF)
+#define WCD9335_MAX_REGISTER	0xffff
+#define WCD9335_SEL_REGISTER	0x800
 
 /* SLIMBUS Slave Registers */
 #define WCD9335_SLIM_PGD_PORT_INT_EN0	WCD9335_REG(0, 0x30)
-- 
2.21.0

