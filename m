Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725F5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109362071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kHHex9Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCaFZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:25:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51450 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaFZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:25:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200331052555euoutp0232c1fa837f56b67a1b591784f5223a21~BTDn4mKny1197211972euoutp02D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:25:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200331052555euoutp0232c1fa837f56b67a1b591784f5223a21~BTDn4mKny1197211972euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585632355;
        bh=bxin13ZKuOM8u8O8i3qTxcRZcgLrefdmNLGj7iJHNdY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kHHex9Xf3yjMXTEGVMqVtWhm1bOcMYTTTPDoAtX8eqeSpGELjfUvnuYo4nOQLikEH
         gzPDl9uSyMSPaYCwwaEVn37GzjP4d7k4xuCKLz+b90jCYPsvdJbm/jCdKxDyKFA9Z7
         IGIJA4hjo+GdBFeemud8CwWosA4NQQZrzJCcS+xY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331052555eucas1p11806bcd25402c052d63b6bd00e87771d~BTDntTJcq2193321933eucas1p1W;
        Tue, 31 Mar 2020 05:25:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3C.96.61286.364D28E5; Tue, 31
        Mar 2020 06:25:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200331052555eucas1p28e4c454f5fcd33457798f6d4b85220d1~BTDnVY7rC2534025340eucas1p2K;
        Tue, 31 Mar 2020 05:25:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331052555eusmtrp1ba37869771f488e7696c1ccc827b8c1a~BTDnUsVzN0739607396eusmtrp18;
        Tue, 31 Mar 2020 05:25:55 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ee-5e82d46348e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.07.08375.264D28E5; Tue, 31
        Mar 2020 06:25:55 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331052554eusmtip2467d68d39da6150963074cae38eafd67~BTDm1pL_L0092300923eusmtip2g;
        Tue, 31 Mar 2020 05:25:54 +0000 (GMT)
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
Message-ID: <3a0cb2bc-84be-6f9f-a0e8-ecb653026301@samsung.com>
Date:   Tue, 31 Mar 2020 07:25:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_O6pwxJsYdfJO0xZtmER05GtO+2-4uHTeexKNeHyUq8_Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87rJV5riDM63SFv0njvJZDHtzm5W
        izt/ZrFbrPt3k8WicWcfk8Xb+0CxK1/fs1lc3jWHzYHDo/XSXzaPnbPusnts//aA1eN+93Em
        j8+b5AJYo7hsUlJzMstSi/TtErgyDs7ayF6wQbhi8f9nzA2MR/i7GDk4JARMJO6v8eli5OIQ
        EljBKLG8/zELhPOFUWL1vW+sEM5nRoneXx+Yuxg5wTpe/13NBpFYzihx6Xw3lPOeUeLt7wXs
        IFXCAq4SO5taGUF2iAhoSKz/AraDWeAMk8S1Q5PBatgEDCW63naxgdi8AnYS02Y+BouzCKhK
        tDcuA7NFBWIkLh7uZ4WoEZQ4OfMJC4jNKRAo8fPLGrA4s4C8RPPW2cwQtrjErSfzmUCWSQhs
        Y5c492wmI8TZLhJ7/m5lgrCFJV4d38IOYctInJ7cwwLR0Mwo8fDcWnYIp4dR4nLTDKhua4k7
        536xgbzDLKApsX6XPkTYUeLZlZPMkJDkk7jxVhDiCD6JSdumQ4V5JTrahCCq1SRmHV8Ht/bg
        hUvMExiVZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPR
        6X/HP+1g/Hop6RCjAAejEg/vg6uNcUKsiWXFlbmHGCU4mJVEeNn8G+KEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYFy3L/HQrG2/psts9d1z0yCnojJv
        8id9z+jV/xdWvnf7c4P5v2fFsxcnX17cJvCpc0rBxe7nqTmvThjv+9zNWB1n/uXE/82hH3du
        ZLHhCfzHH1vV1tgkz8uZ/+HBGYl/3gbmi0STm+JObvmWfVoo8uWR9hPfk1YdtG2rniJydPK2
        1pne3T+reVyVWIozEg21mIuKEwE8FmXOQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7rJV5riDK4/ZbToPXeSyWLand2s
        Fnf+zGK3WPfvJotF484+Jou394FiV76+Z7O4vGsOmwOHR+ulv2weO2fdZffY/u0Bq8f97uNM
        Hp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlHJy1kb1gg3DF4v/PmBsYj/B3MXJySAiYSLz+u5qti5GLQ0hgKaPEl+Z7bBAJGYmT0xpY
        IWxhiT/XuqCK3jJKPDjzlQUkISzgKrGzqZWxi5GDQ0RAQ2L9Fx+QGmaBc0wS965tY4aayizx
        sm0H2FQ2AUOJrrddYDavgJ3EtJmP2UFsFgFVifbGZWC2qECMxM89XSwQNYISJ2c+AbM5BQIl
        fn5ZA3YRs4CZxLzND5khbHmJ5q2zoWxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwArcd+7l5B+OljcGHGAU4GJV4eB9cbYwTYk0sK67MPcQo
        wcGsJMLL5t8QJ8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wOSQVxJvaGpobmFpaG5sbmxm
        oSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBkTfUfX/TWvPoY6EfXvDy7/4Q5nrM8q7TDt4f
        OgedD3NyN+sE3H14V9hVNfvprINN1s6vjeaLTp9ic/RXrKbSV/twQZH6ekV11Y0/tN0VSwpZ
        JRMOF6ycc8F5uUXepMLut4euF4j8ytkvEH//g7av7tzIxILmEmY371mr/j2Tkr5tmLQhVsRc
        iaU4I9FQi7moOBEAjHl1W9YCAAA=
