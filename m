Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D78FC34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698B206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BJZU9EU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRI2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:28:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41842 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgBRI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:28:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01I8SW4U066945;
        Tue, 18 Feb 2020 02:28:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582014512;
        bh=KxsGlJLlQqpQOFPAW8G1D3lM/rR4M+CFCA+c33IlSfI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BJZU9EU2/oSzVLAqxKpS3NaSJSmxtqOGyzAn3JnmVx2F/fnRAi7lS7qygRpcyhYIy
         I+Rdv6pSGJ+v/oqoz89l+m5n9NdQGvuTfdWboAxce9ZoSheZ12ILHmCXptQPyEOMUI
         ANaj3/ybFaHWk/DRl9VzRv4viUXntW/wIv2IpyGQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01I8SWab094063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 02:28:32 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 02:28:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 02:28:30 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01I8SREa008811;
        Tue, 18 Feb 2020 02:28:27 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        <stefan.wahren@i2se.com>, <afaerber@suse.de>, <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
 <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
 <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
 <20200217132133.GA27134@lst.de>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b3c56884-128e-a7e1-2e09-0e8de3c3512d@ti.com>
Date:   Tue, 18 Feb 2020 10:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217132133.GA27134@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chrishtoph,

The branch works fine for SATA on DRA7 with CONFIG_LPAE once I
have the below DT fix.

Do you intend to send these fixes to -stable?

------------------------- arch/arm/boot/dts/dra7.dtsi -------------------------
index d78b684e7fca..853ecf3cfb37 100644
@@ -645,6 +645,8 @@
  		sata: sata@4a141100 {
  			compatible = "snps,dwc-ahci";
  			reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
+			#size-cells = <2>;
+			dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;
  			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
  			phys = <&sata_phy>;
  			phy-names = "sata-phy";


cheers,
-roger

On 17/02/2020 15:21, Christoph Hellwig wrote:
> Roger,
> 
> can you try the branch below and check if that helps?
> 
>      git://git.infradead.org/users/hch/misc.git arm-dma-bus-limit
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-bus-limit
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
