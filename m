Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F15C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A1720661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aielRH4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgBCIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:38:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46574 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBCIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:38:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0138ckDD100871;
        Mon, 3 Feb 2020 02:38:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580719126;
        bh=Tfda4LvuUEYTDvyGlYS6mOHiUVeU9HHASiG1AIAbvcA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aielRH4sdU7RaEk2GdG9JP1i7St4zjZiS4dkoufB9dlA67dAq+AkPwIbhnA/R+2GP
         57BXHZUZgiBHZqa2XGSMFuxhEVySL5B+vW8TjKkktaX7409EQ3a/zB8ABoiEIeUCsg
         HIa2udZRK0MVzhbiZrAy6TLnfG7mwFqh3O0/qCRU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0138ckXi124317;
        Mon, 3 Feb 2020 02:38:46 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 02:38:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 02:38:46 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0138cipW104965;
        Mon, 3 Feb 2020 02:38:44 -0600
Subject: Re: [PATCH] firmware: ti_sci: Correct the timeout type in
 ti_sci_do_xfer()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>
References: <20200122104009.15622-1-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a63c23ec-d468-fc9b-3990-becd7c120df6@ti.com>
Date:   Mon, 3 Feb 2020 10:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122104009.15622-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2020 12:40, Peter Ujfalusi wrote:
> msecs_to_jiffies() returns 'unsigned long' and the timeout parameter for
> wait_for_completion_timeout() is also 'unsigned long'
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/firmware/ti_sci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 3d8241cb6921..361a82817c1f 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -422,7 +422,7 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>   				 struct ti_sci_xfer *xfer)
>   {
>   	int ret;
> -	int timeout;
> +	unsigned long timeout;
>   	struct device *dev = info->dev;
>   
>   	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
