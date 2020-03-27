Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAA0C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2CB206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CewQVAlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgC0JLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:11:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46029 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0JLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:11:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200327091059euoutp0211bc6179ca3020ade1e3390f2084692c~AHi-JyNr10477904779euoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:10:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200327091059euoutp0211bc6179ca3020ade1e3390f2084692c~AHi-JyNr10477904779euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585300259;
        bh=P8b49fKTqxvHEVfznbeY2BS6Zozf9WEO68ZcgbVoi10=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CewQVAlLbkT8UxdB6KbTdRWM1I4wNdmqFPQ/X2f4BK97phHpjHO7+kZDMHY2y2Hpl
         kMhodcsJtxAe23lsSJLlwaUaFaMsrKayseaw1PyDpJJPsOatgLomrun4R6gWPE5UBK
         SCfrQ8Y5eMpvPBT6WGiHFrAmrycrAlpEKUGUsIx4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200327091059eucas1p1d251c3c32a815723613ca8aa4b5e161e~AHi_2u-Vz0441404414eucas1p1l;
        Fri, 27 Mar 2020 09:10:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.02.60698.223CD7E5; Fri, 27
        Mar 2020 09:10:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200327091058eucas1p27ae8a0068a01367fc95cdb1d73658d99~AHi_brVBY3148631486eucas1p2-;
        Fri, 27 Mar 2020 09:10:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200327091058eusmtrp18a994ac65d31853e3d42cbde6fa17287~AHi_bDujz2611026110eusmtrp1f;
        Fri, 27 Mar 2020 09:10:58 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-98-5e7dc322356a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.C1.07950.223CD7E5; Fri, 27
        Mar 2020 09:10:58 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200327091058eusmtip221cf32f8dee496a56d948f968a445d78~AHi98kbp-1115711157eusmtip2L;
        Fri, 27 Mar 2020 09:10:58 +0000 (GMT)
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        amd-gfx-request@lists.freedesktop.org, alexander.deucher@amd.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <cd773011-969b-28df-7488-9fddae420d81@samsung.com>
Date:   Fri, 27 Mar 2020 10:10:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rKh2vjDI7fYbLoPXeSyWLand2s
        Fuv+3WSxaNzZx2Tx9j6Qe+XrezaLy7vmsDmwe7Re+svmsXPWXXaP7d8esHrc7z7O5PF5k1wA
        axSXTUpqTmZZapG+XQJXxsfvB1kLlotUTD+8hrmBcb1AFyMnh4SAicSE5//Zuhi5OIQEVjBK
        XFqyixHC+cIocffIN1YI5zOjxMepG5hhWjY8nQSVWM4o8fjJXSjnPaPEkrvLGUGqhAVcJXY2
        tYLNEhHoZJToW7+ZBSTBLFAmcen5HDYQm03AUKLrbReYzStgJ/Gr8zJYDYuAqsTtf81gg0QF
        YiQuHu5nhagRlDg58wlYDaeAtcS3jWvYIGbKSzRvnc0MYYtL3HoynwlksYTAOnaJnvmPWSHu
        dpGYcesL1A/CEq+Ob2GHsGUkTk/uYYFoaGaUeHhuLTuE08MocblpBiNElbXEnXO/gNZxAK3Q
        lFi/Sx8i7Cjx7MpJZpCwhACfxI23ghBH8ElM2jYdKswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0
        C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmIhO/zv+dQfj
        vj9JhxgFOBiVeHgb2mrihFgTy4orcw8xSnAwK4nwPo0ECvGmJFZWpRblxxeV5qQWH2KU5mBR
        Euc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDo4nXukXCn45+E5UW/db+f3/6U5dDigLLQIwuq
        U3N2eE+6+3MN58kkhoIn5t56sr2a8wQT3mSGuNr/eXLd/e3WymPf1hfcn7W2J/1Dod+po8/7
        LzlO6f93yeFxwk/VNo8LnpZXuBPPvb8kwLDgpXyI7EXHv0ybTlR90m6c4jFXO4UzcPHXc9z3
        lViKMxINtZiLihMBYpN1DEADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7pKh2vjDC6dUbXoPXeSyWLand2s
        Fuv+3WSxaNzZx2Tx9j6Qe+XrezaLy7vmsDmwe7Re+svmsXPWXXaP7d8esHrc7z7O5PF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsfv
        B1kLlotUTD+8hrmBcb1AFyMnh4SAicSGp5NYQWwhgaWMEjum5kLEZSROTmtghbCFJf5c62Lr
        YuQCqnnLKHFj60sWkISwgKvEzqZWRpCEiEAno8SenxeZQBLMAmUSuy40M0J0fGGU+Hz8ISNI
        gk3AUKLrLcgoTg5eATuJX52XwSaxCKhK3P7XDFYjKhAj8XNPFwtEjaDEyZlPwGxOAWuJbxvX
        sEEsMJOYt/khM4QtL9G8dTaULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBMbdtmM/t+xg7HoXfIhRgINRiYdXo6UmTog1say4MvcQowQHs5II
        79NIoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NCXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGxolLGue9uW0rnRubqqheH3vq8v7vX0Ij1/W48K8tqdql
        Z1IaETcl9UG8phj3xPuaUofXy91hCuETXai0YZHXusTn3I9zP9q67XK6uLS4yL7E7c9HIeNd
        t61vXFk8ITZuD+ux5x3f9fy22JhcdW50DvGsF44PEJKZsWQp1yvpGV7Jsy42ud72VGIpzkg0
        1GIuKk4EAOOqLn/RAgAA
