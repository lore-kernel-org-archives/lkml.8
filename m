Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C454C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5744520756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDNxMUxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEPME5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgEPMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:04:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60022C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d21so4972106ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFdlLRF+QWHVp0kmWtaOpTTeJ1VX1CvltfufxnJoxmc=;
        b=kDNxMUxHD0tw6qdcHfGMSbWfVV/pXv9ohp4lk4uazf1X2JeJYVRbJUaSeDxz3vxvS8
         CRPEtRxG7txVO22AQYpEVlr3/FgsEmU0YuzU7uWnXOpJT+JAoFp5svMKAFjTsd+CX3qG
         KTxVAC4z4FEhQ3e2zLiANHVhwRKIDvtidzwwRBFBhnpl75MZFEIToa2AYLfZzLGvAvMj
         fmjqSphqmf9g2h03EHppZaZ90R3hrPTgshVaSdBxmS3R8PKx39bB120ST+kLfhLVsZnP
         fe60qR85bJlQg63m9PiimEt22qRDdwFR5vxpZBn8Xr2lymlwYgfhqcJHwGtKuYrfwvLZ
         2T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFdlLRF+QWHVp0kmWtaOpTTeJ1VX1CvltfufxnJoxmc=;
        b=qwMyEZn/m8LHTF00wlKqeD3dzmtexQi2IJ6WruAaexJjrLXnFmE6vjWzpzekNFaXbf
         32N+SHlf+7obkENxO//t1xd0uTSg8mrOTQ082k/zFxJ1n22PWeAEFgzwena+FjP2Ky5o
         9q+8H3DgnonPMUoY11ozRBVhKpQK3wsbttYkEU4cnyITMFSnqxMELURUIQxjr7JQ+OO5
         OoHd9L1+7DvKtJbKZQeA4gX0FKrcDZxpIsYMjhIVYG0mV1+NEz2vfGgWB44DAxB+ua8K
         Po44s42CuZtROzYtt6y1wzLRhypHkz+vJ+7EwiwcyvE4qZHesobSFOtM1+QJR/Pel08g
         bx7g==
X-Gm-Message-State: AOAM531sw85RC63sxAwkLcT5gKpIC/zXRQqGByoQhh41aAOCCCYV7X+r
        4Q/s3yGPb5ef7HexucLxyU0=
X-Google-Smtp-Source: ABdhPJx8EwzyH1qoZJ9kcNxt/OML62+QNqsVcPSktO5p3bVn/XqIzc4UkppQjcb89cOYAzyxJ4rFPg==
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr3406765ljs.225.1589630690761;
        Sat, 16 May 2020 05:04:50 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id r20sm2581538ljj.44.2020.05.16.05.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:04:50 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, alcooperx@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] phy: phy-brcm-usb: Constify static structs
Date:   Sat, 16 May 2020 14:04:41 +0200
Message-Id: <20200516120441.7627-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
References: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of structs were not modified and can therefore be made const
to allow the compiler to put them in read-only memory.

In order to do so, update a few functions that don't modify there input
to take pointers to const.

Before:
   text    data     bss     dec     hex filename
  15511    6448      64   22023    5607 drivers/phy/broadcom/phy-brcm-usb.o

After:
   text    data     bss     dec     hex filename
  16058    5936      64   22058    562a drivers/phy/broadcom/phy-brcm-usb.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 491bbd46c5b3..99fbc7e4138b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -39,14 +39,14 @@ struct match_chip_info {
 	u8 optional_reg;
 };
 
-static struct value_to_name_map brcm_dr_mode_to_name[] = {
+static const struct value_to_name_map brcm_dr_mode_to_name[] = {
 	{ USB_CTLR_MODE_HOST, "host" },
 	{ USB_CTLR_MODE_DEVICE, "peripheral" },
 	{ USB_CTLR_MODE_DRD, "drd" },
 	{ USB_CTLR_MODE_TYPEC_PD, "typec-pd" }
 };
 
-static struct value_to_name_map brcm_dual_mode_to_name[] = {
+static const struct value_to_name_map brcm_dual_mode_to_name[] = {
 	{ 0, "host" },
 	{ 1, "device" },
 	{ 2, "auto" },
@@ -138,7 +138,7 @@ static int brcm_usb_phy_exit(struct phy *gphy)
 	return 0;
 }
 
-static struct phy_ops brcm_usb_phy_ops = {
+static const struct phy_ops brcm_usb_phy_ops = {
 	.init		= brcm_usb_phy_init,
 	.exit		= brcm_usb_phy_exit,
 	.owner		= THIS_MODULE,
@@ -170,7 +170,7 @@ static struct phy *brcm_usb_phy_xlate(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static int name_to_value(struct value_to_name_map *table, int count,
+static int name_to_value(const struct value_to_name_map *table, int count,
 			 const char *name, int *value)
 {
 	int x;
@@ -185,7 +185,7 @@ static int name_to_value(struct value_to_name_map *table, int count,
 	return -EINVAL;
 }
 
-static const char *value_to_name(struct value_to_name_map *table, int count,
+static const char *value_to_name(const struct value_to_name_map *table, int count,
 				 int value)
 {
 	if (value >= count)
@@ -252,7 +252,7 @@ static const struct attribute_group brcm_usb_phy_group = {
 	.attrs = brcm_usb_phy_attrs,
 };
 
-static struct match_chip_info chip_info_7216 = {
+static const struct match_chip_info chip_info_7216 = {
 	.init_func = &brcm_usb_dvr_init_7216,
 	.required_regs = {
 		BRCM_REGS_CTRL,
@@ -262,7 +262,7 @@ static struct match_chip_info chip_info_7216 = {
 	},
 };
 
-static struct match_chip_info chip_info_7211b0 = {
+static const struct match_chip_info chip_info_7211b0 = {
 	.init_func = &brcm_usb_dvr_init_7211b0,
 	.required_regs = {
 		BRCM_REGS_CTRL,
@@ -275,7 +275,7 @@ static struct match_chip_info chip_info_7211b0 = {
 	.optional_reg = BRCM_REGS_BDC_EC,
 };
 
-static struct match_chip_info chip_info_7445 = {
+static const struct match_chip_info chip_info_7445 = {
 	.init_func = &brcm_usb_dvr_init_7445,
 	.required_regs = {
 		BRCM_REGS_CTRL,
-- 
2.26.2

