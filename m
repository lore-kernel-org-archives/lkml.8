Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4EC5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BB820767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IapQxkxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDXHsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:48:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43252 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:48:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03O7mE1Y056978;
        Fri, 24 Apr 2020 02:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587714494;
        bh=8lL/eQOBz+qjJC+/oqhBwQbP/6H9l8sdjDhJx6Sjo0E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IapQxkxYEESLSmUugC5b0mnlg59ifvsIHQsIiOVI0SWRsaJ2+/jed4tFCQ/50a/0p
         krJNR2yrg1xNNY8UtxKLqB53i0OS/FTlKs8BGJ2GrhLdxISegiEZeI0gUgtWdPXttS
         IcA6jNZEFpDiGXEhG4X0W+Dw9vl4Hbol9njdNYEY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03O7mEAA089910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 02:48:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 02:48:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 02:48:14 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O7mCK2086298;
        Fri, 24 Apr 2020 02:48:12 -0500
Subject: Re: [PATCH v3] usb: dwc3: support continuous runtime PM with dual
 role
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <sergei.shtylyov@cogentembedded.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200319100207.19957-1-martin.kepplinger@puri.sm>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <cb2db077-0f37-2221-84f6-a7adfd6ed1f1@ti.com>
Date:   Fri, 24 Apr 2020 10:48:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200319100207.19957-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/2020 12:02, Martin Kepplinger wrote:
> The DRD module calls dwc3_set_mode() on role switches, i.e. when a device is
> being plugged in. In order to support continuous runtime power management when
> plugging in / unplugging a cable, we need to call pm_runtime_get_sync() in
> this path.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Roger Quadros <rogerq@ti.com>


cheers,
-roger

> ---
> 
> 
> revision history
> ----------------
> v3: call pm_runtime_get_sync() and fix commit message typo (thanks Sergei)
> v2: move pm_rumtime calls into workqueue (thanks Roger)
>      remove unrelated documentation patch
>      https://lore.kernel.org/linux-usb/7a085229-68a7-d700-1781-14225863a228@cogentembedded.com/T/
> v1: https://lore.kernel.org/linux-usb/ef22f8de-9bfd-c1d5-111c-696f1336dbda@puri.sm/T/
> 
> 
>   drivers/usb/dwc3/core.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1d85c42b9c67..da93faef74a6 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -121,17 +121,19 @@ static void __dwc3_set_mode(struct work_struct *work)
>   	if (dwc->dr_mode != USB_DR_MODE_OTG)
>   		return;
>   
> +	pm_runtime_get_sync(dwc->dev);
> +
>   	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
>   		dwc3_otg_update(dwc, 0);
>   
>   	if (!dwc->desired_dr_role)
> -		return;
> +		goto out;
>   
>   	if (dwc->desired_dr_role == dwc->current_dr_role)
> -		return;
> +		goto out;
>   
>   	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
> -		return;
> +		goto out;
>   
>   	switch (dwc->current_dr_role) {
>   	case DWC3_GCTL_PRTCAP_HOST:
> @@ -190,6 +192,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>   		break;
>   	}
>   
> +out:
> +	pm_runtime_mark_last_busy(dwc->dev);
> +	pm_runtime_put_autosuspend(dwc->dev);
>   }
>   
>   void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
