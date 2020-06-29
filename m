Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F580C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CDE2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ll/Jzj6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgF2Sm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgF2Smo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06610C031C70;
        Mon, 29 Jun 2020 11:03:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so13135952eje.7;
        Mon, 29 Jun 2020 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDek8r7LVAlQow/T56rpM0Mc0RAnfT3YmV7KyKIShqI=;
        b=Ll/Jzj6e8E7W0z4YvPrYwL5WQz9XTQod0TDSEmqcpjxqZk5M9nLAVisVGz45+a5XjA
         bCrZsbqa82HIWtilj1auvdCn/SPpq7BotwvO6OnP9hWLZIBg237YZxGUMXxEqUwVmasm
         EjWnzX7mL7eDV2pK5wSRfxfentHcXKyQPlAnywC6tukq/G+Ed/0HePHVcmWDQP4Ntin6
         2c9cZHDieeLJ2veSQmr4nDhgNX3XnpZNenHB3v/rcxaZ9SjLi6rrqtC3l9wyCyP0qTpH
         pWqFtp7nHHsRkXRUvJfUMjghm446ANL0ReYuNV9DIZBWuAcp5fSMqNLArA9REK62hNSd
         qiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDek8r7LVAlQow/T56rpM0Mc0RAnfT3YmV7KyKIShqI=;
        b=mJKseGqy1CaEi9MOO09/8ZZpYAAjLgWzV8W5Z1UpMk5OpsfAAdtB06hbnFFWnYbk7i
         WtXWbddKD/SszKMO2PFo4JcPM3mreipzXh4Yz2F24g87epN7c9Dn6G6FpostV/xx0nvi
         c8EmXkt3IrtuTNBta1vNn5hkm2FqfbFgheKHNVHCb4IzYbMjkfVne15dfG7VLQrjTJ9r
         9vBpqZWi5mEcxwEopsJq3FzX3BuYqDTsY8KNfROGjbHMha4NA95+RmSTgcj0OsnOHSjD
         GKOhrPdoA34TK/pbKMFkGINhGn7dJszyjNpGHO1UNemd9KE+Gw1Ycvk5vWizQ9y+SyGi
         2CWw==
X-Gm-Message-State: AOAM530B4IGXeNyIi0T12Pb+GLfqGFsMhGdSegSwvCOWC89Ulz3C7SAx
        YTaahDJcY4FctsmIH8YCjrwn2l9b
X-Google-Smtp-Source: ABdhPJwJJLAz8V9se/DJFmod23ChA3LmTLg4Fx00dNp+8eKcmvyS6wwPKQmKk9dxyMMpvQvw20cf/g==
X-Received: by 2002:a17:906:26c3:: with SMTP id u3mr14456646ejc.483.1593453801692;
        Mon, 29 Jun 2020 11:03:21 -0700 (PDT)
Received: from localhost.localdomain (p200300f137396800428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3739:6800:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id w17sm235449eju.42.2020.06.29.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:03:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marex@denx.de,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC for-5.8] usb: dwc2: Cleanup debugfs when usb_add_gadget_udc() fails
Date:   Mon, 29 Jun 2020 20:03:14 +0200
Message-Id: <20200629180314.2878638-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call dwc2_debugfs_exit() when usb_add_gadget_udc() has failed. This
ensure that the debugfs entries created by dwc2_debugfs_init() are
cleaned up in the error path.

Fixes: 207324a321a866 ("usb: dwc2: Postponed gadget registration to the udc class driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This patch is compile-tested only. I found this while trying to
understand the latest changes to dwc2/platform.c.


 drivers/usb/dwc2/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c347d93eae64..02b6da7e21d7 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -582,12 +582,14 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		retval = usb_add_gadget_udc(hsotg->dev, &hsotg->gadget);
 		if (retval) {
 			dwc2_hsotg_remove(hsotg);
-			goto error_init;
+			goto error_debugfs;
 		}
 	}
 #endif /* CONFIG_USB_DWC2_PERIPHERAL || CONFIG_USB_DWC2_DUAL_ROLE */
 	return 0;
 
+error_debugfs:
+	dwc2_debugfs_exit(hsotg);
 error_init:
 	if (hsotg->params.activate_stm_id_vb_detection)
 		regulator_disable(hsotg->usb33d);
-- 
2.27.0

