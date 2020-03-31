Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF5C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D713E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTcnjGv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgCaO3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:29:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56220 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbgCaO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:29:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200331142913euoutp022034287bd868d81d14cb19552bc068e0~Bad-BU4LA2961629616euoutp02x
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:29:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200331142913euoutp022034287bd868d81d14cb19552bc068e0~Bad-BU4LA2961629616euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585664953;
        bh=FnH1CR4CGNjTs+LAgOkEqdqVWm7njDfaUNTNh3SNqOo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QTcnjGv4bvcvG6odHq6dwGlgIdilwE1jXIP48rY+XAczGN9V9X9likECeVwqUCvNu
         2BeHLyLXSlLG6DP4k9Ic5SMtpMZUZol3D+KDjCgy8DHiduWZ4QQMTqnCwHfrFU9oKZ
         49bcCzG67Oo+ryuGvUFv24vm9Nok4G0To3acnlLQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331142913eucas1p10dc37b994078cdb5ec78bf2576bef4d4~Bad_wxJHE0697206972eucas1p11;
        Tue, 31 Mar 2020 14:29:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.E4.61286.9B3538E5; Tue, 31
        Mar 2020 15:29:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331142912eucas1p12b93673531fbe7536addaba15c785018~Bad_OQEWM0697206972eucas1p10;
        Tue, 31 Mar 2020 14:29:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331142912eusmtrp1832f46bf8074cca41460d778f02ca087~Bad_No6U11407014070eusmtrp1f;
        Tue, 31 Mar 2020 14:29:12 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-d6-5e8353b922dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.03.08375.8B3538E5; Tue, 31
        Mar 2020 15:29:12 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331142912eusmtip2d6111a98eb084b7dca94cf7793bd7efe~Bad9lbddt2905029050eusmtip2N;
        Tue, 31 Mar 2020 14:29:11 +0000 (GMT)
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx-request@lists.freedesktop.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b65eddc1-e88a-cd64-86bb-5a9e99a7671d@samsung.com>
Date:   Tue, 31 Mar 2020 16:29:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NEhfZwE6B0UBu0My7Sk5YNoDE=7Nj_CUYpPe9HOjpjqQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87o7g5vjDHZt57HoPXeSyWLand2s
        Fnf+zGK3WPfvJotF484+Jou394FiV76+Z7O4vGsOmwOHR+ulv2weO2fdZffY/u0Bq8f97uNM
        Hp83yQWwRnHZpKTmZJalFunbJXBlrNv7g7lgv1jF4TsPWBsYJwt1MXJySAiYSCw51MjYxcjF
        ISSwglHix5uPzCAJIYEvjBJtl+UgEp8ZJT7PXscE07Gibw1Ux3JGiU9XtzFBOO8ZJZpuTWUD
        qRIWcJXY2dQKVMXBISKgIbH+iw9IDbPAGSaJa4cms4PUsAkYSnS97QKr5xWwk/i5cyYrSD2L
        gKrEup5IkLCoQIzExcP9rBAlghInZz5hASnhFAiUaNohDRJmFpCXaN46mxnCFpe49WQ+1J27
        2CWmz9OEsF0k7n3azgJhC0u8Or6FHcKWkTg9uYcF5DQJgWZGiYfn1rJDOD2MEpebZjBCVFlL
        3Dn3iw1kMbOApsT6XfoQYUeJZ1dOMoOEJQT4JG68FYS4gU9i0rbpUGFeiY42aECrScw6vg5u
        7cELl5gnMCrNQvLYLCTfzELyzSyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIE
        JqLT/45/2sH49VLSIUYBDkYlHt4Km+Y4IdbEsuLK3EOMEhzMSiK8bP4NcUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUw7l69Rf91vSDL2wPWx9z4Hr2J
        1n/ycgP7rpC7JdZ7XeW6udVneRa8yTpnOqfzxCle/1cLVV599dIPObreY0fo2XmPvbWeG6mz
        3DF8t3HZhG88tx+fetb38fUDXeurq7f6idT/yWVYzcCw8rXMqsOHNGe8jZ3O0D1jfoyw8pLO
        4NvSF5Rbrn1b916JpTgj0VCLuag4EQAlOTTJQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7o7gpvjDDb8V7PoPXeSyWLand2s
        Fnf+zGK3WPfvJotF484+Jou394FiV76+Z7O4vGsOmwOHR+ulv2weO2fdZffY/u0Bq8f97uNM
        Hp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlrNv7g7lgv1jF4TsPWBsYJwt1MXJySAiYSKzoW8PYxcjFISSwlFHi5PrfbBAJGYmT0xpY
        IWxhiT/Xutggit4ySlyZc5cZJCEs4Cqxs6kVqJuDQ0RAQ2L9Fx+QGmaBc0wS965tY4ZoWMgi
        sf/BKbBJbAKGEl1vu8A28ArYSfzcOZMVpJlFQFViXU8kSFhUIEbi554uFogSQYmTM5+wgJRw
        CgRKNO2QBgkzC5hJzNv8kBnClpdo3jobyhaXuPVkPtMERqFZSLpnIWmZhaRlFpKWBYwsqxhF
        UkuLc9Nziw31ihNzi0vz0vWS83M3MQKjb9uxn5t3MF7aGHyIUYCDUYmHt8KmOU6INbGsuDL3
        EKMEB7OSCC+bf0OcEG9KYmVValF+fFFpTmrxIUZToNcmMkuJJucDE0NeSbyhqaG5haWhubG5
        sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGlhVd1pk+D7j3ci+oZ6wXTY//2nmt4F+h
        yI+PS29qC8ydNK2Qu0BxA0vcwrKP23g0ku6cV8p96pWx8ll9Ya3qxG0v7mxe5B8SdsOa413P
        YpP253M49fe8VNPf2yZ2oebaju0b3uxKL2uwLS2csmHt6SfLc0I6zITj2yc47IwX7bsv+tbp
        45G1SizFGYmGWsxFxYkA93X8A9QCAAA=
