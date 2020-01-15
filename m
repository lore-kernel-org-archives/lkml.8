Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB8C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5F222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cRTE0535"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAOOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:50:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47091 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAOOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:50:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115145018euoutp01692e294a1f4256053632c2b5d1ca397b~qFusd-yf10791207912euoutp01g
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115145018euoutp01692e294a1f4256053632c2b5d1ca397b~qFusd-yf10791207912euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579099818;
        bh=NXPvp1zYgb9gUmV9qAl2ZhCLamS6Ygtjex83I12F2Xk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cRTE0535aT5viddPt8EH6g7TTxAc7M9OM6bH+ROgfHtUtEQWFVJuKJdUOa/hbB7V6
         m1Rp/v0uyvoUih/9wM1lYEpTUoXTkcUmaR8PGa4bxyB5fiutZ9V25H5e2A1ivhSku2
         KI9hb54+lIU0piv5tdSUNdMPdDNMeW6oOZM+C+fU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115145018eucas1p19c95153872d7a1895718036fa17c8918~qFusYbRyR2783327833eucas1p1R;
        Wed, 15 Jan 2020 14:50:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7E.7E.61286.AA62F1E5; Wed, 15
        Jan 2020 14:50:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115145018eucas1p260f7cb61e0dc9738cc5fd3bff9dd3b27~qFusJbuO81408814088eucas1p28;
        Wed, 15 Jan 2020 14:50:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115145018eusmtrp21b96c9875b5a8e01641a8242416f3216~qFusI7DwW0683306833eusmtrp2M;
        Wed, 15 Jan 2020 14:50:18 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-2d-5e1f26aa99c5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.4A.07950.AA62F1E5; Wed, 15
        Jan 2020 14:50:18 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200115145016eusmtip271834eddaaa45ebe9074e4e891b665e8~qFuquTwu52322023220eusmtip2g;
        Wed, 15 Jan 2020 14:50:16 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: vesafb: add missed release_region
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <69c018bc-b51b-0eab-39bc-6cd14a0245e5@samsung.com>
Date:   Wed, 15 Jan 2020 15:50:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205160712.32245-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87qr1OTjDNrnC1hc+fqezWL2oZfM
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJXxoPkFW8FH7oqt
        v6obGM9xdjFycEgImEg83FTWxcjFISSwglFiyZlGZgjnC6PEihv/2boYOYGcz4wSz96lgdgg
        DY+ub2WBKFrOKNH19SOU85ZR4sWSHawgVcIC7hLPl81jAbFFBNQlPu/ayQ5iMwskSJxedA8s
        ziZgJTGxfRUjiM0rYCdx5Pg8ZhCbRUBVYsnjzUwgtqhAhMSnB4dZIWoEJU7OfALWywnUO+XK
        AzaImeISt57MZ4Kw5SW2v50D9oKEQD+7xM41XawQZ7tINB3dwwhhC0u8Or6FHcKWkfi/E6QZ
        pGEdo8TfjhdQ3dsZJZZP/scGUWUtcefcLzZQiDELaEqs36UPEXaUWHHiFCskIPkkbrwVhDiC
        T2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkr81C8s4sJO/MQti7gJFlFaN4amlx
        bnpqsWFearlecWJucWleul5yfu4mRmA6Of3v+KcdjF8vJR1iFOBgVOLhzfgjFyfEmlhWXJl7
        iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZ
        ODilGhg7YnbP8k2fpnw3eNLzJcUXM97uizputXjxdJv2S+ubOTKyXoTJrXoy4eXMw8u7VsTW
        xfC+r7aROde3zezEm6cFzHv7LWeql2s902F99db20/5D1+4VH7cuu+EZU1jqbN6yg8fAT8Ty
        16d+lw38laJm76PLtauMGyNsZBPm8TxYkO2tsfPvogtKLMUZiYZazEXFiQA0v5uIIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qr1OTjDM40MFtc+fqezWL2oZfM
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxoPkFW8FH7oqtv6obGM9xdjFyckgImEg8ur6V
        pYuRi0NIYCmjxMsve5i7GDmAEjISx9eXQdQIS/y51sUGUfOaUeJ832F2kISwgLvE82XzWEBs
        EQF1ic+7drKD9DILJEg8m5cCUd/LKPFhxSlWkBo2ASuJie2rGEFsXgE7iSPH5zGD2CwCqhJL
        Hm9mArFFBSIkDu+YBVUjKHFy5hOw+ZxAvVOuPGADsZmBdv2Zd4kZwhaXuPVkPhOELS+x/e0c
        5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbPtmM/t+xg
        7HoXfIhRgINRiYf3wD+5OCHWxLLiytxDjBIczEoivCdnyMYJ8aYkVlalFuXHF5XmpBYfYjQF
        em4is5Rocj4wtvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCy
        bzl0+/ABvxXRkw70i8zzvx8WzjnX98ae4JZiof98mRfFpCQFWaq3vj/lL3qaT+Dh/OOGPR4O
        S5fMn7j7D8d0viCvKfwS894+UPryb0Yf4781lpLFz5e25ZzIW/tOoVuhcPm74usO4n/ncwgH
        //OxYypsVXwZf1R3lq7Goa1s1aE5h76IGF1TYinOSDTUYi4qTgQA/uL3LLUCAAA=
X-CMS-MailID: 20200115145018eucas1p260f7cb61e0dc9738cc5fd3bff9dd3b27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205160725eucas1p226595a8d3043f48183a0a646bda61b4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205160725eucas1p226595a8d3043f48183a0a646bda61b4c
References: <CGME20191205160725eucas1p226595a8d3043f48183a0a646bda61b4c@eucas1p2.samsung.com>
        <20191205160712.32245-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/19 5:07 PM, Chuhong Yuan wrote:
> The driver forgets to free the requested irq in remove and probe
> failure.

This is I/O region not IRQ.

> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Modify commit message.
> 
>  drivers/video/fbdev/vesafb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index d9c08f6c2155..fbb196a8bbf6 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -468,6 +468,7 @@ static int vesafb_probe(struct platform_device *dev)
>  	fb_info(info, "%s frame buffer device\n", info->fix.id);
>  	return 0;
>  err:
> +	release_region(0x3c0, 32);

There is one 'goto err;' instance before request_region() which
needs to be taken care of first.

>  	arch_phys_wc_del(par->wc_cookie);
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
> @@ -480,6 +481,7 @@ static int vesafb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  
> +	release_region(0x3c0, 32);
>  	unregister_framebuffer(info);

The order of operations on remove should be the reverse of
order of operations on probe.

[ We cannot release I/O region while framebuffer is active. ]

>  	framebuffer_release(info);

Please fix the patch and re-submit.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
