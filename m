Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B32D221EC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O76ukPbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIHMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:38:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50441 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgIHLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:50:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200908113747euoutp01466b4f9ffee0ab07b33f2367053fc395~yy-Q60CNC0752907529euoutp01v
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200908113747euoutp01466b4f9ffee0ab07b33f2367053fc395~yy-Q60CNC0752907529euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599565067;
        bh=IksfWJS9W+nx/s+HKKC3IC9FURMGnu/x8VGbOOkCFFA=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=O76ukPbtuOy3JkQ+g0/81Vfnr96z+pvVPeyqKnLxsvMuBSiTTmhlhEEOplfjHKCW+
         6p5pYwkRaQ2hZ4Pf0AzJNMgWJeI5jj6tv7q6m/78txuf0ZpoQCP+GsByE68f+0kFsM
         a2RFw1U+SvQ7RI5XQzql7dhbbq+pNZlyijiqU2kI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908113747eucas1p1d9f7fd6fbf9e0a1ca52324db61ad30ec~yy-Qmh3XJ0741007410eucas1p1l;
        Tue,  8 Sep 2020 11:37:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.6E.06456.B0D675F5; Tue,  8
        Sep 2020 12:37:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113746eucas1p2192fcec3ad95ed43c74461c0ccdf527d~yy-QJpdrM2602726027eucas1p29;
        Tue,  8 Sep 2020 11:37:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908113746eusmtrp2d1245f1c835f043e9794572bfb889081~yy-QJGOGn3046530465eusmtrp26;
        Tue,  8 Sep 2020 11:37:46 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-27-5f576d0b8704
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.C4.06017.A0D675F5; Tue,  8
        Sep 2020 12:37:46 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908113746eusmtip28a5016e082bbc918ca632d2c497f9d9b~yy-P0M8wF1482014820eusmtip2O;
        Tue,  8 Sep 2020 11:37:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: remove set but not used 'ulBestVCO'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Message-ID: <8b15618f-eaf5-e646-2655-939d8b456b27@samsung.com>
Date:   Tue, 8 Sep 2020 13:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200827130008.428706-1-yanaijie@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7rcueHxBo1NLBZXvr5ns/i//Aqj
        xYm+D6wWl3fNYbNYtKeT2YHVo+XIW1aP+93HmTw+b5ILYI7isklJzcksSy3St0vgyjj48ixT
        wRSBiiO/TzM2MC7l6WLk5JAQMJF4eP0LexcjF4eQwApGiVnd06CcL4wSa9ruMEM4nxklptxv
        Z4RpmXJ7CguILSSwnFFi20sLiKK3jBLnPjwGS7AJWElMbF8F1iAs4Cbxr/cDM4gtIqAs0Xh/
        OitIA7NAA6PEvcOHgfZxcPAK2Ek0rPIGqWERUJGYOWUqG4gtKhAh8enBYVYQm1dAUOLkzCdg
        8zmB5i+63gBmMwuIS9x6Mp8JwpaXaN46G+xqCYHp7BJbbx9gg7jaRWJ/ywpWCFtY4tXxLewQ
        tozE/50gzSAN6xgl/na8gOreziixfPI/qG5riTvnfrGBXMosoCmxfpc+RNhRYvb7lUwgYQkB
        PokbbwUhjuCTmLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5g
        ZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmFxO/zv+aQfj10tJhxgFOBiVeHg/eIXF
        C7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZ
        qakFqUUwWSYOTqkGxkCutCkTlU7smn/SJ0r8188IHsdGmQbzkrqPD6s897Fxhq1hXGRRGJr+
        a/FUH7uOz1Pk2BP/fSvsUXqv0yrw7tnS3nXLoi6VW7r8V3MTqi74eUyqcFu52JwEif2M1Zdn
        lrJmqZXuWLvmoH29utIm2ei1mrNaeGVtH7TteKVfciRpy6IKczkHJZbijERDLeai4kQAae9N
        2SoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7pcueHxBr8uKlpc+fqezeL/8iuM
        Fif6PrBaXN41h81i0Z5OZgdWj5Yjb1k97ncfZ/L4vEkugDlKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pgy7NMBVMEKo78Ps3YwLiUp4uRk0NC
        wERiyu0pLF2MXBxCAksZJXY/3cfYxcgBlJCROL6+DKJGWOLPtS42iJrXjBLzXx1iAUmwCVhJ
        TGxfxQhiCwu4Sfzr/cAMYosIKEs03p/OCtLALNDAKHHyaxsjRHcvo0TD9BdgG3gF7CQaVnmD
        NLAIqEjMnDKVDcQWFYiQOLxjFthQXgFBiZMzn4At4wRatuh6A5jNLKAu8WfeJWYIW1zi1pP5
        TBC2vETz1tnMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQI
        jKZtx35u2cHY9S74EKMAB6MSD+8Hr7B4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccX
        leakFh9iNAV6biKzlGhyPjDS80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB
        9DFxcEo1MJ7q+9MfeUTmTOqBn2uuCl7snS+QdDvbWKT/5gd5hpqja8KbrxtzrXlv+N94irfe
        gYjCuoqwrXUbbaU6Wi3rnhnWOfuZMfybq7+1TemmeFXc76UzlVLiMq6tDju88OxGyYlaDUtP
        iHrGMvGECEqw3AnjlHP6tuprySfzmbVfIv7oic/XTZJ2VGIpzkg01GIuKk4EAGCK1xW8AgAA
X-CMS-MailID: 20200908113746eucas1p2192fcec3ad95ed43c74461c0ccdf527d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200827130039eucas1p124a0c2d9912f55281386c9318013a17a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200827130039eucas1p124a0c2d9912f55281386c9318013a17a
References: <CGME20200827130039eucas1p124a0c2d9912f55281386c9318013a17a@eucas1p1.samsung.com>
        <20200827130008.428706-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/20 3:00 PM, Jason Yan wrote:
> This addresses the following gcc warning with "make W=1":
> 
> drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
> ‘ProgramClock’:
> drivers/video/fbdev/kyro/STG4000InitDevice.c:123:6: warning: variable
> ‘ulBestVCO’ set but not used [-Wunused-but-set-variable]
>   123 |  u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
>       |      ^~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/kyro/STG4000InitDevice.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> index edaeec2d9590..21875d3c2dc2 100644
> --- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> @@ -120,7 +120,7 @@ u32 ProgramClock(u32 refClock,
>  {
>  	u32 R = 0, F = 0, OD = 0, ODIndex = 0;
>  	u32 ulBestR = 0, ulBestF = 0, ulBestOD = 0;
> -	u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
> +	u32 ulBestClk = 0, ulBestScore = 0;
>  	u32 ulScore, ulPhaseScore, ulVcoScore;
>  	u32 ulTmp = 0, ulVCO;
>  	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
> @@ -189,7 +189,6 @@ u32 ProgramClock(u32 refClock,
>  						ulScore = ulPhaseScore + ulVcoScore;
>  
>  						if (!ulBestScore) {
> -							ulBestVCO = ulVCO;
>  							ulBestOD = OD;
>  							ulBestF = F;
>  							ulBestR = R;
> @@ -206,7 +205,6 @@ u32 ProgramClock(u32 refClock,
>                            but we shall keep this code in case new restrictions come into play
>                            --------------------------------------------------------------------------*/
>  						if ((ulScore >= ulBestScore) && (OD > 0)) {
> -							ulBestVCO = ulVCO;
>  							ulBestOD = OD;
>  							ulBestF = F;
>  							ulBestR = R;
> 
