Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5020771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qFswgmZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGGNHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:07:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55141 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:07:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200707130701euoutp02b3be6026af4a8cfd31b6e39fdd1f7bff~fekMYiAME2298422984euoutp02T
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:07:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200707130701euoutp02b3be6026af4a8cfd31b6e39fdd1f7bff~fekMYiAME2298422984euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594127221;
        bh=U2aVauy2+JpINyhil7vNueItQM70I3jBlub5F2RoPaI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qFswgmZFPK21NxIp6LjhjIWdiP4hnMa3W/Dfea/0ql20x5k+AP4j4Ar51Tq07mcW+
         8tdm5eAwtL8UhhUVSdd8dvvh5J9wY9QzKexvo81d2o9wZXB0qtguzJ41V0ouWd/AKg
         cPL3NP/bhevlP7zW1sSyyJfI+Srq6V9E1ewDsGM4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200707130700eucas1p17f35c74c6cf62fd3a0373037b209f6e3~fekLfBnmJ2868428684eucas1p1D;
        Tue,  7 Jul 2020 13:07:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.42.06456.473740F5; Tue,  7
        Jul 2020 14:07:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200707130700eucas1p1b618f2a9e6f8f5be3c97c762220300a0~fekLBimdw1405714057eucas1p1A;
        Tue,  7 Jul 2020 13:07:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200707130700eusmtrp1b04bf2435e172dc545c8cedac0e8af43~fekLAyDGx0101401014eusmtrp18;
        Tue,  7 Jul 2020 13:07:00 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-7e-5f0473748f5b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.D7.06314.473740F5; Tue,  7
        Jul 2020 14:07:00 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200707130659eusmtip1477441c2867581295ee26f9e4279cfdb~fekKW-Wv62686526865eusmtip1N;
        Tue,  7 Jul 2020 13:06:59 +0000 (GMT)
Subject: Re: [PATCH v7 04/36] drm: amdgpu: fix common struct sg_table
 related issues
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ef43cce1-40dc-77fd-1107-33c64d947ed1@samsung.com>
Date:   Tue, 7 Jul 2020 15:06:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bfbdf1ee-c970-d862-cc81-4712c34b7685@amd.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjH5z23TnHytkXPxLgsg0QJM47J5DI+nC8GX/rQDFmc2aK2Zs8W
        +UAKq6wmlWiZalS6iLJtF+XWzlLZKabShFSohrJTcs2M0u4Rffv/n+f3PM/7n3lZUjFI+7AR
        Gp2o1agilYwbVf1k/NkanUSFra2o9+MvtDYTfFZ3Pc0Xlp9y4e9cKad5e++Unay+SPId30YY
        vuTmY4LPexjEf+14S/Cm95003153jeEbRvvprZxwpu03I5TllCHh/vc8Sqj53kcLvecbCaGy
        4KTweuI9KWR0FSGh/mUCI6SaS5HwxbRw96xQt82HxMiIOFEbELzfLdzebiJiCuYcM1rWJSDz
        7BTkygLeAD+6Cl1SkBurwMUILnV8ImXzFUGNrY6WzRcEd5OHXaZHJpprkdwoQnBVP0TIZgTB
        B8sLJ+WJQ+B0tplxNLywFUFRvtVJkbiagDc/PzgpBgdCij2FcWgOB4PhTRrh0BReBjlWPe3Q
        c/E+KP9YQ8iMBzRn91MO7YqDIFc/4GRIvAiSqq6SsvaGV/25zmOAk1kY7xmdGmCnzA4YzvGR
        M3jCUKP5b54FYMswUDKfhOBt6y0X2RgQtCdeQTIVBN2tvxjHIhL7QnldgFzeBs8GExl5vzt0
        2T3kN7hDevVlUi5zcO6sQqaXg7Hx9r+zDc/byDSkNM5IZpyRxjgjjfH/3TxElSJvMVaKUotS
        oEY86i+poqRYjdr/YHSUCU39PttE41gt+tZ2wIIwi5SzuXAVFaagVXFSfJQFAUsqvbjtLbZ9
        Cu6QKv64qI0O08ZGipIFzWcppTe3/vrHvQqsVunEI6IYI2qnuwTr6pOAsgYfWDMjB6ig+nmh
        99y7dKlbAh4l5S62Tub/7rxsWB2zsMyTe2z/HJ3+lA8cMNo0vVX3vZLHmzYWLt30DnPqsYT+
        yiUDfgY2N35kBdvHnKl6kb7Sf2u2L7fnxi68MxO6y0x63xMtTbqWkMNxRzqH1EW3JvQ9ZiVT
        UTJc3GCoU1JSuCpwFamVVH8AnoTEznkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7olxSzxBv+X8Vj0njvJZDHtzm5W
        i6XrG9ktNs5Yz2rx9j6Q+3/bRGaLK1/fs1msXH2UyWLBfmuLL1ceMllsenyN1eLyrjlsFgc/
        PGF14PVovfSXzWPNvDWMHnu/LWDx2P7tAavH/e7jTB6bl9R73P73mNlj8o3ljB67bzawefRt
        WcXo8XmTXAB3lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7G28ubmAqW8FfMOmTUwLiFp4uRk0NCwETi38kdjF2MXBxCAksZJbbc+c4OkZCRODmt
        gRXCFpb4c62LDaLoLaPEifd9YAlhgTCJ/xNnMoMkRASOMEocPLWECcRhFtjGJPF66S6oud8Y
        Jd50z2YCaWETMJToegsyi5ODV8BOoufuBLA4i4CKxLwj7WBjRQXiJJZvmc8OUSMocXLmExYQ
        m1PAWmJ++1OwGmYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYLRvO/Zz8w7GSxuDDzEKcDAq8fBmJLLEC7EmlhVX
        5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84GJKK8k3tDU0NzC0tDc
        2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6P1len5y36bVQR9Sa8/Nmta8L8XG9zY
        Cv9WKU2axvL5/9qss0vCztyIEox9f0uq77yy50zxKM8zc4N9p1ks9jWYyfyw7sHaNz2K69lc
        rCOjFc7efin6p1kgyvdY3m9rjVUTsjt/fN3V+nw97+SUtVnbdsxYubF9rkP1Wa2/R/69LbhV
        W5OzeUeJEktxRqKhFnNRcSIAjDRWAQwDAAA=
