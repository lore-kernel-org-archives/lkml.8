Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FB220754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V9nMsPgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCTLs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:48:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55504 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTLs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:48:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200320114855euoutp01c3a9c89ad48bcbc8dadcb11adc5a2a1c~_AL43U7c60161001610euoutp017
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:48:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200320114855euoutp01c3a9c89ad48bcbc8dadcb11adc5a2a1c~_AL43U7c60161001610euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584704935;
        bh=nLcjzIOGCN900e/OEOUNApcMwCdwdSMIJRGT8aZqxpc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V9nMsPgz/ev+yVZOVCLbz2TxfvIpX7jPSkwkgk/hngxFbRMa8HxgM0S56tx0xS94V
         jl2B3hf94y75/wjuYGiKamqccp/qd23HGK59nbNpFmYgm8JXXJy1d0QCpk3Hnh4kLx
         CalxfwkKiqd81TPD8e0gOoSFcPPWBmxWJz774MqY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200320114855eucas1p1f4f46d392692f17471526c7d82771f50~_AL4sk0uM0567705677eucas1p18;
        Fri, 20 Mar 2020 11:48:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C3.13.60679.7ADA47E5; Fri, 20
        Mar 2020 11:48:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200320114855eucas1p2a0ebaee7b17af54e408d558d9205dfdd~_AL4P_lJP0691306913eucas1p22;
        Fri, 20 Mar 2020 11:48:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200320114855eusmtrp1cc1388611252763c88adef345d5085cd~_AL4PYfrV1196311963eusmtrp1Q;
        Fri, 20 Mar 2020 11:48:55 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-cd-5e74ada7f0a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.39.08375.7ADA47E5; Fri, 20
        Mar 2020 11:48:55 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200320114854eusmtip22f9ca6c7b13e42591a560e2774e1a12c~_AL3929nC0580505805eusmtip2g;
        Fri, 20 Mar 2020 11:48:54 +0000 (GMT)
Subject: Re: [PATCH v3] video: fbdev: arcfb: add missed free_irq and fix the
 order of request_irq
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <80493efb-cc29-73e2-da8e-72902c709f1a@samsung.com>
Date:   Fri, 20 Mar 2020 12:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200310143050.5154-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87rL15bEGXy5p2px5et7NovZh14y
        W5zo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzFJdNSmpOZllqkb5dAlfGvav3mAt2CVac
        XvKBpYHxH28XIyeHhICJxJH2ucxdjFwcQgIrGCWOfT3JDJIQEvjCKHFqTzBE4jOjxIRt/xhh
        OhYu+ALVsZxR4tv2LYwQzltGiT1NT8DahQWSJd4c+g5miwioS3zetZMdxGYWSJA4vegeC4jN
        JmAlMbF9FdhUXgE7iRPnrjKB2CwCqhIXZ81mA7FFBSIkPj04zApRIyhxcuYTsF5OAUuJifuf
        skHMFJe49WQ+E4QtL7H97Ryw6yQE+tkleuctgDrbRWLDoo9MELawxKvjW9ghbBmJ05N7WCAa
        1jFK/O14AdW9nVFi+eR/bBBV1hJ3zv0CsjmAVmhKrN+lDxF2lOhYtIYFJCwhwCdx460gxBF8
        EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMExiVZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz
        01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPK6X/Hv+xg3PUn6RCjAAejEg+vxcqSOCHWxLLiytxD
        jBIczEoivLrpxXFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJx
        cEo1ME66tL+vpLFi75GkO9IMUd+1THkOx1hOf1eUuKx6xd3URf2dAnlxws9nzONsFtN12hmW
        9PXrmT+Xp2z03CRwan1A8LOLMX/iOraWSKa2dDT+eJW1U/ahvo3CDx8HTQbzt4tm9+j9iE/Y
        2bEw9Y7Y5bVeiQsmi9Vfn3dt5Sxt/bNPJ9588jd7f4cSS3FGoqEWc1FxIgAriBQeJQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7rL15bEGfQ0sllc+fqezWL2oZfM
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx7+o95oJdghWnl3xgaWD8x9vFyMkhIWAisXDB
        F+YuRi4OIYGljBIf/14HcjiAEjISx9eXQdQIS/y51sUGUfOaUeL0tMVMIAlhgWSJN4e+M4PY
        IgLqEp937WQH6WUWSJB4Ni8For6HUeLEk08sIDVsAlYSE9tXMYLYvAJ2EifOXQWbwyKgKnFx
        1mw2EFtUIELi8I5ZUDWCEidnPgHr5RSwlJi4/ylYDTPQrj/zLjFD2OISt57MZ4Kw5SW2v53D
        PIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwAjaduzn5h2M
        lzYGH2IU4GBU4uG1WFkSJ8SaWFZcmXuIUYKDWUmEVze9OE6INyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84HRnVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVHu
        uEvytm+LmIM5rSbfeH5ffv01A2uGG7c0r9WWfM2bn538+QvjgrXHlp79U7dPZXqqg77/1dcm
        RZ7zhbM19jOY/1urcWFur/xPzX3hW19d5dp/iiVljlLbr8pVRi6iXqdkz0cs2TT5Y+i/Jcd/
        T+H3Fqt2TvHaepu7s3bWVRXBhQLHLP9qzt2nxFKckWioxVxUnAgAOMSXA7YCAAA=
X-CMS-MailID: 20200320114855eucas1p2a0ebaee7b17af54e408d558d9205dfdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200310143100eucas1p241418d286851099f545477b153d3fa0c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200310143100eucas1p241418d286851099f545477b153d3fa0c
References: <CGME20200310143100eucas1p241418d286851099f545477b153d3fa0c@eucas1p2.samsung.com>
        <20200310143050.5154-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/20 3:30 PM, Chuhong Yuan wrote:
> The driver forgets to free irq in remove which is requested in
> probe.
> Add the missed call to fix it.
> Also, the position of request_irq() in probe should be put before
> register_framebuffer().
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v3:
>   - Add missed variable par in remove.
> 
>  drivers/video/fbdev/arcfb.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index 314ab82e01c0..9a720c14056c 100644
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
> @@ -590,9 +590,12 @@ static int arcfb_probe(struct platform_device *dev)
>  static int arcfb_remove(struct platform_device *dev)
>  {
>  	struct fb_info *info = platform_get_drvdata(dev);
> +	struct arcfb_par *par = info->par;

Please look at the line below, 'info' is checked for being NULL so
either 'par = info->par' can dereference NULL pointer or the check is
superfluous and should be removed.

Also there is no need for 'par' variable (it is used only once),
why not simply use info->par->irq in free_irq() call below?

>  	if (info) {
>  		unregister_framebuffer(info);
> +		if (irq)
> +			free_irq(par->irq, info);
>  		vfree((void __force *)info->screen_base);
>  		framebuffer_release(info);
>  	}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
