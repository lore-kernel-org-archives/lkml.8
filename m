Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43994C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1173121974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EouHjzqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgEHVUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgEHVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDECC061A0C;
        Fri,  8 May 2020 14:20:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so12233276wma.4;
        Fri, 08 May 2020 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=EouHjzqzm/494wG6EcB1CIMJYU4kdLHbavWF8FuDc6i3pyLM8HI1UyMXx781m+Famw
         4Br/r8lBNPieXkek0it5gU4JKPyfZScUSdz+rc4v6JX+4m9zWkPpVRR73fcCOdExNGOL
         sHSR7aryRPASpZaz4r5N70NqZ/9+mQWJhihoY+Gj68WJ5NM5AKctldERP75GTct90yDm
         9Oz2t0hjkMqqfnJM7Zo0O8zZKmtRsHuAduznbrYbdFGEqe+BjaXC+EWa0XNnOnaxM/14
         QW/FaXs4GZUPD1KDSSMcoYn7eHf3KPNyN3hu4fYxe0I9ANeiJy9OmcVP81lv2h/o18UM
         wKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=Ai+UGRay3UedwfIc0bUOXtH6Q1cTrjUBsUJDuvqJWR/14PKgYv9irUxbXzVl9mTFSU
         Qtv3WK4Jfi/2jiIIhRbjKDGEoz7KM5GoreUvIAdsxKoMbgRrI0ip2cPADmtaMVCuEHHQ
         afL1Exr+S+4CLLK9Oxf3NMkSOs6FmQIu3oAIXcHBiXJSKZp1B7oSZMeVtfSp1NXVZsej
         PDC5bNQy4v+zElKZ0ljl7kFVyZBhN+FHCCrw+UsnvKTT2lEnamwgh1vcpwO0Y3hfpWVb
         TPwa0xlTuHPtSan1HRDOBuHzDG1Cj9mRZm+tYA8tRIpDEIfrFYW5WzQeXTZnmcfDV1vF
         fLIA==
X-Gm-Message-State: AGi0PuaFQgubH8U6hSCefufF8jzUsjC90PrUpAPh/K7bUTfAujX9Y0IA
        BjXJI4oPbrHJFcHb6J+WYhYn09sYwxI=
X-Google-Smtp-Source: APiQypL9SvSACY/ptDdzKnQdmAQ81UAswVboa0ILmySMCSCfOVnPumxavUbh4Kfxq9thk5duJGYnQw==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr17972530wme.139.1588972804547;
        Fri, 08 May 2020 14:20:04 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n9sm4669705wrv.43.2020.05.08.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:20:04 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v8 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Fri,  8 May 2020 17:19:27 -0400
Message-Id: <20200508211929.39020-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508211929.39020-1-alcooperx@gmail.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
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

