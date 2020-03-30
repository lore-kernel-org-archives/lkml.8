Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD66AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A9206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NQLgoREV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgC3IS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:18:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49277 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgC3IS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:18:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200330081825euoutp02d4d68f118dafef06ffb6a6a8378e9da9~BBw8PhWUM1473914739euoutp027
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:18:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200330081825euoutp02d4d68f118dafef06ffb6a6a8378e9da9~BBw8PhWUM1473914739euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585556305;
        bh=R4zKoePkE2jPIN9aq9DgHKaT2r9GlP1DFSynnnPQ5ME=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NQLgoREVHeJ/WRu/QSmjIvPjhj+PHIY0kBrIa1p/OsSk32Ucho2rEKNC2jzqEJZiu
         E99MU1vTeA3Z69iVuzz57N4TVwz2G/Sq6P4mTeV3xW2BT/Gcsq6funCRBNJrF6ePpx
         rIG4KPlD1HI/xGZ8McmNedeS/qXQqd9DsKiNQ7Cs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200330081824eucas1p24db5a4b1a0e203b1eef2c353c93a2191~BBw768dP_0046300463eucas1p2z;
        Mon, 30 Mar 2020 08:18:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.DE.60698.05BA18E5; Mon, 30
        Mar 2020 09:18:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200330081824eucas1p296ab0a861f799cf33aed0226869ac6fd~BBw7gAEJx0850008500eucas1p2-;
        Mon, 30 Mar 2020 08:18:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200330081824eusmtrp2e3bb561c7cfe7310445d73d502d0d31f~BBw7faMjc3035830358eusmtrp23;
        Mon, 30 Mar 2020 08:18:24 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-3d-5e81ab504239
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.62.08375.05BA18E5; Mon, 30
        Mar 2020 09:18:24 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200330081823eusmtip18b39490b9c1a16667bebde8cd28cdae7~BBw6-6o8S1990419904eusmtip14;
        Mon, 30 Mar 2020 08:18:23 +0000 (GMT)
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        amd-gfx-request@lists.freedesktop.org, alexander.deucher@amd.com
Message-ID: <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
Date:   Mon, 30 Mar 2020 10:18:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cd773011-969b-28df-7488-9fddae420d81@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87oBqxvjDFafUbXoPXeSyWLand2s
        Fuv+3WSxaNzZx2Tx9j6Qe+XrezaLy7vmsDmwe7Re+svmsXPWXXaP7d8esHrc7z7O5PF5k1wA
        axSXTUpqTmZZapG+XQJXxt+PR1gLJghWLHvQztTA2MTXxcjJISFgInHu2FW2LkYuDiGBFYwS
        6z8tY4JwvjBKPLu7ih3C+cwo8X/FYSaYlm3vm6FaljNKrD0yiRnCec8oceb8OjaQKmEBV4md
        Ta2MIDabgKFE19susA4RgU5Gib71m1lAEswCZRKXns8BSnBw8ArYSTTsDgQJswioSvy6dAWs
        V1QgRuLi4X5WEJtXQFDi5MwnYK2cAvYS6+b3QI2Rl2jeOpsZwhaXuPVkPtgPEgLr2CV+b+yH
        OttF4u/V81C2sMSr41vYIWwZif87YRqaGSUenlvLDuH0MEpcbprBCFFlLXHn3C+wS5kFNCXW
        79KHCDtKPLtykhkkLCHAJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzULy
        2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKah0/+Of93BuO9P
        0iFGAQ5GJR7eGVsb4oRYE8uKK3MPMUpwMCuJ8LL5A4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Gi96GSskkJ5YkpqdmlqQWgSTZeLglGpg1Iu4ZM14TLbYUUdL0q3Gr36ajlpwBldU8ZctMZ/T
        Txz8sfn350qd2emaHxLTrUx6N+77UCzLldLs0Kr2fhev/oe5u5oXCjy64p3RfH568q2suT5L
        73CueV4lkJqzdMFRN787b77NqU70nRh9JaTl3yIVnZdrooUaflYnbc19uLchxHJVylMOJZbi
        jERDLeai4kQAWIaCrT8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7oBqxvjDNZe57PoPXeSyWLand2s
        Fuv+3WSxaNzZx2Tx9j6Qe+XrezaLy7vmsDmwe7Re+svmsXPWXXaP7d8esHrc7z7O5PF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJext+P
        R1gLJghWLHvQztTA2MTXxcjJISFgIrHtfTNbFyMXh5DAUkaJDYeXskMkZCROTmtghbCFJf5c
        64Iqesso8fX+KhaQhLCAq8TOplZGEJtNwFCi6y1EkYhAJ6PEnp8XmUASzAJlErsuNDNCdK9k
        kmg8ug2oioODV8BOomF3IEgNi4CqxK9LV8AGiQrESPzc0wW2gFdAUOLkzCdgNqeAvcS6+T0s
        EDPNJOZtfsgMYctLNG+dDWWLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWG
        esWJucWleel6yfm5mxiBcbft2M/NOxgvbQw+xCjAwajEwztja0OcEGtiWXFl7iFGCQ5mJRFe
        Nn+gEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDU0JeSbyhqaG5haWhubG5sZmFkjhvh8DB
        GCGB9MSS1OzU1ILUIpg+Jg5OqQbG6m+SsS0XpdYVT2U9IuuTvOnjtylSeR9a8vwXb3IMW2Jo
        URp6Ne/edUMtuUV3Xbm0r39vcp71PJ/j6ZZppc/f2KSv/mR3Z9fJwFhXD4tGqbKtxjOOTbP5
        +pe5bvX+hTsS9mSeKA9WXRtjqc5w7Kez6Yylhsm3Ntxy6nX+etbFNySi/G7+UZd+JZbijERD
        Leai4kQAmghP7tECAAA=
