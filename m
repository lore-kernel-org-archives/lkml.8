Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD85222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GRCGFpdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCBPmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47044 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCBPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154231euoutp02bda7ef7835dc575ca9aef897424a9400~4hwtLVCv81345813458euoutp02V
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302154231euoutp02bda7ef7835dc575ca9aef897424a9400~4hwtLVCv81345813458euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163751;
        bh=hI3u1pukdnZavMLwcOWKBxl7dWUW2WAxnFQT8JclRYw=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=GRCGFpdIYGXsUNQaTWt1F08dM6DZ9Zoveyy00sSonayUzLD9xGJnGfQo4wZHamjx7
         hnXryCd7yD8bmnYrnySia88BDr9liWT/+IBM7eZE8VHbeaBTV5ya2qgF/KigHWN+J7
         f//5uLSMTl+DHnM98ZO/Pc9o27KOt+kPlFRj7cFI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154231eucas1p29af42f5ae062539f7fbf7505c47b77a7~4hws3RjPh2401424014eucas1p25;
        Mon,  2 Mar 2020 15:42:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.C3.60698.7692D5E5; Mon,  2
        Mar 2020 15:42:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154230eucas1p1a47d2ce0c4538702d0a1c6a5e4c4d0f2~4hwsZrClU0815708157eucas1p1V;
        Mon,  2 Mar 2020 15:42:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154230eusmtrp18bf3e2889b1b599f7b05c00fd8da835d~4hwsZBM4L2922329223eusmtrp1B;
        Mon,  2 Mar 2020 15:42:30 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-79-5e5d2967e48b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.20.08375.6692D5E5; Mon,  2
        Mar 2020 15:42:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154230eusmtip2c6f616257f36cade6a4e8985c7a30187~4hwr-CGR_2188921889eusmtip2F;
        Mon,  2 Mar 2020 15:42:30 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/4] video: fbdev: remove set but not used variable
 'bytpp'
To:     yu kuai <yukuai3@huawei.com>
Cc:     benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Message-ID: <e060e0a0-1861-20f0-d1ef-6a8137949659@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119121730.10701-5-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87rpmrFxBl2rOC0+NLUyW1z5+p7N
        4kTfB1aLy7vmsFlce3eGzWLOQjaLhY9usDmwe7Qcecvq0fOmhdXjfvdxJo/Pm+QCWKK4bFJS
        czLLUov07RK4MtZ8Syxo46n403+ZqYHxG2cXIyeHhICJxIHr65m6GLk4hARWMEocu/ycHcL5
        wiixt3EHM4TzmVHi4bE9zDAtE5acZIVILGeU6PrxFsp5yyjxa9lxFpAqNgEriYntqxhBbGGB
        QInnO5tZQWwRAQWJW80vwHYwgyxc9vwcWIJXwE7iwpP9YA0sAioSb6/eBIuLCkRIfHpwGKpG
        UOLkzCdgCzgFLCSO9vaBncQsIC5x68l8JghbXqJ562ywuyUE1rFLNB3dxAhxt4vE9QmHoWxh
        iVfHt7BD2DISpyf3sEA1MEr87XgB1b2dUWL55H9sEFXWEnfO/QKyOYBWaEqs36UPEXaUOHni
        I1hYQoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tosJO/MQvLO
        LIS9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmntP/jn/dwbjvT9IhRgEORiUe
        3gDm2Dgh1sSy4srcQ4wSHMxKIry+nNFxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJI
        TyxJzU5NLUgtgskycXBKNTDKaImzr5vseLhuKouy/rr0iekfNzd3cxi/nhmzaf7T2DlnOg0O
        znzzJKY0QTJEWGiNf2hkqLDI2lncRXatrTaXszyC120O2r6o/ca0GS78X//EXtF//mrdH/vN
        zY4vHOY/yZyvufta24oHbSIbdP/9efRGI+fRm6gp/Qfnute37Evwmeap3xmuxFKckWioxVxU
        nAgAqwksBzkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7ppmrFxBo+6tCw+NLUyW1z5+p7N
        4kTfB1aLy7vmsFlce3eGzWLOQjaLhY9usDmwe7Qcecvq0fOmhdXjfvdxJo/Pm+QCWKL0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MtZ8Syxo46n4
        03+ZqYHxG2cXIyeHhICJxIQlJ1m7GLk4hASWMkqsONvA2MXIAZSQkTi+vgyiRljiz7UuNoia
        14wS7ZP3s4Ak2ASsJCa2r2IEsYUFAiWe72xmBbFFBBQkbjW/YAdpYBZYwSjxYsVldojunYwS
        xw5sAaviFbCTuPBkP1g3i4CKxNurN8HiogIREod3zGKEqBGUODnzCdg2TgELiaO9fcwgNrOA
        usSfeZegbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84
        Mbe4NC9dLzk/dxMjMNK2Hfu5eQfjpY3BhxgFOBiVeHgDmGPjhFgTy4orcw8xSnAwK4nw+nJG
        xwnxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAJ5JXEG5oamltYGpobmxubWSiJ83YIHIwR
        EkhPLEnNTk0tSC2C6WPi4JRqYPS+XbvMQHrVtmbRraw/t95n/S44ffPSEtdDnaZNvz5Xvr8Z
        P0OhRHbmrAl/DecWdgoIt4g//x2y8cAXRybxpZM0w1KkTbdofVpk1XhINcQ4cM+lB8tPeOYd
        3n7Y3+3dHHHD81umzGMRnSnJc7KKyUbr/V6//I06vYJGvI/CPBwz3vyb2Tf//VklluKMREMt
        5qLiRABpQkznygIAAA==
X-CMS-MailID: 20200302154230eucas1p1a47d2ce0c4538702d0a1c6a5e4c4d0f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200119121831eucas1p19d7d048f980db055edf2eb15d5e82253
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200119121831eucas1p19d7d048f980db055edf2eb15d5e82253
References: <20200119121730.10701-1-yukuai3@huawei.com>
        <CGME20200119121831eucas1p19d7d048f980db055edf2eb15d5e82253@eucas1p1.samsung.com>
        <20200119121730.10701-5-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/radeon_base.c: In function
> ‘radeonfb_set_par’:
> drivers/video/fbdev/aty/radeon_base.c:1660:32: warning:
> variable ‘bytpp’ set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Patch queued for v5.7, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 7d2ee889ffcd..22b3ee4f2ffa 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1657,7 +1657,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	int i, freq;
>  	int format = 0;
>  	int nopllcalc = 0;
> -	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
> +	int hsync_start, hsync_fudge, hsync_wid, vsync_wid;
>  	int primary_mon = PRIMARY_MONITOR(rinfo);
>  	int depth = var_to_depth(mode);
>  	int use_rmx = 0;
> @@ -1731,7 +1731,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  		vsync_wid = 0x1f;
>  
>  	format = radeon_get_dstbpp(depth);
> -	bytpp = mode->bits_per_pixel >> 3;
>  
>  	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD))
>  		hsync_fudge = hsync_fudge_fp[format-1];
> 
