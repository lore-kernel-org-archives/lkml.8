Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A202C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EED120737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hW/IwaIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgICHYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:24:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40594 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgICHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:24:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0837NiCe018361;
        Thu, 3 Sep 2020 02:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599117824;
        bh=BdMcfk7mKlIUdjEAq+VRlXKBmSbVXPDgc1l6pkmOA7o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hW/IwaIAdNdnDU+v9/vyXaVafOVA6mmWSPNAnOsbLJTpPOjr1PIN6w9d1AY/I+cWK
         xCJFRnE4Llr/SRmaBAyQrObTLjVNM3Atvvq23zGVy6BDtpXBkIaEve2lhZN7vzy8sf
         P9plX1XlNEr6VGHh+TmH3jhq+ly8CfrPVu34CIto=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0837Ni3x117709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 02:23:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 02:23:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 02:23:43 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0837NenZ011328;
        Thu, 3 Sep 2020 02:23:40 -0500
Subject: Re: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
To:     Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
 <e53e87b0-7e0a-763f-8b8b-0dc278e1f225@ti.com>
 <DM6PR07MB5531DF749C993423B0A3E746D32C0@DM6PR07MB5531.namprd07.prod.outlook.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <4a0d1e85-0db6-af62-a1ea-e8f0c684b4a6@ti.com>
Date:   Thu, 3 Sep 2020 10:23:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB5531DF749C993423B0A3E746D32C0@DM6PR07MB5531.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milind,

On 03/09/2020 09:22, Milind Parab wrote:

> Also, note that CDNS MHDP implements DP_FRAMER_TU_p where bits 5:0 is tu_valid_symbols. So max programmable value is 63.
> Register document gives following explanation 
> "Number of valid symbols per Transfer Unit (TU). Rounded down to lower integer value (Allowed values are 1 to (TU_size-1)"
> 
> So, it says in case vs calculates to 64 (where Avail BW and Req BW are same) we program tu_valid_symbols = 63

Hmm, so "Rounded down to lower integer value" means

floor(x) - 1 ?

If that's the case, we need to subtract 1 in all cases, not only when req bw == avail bw.

> Third, is about the line_threshold calculation
> Unlike TU_SIZE and Valid_Symbols, line_threshold is implementation dependent
> 
> CDNS MHDP register specs gives the definition as " Video FIFO latency threshold" 
> Bits 5:0, Name "cfg_active_line_tresh", Description "Video Fifo Latency threshold. Defines the number of FIFO rows before reading starts. This setting depends on the transmitted video format and link rate."
> 
> This parameter is the Threshold of the FIFO. For optimal performance (considering equal write and read clock) we normally put the threshold in the mid of the FIFO.
> Hence the reset value is fixed as 32.
> Since symbol FIFO is accessed by Pxl clock and Symbol Link Clock the Threshold is set to a value which is dependent on the ratio of these clocks
> 
> line_threshold = full_fifo - fifo_ratio_due_to_clock_diff + 2
> where,
> full_fifo = (vs+1) * (8/bpp)
> fifo_ratio_due_to_clock_diff = ((vs+1) * pxlclock/mhdp->link.rate - 1) / mhdp->link.num_lanes 
> 
> Note that line_threshold can take a max value of 63

That doesn't result in anything sensible. 8/bpp is always 0.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