X-CMS-MailID: 20200330081824eucas1p296ab0a861f799cf33aed0226869ac6fd
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020-03-27 10:10, Marek Szyprowski wrote:
> Hi Christian,
>
> On 2020-03-27 09:11, Christian König wrote:
>> Am 27.03.20 um 08:54 schrieb Marek Szyprowski:
>>> On 2020-03-25 10:07, Shane Francis wrote:
>>>> As dma_map_sg can reorganize scatter-gather lists in a
>>>> way that can cause some later segments to be empty we should
>>>> always use the sg_dma_len macro to fetch the actual length.
>>>>
>>>> This could now be 0 and not need to be mapped to a page or
>>>> address array
>>>>
>>>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>>>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>>> This patch landed in linux-next 20200326 and it causes a kernel 
>>> panic on
>>> various Exynos SoC based boards.
>>>> ---
>>>>    drivers/gpu/drm/drm_prime.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>> index 86d9b0e45c8c..1de2cde2277c 100644
>>>> --- a/drivers/gpu/drm/drm_prime.c
>>>> +++ b/drivers/gpu/drm/drm_prime.c
>>>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct 
>>>> sg_table *sgt, struct page **pages,
>>>>           index = 0;
>>>>        for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>>>> -        len = sg->length;
>>>> +        len = sg_dma_len(sg);
>>>>            page = sg_page(sg);
>>>>            addr = sg_dma_address(sg);
>>> Sorry, but this code is wrong :(
>>
>> Well it is at least better than before because it makes most drivers 
>> work correctly again.
>
> Well, I'm not sure that a half-broken fix should be considered as a 
> fix ;)
>
> Anyway, I just got the comment from Shane, that my patch is fixing the 
> issues with amdgpu and radeon, while still working fine for exynos, so 
> it is indeed a proper fix.

Today I've noticed that this patch went to final v5.6 without even a day 
of testing in linux-next, so v5.6 is broken on Exynos and probably a few 
other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays 
function.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

