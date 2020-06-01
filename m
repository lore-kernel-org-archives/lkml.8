Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746592065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DD5CW6z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFANZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:25:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38151 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFANZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:25:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601132511euoutp01d0895a3e5bf4ba3cb0efc9c68eb13036~UblxuJCvs2438824388euoutp01i
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:25:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601132511euoutp01d0895a3e5bf4ba3cb0efc9c68eb13036~UblxuJCvs2438824388euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591017911;
        bh=vqGZG5qX74FLzAKj5zGsagfREBRj7/YhNejXCy/cIJA=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=DD5CW6z9cc37FIKAEAPCLHCbgm/b2v2zVjlbBjTfSIa6yR2aSUF6IbOzunqIOqctp
         8gccrdhT/0k3wckeexQ2KwwsxwYPL5zBGRnPsN3TUGNjYvkCvfFolzHQHlgXR9oIfL
         G41d60tl2mK8HYwv/uprwxc1sjRlzERGOHTXoJ0U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601132511eucas1p1f8f1c6593d2a67424983a859e7991403~Ublxi8SEm2556225562eucas1p1A;
        Mon,  1 Jun 2020 13:25:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E2.33.60679.7B105DE5; Mon,  1
        Jun 2020 14:25:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601132510eucas1p273bbde70a05e8433deacd67c9b2dd482~Ublw6N0uN2508925089eucas1p2a;
        Mon,  1 Jun 2020 13:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601132510eusmtrp1e82d0db7399a5fdf0c6db2df7f0e746f~Ublw5oGPc2270722707eusmtrp1M;
        Mon,  1 Jun 2020 13:25:10 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-29-5ed501b77c71
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.DB.08375.6B105DE5; Mon,  1
        Jun 2020 14:25:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601132510eusmtip1a366c4100336dbaaed6365a45a1837fb~UblwdoQa91148011480eusmtip1E;
        Mon,  1 Jun 2020 13:25:10 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v1] video: fbdev: sm712fb: fix an issue about iounmap
 for a wrong address
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <cdc18f39-b4e2-a8cb-6816-4de3888aeb48@samsung.com>
Date:   Mon, 1 Jun 2020 15:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200422160719.27763-1-zhengdejin5@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk752w5+ZzKXuw+ojTISxoMDTPJ2J8k608FaTNPKpsXdrwW
        kZCYrExTKxxqF8sb4q3QnJdKwalDg7ywLmqK5oVWOS0qzXIeJf+9PJf3fZ6PjyGktUIXJjo2
        gdXGqjRySkw2dP7q29+IBkM9S187K2ZyOpBi4PtXSnGtpIZSdN36JlT0GwopxUtTPqGoetyC
        FIbxt0QAo2zSD9PKF0VVtHL0hlGgnBqdpJTz9dtPCM+KD0WwmugkVuvhf14clTVkRPHFohRj
        3hyZhnppHRIxgH2guDkL6ZCYkeJyBNbmEsJGSPECgsFWEU/MI+i5Wy1cd9RYRwQ8UYYg903l
        mt2CYKhrWmBTUdgXbl+3ESLGEYfBU8Pf1bVOeC8UpGeTNgOBpxCYl8ZWg0iwP4ykD6+cYBgS
        74a2J0E22BmfBuvHDiEvcYDuggnSNouwH8wW8VEJLIN3E/cF/LwDGi2FhG0/YAMNi/mLJB/7
        KJR8Wkb87AizxmdrD7AVTHk3Sd5QjeBP5vSauxFBWd4yxav84EPfb8qWjsBuUGPw4OEjMNfW
        uRoasD2YLQ58CHvIbbhH8LAEMjOkvHoP1JbWUutndU0VRA6S6zdU02+oo99QR///7gNEViIZ
        m8jFRLLcgVg22Z1TxXCJsZHuF+Ji6tHKPzItGxeeI8NSeDvCDJLbSZjxgVCpUJXEpca0I2AI
        uZMksNcUKpVEqFIvsdq4MG2ihuXa0RaGlMsk3o9mzklxpCqBVbNsPKtdZwWMyCUNuVpy3k95
        loclk60zFpm6+7hrXT0XkCKIShuM8j55rOJH+GRfv9uck1Ow1nzwqm7XHfqh+lV1iHiwrrz4
        DCykj1/cZGW+mK6EU5cZJtCezGiBGXmPuvXw5rHMU/SQdVu22dcnJ3i8P7I/N8SVHjba0T8l
        9E6vztzPak1GkEZOclEqr32EllP9A5rrhotDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7rbGK/GGcw5q27xcsJhRosrX9+z
        WTQvXs9mcaLvA6vF5V1z2CwOnJ7CbLFmyR5Gi12PbjI7cHjsnHWX3WP/3DXsHve7jzN5PL//
        lM3j8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQi
        fbsEvYzea8cZC+ZxVhyf/JGlgfEsexcjJ4eEgInE+k/3mLoYuTiEBJYySvw8uJeti5EDKCEj
        cXx9GUSNsMSfa11sEDWvGSX+XL/BCpJgE7CSmNi+ihHEFhaIl/j5ohnMFhFQl5jZ0s8CYjML
        PGeU6FgTDtHcxyjxf+sdsM28AnYS91rusoIsYxFQkdi31BUkLCoQIXF4xyxGiBJBiZMzn4DN
        4RSwlng1dzEzxEx1iT/zLkHZ4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypG
        kdTS4tz03GJDveLE3OLSvHS95PzcTYzA6Nt27OfmHYyXNgYfYhTgYFTi4d1w/0qcEGtiWXFl
        7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5gY8kriDU0NzS0sDc2N
        zY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MHa3Obcy533PldToazz2XE9r89M/DI6K
        GvpygvXeZ/dI6Z53054i36Yl/+dS07Sclw17S/rlnCdMq7c9ddbdUPRn2PvzZ55sX8uwa/+1
        ngU2Wr//eXYeWal741J6+1ux7K9Lf6xh/Djv350vtrX7KjRS1dQPhWj679fkWCLYWuMpvKAm
        0ylrixJLcUaioRZzUXEiAOuMJ/zUAgAA
X-CMS-MailID: 20200601132510eucas1p273bbde70a05e8433deacd67c9b2dd482
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200422160730eucas1p179849adadf1cb41dfe54d7e5f8b61c8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200422160730eucas1p179849adadf1cb41dfe54d7e5f8b61c8e
References: <CGME20200422160730eucas1p179849adadf1cb41dfe54d7e5f8b61c8e@eucas1p1.samsung.com>
        <20200422160719.27763-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/22/20 6:07 PM, Dejin Zheng wrote:
> the sfb->fb->screen_base is not save the value get by iounmap() when
> the chip id is 0x720. so iounmap() for address sfb->fb->screen_base
> is not right.
> 
> Fixes: 1461d6672864854 ("staging: sm7xxfb: merge sm712fb with fbdev")
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sm712fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 6a1b4a853d9e..8cd655d6d628 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1429,6 +1429,8 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
>  static void smtc_unmap_smem(struct smtcfb_info *sfb)
>  {
>  	if (sfb && sfb->fb->screen_base) {
> +		if (sfb->chip_id == 0x720)
> +			sfb->fb->screen_base -= 0x00200000;
>  		iounmap(sfb->fb->screen_base);
>  		sfb->fb->screen_base = NULL;
>  	}
> 

