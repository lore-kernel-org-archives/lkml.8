Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6603BC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B972076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f49rlbH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCRLNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:13:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52604 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCRLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:13:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02IBDiOS080234;
        Wed, 18 Mar 2020 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584530024;
        bh=Li2cQAFtBxR6JChItlEo5lYNjMUbYbRm2G+Nf69FntI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f49rlbH4Gu+E8aJxbqF0xgdSuYfIOvV5/rvOfvhf71h4f+C/kukLs1QInnxZmsrsC
         NIBBBUEYrMkrsAQkU2gL4r1DsvL1tTSq9Zi2U8noxNNGAZP+Uksargo6frPp+SINI1
         kQK1POs4ZmfaUKUEb/SQdoEWROOBYXmN9HuH7yN4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02IBDiqX127238;
        Wed, 18 Mar 2020 06:13:44 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 06:13:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 06:13:44 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02IBDgxR125063;
        Wed, 18 Mar 2020 06:13:42 -0500
Subject: Re: [PATCH 1/2] usb: dwc3: support continuous runtime PM with dual
 role
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, <balbi@kernel.org>,
        <robh@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200318083508.20781-1-martin.kepplinger@puri.sm>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <a032925d-112b-204c-fbc8-b45225016654@ti.com>
Date:   Wed, 18 Mar 2020 13:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318083508.20781-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

On 18/03/2020 10:35, Martin Kepplinger wrote:
> The DRD module calls dwc3_set_mode() on role switches, i.e. when a device is
> being pugged in. In order to support continuous runtime power management when
> plugging in / unplugging a cable, we need to call pm_runtime_get() in this path.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>   drivers/usb/dwc3/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index edc17155cb2b..7743c4de82e9 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -196,11 +196,16 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>   {
>   	unsigned long flags;
>   
> +	pm_runtime_get(dwc->dev);
> +
>   	spin_lock_irqsave(&dwc->lock, flags);
>   	dwc->desired_dr_role = mode;
>   	spin_unlock_irqrestore(&dwc->lock, flags);
>   
>   	queue_work(system_freezable_wq, &dwc->drd_work);

We are not touching any IP registers and just scheduling
the drd_work in this function so it doesn't make sense to do pm_runtime_get here.

How about dong pm_runtime_get/put in __dwc3_set_mode()?

> +
> +	pm_runtime_mark_last_busy(dwc->dev);
> +	pm_runtime_put_autosuspend(dwc->dev);
>   }
>   
>   u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
