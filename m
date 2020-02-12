Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD47C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DBA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GDcPSf4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBLKuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:50:20 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48934 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:50:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CAo3qA007091;
        Wed, 12 Feb 2020 04:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581504603;
        bh=tGlCcRo7L8jqssPN+fgSS2AfAreHI8YYpQ5+aQblHEM=;
        h=To:CC:From:Subject:Date;
        b=GDcPSf4AOX5R5jIIcEdH9eiWcOOJlh1mDi2Amh4r2nC2qeD365Nr+NxTmGm4fjj/t
         LhdbbCHEAciZp5tU8BHbV5XGmJjGViY0p2RuTvKtXE1kxOqhUCa2+Ap2YpdvAShU5Y
         sYg+afeVKV2Qk7v6pOBFaxbNegZkXMkqwy7osJ+g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01CAo3QA019833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 04:50:03 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 04:50:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 04:50:02 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CAnxPt126968;
        Wed, 12 Feb 2020 04:50:00 -0600
To:     <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>
CC:     <stefan.wahren@i2se.com>, <afaerber@suse.de>, <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Subject: dma_mask limited to 32-bits with OF platform device
Message-ID: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
Date:   Wed, 12 Feb 2020 12:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to understand why of_dma_configure() is limiting the dma and coherent masks
instead of overriding them.

see commits
a5516219b102 ("of/platform: Initialise default DMA masks")
ee7b1f31200d ("of: fix DMA mask generation")

In of_platform_device_create_pdata(), we initialize both masks to 32-bits unconditionally,
which is fine to support legacy cases.

	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
         if (!dev->dev.dma_mask)
                 dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

Then in of_dma_configure() we limit it like so.

         dev->coherent_dma_mask &= mask;
         *dev->dma_mask &= mask;

This way, legitimate devices which correctly set dma-ranges in DT
will never get a dma_mask above 32-bits at all. How is this expected to work?

For a test, I added this in dra7.dtsi sata node. (NOTE: CONFIG_ARM_LPAE=y)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 93aa65c75b45..cd8c6cea23d5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -571,6 +571,8 @@
  		sata: sata@4a141100 {
  			compatible = "snps,dwc-ahci";
  			reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
+			#size-cells = <2>;
+			dma-ranges = <0x00000000 0x00000000 0x10 0x00000000>;
  			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
  			phys = <&sata_phy>;
  			phy-names = "sata-phy";

----------------------------- drivers/of/device.c -----------------------------
index e9127db7b067..1072cebad57a 100644
@@ -95,6 +95,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
  	const struct iommu_ops *iommu;
  	u64 mask, end;
  
+	dev_info(dev, "of_dma_configure\n");
  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
  	if (ret < 0) {
  		/*
@@ -123,7 +124,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
  			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
  			return -EINVAL;
  		}
-		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
+		dev_info(dev, "dma %llx paddr %llx size %llx\n", dma_addr, paddr, size);
+		dev_info(dev, "dma_pfn_offset(%#08lx)\n", offset);
  	}
  
  	/*
@@ -152,6 +154,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
  	mask = DMA_BIT_MASK(ilog2(end) + 1);
  	dev->coherent_dma_mask &= mask;
  	*dev->dma_mask &= mask;
+
+	dev_info(dev, "end %llx, mask %llx\n", end, mask);
  	/* ...but only set bus limit if we found valid dma-ranges earlier */
  	if (!ret)
  		dev->bus_dma_limit = end;

And I see.

[    1.134294]  4a140000.sata: of_platform
[   13.203917] ahci 4a140000.sata: of_dma_configure
[   13.225635] ahci 4a140000.sata: dma 0 paddr 0 size 1000000000
[   13.266178] ahci 4a140000.sata: dma_pfn_offset(0x000000)
[   13.297621] ahci 4a140000.sata: end fffffffff, mask fffffffff
[   13.585499] ahci 4a140000.sata: dma_mask 0xffffffff, coherent_mask 0xffffffff
[   13.599082] ahci 4a140000.sata: setting 64-bit mask ffffffffffffffff

Truncation of dma_mask and coherent_mask is undesired in this case.

How about fixing it like so?

- 	dev->coherent_dma_mask &= mask;
-	*dev->dma_mask &= mask;
+ 	dev->coherent_dma_mask = mask;
+ 	*dev->dma_mask = mask;

Also this comment doesn't make sense anymore?

         /*
          * Limit coherent and dma mask based on size and default mask
          * set by the driver.
          */

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
