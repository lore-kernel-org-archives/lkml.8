Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB57EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102420771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pppe01No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgDHSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:14:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgDHSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:14:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so8968362wrx.9;
        Wed, 08 Apr 2020 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vldV9JJykEkruZKth3hZnteRVICe4AENDSg+Cses34=;
        b=Pppe01NoQ9wjByFo4RxMIwrmC3PVJTi+a+oJj2ggrC1zqPg5ES5gGVhg3Mo7G4p6Zr
         O04YuP4l3wGFqLGXf9v/TFEP3Fxm3u7o3k3H/BGhPnJbo3zErCQEF1bi6DpYh+kEkkHv
         38IZtuAfSLvaPkbN3fNXOMKxKae9Ue2OgOfI4Fw9AABXsLNueNLltR/RHUpwHvpFCSgI
         mNu7Qe8sz6THA19V7JwmoZ6BXSbPDNWCseMdZmeljFcFd9As4a6XyB5MT4Ia3M+JIlop
         lPzimqydfWcpSM7IObt2RLGkp+MbSPv9xr37kcSugsDI7F3K99oywzG5AUKL4zdxEXn0
         aHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vldV9JJykEkruZKth3hZnteRVICe4AENDSg+Cses34=;
        b=VxQ+J4Ue3ahyGEM0bH8iso4CbJT/EK7T6RupPlY7TzhVrqah7DHvN4Av8bZyWTAw2K
         N6OeULmqzwdgvGa1iBVnfnoxFKJDSC7ASi/cyHaTXdZ4i+gbU0bb21DONNLEdCyC5v5T
         BJGF+UG6SBilEyRuhSLTTQ3A5prRx9834IedsNf7xpKCsidK/moe8QH0lfD7yUknXLFt
         li35m0poL6I2nyElSRio7uz5NRC2p2+856lhWWnRwRC//Xyvmiwu32U8tiyLaUn7Ju/z
         GQ+Iv1WqEaUHu5M1/NKpUjSqNk3JCeTCitVY+RXqJ4tNh64pE5NxMVqdE6hT6ReOsApD
         eB/w==
X-Gm-Message-State: AGi0Pubv2qkR/agI77xfs9copMcMTAuFSWKHSYMv+XO4MkfP/ZVl9nL3
        dmd9wCvvz03T76crFPJakBto/LwfpKw=
X-Google-Smtp-Source: APiQypKFKdouvw1RyMhM0e5AJC7Eaea9Ga/I+TK5C7PlAQvCe7NXQtS6CJXZPOgxPiCQPWl0SbltZw==
X-Received: by 2002:a5d:6102:: with SMTP id v2mr9598460wrt.298.1586369685286;
        Wed, 08 Apr 2020 11:14:45 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n124sm441700wma.11.2020.04.08.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:14:44 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Wed,  8 Apr 2020 14:14:04 -0400
Message-Id: <20200408181406.40389-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408181406.40389-1-alcooperx@gmail.com>
References: <20200408181406.40389-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/xhci-plat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 1d4f6f85f0fe..44406d0eb317 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -112,6 +112,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.quirks = XHCI_RESET_ON_RESUME,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -147,6 +151,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "brcm,xhci-brcm-v2",
+		.data = &xhci_plat_brcm,
+	}, {
+		.compatible = "brcm,bcm7445-xhci",
+		.data = &xhci_plat_brcm,
 	},
 	{},
 };
-- 
2.17.1

