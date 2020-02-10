Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68820658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZSIBgd93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgBJPAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:00:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36202 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgBJPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:00:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AExScZ022002;
        Mon, 10 Feb 2020 08:59:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581346768;
        bh=937sYJ9HmKfZfaKbpgbA3zfFxgMIg4xMgNvoLDr0WkI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZSIBgd936helc2ZRY/aUvTZnhjE5FMx4I/zLDg+8j9shHxAKwS90N6JVLJvsvpMCR
         MdQ7FjW6dn7+cre6bnB6dDApMJza1ghNZTmAKRiMI3tPveSEFILYcAVvepb/SPDt4Z
         KFZ/n33TjyOSdjocsoSO7DyTslbUFajAfgnBy84k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AExSYP042330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 08:59:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 08:59:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 08:59:28 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AExPP7003090;
        Mon, 10 Feb 2020 08:59:26 -0600
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused delay in
 pointer callback
To:     Mark Brown <broonie@kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>, <lgirdwood@gmail.com>,
        <tiwai@suse.com>, <perex@perex.cz>, <lars@metafoo.de>,
        <alsa-devel@alsa-project.org>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200210140423.10232-1-peter.ujfalusi@ti.com>
 <s5hmu9qfrq7.wl-tiwai@suse.de> <15c7df10-cf9f-109c-3cbf-e73af7f4f66a@ti.com>
 <20200210143717.GO7685@sirena.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8b48b17d-3751-c027-7b66-fbea3b5a412f@ti.com>
Date:   Mon, 10 Feb 2020 16:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210143717.GO7685@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 16.37, Mark Brown wrote:
> On Mon, Feb 10, 2020 at 04:28:44PM +0200, Peter Ujfalusi wrote:
>> On 10/02/2020 16.21, Takashi Iwai wrote:
> 
>>>>  	delay += codec_delay;
>>>>  
>>>> -	runtime->delay = delay;
>>>> +	runtime->delay += delay;
> 
>>> Is it correct?
>>> delay already takes runtime->delay as its basis, so it'll result in a
>>> double.
> 
>> The delay here is coming from the DAI and the codec.
>> The runtime->delay hold the PCM (DMA) caused delay.
> 
> I think Takashi's point here (and a query I have) is that we end up with
> 
> 	delay = runtime->delay;
> 	delay += stuff;
> 	runtime->delay += delay;
> 
> which is equivalent to
> 
> 	runtime->delay = (runtime->delay * 2) + stuff;
> 
> and that's a bit surprising.

I see, I have missed what
9fb4c2bf130b ASoC: soc-pcm: Use delay set in component pointer function

did.
the soc-pcm part of the patch can be dropped then.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
