Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE16C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0970823126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SrTd/ro7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgELWYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731994AbgELWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B66AC061A0C;
        Tue, 12 May 2020 15:24:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so11971897wmf.1;
        Tue, 12 May 2020 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6/lnxUNaPxPPXlTLJRj6AhR7vTkkb3EZ8aqBlM0OWk=;
        b=SrTd/ro7AvaEauxrrPTxDh3wvmrjWHigYFTwI6OCAchA0LTOoEpBuyhjdECOi3W5JP
         nloq0YQb4LVaFJ6VN6jMc4vp45mu2GK2NfcpiPSB7PZcjFY/G4TJ/29TgVI+riddVEoL
         zUHupnteXosHUlb6g5tBM3MRUBRaAsYsPgJw5YGIK6TJcOeGeHWH2noAhwAjEgJ7xuNp
         NNWp6qZDm9EDrFYn8eWry4sxi1E95y7tlM33Mvgvv9fYzK+5509XDCTKjRnTh53apiu2
         Uz9wc7CXgR42yew0ceWmexHuk4qJEcsX4qtzfW0GyiDsj0ePezsQiGlpEqBQz3rQxeQC
         ZpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6/lnxUNaPxPPXlTLJRj6AhR7vTkkb3EZ8aqBlM0OWk=;
        b=GujbnWv5+SB277d9bNMCbcOMg3wGZsdrrw17pWgFf9Sj+oog6aKn3KdqDh49JdrHra
         VtwaopqEvxgoBFp+Z4gBNoAFtWOXXYN4LDX1YHodlBtUDMBPG+cfD8avIrRplkVFkQzZ
         Lt9bAgXkf6E3KFVQG5u4efqqWOUKck+4Vi7y/kErkHozz//Cylfv0GywlNlbkigvMehY
         n2bE4plcXrlgkIZSIn3+AMjuInZmJ1asWrKqE8n00/J64q5RDgTdD3nIturI3CFJPC4/
         3nuR/fGhLikrlV90HbSjWv8Yoj0d1H410AEo9DV9xeKrCKBVGbALAmeh4SJX2Gc7RPDx
         9t5g==
X-Gm-Message-State: AGi0Puabrw42p9goXtTK0bRxGpri/xJmYIY4xo8QGuTTocyWvIbQxoy7
        5/pjlNMsB8Nk5TR6MI2XsfA=
X-Google-Smtp-Source: APiQypIFFG9NZZdOzQj9vGlbbtC4ygVpYGhkLOO2LmO2sp/3GaDT2eT9UR+jUxCZfNfk8KIGsqyO7A==
X-Received: by 2002:a1c:f211:: with SMTP id s17mr43022273wmc.168.1589322280765;
        Tue, 12 May 2020 15:24:40 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH v2 6/6] phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2
Date:   Wed, 13 May 2020 00:24:24 +0200
Message-Id: <20200512222424.549351-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3.10 vendor kernel sets the ACA_ENABLE bit on Meson8b, Meson8m2 and
GXBB, but not on Meson8. Add a compatible string for Meson8m2 which also
sets that bit.
While here, also update the Kconfig text and MODULE_DESCRIPTION.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/Kconfig            | 2 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 3495b23af797..5ec53874d1ea 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -3,7 +3,7 @@
 # Phy drivers for Amlogic platforms
 #
 config PHY_MESON8B_USB2
-	tristate "Meson8, Meson8b and GXBB USB2 PHY driver"
+	tristate "Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver"
 	default ARCH_MESON
 	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	depends on USB_SUPPORT
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 436dfa1a8a04..03c061dd5f0d 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -302,6 +302,10 @@ static const struct of_device_id phy_meson8b_usb2_of_match[] = {
 		.compatible = "amlogic,meson8b-usb2-phy",
 		.data = &phy_meson8b_usb2_match_data
 	},
+	{
+		.compatible = "amlogic,meson8m2-usb2-phy",
+		.data = &phy_meson8b_usb2_match_data
+	},
 	{
 		.compatible = "amlogic,meson-gxbb-usb2-phy",
 		.data = &phy_meson8b_usb2_match_data
@@ -320,5 +324,5 @@ static struct platform_driver phy_meson8b_usb2_driver = {
 module_platform_driver(phy_meson8b_usb2_driver);
 
 MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Meson8, Meson8b and GXBB USB2 PHY driver");
+MODULE_DESCRIPTION("Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver");
 MODULE_LICENSE("GPL");
-- 
2.26.2

