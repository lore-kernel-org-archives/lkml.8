Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAC6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7741E2137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qg8zpCQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgEBLsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727863AbgEBLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243CC061A0F;
        Sat,  2 May 2020 04:48:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so14953936wrb.8;
        Sat, 02 May 2020 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8Y8vyWaKjvq+2hEsWpjb9Kq65ykf9NzPsAFh4Ba51Q=;
        b=Qg8zpCQ1u60k5Adv5X4albNsxBd5cOJphyEaRw668QCuIQAcUO80mitHI84Wf+ezHu
         DCSUe4xWXO32INPx76D/UA3aaZXV+ZirOTfKbTwEuXsrVLwcaogx1MVqZCzOQTNuoGXm
         UJcGDkbipMc5NqcrzYpoJvCGS+c4HAOL6UhNNlq/jfpwMr10ukz+mVBfs5LsW83clJw7
         ZWocN0itCyqLfmUwCTZpHIJ79A80gIXZC/89GUaEHC//JvImGNYmlpI+UpgPvb9yvnzP
         8yO6fn9Tn06ISbl9VtWDLMx+yUK5ea3u5g9DuY1+BcnbLiyuGp4mc0QjNlOb1d2Ehza9
         fbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8Y8vyWaKjvq+2hEsWpjb9Kq65ykf9NzPsAFh4Ba51Q=;
        b=BEHGH8kcGSSvqZXJWnR/MXc2PuTj3gDsllqYMT8EKiN9S0xFYF5vpuXXt9ZOavGpg7
         UX5c8ChwrJ5/XVS8RhtvejmAOMlzfsUdLgD5bF7qiFWkNdy0blMUjohDT9u8xWs5oViW
         l/pq640K1bU0xX/lTKjvo7ooMm3KBVz0k5/HJo6BXscjh2GS5RMiooezxOwlcKl3+QPb
         M8ximSqrb7m5VgjJ5AaT4xk+8lB5gcFlymhBfzZyyBcJ5KuWQm187ufZjKsZd50C8ctj
         qkpAxNPfXEK79uwUAcHNQlQVLu1ZbV7fqqwvyWUPUhlGsNYuqSP63rJEWify6e6ZJ6tx
         HHDg==
X-Gm-Message-State: AGi0PuYaFGcE44r6/uKSS9dV0hFdof83Ar6XB7iDRPYvsgUJ02+yzKOH
        JxSSAzVuiA9NESJOgPkG/VWFjY9WFo4=
X-Google-Smtp-Source: APiQypJEGjjn2WBJ7BnD+n22PPH7FqjwGuI1I7UOjHzYKUERFtnsyH7o9OB5m4xWhzPPveuM14uX1g==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr8656076wrn.209.1588420113272;
        Sat, 02 May 2020 04:48:33 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/6] phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2
Date:   Sat,  2 May 2020 13:47:52 +0200
Message-Id: <20200502114752.1048500-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
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

