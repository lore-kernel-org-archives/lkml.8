Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA44C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134C921D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rodtYEtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgDQOIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:08:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58284 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgDQOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:08:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200417140821euoutp0279195e4f8b7d0835625e398c6ac52496~GoJnTkH_41553115531euoutp02y
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:08:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200417140821euoutp0279195e4f8b7d0835625e398c6ac52496~GoJnTkH_41553115531euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587132501;
        bh=wU/u5yFVwW6Q0MZ+7cwWMbArKdCvY7UAvaNw+w73Lz0=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=rodtYEtSvR0j/PIemYUGu/3yIfZzqy0L96JRfM0zK6IJyaMTKm7PUaesVvum5Kw/T
         nCZdbTlzyB97vsqy70BDOY08WaKpEn/Ua9nKFV/iy3QS/UDhHtZRJC2PwslwQVBmWB
         jSAjJWVFbFDRX4IM3Lb7WJLk6uKUNUFUnxjIw7Pg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200417140821eucas1p13bbd564c40f19ed8516fb5b8436e04ac~GoJnKsD8n2642726427eucas1p1Y;
        Fri, 17 Apr 2020 14:08:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.DA.60698.558B99E5; Fri, 17
        Apr 2020 15:08:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200417140820eucas1p11ca145debc2f6154820238dca381f180~GoJm3b_-N2642726427eucas1p1V;
        Fri, 17 Apr 2020 14:08:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200417140820eusmtrp1dd0293a495c5cd1fc63ad18784506372~GoJm2nwZa2264522645eusmtrp1a;
        Fri, 17 Apr 2020 14:08:20 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-fb-5e99b8550b3a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.E0.07950.458B99E5; Fri, 17
        Apr 2020 15:08:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200417140820eusmtip2d87bb9f07f5237d0acc713b350086850~GoJmgEoWB0417604176eusmtip2O;
        Fri, 17 Apr 2020 14:08:20 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4] video: fbdev: arcfb: add missed free_irq and fix the
 order of request_irq
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <7f86f442-814c-be94-d387-5448f8260ca6@samsung.com>
Date:   Fri, 17 Apr 2020 16:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200324132353.21785-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7qhO2bGGRybz2Jx5et7NovZh14y
        W5zo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzFJdNSmpOZllqkb5dAldG16mf7AW3+Soe
        9c9mamB8wt3FyMkhIWAi8eT7UpYuRi4OIYEVjBKfWw4zQzhfGCXOND1kh3A+M0o8+bqZGabl
        3fQeRojEckaJF99OsEI4bxkl1hz/wAhSxSZgJTGxfRWYLSyQLHHgxBYmEFtEQF3i866d7CA2
        s0CCxOlF91hAbF4BO4kJDztZQWwWAVWJT0s/gMVFBSIkPj04zApRIyhxcuYToDgHByfQ/F/z
        DCHGiEvcejKfCcKWl9j+dg7YCxIC3ewS69d1M0Fc7SJx6sMdVghbWOLV8S3sELaMxOnJPSwQ
        DesYJf52vIDq3s4osXzyPzaIKmuJO+d+sYFsZhbQlFi/Sx8i7CgxZdJGJpCwhACfxI23ghBH
        8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LNZSN6ZheSdWQh7FzCyrGIUTy0t
        zk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMKaf/Hf+6g3Hfn6RDjAIcjEo8vAY9M+OEWBPLiitz
        DzFKcDArifAedAMK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvE
        wSnVwMguX7K6sfbYjS6+Bmetg1rn+638Lu592Pwqnnfh1Q2xWxcd4nvwnrvjnptc+OeLi7my
        z+2WlN596Gt01VTNm9F76qOU99gpmW96GpOsInphDpPMslK+pmdrNb7kC5+o9mDOKWe60PS4
        JOxcQesuY57LT8Jn/roaq/h/xZpnqwyrW05rp2s+sFJiKc5INNRiLipOBAA/q2sdJQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7ohO2bGGaz8p25x5et7NovZh14y
        W5zo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5G16mf7AW3+Soe9c9mamB8wt3FyMkhIWAi8W56
        DyOILSSwlFHif0N8FyMHUFxG4vj6MogSYYk/17rYuhi5gEpeM0qc37ULrJ5NwEpiYvsqMFtY
        IFniwIktTCC2iIC6xOddO9lB5jALJEg8m5cC0dvLKPH0+A9mkBpeATuJCQ87WUFsFgFViU9L
        P7CA2KICERKHd8xihKgRlDg58wkLyBxOoF2/5hmChJmBxv+Zd4kZwhaXuPVkPhOELS+x/e0c
        5gmMQrOQdM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbPtmM/t+xg
        7HoXfIhRgINRiYfXoGdmnBBrYllxZe4hRgkOZiUR3oNuQCHelMTKqtSi/Pii0pzU4kOMpkC/
        TWSWEk3OB0Z2Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRkaD
        zkNB95ZuNdExmXhtwnqfPf3Pnhc43xFzN1DfWndadcXRd106ldc/1wRODc9uiWxYt7DU/7Hq
        +Wkp/gEzElomsnzetDE/wWsHY/kS+d5raziUfj+d5vGR7+26mAm1lV3qh6TFI/PM5mUcn6S/
        f111Gsv5sG7hTedsPoXusoq8M+ENz62DIUosxRmJhlrMRcWJAJfi/DG0AgAA
X-CMS-MailID: 20200417140820eucas1p11ca145debc2f6154820238dca381f180
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200324132405eucas1p210aa8eaf8240ce1951514450e701179a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200324132405eucas1p210aa8eaf8240ce1951514450e701179a
References: <CGME20200324132405eucas1p210aa8eaf8240ce1951514450e701179a@eucas1p2.samsung.com>
        <20200324132353.21785-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/20 2:23 PM, Chuhong Yuan wrote:
> The driver forgets to free irq in remove which is requested in
> probe.
> Add the missed call to fix it.
> Also, the position of request_irq() in probe should be put before
> register_framebuffer().
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> Changes in v4:
>   - Use info->par->irq instead of par->irq to avoid dereferencing NULL pointer.
> 
>  drivers/video/fbdev/arcfb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index 314ab82e01c0..6f7838979f0a 100644
> --- a/drivers/video/fbdev/arcfb.c
> +++ b/drivers/video/fbdev/arcfb.c
> @@ -544,10 +544,6 @@ static int arcfb_probe(struct platform_device *dev)
>  	par->cslut[1] = 0x06;
>  	info->flags = FBINFO_FLAG_DEFAULT;
>  	spin_lock_init(&par->lock);
> -	retval = register_framebuffer(info);
> -	if (retval < 0)
> -		goto err1;
> -	platform_set_drvdata(dev, info);
>  	if (irq) {
>  		par->irq = irq;
>  		if (request_irq(par->irq, &arcfb_interrupt, IRQF_SHARED,
> @@ -558,6 +554,10 @@ static int arcfb_probe(struct platform_device *dev)
>  			goto err1;
>  		}
>  	}
> +	retval = register_framebuffer(info);
> +	if (retval < 0)
> +		goto err1;
> +	platform_set_drvdata(dev, info);
>  	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
>  		videomemorysize >> 10);
>  
> @@ -593,6 +593,8 @@ static int arcfb_remove(struct platform_device *dev)
>  
>  	if (info) {
>  		unregister_framebuffer(info);
> +		if (irq)
> +			free_irq(((struct arcfb_par *)(info->par))->irq, info);
>  		vfree((void __force *)info->screen_base);
>  		framebuffer_release(info);
>  	}
> 
