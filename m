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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7149C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8F720716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eQcxtvqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgICPJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:09:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50186 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgICN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:58:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083DOEAN107415;
        Thu, 3 Sep 2020 08:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599139454;
        bh=EcU5sNHWfjTOyGcbOYeypp2bM4hBc053FDywI/zCZgI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eQcxtvqnZRKreSf0Vaxnunri+IKr+JeTETEHDlG3TGHQUc0M0Mn73C+q8Vv1namqZ
         jZ1xow4jSsm6s+OODwzn6yKM0UsJqVYz1A8eR+d0Kg1MSwmw3ayHAYGW8JOscxQtj/
         By5Vv8GASjI1iQNpg8F4N9ttfpt3hp8vKZnKTdPU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083DOEAr006875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:24:14 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:24:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:24:13 -0500
Received: from [10.250.71.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083DODrj004638;
        Thu, 3 Sep 2020 08:24:13 -0500
Subject: Re: [PATCH V2 2/8] arm64: dts: ti: k3-am65-main: Use lower case
 hexadecimal
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200903130015.21361-3-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2875a2d5-2f1b-7579-4642-aec8dc829d5b@ti.com>
Date:   Thu, 3 Sep 2020 08:24:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903130015.21361-3-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 76e0edc4ad5c..d53d1ead4bb6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -344,9 +344,9 @@
>  					<0x4090 0x3>; /* SERDES1 lane select */
>  		};
>  
> -		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
> +		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41e0 {
>  			compatible = "syscon";
> -			reg = <0x0000041E0 0x14>;
> +			reg = <0x0000041e0 0x14>;
>  		};
>  
>  		ehrpwm_tbclk: syscon@4140 {
> 

