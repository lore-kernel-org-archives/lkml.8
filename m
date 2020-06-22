Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF52D2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fwhLeGUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgFVJmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgFVJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB7C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so15034719wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6LOSRZxGizpxzfF22Sv14N1k+l2XBln54kSc7WXTbU=;
        b=fwhLeGUTHzaOn5r0hKFAxOrI/4bP6cRMLAZ9vxuMsWmVTbLCLBfuv2c3zx2K+9WkzC
         4510agGDHbhXy4FxLo2y6wSgQ64p20rVWdVPiqvbTzNx3rKJ0wAQIRkSuhTdzUPDyq33
         EGJ7dP781SaoA69mOAe2VG//Mj+PraeucVuHaZFWBoluRKQxOPm81fI00ykep20zlmSB
         RPZYYFefMuTBJhmo6T+gCbA2sk4rO/dFZ8SsuCQmoiiBtm5IHQMXEHE2Tj3zbDGXmqd+
         33R1jARght4O0k5GCattCXLy0yW2yV908NCQr9OgF+g3eygrEUkhQhtDWFMWiBtAcU50
         OBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6LOSRZxGizpxzfF22Sv14N1k+l2XBln54kSc7WXTbU=;
        b=i3kX041onrg+oRobuFTBc58AXC6mzWcwajVcpRrfhukvsGeCMIf6VyMX2VVKeKRRHb
         HawFq6x+A9chOHYlZd6+HoFoESE5CWonXo0VaAAvMIPhSh9VAFHS6p05lHsB7qpI46gd
         AumY5XSWNhRYbJRJmkFbRIy8c34A1OQHdFFhAc123riUwEfcpFLw4MxziK9VJHBxs1Np
         5FioyxRHPYArufRWjqWdNCkcalIDWSfQMNPflsvQlwFmmrBrFlwSdpLKKRHNjDRq8AKQ
         BIGQii0ZwSJG3MtP0b/ZqA5U12c1R01J0PN9fquz2ZH5MqVqD8CKTU99P5GAHNx0NwRp
         ETnA==
X-Gm-Message-State: AOAM531B9ee9BGVDLwAtPxedmOG72WVjtHxVfisS3PJAOmZ2TLwWu6ZX
        eYV32FWCkaVjTvCqkYbfUgJluw==
X-Google-Smtp-Source: ABdhPJxKaZTzwaRgXjyD3lQOmmZEDuZrxf5WMvWd8aJTlxKoe6V5StaOUPB2OradOOO/ubvV2pVenA==
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr17253456wmf.162.1592818903618;
        Mon, 22 Jun 2020 02:41:43 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/15] dt-bindings: mdio: add phy-supply property to ethernet phy node
Date:   Mon, 22 Jun 2020 11:37:41 +0200
Message-Id: <20200622093744.13685-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622093744.13685-1-brgl@bgdev.pl>
References: <20200622093744.13685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The phy-supply property is often added to MAC nodes but this is wrong
conceptually. These supplies should be part of the PHY node on the
MDIO bus. Add phy-supply property at PHY level to mdio.yaml.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/net/mdio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index d6a3bf8550eb..9c10012c2093 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -90,6 +90,10 @@ patternProperties:
           Delay after the reset was deasserted in microseconds. If
           this property is missing the delay will be skipped.
 
+      phy-supply:
+        description:
+          Phandle to the regulator that provides the supply voltage to the PHY.
+
     required:
       - reg
 
-- 
2.26.1

