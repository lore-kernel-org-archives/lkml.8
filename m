Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA131C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30E20661
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cAx0cyUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAOQPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:15:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45761 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:15:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115161552euoutp01cfd3ec29e7d2cae25c5db6e4a784ee23~qG5ZisoSi1100611006euoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 16:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115161552euoutp01cfd3ec29e7d2cae25c5db6e4a784ee23~qG5ZisoSi1100611006euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579104952;
        bh=inWqZzir4b7TF3yBvBHSvQfLl3bhWeO5xiEb0HOgFs4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cAx0cyUWNb6IDxhC5VvRQnMODf26K38sn/8lNkt3M54u5B+IkCSq3pUwspZaYl0IU
         NQMgk38MCbOfCh0pUbWRSoYrqLjBD2yxZCCO3We2SlyQ+QkxDE3cLabNJ4p6TEwt2E
         PMg0XTfdNDvQvrF8E+4yXYAIP5v9Nsl1L79vHYN4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115161551eucas1p1acd5be96f9f48c1b3c1c2875e20127b2~qG5ZbeHoY3038430384eucas1p1r;
        Wed, 15 Jan 2020 16:15:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.55.60679.7BA3F1E5; Wed, 15
        Jan 2020 16:15:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115161551eucas1p12019c2c12ce2a8fbb00e0fff86c89c37~qG5ZGmPxM1400014000eucas1p1p;
        Wed, 15 Jan 2020 16:15:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115161551eusmtrp1c3226a878d5338e65c37739811cf28a7~qG5ZGDq_81487414874eusmtrp14;
        Wed, 15 Jan 2020 16:15:51 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-40-5e1f3ab72f00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.64.08375.7BA3F1E5; Wed, 15
        Jan 2020 16:15:51 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115161549eusmtip1b2ba369c8294f5c41cdf951a84dc9277~qG5XNN1xn1836618366eusmtip1x;
        Wed, 15 Jan 2020 16:15:49 +0000 (GMT)
Subject: Re: [PATCH] fbdev: remove object duplication in Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a5baddef-59d6-28f6-f882-90d8957089aa@samsung.com>
Date:   Wed, 15 Jan 2020 17:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200106081352.27730-1-masahiroy@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87rbreTjDA59MbG48vU9m8WJvg+s
        Fpd3zWGzePjgBqsDi8emVZ1sHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJXx5doz9oKvHBUb
        b7xma2BsYO9i5OSQEDCRaNq3grmLkYtDSGAFo8S9m6+hnC+MEssXzGODcD4zSkxqO8kM0/Lz
        XAMjRGI5o8TRJ71MEM5bRomelzdZQaqEBRwlvv17xgZiiwhoSdxZ2gEWZxZIkDi96B4LiM0m
        YCUxsX0VI4jNK2An8eTxdbAaFgFVicvdh8HiogIREp8eHGaFqBGUODnzCVgvJ1Bvw/H5bBAz
        xSVuPZnPBGHLS2x/OwfsBwmBbnaJUy8+Q53tIrHk2lsoW1ji1fEt0BCQkTg9uYcFomEdo8Tf
        jhdQ3duBITD5HxtElbXEnXO/gGwOoBWaEut36UOEHSUeTVjDBBKWEOCTuPFWEOIIPolJ26Yz
        Q4R5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQvDYLyTuzkLwzC2HvAkaWVYziqaXFuempxUZ5
        qeV6xYm5xaV56XrJ+bmbGIFJ5fS/4192MO76k3SIUYCDUYmHN+OPXJwQa2JZcWXuIUYJDmYl
        Ed6TM2TjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamCM
        m7Zk6Rkht+kPfduu1BotfBL1aGFyz7WqNJGkH7q3zKa3TGXLlnFO/Ka5x+UN0+z28vu7jSpP
        xkxcnL/v/UmH8uk3VdYZ/8/st/pmVG26I4LvrdWukplmpUUP/Aw3Vy74tz3W4qJ//6VAgWzD
        JkGlAjbDU79f8sZEVnfc3M/eOK/1ycq9lzWVWIozEg21mIuKEwGEd1iSJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7rbreTjDBbdkre48vU9m8WJvg+s
        Fpd3zWGzePjgBqsDi8emVZ1sHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx5doz9oKvHBUbb7xma2BsYO9i5OSQEDCR+Hmu
        gRHEFhJYyihxartyFyMHUFxG4vj6MogSYYk/17rYuhi5gEpeM0r8btsMVi8s4Cjx7d8zNhBb
        REBL4s7SDlaQXmaBBIln81Ig6nsZJZa2/mYFqWETsJKY2L4KrJdXwE7iyePrYHEWAVWJy92H
        weKiAhESh3fMgqoRlDg58wkLiM0J1NtwfD7YLmYBdYk/8y4xQ9jiEreezGeCsOUltr+dwzyB
        UWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMD42Xbs5+YdjJc2
        Bh9iFOBgVOLhzfgjFyfEmlhWXJl7iFGCg1lJhPfkDNk4Id6UxMqq1KL8+KLSnNTiQ4ymQM9N
        ZJYSTc4HxnZeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGRm/d
        acZynCvL1zKb9bXfDO1/mP9s88LWqdWJ8ziKffxTtz8MPvhv40unK47qcss81+/hbn5903FJ
        rRUTf/lMs426vIdd3j3d1RSXwMMm/MR8xvaujCmL9X4o2Vd7vM2/Ub3O4u5D9dhGpu97jMQP
        8vtsP/a9aFN+69EZH8+enrvdvNhqfdF5JZbijERDLeai4kQAPDo6z7UCAAA=
X-CMS-MailID: 20200115161551eucas1p12019c2c12ce2a8fbb00e0fff86c89c37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200106081436epcas5p3dc6a4023510ef179e9ce94a056c75fb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200106081436epcas5p3dc6a4023510ef179e9ce94a056c75fb8
References: <CGME20200106081436epcas5p3dc6a4023510ef179e9ce94a056c75fb8@epcas5p3.samsung.com>
        <20200106081352.27730-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/20 9:13 AM, Masahiro Yamada wrote:
> The objects in $(fb-objs) $(fb-y) $(fb-m) are linked to fb.ko .
> 
> This line adds $(fb-y) to fb-objs, so the objects from $(fb-y) are
> listed twice as the dependency of the module.
> 
> It works because Kbuild trims the duplicated objects from linking,
> but there is no good reason to have this line.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
>  drivers/video/fbdev/core/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index 37710316a680..26cbc965497c 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -16,7 +16,6 @@ fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>  				     fbcon_ccw.o
>  endif
>  endif
> -fb-objs                           := $(fb-y)
>  
>  obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
>  obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
> 
