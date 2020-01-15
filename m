Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C9C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B6D222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nYY/KOn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAOQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:19:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46618 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:19:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115161906euoutp01740429bb85296bbf1d031d3ce063e86c~qG8OQSsik1277712777euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 16:19:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115161906euoutp01740429bb85296bbf1d031d3ce063e86c~qG8OQSsik1277712777euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579105146;
        bh=ncRAnEl+POE1Y5QLwdp3gNB9GHD8c9MdSU3l2ecI1nc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nYY/KOn2/pxQSS7NwmLVs1iBfmePp5oi7xqqjtnJa/3Ej/j4wCRz+gYJKzEObMFYL
         17mh3fTN802do4XRyFtd1B8yZDOdLVOc+KbFzKM6iUQO2FL30vo6225IqtkJEcNMYe
         NDtkr/dpzk4cIMcbWw0Lwt0X1r2e9rD5TUP2Tt+Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115161905eucas1p155d50e6f51933f2342b5d1df64ef0054~qG8N9tPQC1203412034eucas1p1A;
        Wed, 15 Jan 2020 16:19:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.59.61286.97B3F1E5; Wed, 15
        Jan 2020 16:19:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115161905eucas1p21ba0a0cc496c4c20c10d88967b337006~qG8Njxu4-1153211532eucas1p28;
        Wed, 15 Jan 2020 16:19:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115161905eusmtrp15507b380e74fa61a412ec90b306ae611~qG8NjIAKs1743517435eusmtrp1u;
        Wed, 15 Jan 2020 16:19:05 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e9-5e1f3b793a21
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.B4.08375.97B3F1E5; Wed, 15
        Jan 2020 16:19:05 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200115161904eusmtip2d3b57e42959cbce3a73c8e4759520175~qG8M4k3Fw1686316863eusmtip2H;
        Wed, 15 Jan 2020 16:19:04 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: nvidia: clean up indentation issues and
 comment block
To:     Colin King <colin.king@canonical.com>
Cc:     Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <26ccc9eb-6edb-3ec6-5714-0bb470366b17@samsung.com>
Date:   Wed, 15 Jan 2020 17:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200113144627.219967-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7qV1vJxBi9Oalv87P7CZvF7dS+b
        xZWv79kstt6StjjR94HV4vKuOWwObB6zGnrZPHbOusvucb/7OJPH501yASxRXDYpqTmZZalF
        +nYJXBlbF8gWtAtXXJl/nLGBcQ1fFyMnh4SAicSMFZcZuxi5OIQEVjBK9M0+xgLhfGGUuHB3
        LTuE85lR4uOVo4wwLSsvTmGGSCxnlLjf+BvKecso8fLzGqYuRg4OYYEoiWsvskBMEQFNifPn
        ikBKmEFWrFi2hA1kEJuAlcTE9lVgQ3kF7CTaXvSygtgsAqoSbX3N7CC2qECExKcHh1khagQl
        Ts58wgJicwrYS8zctIEJxGYWEJe49WQ+lC0vsf3tHLB7JAQWsUuceXmXGeQICQEXiXnLlSAe
        EJZ4dXwLO4QtI3F6cg8LRP06Rom/HS+gmrczSiyf/I8Nospa4s65X2wgg5iBvlm/Sx9ipqPE
        qUW2ECafxI23ghAn8ElM2jYdaiuvREebEMQMNYkNyzawwWzt2rmSeQKj0iwkj81C8swsJM/M
        Qli7gJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmCiOf3v+KcdjF8vJR1iFOBgVOLh
        zfgjFyfEmlhWXJl7iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmk
        J5akZqemFqQWwWSZODilGhinp003Tu/7u1W1w4vhz2J13c0P55152ujsd6hv8ZK/278ePtRe
        IZCQxbqjr4q3ZfnUgwcOndh9dtIb1UBbsx3SM+TtMx81dFaenGA5xStA7HXE14n8629F/JHl
        zDrjrS/Ld1PI1dDlaMsGP5MZJYreW3wzpnFeuHKnL0Pho6PnZ52VB2y6g+YpsRRnJBpqMRcV
        JwIAnGZjVTADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7qV1vJxBus/81n87P7CZvF7dS+b
        xZWv79kstt6StjjR94HV4vKuOWwObB6zGnrZPHbOusvucb/7OJPH501yASxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlbF8gWtAtXXJl/nLGB
        cQ1fFyMnh4SAicTKi1OYQWwhgaWMEiemO3cxcgDFZSSOry+DKBGW+HOti62LkQuo5DWjxMv2
        DmaQGmGBKIlrL7JATBEBTYnz54pASpgFVjBKXL5ygRGifhKjxJWrMxhBBrEJWElMbF8FZvMK
        2Em0vehlBbFZBFQl2vqa2UFsUYEIicM7ZkHVCEqcnPmEBcTmFLCXmLlpAxOIzSygLvFn3iVm
        CFtc4taT+VBxeYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9d
        Lzk/dxMjMLK2Hfu5eQfjpY3BhxgFOBiVeHgz/sjFCbEmlhVX5h5ilOBgVhLhPTlDNk6INyWx
        siq1KD++qDQntfgQoynQcxOZpUST84FRn1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1
        OzW1ILUIpo+Jg1OqgVGwMWbtgV7ufmnhoL5tFaYmffddLn6a9DFGLDSh+Y23SWrSPbdQq1rX
        GJ7y66u0V2+4el5xoUnDucxQndfHxLXi3Wo7lZzmLeN+dDttQ0LDHveUtwrqT5sOZuw7sDzP
        M3PD5fLNIc1L/dvO3vu5UyWzP1341ZoIjlt9+2WvT1L9bn8/a31qjhJLcUaioRZzUXEiAOrJ
        MTfCAgAA
