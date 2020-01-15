Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A327C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADA6214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AKqDlkDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOPvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:51:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35601 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:51:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200115155115euoutp02f2d002169103927da7e15edfef3bd473~qGj6Lbqj92422924229euoutp02l
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 15:51:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200115155115euoutp02f2d002169103927da7e15edfef3bd473~qGj6Lbqj92422924229euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579103475;
        bh=+44ruQrELZzOfxaxRN2GmBO3IiWVrUwlLHTkRFl5+to=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AKqDlkDk2HuuNJM8EpsZqXxshA+EfieR4fZqoJYSXQS6YHF51zWpnuC3TQkTAdD3M
         4QlUD5525LiauJHakxio/3AwQ4pTiBd4uSNnAygs/acgRN2qHo+0HjPZ/AfVkD83iS
         F5jBlsxwSTogQOSheeCiXvv8Ykvbd9wfs6F/qwtI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115155115eucas1p27a60e25c2d968b43a30d2780a72de44e~qGj6Ed99s1479514795eucas1p2b;
        Wed, 15 Jan 2020 15:51:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.72.60679.3F43F1E5; Wed, 15
        Jan 2020 15:51:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115155114eucas1p198c7ce2fbffe03e764f82f61898186db~qGj5puXIr1202512025eucas1p1Y;
        Wed, 15 Jan 2020 15:51:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115155114eusmtrp2794655590659509db9904f1d9212ed0b~qGj5pKZGV1277712777eusmtrp2s;
        Wed, 15 Jan 2020 15:51:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a3-5e1f34f34cdf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.B1.08375.2F43F1E5; Wed, 15
        Jan 2020 15:51:14 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115155114eusmtip132e904b80e9be5b7346d2b9713cbf679~qGj5NU8rN0471004710eusmtip1M;
        Wed, 15 Jan 2020 15:51:14 +0000 (GMT)
Subject: Re: [PATCH] pxa168fb: fix release function mismatch in probe
 failure
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <83ca49d1-ca86-1005-7799-cc9f95af28db@samsung.com>
Date:   Wed, 15 Jan 2020 16:51:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205160613.32075-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qfTeTjDA7NZbe48vU9m8XsQy+Z
        LU70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj1bn/jAXTuCr2
        LNjN0sC4g6OLkZNDQsBEYv7J+0wgtpDACkaJTVOkuxi5gOwvjBJX/h5jg3A+M0pMnTqBDabj
        Zf8EqMRyRolJjyczQThvGSUWzjzGDFIlLOAvMenuCnYQW0RAXeLzrp1gNrNAgsTpRfdYQGw2
        ASuJie2rGEFsXgE7ifNLboP1sgioSiz4vQVsm6hAhMSnB4dZIWoEJU7OfALWywnU+3fhISaI
        meISt57Mh7LlJba/ncMMcpCEQDe7xMr7TxkhznaRmHT1ODOELSzx6vgWdghbRuL/zvlMEA3r
        GCX+dryA6t7OKLF88j+op60l7pz7BWRzAK3QlFi/Sx8i7CjxcOt9dpCwhACfxI23ghBH8ElM
        2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LVZSN6ZheSdWQh7FzCyrGIUTy0tzk1P
        LTbKSy3XK07MLS7NS9dLzs/dxAhMKaf/Hf+yg3HXn6RDjAIcjEo8vBl/5OKEWBPLiitzDzFK
        cDArifCenCEbJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwen
        VAOjaEyzc7lfyXY1htYLdwIcXx0OeTJjwxrLz1lmQkrSfP5GsXVWa7IkZu3ny05y/aOs5Gks
        +jSrOXipbPOuvzw7J6+bzS1z11buikK9gsH3e8/u1C9vunP8V0j6eufpKc1npd37piYc536w
        MyN0zsyn2rILSyfptXBkCeZ+fSN1aG25xK/lExuUWIozEg21mIuKEwFFRS6yJQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7qfTOTjDI4eU7W48vU9m8XsQy+Z
        LU70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j1bn/jAXTuCr2LNjN0sC4g6OLkZNDQsBE4mX/
        BLYuRi4OIYGljBKtH5ewdzFyACVkJI6vL4OoEZb4c60LquY1o8Sb5UeZQRLCAr4SZzo2sIPY
        IgLqEp937QTrZRZIkHg2LwWivpdR4vn2lWA1bAJWEhPbVzGC2LwCdhLnl9wGm8MioCqx4PcW
        NhBbVCBC4vCOWVA1ghInZz5hAbE5gXr/LjzEBGIzA+36M+8SM4QtLnHryXyouLzE9rdzmCcw
        Cs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhB24793LyD8dLG
        4EOMAhyMSjy8GX/k4oRYE8uKK3MPMUpwMCuJ8J6cIRsnxJuSWFmVWpQfX1Sak1p8iNEU6LmJ
        zFKiyfnA6M4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCoy5Q6
        10JLLK8oPHWeVG/00dmais3MfOZrbYXFqrI1fb5zPXaVy52deXX7zPTPNfkV6Tpx7bcs9ynu
        f87Y82WqvSpPtMGVM4w8GaGzXk70Onf2a/Z7LT/HrDmzM7V/vOD9b76Ku3A/37vL/CGRLRt7
        uraw3LOWfOpx8NLfpglK7Hz/6vfKaiuxFGckGmoxFxUnAgB9pX67tgIAAA==
X-CMS-MailID: 20200115155114eucas1p198c7ce2fbffe03e764f82f61898186db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205160628epcas4p38c1843647699dcbd209c5381d65ab869
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205160628epcas4p38c1843647699dcbd209c5381d65ab869
References: <CGME20191205160628epcas4p38c1843647699dcbd209c5381d65ab869@epcas4p3.samsung.com>
        <20191205160613.32075-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/19 5:06 PM, Chuhong Yuan wrote:
> The driver uses kfree() to release the resource allocated by
> framebuffer_alloc(), which does not match.
> Use framebuffer_release() instead to fix it.

For pxa168fb driver framebuffer_release() does only kfree() so
there is no real breakage currently. Lets fix it anyway so it
won't break in the future.

> Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxa168fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 1410f476e135..b9435133b6f3 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -769,7 +769,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  	dma_free_coherent(fbi->dev, info->fix.smem_len,
>  			info->screen_base, fbi->fb_start_dma);
>  failed_free_info:
> -	kfree(info);
> +	framebuffer_release(info);
>  
>  	dev_err(&pdev->dev, "frame buffer device init failed with %d\n", ret);
>  	return ret;
> 
