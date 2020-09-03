Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B992137B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v+6dHNu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgICOsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:48:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41268 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgICOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:48:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083DNn7s114942;
        Thu, 3 Sep 2020 08:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599139429;
        bh=Sv1rjptrB/D2VFs2GCeWi3Odnsbw5rU6WNrwMZKxhHs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v+6dHNu8LnhbD273WhVSkGuVpfpGe72WGQvK3jqyxZGTrLOZTw6HpUJbBg9gFtjJC
         L15FaEd+2TOZxGO3cgyQk3R9C07r2pUrCp71Ghq7tT/Gc3nPtz/NWQOk+VDMhZFVsU
         gA1KZsPu96NDaitpF0SOs1px9DPBzGkyQJQy9Y8k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083DNnsT012472;
        Thu, 3 Sep 2020 08:23:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:23:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:23:49 -0500
Received: from [10.250.71.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083DNnMN023770;
        Thu, 3 Sep 2020 08:23:49 -0500
Subject: Re: [PATCH V2 1/8] arm64: dts: ti: k3-j721e: Use lower case
 hexadecimal
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200903130015.21361-2-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <39ebf70b-6ecb-3586-8786-fd2ce43c2e00@ti.com>
Date:   Thu, 3 Sep 2020 08:23:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903130015.21361-2-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200903132348.PDLkreb_gOyXrdbVHLScR8a4T0JuCxbD-FGSdf5HF8U@z>

On 9/3/20 8:00 AM, Nishanth Menon wrote:
> Device tree convention uses lower case a-f for hexadecimals. Fix the
> same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> Change:
> v2: - new
> 
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index f787aa73aaae..1bb8235d9ffb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -127,7 +127,7 @@
>  		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
>  			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
>  			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
> -			 <0x00 0x00A40000 0x00 0x00A40000 0x00 0x00000800>, /* timesync router */
> +			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
>  			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
>  			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
>  			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
> 