X-CMS-MailID: 20200327091058eucas1p27ae8a0068a01367fc95cdb1d73658d99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb
References: <20200325090741.21957-2-bigbeeshane@gmail.com>
        <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
        <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com>
        <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 2020-03-27 09:11, Christian König wrote:
> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
>> On 2020-03-25 10:07, Shane Francis wrote:
>>> As dma_map_sg can reorganize scatter-gather lists in a
>>> way that can cause some later segments to be empty we should
>>> always use the sg_dma_len macro to fetch the actual length.
>>>
>>> This could now be 0 and not need to be mapped to a page or
>>> address array
>>>
>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> This patch landed in linux-next 20200326 and it causes a kernel panic on
>> various Exynos SoC based boards.
>>> ---
>>>    drivers/gpu/drm/drm_prime.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>> index 86d9b0e45c8c..1de2cde2277c 100644
>>> --- a/drivers/gpu/drm/drm_prime.c
>>> +++ b/drivers/gpu/drm/drm_prime.c
>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct 
>>> sg_table *sgt, struct page **pages,
>>>           index = 0;
>>>        for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>>> -        len = sg->length;
>>> +        len = sg_dma_len(sg);
>>>            page = sg_page(sg);
>>>            addr = sg_dma_address(sg);
>> Sorry, but this code is wrong :(
>
> Well it is at least better than before because it makes most drivers 
> work correctly again.

Well, I'm not sure that a half-broken fix should be considered as a fix ;)

Anyway, I just got the comment from Shane, that my patch is fixing the 
issues with amdgpu and radeon, while still working fine for exynos, so 
it is indeed a proper fix.

> See we only fill the pages array because some drivers (like Exynos) 
> are still buggy and require this.

Exynos driver use this pages array internally.

>
> Accessing the pages of an DMA-buf imported sg_table is illegal and 
> should be fixed in the drivers.

True, but in meantime we should avoid breaking stuff which worked fine 
for ages.

>
>> [SNIP]
>>
>> I will send a patch in a few minutes with the above fixed code.
>
> That is certainly a good idea for now, but could we also put on 
> somebodies todo list an item to fix Exynos?

Yes, I can take a look into removing the use of the internal pages 
array. It is used mainly for implementing vmap for fbdev emulation, but 
this can be handled in a different way.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

