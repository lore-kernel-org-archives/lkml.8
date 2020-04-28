Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158CB20746
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OCWnPWOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgD1INu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:13:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50690 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD1INr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:13:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03S8CpPF056069;
        Tue, 28 Apr 2020 03:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588061571;
        bh=3xjMu9onpulA2kur4sqLpTmL4sNgAay/v4viJL4Tx4s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OCWnPWOjttsHUNxX57fKwHivjGFuY6igEVvRBP9h0uMk5SZ7A2DIAKtt7daZZMD84
         gYBXiLNm/jfB1i7aRprHnHrSlG2YHkDba0v01kEX7kv4ZaBIzB3nmTZLrNJffmKCYD
         wXgFQRc8Mrk4Aa+68GcFX5Os7fWolGr0IXcU3PlE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03S8CoG7009430;
        Tue, 28 Apr 2020 03:12:50 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Apr 2020 03:12:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Apr 2020 03:12:49 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03S8Cljp056226;
        Tue, 28 Apr 2020 03:12:48 -0500
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix dma_chan refcnt leak when
 getting dma type
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yuanxzhang@fudan.edu.cn>, <kjlu@umn.edu>,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a64cfa62-c377-b516-7386-23340e532285@ti.com>
Date:   Tue, 28 Apr 2020 11:13:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2020 15.48, Xiyu Yang wrote:
> davinci_mcasp_get_dma_type() invokes dma_request_chan(), which returns a
> reference of the specified dma_chan object to "chan" with increased
> refcnt.
> 
> When davinci_mcasp_get_dma_type() returns, local variable "chan" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one exception handling path of
> davinci_mcasp_get_dma_type(). When chan device is NULL, the function
> forgets to decrease the refcnt increased by dma_request_chan(), causing
> a refcnt leak.
> 
> Fix this issue by calling dma_release_channel() when chan device is
> NULL.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 734ffe925c4d..7a7db743dc5b 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1896,8 +1896,10 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
>  				PTR_ERR(chan));
>  		return PTR_ERR(chan);
>  	}
> -	if (WARN_ON(!chan->device || !chan->device->dev))
> +	if (WARN_ON(!chan->device || !chan->device->dev)) {
> +		dma_release_channel(chan);
>  		return -EINVAL;
> +	}

If we get a channel then chan->device and chan->device->dev never NULL,
it can not be.
I think the reason why this is here is that static checkers tends to
scream at us.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>  
>  	if (chan->device->dev->of_node)
>  		ret = of_property_read_string(chan->device->dev->of_node,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
