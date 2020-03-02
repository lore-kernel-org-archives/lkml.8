Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2D924676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AqZfkeeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCBPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:29 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55733 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCBPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:28 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154227euoutp018985324df335a31ad2204c0f4ca4f955~4hwo7ivPO1322613226euoutp018
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302154227euoutp018985324df335a31ad2204c0f4ca4f955~4hwo7ivPO1322613226euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163747;
        bh=2Q4/AluqvvIf3Zl38zvbs1irbTW6yQIMu0j1JxGQqgU=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=AqZfkeeE8NjgZLAa4wgnq+qO2SXgb4xzozK9HVzD3/MSOdWxB7U2Vd9bbsx/i4xT7
         dSNQVtUPl2SerPgwNhgOU0bDJKdUpkj7KIICIQWiI5LEgqPgoQDd91ildRGKOvmYHE
         Y2qlbNjblxp7Yo1aq2S861/NlAz7lL5/J7EnQ/Mo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154226eucas1p297ade7ce07637ed82a6535a32162ac3d~4hwoq_7CH2401424014eucas1p22;
        Mon,  2 Mar 2020 15:42:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.C3.60698.2692D5E5; Mon,  2
        Mar 2020 15:42:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154226eucas1p2d5e250206de14276f2f574798505b703~4hwoYnL_51589815898eucas1p2h;
        Mon,  2 Mar 2020 15:42:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154226eusmtrp1e8195fa6bb37d243277a6d6ba903d4ef~4hwoYFOLT2870428704eusmtrp1T;
        Mon,  2 Mar 2020 15:42:26 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-6f-5e5d29625ed6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.FF.07950.2692D5E5; Mon,  2
        Mar 2020 15:42:26 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154226eusmtip11eaf0e7cc92c5b93f457679a348a4284~4hwoEsMtl2008820088eusmtip1X;
        Mon,  2 Mar 2020 15:42:26 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4] video: fbdev: remove set but not used variable
 'vSyncPol'
To:     yu kuai <yukuai3@huawei.com>
Cc:     benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Message-ID: <a18c91bf-2517-00d5-3943-0e01a12346f0@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119121730.10701-4-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87pJmrFxBmuOaVt8aGpltrjy9T2b
        xYm+D6wWl3fNYbO49u4Mm8WchWwWCx/dYHNg92g58pbVo+dNC6vH/e7jTB6fN8kFsERx2aSk
        5mSWpRbp2yVwZVzrzCo4wVNxvHsFYwPjQq4uRk4OCQETiWtPXjN2MXJxCAmsYJS4ffYRK4Tz
        hVHiT+crFgjnM6PEmXUP2WFabp5uYYNILGeUOLz4CVTLW0aJb1sns4FUsQlYSUxsX8UIYgsL
        hEjsuH6BCcQWEVCQuNX8gh2kgRlk4bLn51hBErwCdhITPhwGs1kEVCTO/HoNNkhUIELi04PD
        UDWCEidnPgG6iYODU8BC4twsL5Aws4C4xK0n85kgbHmJ5q2zmUHmSwisY5fYvGQ6O0i9hIAL
        0BFMEB8IS7w6vgXqGxmJ05N7WKDqGSX+dryAat7OKLF88j82iCpriTvnfrGBDGIW0JRYv0sf
        IuwosW9eGyPEfD6JG28FIW7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJY7OQ
        fDMLyTezEPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZh2Tv87/nUH474/SYcY
        BTgYlXh4A5hj44RYE8uKK3MPMUpwMCuJ8PpyRscJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe
        9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwLj25aJgt7j2E1ebpUJKFsrJXdxoGTTNc8ZMroXTA577
        776i9eFVf+clA9UcUZFtj6UtuZUviVv88BV95lfdJ/As6rUrY2WyQWhcxUb3yKt7rPI99faL
        t65bMWOq5IsDvBUfQ9M2CHaf0jPcf/6vosOdIMk96/6w7ZnXomZonnEley/HrpiUdCWW4oxE
        Qy3mouJEAJY1/BE3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pJmrFxBm1TpSw+NLUyW1z5+p7N
        4kTfB1aLy7vmsFlce3eGzWLOQjaLhY9usDmwe7Qcecvq0fOmhdXjfvdxJo/Pm+QCWKL0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mq51ZhWc4Kk4
        3r2CsYFxIVcXIyeHhICJxM3TLWxdjFwcQgJLGSVOH5rN1MXIAZSQkTi+vgyiRljiz7UuqJrX
        jBKbX8xlBUmwCVhJTGxfxQhiCwuESOy4foEJxBYRUJC41fyCHaSBWWAFo8SLFZfZIbp3Mkps
        79oC1sErYCcx4cNhsEksAioSZ369ZgOxRQUiJA7vmAVVIyhxcuYTFpCLOAUsJM7N8gIJMwuo
        S/yZd4kZwhaXuPVkPhOELS/RvHU28wRGoVlIumchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSK
        E3OLS/PS9ZLzczcxAuNs27GfW3Ywdr0LPsQowMGoxMP7gyE2Tog1say4MvcQowQHs5IIry9n
        dJwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wNTQF5JvKGpobmFpaG5sbmxmYWSOG+HwMEY
        IYH0xJLU7NTUgtQimD4mDk6pBsb6xTbfetctmTr5szW3xZmLBixfcxkeufPnXP21/mhfLrv1
        00L2zP2qs6/Oi1mgPmF6o2nXpHOvHNfPd2WoX+R1pqFGXzHI5UKFxMwcj606b0XmO7AcZU4P
        Y0lpfOkVa2Gn6hhz/Mxd077w5A3m5Zb+h5NPZamd+S/NOyFS4Hk9V/nbozqrpyqxFGckGmox
        FxUnAgDeutgHyQIAAA==
X-CMS-MailID: 20200302154226eucas1p2d5e250206de14276f2f574798505b703
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200119121832eucas1p29efb035b8b8258bf8f78d37e39c64030
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200119121832eucas1p29efb035b8b8258bf8f78d37e39c64030
References: <20200119121730.10701-1-yukuai3@huawei.com>
        <CGME20200119121832eucas1p29efb035b8b8258bf8f78d37e39c64030@eucas1p2.samsung.com>
        <20200119121730.10701-4-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/radeon_base.c: In function
> ‘radeonfb_set_par’:
> drivers/video/fbdev/aty/radeon_base.c:1653:48: warning: variable
> ‘cSync’ set but not used [-Wunused-but-set-variable]
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
>  drivers/video/fbdev/aty/radeon_base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 0666f848bf70..7d2ee889ffcd 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	struct fb_var_screeninfo *mode = &info->var;
>  	struct radeon_regs *newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
> -	    vSyncStart, vSyncEnd, cSync;
> +	    vSyncStart, vSyncEnd;
>  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
>  	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
>  	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
> @@ -1730,8 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  	else if (vsync_wid > 0x1f)	/* max */
>  		vsync_wid = 0x1f;
>  
> -	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
> -
>  	format = radeon_get_dstbpp(depth);
>  	bytpp = mode->bits_per_pixel >> 3;
>  