X-CMS-MailID: 20200331052555eucas1p28e4c454f5fcd33457798f6d4b85220d1
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2020-03-30 15:23, Alex Deucher wrote:
> On Mon, Mar 30, 2020 at 4:18 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi
>>
>> On 2020-03-27 10:10, Marek Szyprowski wrote:
>>> Hi Christian,
>>>
>>> On 2020-03-27 09:11, Christian König wrote:
>>>> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
>>>>> On 2020-03-25 10:07, Shane Francis wrote:
>>>>>> As dma_map_sg can reorganize scatter-gather lists in a
>>>>>> way that can cause some later segments to be empty we should
>>>>>> always use the sg_dma_len macro to fetch the actual length.
>>>>>>
>>>>>> This could now be 0 and not need to be mapped to a page or
>>>>>> address array
>>>>>>
>>>>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>>>>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>>>>> This patch landed in linux-next 20200326 and it causes a kernel
>>>>> panic on
>>>>> various Exynos SoC based boards.
>>>>>> ---
>>>>>>     drivers/gpu/drm/drm_prime.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>>>> index 86d9b0e45c8c..1de2cde2277c 100644
>>>>>> --- a/drivers/gpu/drm/drm_prime.c
>>>>>> +++ b/drivers/gpu/drm/drm_prime.c
>>>>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct
>>>>>> sg_table *sgt, struct page **pages,
>>>>>>            index = 0;
>>>>>>         for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>>>>>> -        len = sg->length;
>>>>>> +        len = sg_dma_len(sg);
>>>>>>             page = sg_page(sg);
>>>>>>             addr = sg_dma_address(sg);
>>>>> Sorry, but this code is wrong :(
>>>> Well it is at least better than before because it makes most drivers
>>>> work correctly again.
>>> Well, I'm not sure that a half-broken fix should be considered as a
>>> fix ;)
>>>
>>> Anyway, I just got the comment from Shane, that my patch is fixing the
>>> issues with amdgpu and radeon, while still working fine for exynos, so
>>> it is indeed a proper fix.
>> Today I've noticed that this patch went to final v5.6 without even a day
>> of testing in linux-next, so v5.6 is broken on Exynos and probably a few
>> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
>> function.
> Please commit your patch and cc stable.

I've already did that: https://lkml.org/lkml/2020/3/27/555

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