X-CMS-MailID: 20200115161905eucas1p21ba0a0cc496c4c20c10d88967b337006
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200113144633eucas1p191c367b401a4c984fbf593794534aa7a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200113144633eucas1p191c367b401a4c984fbf593794534aa7a
References: <CGME20200113144633eucas1p191c367b401a4c984fbf593794534aa7a@eucas1p1.samsung.com>
        <20200113144627.219967-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/20 3:46 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a hunk of code that is incorrectly indented, clean up the
> indentation and a comment block. Also remove block braces around a
> one line statement on an if condition and add missing spaces after
> if keywords.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/nvidia/nvidia.c | 41 ++++++++++++++---------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> index c583c018304d..c24de9107958 100644
> --- a/drivers/video/fbdev/nvidia/nvidia.c
> +++ b/drivers/video/fbdev/nvidia/nvidia.c
> @@ -168,27 +168,26 @@ static int nvidia_panel_tweak(struct nvidia_par *par,
>  {
>  	int tweak = 0;
>  
> -   if (par->paneltweak) {
> -	   tweak = par->paneltweak;
> -   } else {
> -	   /* begin flat panel hacks */
> -	   /* This is unfortunate, but some chips need this register
> -	      tweaked or else you get artifacts where adjacent pixels are
> -	      swapped.  There are no hard rules for what to set here so all
> -	      we can do is experiment and apply hacks. */
> -
> -	   if(((par->Chipset & 0xffff) == 0x0328) && (state->bpp == 32)) {
> -		   /* At least one NV34 laptop needs this workaround. */
> -		   tweak = -1;
> -	   }
> -
> -	   if((par->Chipset & 0xfff0) == 0x0310) {
> -		   tweak = 1;
> -	   }
> -	   /* end flat panel hacks */
> -   }
> -
> -   return tweak;
> +	if (par->paneltweak) {
> +		tweak = par->paneltweak;
> +	} else {
> +		/* Begin flat panel hacks.
> +		 * This is unfortunate, but some chips need this register
> +		 * tweaked or else you get artifacts where adjacent pixels are
> +		 * swapped.  There are no hard rules for what to set here so all
> +		 * we can do is experiment and apply hacks.
> +		 */
> +		if (((par->Chipset & 0xffff) == 0x0328) && (state->bpp == 32)) {
> +			/* At least one NV34 laptop needs this workaround. */
> +			tweak = -1;
> +		}
> +
> +		if ((par->Chipset & 0xfff0) == 0x0310)
> +			tweak = 1;
> +		/* end flat panel hacks */
> +	}
> +
> +	return tweak;
>  }
>  
>  static void nvidia_screen_off(struct nvidia_par *par, int on)
> 