X-CMS-MailID: 20200707130700eucas1p1b618f2a9e6f8f5be3c97c762220300a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103655eucas1p28ea4bf59428550217c8962666d6f077b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103655eucas1p28ea4bf59428550217c8962666d6f077b
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103655eucas1p28ea4bf59428550217c8962666d6f077b@eucas1p2.samsung.com>
        <20200619103636.11974-5-m.szyprowski@samsung.com>
        <bfbdf1ee-c970-d862-cc81-4712c34b7685@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 22.06.2020 15:27, Christian König wrote:
> Am 19.06.20 um 12:36 schrieb Marek Szyprowski:
>> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() 
>> function
>> returns the number of the created entries in the DMA address space.
>> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
>> dma_unmap_sg must be called with the original number of the entries
>> passed to the dma_map_sg().
>>
>> struct sg_table is a common structure used for describing a 
>> non-contiguous
>> memory buffer, used commonly in the DRM and graphics subsystems. It
>> consists of a scatterlist with memory pages and DMA addresses (sgl 
>> entry),
>> as well as the number of scatterlist entries: CPU pages (orig_nents 
>> entry)
>> and DMA mapped pages (nents entry).
>>
>> It turned out that it was a common mistake to misuse nents and 
>> orig_nents
>> entries, calling DMA-mapping functions with a wrong number of entries or
>> ignoring the number of mapped entries returned by the dma_map_sg()
>> function.
>>
>> To avoid such issues, lets use a common dma-mapping wrappers operating
>> directly on the struct sg_table objects and use scatterlist page
>> iterators where possible. This, almost always, hides references to the
>> nents and orig_nents entries, making the code robust, easier to follow
>> and copy/paste safe.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Any objection that we pick this one and the radeon up into our 
> branches for upstreaming?
>
> That should about clashes with other driver changes.

I'm fine. This one and radeon doesn't depend on the prime changes, so it 
should merge fine via your tree. I will try to ask for more review of 
the remaining patches and then try merging via drm-misc.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

