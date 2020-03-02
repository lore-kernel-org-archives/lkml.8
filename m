Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15370C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8070222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I+9jLMj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCBPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55790 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgCBPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154235euoutp018de63f8099fa82afa9986f8452ee6a65~4hwwrwDZB1457214572euoutp01R
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302154235euoutp018de63f8099fa82afa9986f8452ee6a65~4hwwrwDZB1457214572euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163755;
        bh=eDSx6Ol5pio0KwUFZPvqg82H3h7F/bFkN2rPoKXN2sk=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=I+9jLMj6PfEz8LZIIkSatEnPKBNpfMzC7vvS7L+CPqfFVpuz4hmACpdbK+JD6xdvC
         B+UDGG4TE1aS5UvrxeAusWjLDvKCt3gwI0LP3AUcnH+Bl52Z4z4WX0jcsMpesJqJXz
         ri6VRmuI4j3LnO9yeXZ6zakO1j3+joPPdf812E54=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154235eucas1p29481c369be662e126846f6913f0f7bf9~4hwwf4o3f2199621996eucas1p2S;
        Mon,  2 Mar 2020 15:42:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.C3.60698.B692D5E5; Mon,  2
        Mar 2020 15:42:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154234eucas1p28d4029255b58b6cd63e587655010efbc~4hwwKKjeM2399223992eucas1p2O;
        Mon,  2 Mar 2020 15:42:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154234eusmtrp1257456edfec660818add2723ecf1872d~4hwwJjINk2922329223eusmtrp1M;
        Mon,  2 Mar 2020 15:42:34 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-84-5e5d296bb470
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.00.07950.A692D5E5; Mon,  2
        Mar 2020 15:42:34 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154234eusmtip2f17357d24d4c7770d7325bb853ea054b~4hwv0j-m32188921889eusmtip2H;
        Mon,  2 Mar 2020 15:42:34 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: remove set but not used variable 'ulScaleRight'
To:     yu kuai <yukuai3@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Message-ID: <0b16ece5-a95c-5420-b5d4-7c576171780f@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119121945.12517-1-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7rZmrFxBtvOM1tc+fqezeJE3wdW
        i8u75rBZXHt3hs1izkI2i4WPbrA5sHm0HHnL6nG/+ziTx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        +5acZSro4ql4dOs2WwPjd84uRk4OCQETicPbl7CB2EICKxglTrVadTFyAdlfGCXOXj3ICuF8
        ZpR4efQXUBUHWMeZ//UQ8eWMErdXfGCG6H7LKNHa7wdiswlYSUxsX8UIYgsLeEvMXfudBcQW
        EVCQuNX8gh2kmVmgh1HiwJc9YAleATuJddf/gw1iEVCR6Dn8hhXEFhWIkPj04DArRI2gxMmZ
        T8DqOQUsJBatPcQOYjMLiEvcejKfCcKWl2jeOpsZZIGEwGR2iSdPp7JD/OkisX33MiYIW1ji
        1fEtUHEZidOTe1ggGtYxSvzteAHVvZ1RYvnkf2wQVdYSd85B/M8soCmxfpc+RNhRYs2hfnZI
        sPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl8wRGpVlIXpuF5J1ZSN6ZhbB3
        ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMAUc/rf8a87GPf9STrEKMDBqMTDG8Ac
        GyfEmlhWXJl7iFGCg1lJhNeXMzpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp
        2ampBalFMFkmDk6pBsaDxgeTj32f01a9w3bpHdni2stW7z1V7eWmaqwR+ypyK417W67gWpsD
        a/mNvcsWy2df4prUPj9slVS7RHV1aFGvd/WD9qVvS+VE5uyfc/9O1u5Y/QXvJMSm9CW4rvx5
        5/G+EP0/b5aJzmJkWnSZZafNRwHZc96nZLOX1MldFz5/pa89VCFI5L8SS3FGoqEWc1FxIgAd
        hsuNLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7pZmrFxBk/O6Vpc+fqezeJE3wdW
        i8u75rBZXHt3hs1izkI2i4WPbrA5sHm0HHnL6nG/+ziTx+dNcgHMUXo2RfmlJakKGfnFJbZK
        0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ+5acZSro4ql4dOs2WwPjd84u
        Rg4OCQETiTP/67sYuTiEBJYySqy6+4cdIi4jcXx9WRcjJ5ApLPHnWhcbRM1rRomHb16wgSTY
        BKwkJravYgSxhQW8Jeau/c4CYosIKEjcan7BDmIzC/QwSvyaFw/R3A204PsssAZeATuJddf/
        M4PYLAIqEj2H37CC2KICERKHd8DUCEqcnPkEbCingIXEorWHoIaqS/yZd4kZwhaXuPVkPhOE
        LS/RvHU28wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNq
        27GfW3Ywdr0LPsQowMGoxMP7gyE2Tog1say4MvcQowQHs5IIry9ndJwQb0piZVVqUX58UWlO
        avEhRlOg5yYyS4km5wPjPa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8T
        B6dUA2PMHeNfqVYN36wnSR7I5WKxOntwhkTc7nVf5OVqTkjFRH1TlP3ifkL1+2nbzrACu4A4
        pt6Kf+0p5vtrs4/41SmZ1mTnrTStY9zkZq5i/7Wdo9Z5V2/fimcrElRti9olJkrqs0geqilc
        Z+c81W73jutL16w7dMh85/qNfVF7Fb/Myc+VbHwxS4mlOCPRUIu5qDgRAPeAlIK/AgAA
X-CMS-MailID: 20200302154234eucas1p28d4029255b58b6cd63e587655010efbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200119122043eucas1p2b450cd177ca0d86d268323a074c82b05
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200119122043eucas1p2b450cd177ca0d86d268323a074c82b05
References: <CGME20200119122043eucas1p2b450cd177ca0d86d268323a074c82b05@eucas1p2.samsung.com>
        <20200119121945.12517-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 1:19 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/kyro/STG4000OverlayDevice.c: In function
> ‘SetOverlayViewPort’:
> drivers/video/fbdev/kyro/STG4000OverlayDevice.c:334:19: warning:
> variable ‘ulScaleRight’ set but not used [-Wunused-but-set-variable]
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
>  drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> index 0aeeaa10708b..9fde0e3b69ec 100644
> --- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> @@ -331,7 +331,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
>  	u32 ulScale;
>  	u32 ulLeft, ulRight;
>  	u32 ulSrcLeft, ulSrcRight;
> -	u32 ulScaleLeft, ulScaleRight;
> +	u32 ulScaleLeft;
>  	u32 ulhDecim;
>  	u32 ulsVal;
>  	u32 ulVertDecFactor;
> @@ -470,7 +470,6 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
>  		 * round down the pixel pos to the nearest 8 pixels.
>  		 */
>  		ulScaleLeft = ulSrcLeft;
> -		ulScaleRight = ulSrcRight;
>  
>  		/* shift fxscale until it is in the range of the scaler */
>  		ulhDecim = 0;
> 
