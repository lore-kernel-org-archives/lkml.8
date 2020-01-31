Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B4C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8016206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580484423;
	bh=feaXjJSyIbn/V2Z1XTQcyhK42e4ZQjLyMkNzPk0RkS4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gdSBBmN2D1/8Hbq+dRcCdMTnFbo88bl5yJd6Bps28cKV4RLJy0DEsYBJ4+HeFUgxX
	 DSsjiDe1bOEVv18Dvf8mKChbHk50DI7Xrie/M/WOhtnmdANQIxlFiS0nJeRn2unLrN
	 4bM5c2eNQ7EOnaoM/6TCsjws2OJaWPa5JzbUP2DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgAaP1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:27:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33545 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:27:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so7644647oig.0;
        Fri, 31 Jan 2020 07:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ez089ynUc+TlcDcX+4cLFbd8sndHHgz7Rvi4njg721E=;
        b=eUs1klp55sINKzFBcDGM6q8hMj8UoPnCwA/AvRtxmgspQPfHD9Bo4qt23yExM49NAf
         KMhKMPo0ExqQ+13NEpHLAQavSPG8w2KtY1aOYvm3mIrqshwcjFsFYByBjSiyhRny5vTe
         QyUg29ZdbnQBqlvq4kHwbnKQB1S8apf0nsSoMxA/udlFDTj8kE0+GvHU/NNav2pCzNxB
         OhHEJS/mjshNnUXj3zJkmdz9dtC3VR5tiN2RVlLz6TbZz7S1cqpWHT/+0U0aBBQQgsuI
         n5XT8dXg5MJYPIWlLEHzQYHGIYxIiUK0SDIQWxEhWiQdXV0hY5hWbMte9SpfCGEHiHrZ
         sWHA==
X-Gm-Message-State: APjAAAXZqZxT5LlBrLIC4fYqSf393JZyXUroWqa48R/MzirKlbAw35O6
        j70Y209n5XW2kLaOkhbtaxuNDNQ=
X-Google-Smtp-Source: APXvYqxODx8i3br92Jg61geRQgay0X2fzeI7on0ikwKe72gAs1CdViMHUpR123f+RfYosTzistdCzw==
X-Received: by 2002:aca:af09:: with SMTP id y9mr6304826oie.101.1580484421558;
        Fri, 31 Jan 2020 07:27:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p83sm2722525oia.51.2020.01.31.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 07:27:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] dt-bindings: phy: Fix errors in intel,lgm-emmc-phy example
Date:   Fri, 31 Jan 2020 09:27:00 -0600
Message-Id: <20200131152700.18392-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT labels can't have '-' in them causing a compile failure in the example.
Fixing that leads to more warnings:

Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:23.13-33: Warning (reg_format): /example-0/chiptop@e0200000/emmc-phy@a8:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.33-26.13: Warning (avoid_default_addr_size): /example-0/chiptop@e0200000/emmc-phy@a8: Relying on default #address-cells value
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.33-26.13: Warning (avoid_default_addr_size): /example-0/chiptop@e0200000/emmc-phy@a8: Relying on default #size-cells value

Fixes: 5bc999108025 ("dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY")
Cc: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I will apply this to the DT tree for -rc1.

 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index ff7959c21af0..0ccee64c6962 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -45,8 +45,10 @@ examples:
     sysconf: chiptop@e0200000 {
       compatible = "intel,lgm-syscon", "syscon";
       reg = <0xe0200000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <1>;
 
-      emmc-phy: emmc-phy@a8 {
+      emmc_phy: emmc-phy@a8 {
         compatible = "intel,lgm-emmc-phy";
         reg = <0x00a8 0x10>;
         clocks = <&emmc>;
-- 
2.20.1