X-CMS-MailID: 20200331142912eucas1p12b93673531fbe7536addaba15c785018
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
        <cd773011-969b-28df-7488-9fddae420d81@samsung.com>
        <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
        <CADnq5_O6pwxJsYdfJO0xZtmER05GtO+2-4uHTeexKNeHyUq8_Q@mail.gmail.com>
        <3a0cb2bc-84be-6f9f-a0e8-ecb653026301@samsung.com>
        <CADnq5_NEhfZwE6B0UBu0My7Sk5YNoDE=7Nj_CUYpPe9HOjpjqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2020-03-31 16:10, Alex Deucher wrote:
> On Tue, Mar 31, 2020 at 1:25 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi Alex,
>>
>> On 2020-03-30 15:23, Alex Deucher wrote:
>>> On Mon, Mar 30, 2020 at 4:18 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> Hi
>>>>
>>>> On 2020-03-27 10:10, Marek Szyprowski wrote:
>>>>> Hi Christian,
>>>>>
>>>>> On 2020-03-27 09:11, Christian König wrote:
>>>>>> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
>>>>>>> On 2020-03-25 10:07, Shane Francis wrote:
>>>>>>>> As dma_map_sg can reorganize scatter-gather lists in a
>>>>>>>> way that can cause some later segments to be empty we should
>>>>>>>> always use the sg_dma_len macro to fetch the actual length.
>>>>>>>>
>>>>>>>> This could now be 0 and not need to be mapped to a page or
>>>>>>>> address array
>>>>>>>>
>>>>>>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>>>>>>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>>>>>>> This patch landed in linux-next 20200326 and it causes a kernel
>>>>>>> panic on
>>>>>>> various Exynos SoC based boards.
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/drm_prime.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>>>>>> index 86d9b0e45c8c..1de2cde2277c 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_prime.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_prime.c
>>>>>>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct
>>>>>>>> sg_table *sgt, struct page **pages,
>>>>>>>>             index = 0;
>>>>>>>>          for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>>>>>>>> -        len = sg->length;
>>>>>>>> +        len = sg_dma_len(sg);
>>>>>>>>              page = sg_page(sg);
>>>>>>>>              addr = sg_dma_address(sg);
>>>>>>> Sorry, but this code is wrong :(
>>>>>> Well it is at least better than before because it makes most drivers
>>>>>> work correctly again.
>>>>> Well, I'm not sure that a half-broken fix should be considered as a
>>>>> fix ;)
>>>>>
>>>>> Anyway, I just got the comment from Shane, that my patch is fixing the
>>>>> issues with amdgpu and radeon, while still working fine for exynos, so
>>>>> it is indeed a proper fix.
>>>> Today I've noticed that this patch went to final v5.6 without even a day
>>>> of testing in linux-next, so v5.6 is broken on Exynos and probably a few
>>>> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
>>>> function.
>>> Please commit your patch and cc stable.
>> I've already did that: https%3A%2F%2Flkml.org%2Flkml%2F2020%2F3%2F27%2F555
> Do you have drm-misc commit rights or do you need someone to commit
> this for you?

I have no access to drm-misc.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

