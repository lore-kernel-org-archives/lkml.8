Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0A20787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vGsB2hyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCZNpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgCZNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so6511844wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgm3f5ndT4SRxsUOGSFj42TYFBt6uTox34hQIqIPD3M=;
        b=vGsB2hyfU43rwlef6flGgMOkxhQmUE9TjoLs/7igSqI2YagDre8H9juTWABuxvaXwg
         Y8ezn8Xfq12EC8M3aAeIFAcutFpWbw3h8UDC//DESdqYnkigvkmP4sJpH7hMtnKjBUmU
         xoEmFqNdltbGsLrjVWYBNP8MNTC92SwU9Ek0eqfcyOt/OGS4xvc4akTavDrV2MJNed2s
         rzX7xY8ADUkUMvbP6vU3WW8hyeknd4hZ44DkDkLzb07HGPVxDhPabgK7mC8ApFnvz0Ff
         zpAqIla+twnHkGeYdG0K/9e5vELTWkWbyoeb7SUzEAhkkckNd2gJ+cW3vV79pOVuNb6h
         reSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgm3f5ndT4SRxsUOGSFj42TYFBt6uTox34hQIqIPD3M=;
        b=FEp5/LOFgghiHnm0M1IzHxmPy1S1s78P05vycj1BfUDYwMt6Zbq6QSaEY/lmiMG2sl
         ziNTMqdRmgRkg7jdW1zOC0IWGgmfWzl80NpYU/HBWJ5HHbGEeHZc8UhNQ0ZAtTpJAknc
         koH5S9GwNQKkzN27Gb0AwWiTtz9zbFQljzCKP4sTsrElxXN+ozJOOHqOY7Sf8L7xhfJc
         7X7rMxJ197/xN5SDGidlVp4dinGhI2xX9hEVHXqSaBe4vqluCzJ6a0v1tkFixJQ74pEc
         Ht+CWql2ZcR6BBQX5bPIWiJKHlUmqmTn9loOCvNnBOz5dOht9T0BH9Qgxwtq8Tlqsx6R
         rBCA==
X-Gm-Message-State: ANhLgQ1Xio2Mt1oehhtVXLjY3ZeUDJUqjErWDIGHAzkLst1uoLIm8IrX
        pHuhoIgrp5hMAsF2E2qFQSq+cA==
X-Google-Smtp-Source: ADFU+vtuhNxkkXsqiMUzpNuOC+DDKVN6iwl4HMpoiDzFb7EFa0attish9ohgWqYq8mDlRojsNCxpwg==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr40738wmd.186.1585230315865;
        Thu, 26 Mar 2020 06:45:15 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] usb: dwc3: meson-g12a: get the reset as shared
Date:   Thu, 26 Mar 2020 14:44:56 +0100
Message-Id: <20200326134507.4808-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the Amlogic GXL/GXM SoCs, the reset line must
be handled as shared since also used by the PHYs.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 37ef08493e37..41bcbd31fe4e 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -564,7 +564,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->reset = devm_reset_control_get(dev, NULL);
+	priv->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(priv->reset)) {
 		ret = PTR_ERR(priv->reset);
 		dev_err(dev, "failed to get device reset, err=%d\n", ret);
-- 
2.22.0

