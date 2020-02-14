Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1563C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A3222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DK3Xn+l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgBNM0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:26:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43152 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgBNM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:26:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200214122601euoutp01b994db94a2440cd49b0f2e76eb99de79~zRHSd0i6b1929619296euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:26:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200214122601euoutp01b994db94a2440cd49b0f2e76eb99de79~zRHSd0i6b1929619296euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581683161;
        bh=aW/+vMdFzD8SE/Td/cuvjlkwmievkHZjELbJo6wwrUA=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=DK3Xn+l2YYSsFua9oNhBeLu0fz24uLSyoNRU2T1LF1UEkCpRrmNQPdYRvvyRsarQK
         sUfzPUqPq7NcNIHpTgTwSHNRytUA/TSx/aJI0Con68PJRBIp0VN383/7q7Ytwkvz6y
         QOdn976F8DOcQYEEOSDuHDaedKmcmAtgTwpJLlZ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200214122601eucas1p2a5f9f7d8eb7411da7ad70ab4c8996da9~zRHSUTjJp0164901649eucas1p2v;
        Fri, 14 Feb 2020 12:26:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.10.60698.9D1964E5; Fri, 14
        Feb 2020 12:26:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200214122601eucas1p1d1b141c41c788821c80ae6bc2ce04f8a~zRHR_9fcW3230232302eucas1p1Z;
        Fri, 14 Feb 2020 12:26:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200214122601eusmtrp126c556f304ec88903b477fcffdb56e98~zRHR_VoCX1114911149eusmtrp1T;
        Fri, 14 Feb 2020 12:26:01 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-5a-5e4691d9af7c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.DF.08375.9D1964E5; Fri, 14
        Feb 2020 12:26:01 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200214122600eusmtip1b5b5bdb41040567d1986f396fb6bbfb9~zRHRpUmUk2500125001eusmtip1D;
        Fri, 14 Feb 2020 12:26:00 +0000 (GMT)
Subject: Re: [PATCH] ARM: bcm2835_defconfig: add minimal support for
 Raspberry Pi4
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8bd7a25a-359d-5b30-4c95-004032d78cb6@samsung.com>
Date:   Fri, 14 Feb 2020 13:25:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <916c0113-9910-26cd-3720-15399fde507b@i2se.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87o3J7rFGex8omix6fE1VovLu+aw
        WUy8vYHdYtus5WwWm1bcYHNg9dh6y9Rj85J6j82nqz0+b5ILYInisklJzcksSy3St0vgyrh3
        /D1LwQ2uigPzaxsYT3F0MXJySAiYSLzu+c/axcjFISSwglGi5cp9JgjnC6PE7f9LoTKfGSWW
        9Lezw7T8enuRBSKxnFHixKR3zBDOW0aJnfMXgVUJC4RIbOmcA5YQETjJKNFx8S0LSIJNwFCi
        620XG4jNK2AncWT6VbA4i4CqxNQt7WBxUYFYidkrD7NA1AhKnJz5BMjm4OAUsJFYcM4PJMws
        IC+x/S3IfBBbXOLWk/lgd0sIdLNLvL81nx2kXkLARWLeyjKIq4UlXh3fAvWBjMTpyT0sEPXN
        jBIPz61lh3B6GCUuN81ghKiylrhz7hcbyCBmAU2J9bv0IcKOEk+3bYKazydx460gxA18EpO2
        TWeGCPNKdLQJQVSrScw6vg5u7cELl5ghbA+JpVdmMU5gVJyF5MlZSD6bheSzWQg3LGBkWcUo
        nlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYXk7/O/51B+O+P0mHGAU4GJV4eCX63OKEWBPL
        iitzDzFKcDArifAeVgQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUI
        JsvEwSnVwLjWvXuN1IXqk+F37BTdVRdkVCz9e0PQsmLuqc28UT38BV3BYlksK0vTPu3azHF/
        +eT/E4+/0gsrZ/VPjv21+5FrfG32dU9eg9pTrw+u+6k9981yoTcbn2dyvjKJiFtf+2bt7ie+
        E77vz/dacnbtEvnSbJtrCV8vfE8u5nTt9Ljg/0984jK7ltNKLMUZiYZazEXFiQA7Kk9rKwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7o3J7rFGVz7yGOx6fE1VovLu+aw
        WUy8vYHdYtus5WwWm1bcYHNg9dh6y9Rj85J6j82nqz0+b5ILYInSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7h3/D1LwQ2uigPzaxsYT3F0MXJy
        SAiYSPx6e5Gli5GLQ0hgKaPEnX9zmCASMhInpzWwQtjCEn+udbFBFL1mlNg/4SYzSEJYIETi
        Se8ydpCEiMBpRom2R9OgRm1mknjydDIjSBWbgKFE11uQdk4OXgE7iSPTr7KA2CwCqhJTt7SD
        xUUFYiVuzOxggqgRlDg58wlQDQcHp4CNxIJzfiBhZgEziXmbHzJD2PIS29/OgbLFJW49mc80
        gVFwFpLuWUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAyNl27OfmHYyX
        NgYfYhTgYFTi4S2Y4BYnxJpYVlyZe4hRgoNZSYT3sCJQiDclsbIqtSg/vqg0J7X4EKMp0G8T
        maVEk/OBUZ1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFx0b05
        /iePvQrZ6cs07dVE7uOOkRHRe9VehFwwlnjA/XC5aHxMdINszdXEXws5bHT6Tt+zcOyddr/p
        UHfjOvXN/y4VXAzf8N77ybRbkzc5JqUzLpmS1vF/f9xR9aRFbsJF8lGWW+2EGfjbxIz4zzkk
        b2Pz+/w6yeqHweLv3WKOJ6sOB/5K31GhxFKckWioxVxUnAgAmSraYrICAAA=
X-CMS-MailID: 20200214122601eucas1p1d1b141c41c788821c80ae6bc2ce04f8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
References: <CGME20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57@eucas1p1.samsung.com>
        <20200212102009.17428-1-m.szyprowski@samsung.com>
        <a1d66025baa13b2276b12405544fc7107aac8d6c.camel@suse.de>
        <5adcb2de-3570-9c4d-5e5b-726b94fb2029@samsung.com>
        <916c0113-9910-26cd-3720-15399fde507b@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 13.02.2020 10:59, Stefan Wahren wrote:
> On 13.02.20 08:35, Marek Szyprowski wrote:
>> On 12.02.2020 19:31, Nicolas Saenz Julienne wrote:
>>> On Wed, 2020-02-12 at 11:20 +0100, Marek Szyprowski wrote:
>>>> Add drivers for the minimal set of devices needed to boot Raspberry Pi4
>>>> board.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Just so you know, the amount of support on the RPi4 you might be able to get
>>> updating bcm2835_defconfig's config is very limited. Only 1GB of ram and no
>>> PCIe (so no USBs).
>> Yes, I know. A lots of core features is missing: SMP, HIGHMEM, LPAE, PCI
>> and so on, but having a possibility to boot RPi4 with this defconfig
>> increases the test coverage.
> in case you want to increase test coverage, we better enable all
> Raspberry Pi 4 relevant hardware parts (hwrng, thermal, PCI ...). This
> is what we did for older Pi boards.

Okay, I will add thermal in v2. HWRNG is already selected as module. 
Enabling PCI without LPAE makes no sense as the driver won't be able to 
initialize properly.

> SMP, HIGHMEM, LPAE are different and shouldn't be enabled in
> bcm2835_defconfig from my PoV.

Maybe it would make sense to also add bcm2711_defconfig or 
bcm2835_lpae_defconfig?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

