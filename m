Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134ABC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E784620575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aqWwwtgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgD0Mke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:40:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgD0Mke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:40:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RCeKGd125471;
        Mon, 27 Apr 2020 07:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587991220;
        bh=QmZqYVuJhQpW5Co25n8i1nFbhw4FdWBDF8vcXnV1ylo=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=aqWwwtgq9GgYesv+T+gPxuEjNsQbwnv+4X5z77RLPfhWAVs+MJs4rF9XNnTGrNFIv
         Msak3ATjQa0gBX/wrRUGupH0dQjWgVkGlZVRKUmGg7IbCZdut+DUcNu62Wqxx7Pdk9
         q7+VnAchFIrao2AjzXGIFcqeFs17tmFSzkjOtq68=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RCeKuU114941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 07:40:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 07:40:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 07:40:19 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RCeH4I088463;
        Mon, 27 Apr 2020 07:40:18 -0500
Subject: Re: [PATCH] phy: samsung: s5pv210-usb2: Add delay after reset
To:     Jonathan Bakker <xc-racer2@live.ca>,
        <linux-kernel@vger.kernel.org>, <s.nawrocki@samsung.com>,
        <kamil@wypas.org>, <krzk@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
References: <BN6PR04MB06605D52502816E500683553A3D10@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <979ae7cd-2648-c516-1465-3a1507d5fefb@ti.com>
Date:   Mon, 27 Apr 2020 18:10:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB06605D52502816E500683553A3D10@BN6PR04MB0660.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 4/25/2020 11:06 PM, Jonathan Bakker wrote:
> The USB phy takes some time to reset, so make sure we give it to it. The
> delay length was taken from the 4x12 phy driver.
> 
> This manifested in issues with the DWC2 driver since commit fe369e1826b3
> ("usb: dwc2: Make dwc2_readl/writel functions endianness-agnostic.")
> where the endianness check would read the DWC ID as 0 due to the phy still
> resetting, resulting in the wrong endian mode being chosen.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/phy/samsung/phy-s5pv210-usb2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/phy/samsung/phy-s5pv210-usb2.c b/drivers/phy/samsung/phy-s5pv210-usb2.c
> index 56a5083fe6f9..32be62e49804 100644
> --- a/drivers/phy/samsung/phy-s5pv210-usb2.c
> +++ b/drivers/phy/samsung/phy-s5pv210-usb2.c
> @@ -139,6 +139,10 @@ static void s5pv210_phy_pwr(struct samsung_usb2_phy_instance *inst, bool on)
>  		udelay(10);
>  		rst &= ~rstbits;
>  		writel(rst, drv->reg_phy + S5PV210_UPHYRST);
> +		/* The following delay is necessary for the reset sequence to be
> +		 * completed
> +		 */
> +		udelay(80);

Please fix the following checkpatch check error.
CHECK: usleep_range is preferred over udelay; see
Documentation/timers/timers-howto.rst
#151: FILE: drivers/phy/samsung/phy-s5pv210-usb2.c:145:
+               udelay(80);

total: 0 errors, 0 warnings, 1 checks, 10 lines checked

Thanks
Kishon
