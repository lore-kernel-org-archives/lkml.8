Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42EE215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sV5hL3yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgIHIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:40:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46386 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgIHIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:40:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0888e00p039279;
        Tue, 8 Sep 2020 03:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599554400;
        bh=koZgZplBNs3DKUJKJ62z4lQcrmU3I5FtgMxAME0mJaI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sV5hL3yLGLscTaLdxZS6sPPdsgFU12aNhWkhtCNJuiCQKMiWWjPe1XCWtWPFBYN26
         kaqEe9vp6M95IeYGJJsEZmVPEXuU3kR8o+moOyEnnfl5YQ8O8Ij8CkOXNHIOBBayPw
         DF5IXkPVfmRZGE6r49pdwLE28lLWX8+37VXwUlkc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0888e0Sl021567;
        Tue, 8 Sep 2020 03:40:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 03:40:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 03:40:00 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0888dvJ4022975;
        Tue, 8 Sep 2020 03:39:58 -0500
Subject: Re: [PATCH v2 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     <t-kristo@ti.com>, <nm@ti.com>, <peda@axentia.se>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
References: <20200907145213.30788-1-rogerq@ti.com>
 <20200907145213.30788-2-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <e889ae84-4fa3-36b1-174e-738c3bf1182e@ti.com>
Date:   Tue, 8 Sep 2020 11:39:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907145213.30788-2-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Peter

On 07/09/2020 17:52, Roger Quadros wrote:
> Each SERDES lane mux can select upto 4 different IPs.
> There are 4 lanes in each J7200 SERDES. Define all
> the possible functions in this file.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
> 
> diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
> new file mode 100644
> index 000000000000..b091b1185a36
> --- /dev/null
> +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for J7200 WIZ.
> + */
> +
> +#ifndef _DT_BINDINGS_J7200_WIZ
> +#define _DT_BINDINGS_J7200_WIZ
> +
> +#define SERDES0_LANE0_QSGMII_LANE3	0x0
> +#define SERDES0_LANE0_PCIE1_LANE0	0x1
> +#define SERDES0_LANE0_IP3_UNUSED	0x2
> +#define SERDES0_LANE0_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE1_QSGMII_LANE4	0x0
> +#define SERDES0_LANE1_PCIE1_LANE1	0x1
> +#define SERDES0_LANE1_IP3_UNUSED	0x2
> +#define SERDES0_LANE1_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE2_QSGMII_LANE1	0x0
> +#define SERDES0_LANE2_PCIE1_LANE2	0x1
> +#define SERDES0_LANE2_IP3_UNUSED	0x2
> +#define SERDES0_LANE2_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE3_QSGMII_LANE2	0x0
> +#define SERDES0_LANE3_PCIE1_LANE3	0x1
> +#define SERDES0_LANE3_USB		0x2
> +#define SERDES0_LANE3_IP4_UNUSED	0x3
> +
> +#endif /* _DT_BINDINGS_J7200_WIZ */
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
