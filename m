Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C279C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAB020575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PBZ88k+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgELJFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:05:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36032 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:05:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090510euoutp010bac704d3fb6246afa417d6da6eb5ce1~OPJDBzz9I2635826358euoutp01T
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:05:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200512090510euoutp010bac704d3fb6246afa417d6da6eb5ce1~OPJDBzz9I2635826358euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274310;
        bh=AhzmXRfuAXH1r/E+rpzhyc8oI1f4R3agyOC87Kh6/r8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PBZ88k+3hmDP4gG6Y8rDsJhG86LwswmT/IorIJUoBTIqizykNuCAxAXFkzddTKxow
         07eibdHhL0fTOd53GICap3QSEncpey34I8RKMsSnZ1Zw9EcYAFcbQKvEppK5c6uNo+
         tmURmc2krEPwJxFvhydqYL+pyIY2vLojlcBlnLpk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200512090505eucas1p20a660e61f27d8ae9889b1a1eeba5f897~OPI_BjmSS1504115041eucas1p23;
        Tue, 12 May 2020 09:05:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.2C.60698.1C66ABE5; Tue, 12
        May 2020 10:05:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200512090505eucas1p20fdb2ff84bf04f85ba28ae14e6bd5f8c~OPI9mQpuy1504515045eucas1p2R;
        Tue, 12 May 2020 09:05:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512090505eusmtrp203ec1cd226791e437020f232645dd228~OPI9lhoHW0721407214eusmtrp22;
        Tue, 12 May 2020 09:05:05 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-5b-5eba66c1f51b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.F5.08375.0C66ABE5; Tue, 12
        May 2020 10:05:05 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090504eusmtip17a2387bb0530d831d1e6bcd0dc503194~OPI84EYTJ1442114421eusmtip1p;
        Tue, 12 May 2020 09:05:04 +0000 (GMT)
Subject: Re: [PATCH v3 02/25] drm: core: fix common struct sg_table related
 issues
To:     Christoph Hellwig <hch@lst.de>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <df31517c-f3e2-8c57-b353-ff90745038f1@samsung.com>
Date:   Tue, 12 May 2020 11:05:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508071609.GA31690@lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu3JfX0ZXr1HawULg9oPKZEpeMKJK6EIhB9UeUtfTmJLfmrpoW
        lWQvl0Uapq5SK7Oymfiaj2rlqK1laZmYZqhLIzSlhzkparXtavnf9/t+33e+8x0OiUrHcH8y
        SZXKa1TyZIaQYAbzj47g1r0tcWG91QHs2XYrwtYUVePsH0MeynZNfibY23eeIGzZwyj2e5cN
        YWuHunH2dctlgr36tQFjT+ZU4Gzrl2GcrR/Lw9dSnL5ED7gH9jKMq63MIbhG+yDOlVg3cwNn
        LAhXV36U63MModyFnpuAu9ebRXDn6isBV9d2iJuoDYiltktWJ/DJSem8JnTNbomi4hShthIZ
        V2yDeBaowrXAk4R0JJw4fotwYSl9C8Bmh68WSJz4O4C/35hxcZgAsOzpgFNFuh1f8pUifxPA
        18YTqDh8BtB0owpxHeVDb4ENnRY39qUZ+GH0BXCJULobhYYRC+ZaEHQ41I5r3dkUvQbWWLrd
        PEYvhsc6y1EX9qN3wrbrdUDUeENr8bBb40kHwanGq24vSgfC7IZLqIhl8O1wKeIKg3QBCTvM
        FYRYNBpO5Y8AEfvAUUu9h4gXwD/NM4ZsAG3tVR7ikOssd6xo2hEF37X/dD8ASi+F1S2hIr0O
        OnLHpt/FC/aMe4uX8IL5hkJUpCl4+qRUVC+BOsvdf7GtLzvR84DRzaqmm1VHN6uO7n9uGcAq
        gYxPE5SJvBCh4g+ECHKlkKZKDInfr6wFzj/Y5rBMNgHjrz0mQJOAmUudXtEcJ8Xl6UKm0gQg
        iTK+1PEkJ0UlyDMP8pr9uzRpybxgAvNJjJFREddGdkrpRHkqv4/n1bxmZouQnv5ZoJwQ1mr3
        3R592Peyq6mhf5WtYEfMV/XzOHV4WP9K/fKBSZXD9Cn2xkUfRbAxOjInzvA+hevZVBpol2wt
        9tfPHS/8oVzvuSRyYUZ/RorC98i8edne92WMOTRig9IPibF9i/84fIVfdNg+Z4zaqK8gJh+F
        PJ+yG9lnOxDjNtnjoFcMJijk4ctQjSD/C/zubuh/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7oH03bFGXw9xmjRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLhx60sFm2dy1gtDn54wmqx
        5c1EVgdejzXz1jB67P22gMVj06pONo/t3x6wesw7Gehxv/s4k8fmJfUet/89ZvaYfGM5o8fu
        mw1sHn1bVjF6bD5d7fF5k1wAb5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexrJ2toKTbBVzHz5gbWBcy9rFyMEhIWAi8WFSbhcjF4eQwFJGiePH
        JzB2MXICxWUkTk5rYIWwhSX+XOtigyh6yyix6cd+sCJhgRCJrZeOM4HYIgJKEk9fnWUEKWIW
        uMEs8W1zLztEx0lmiecXToJ1sAkYSnS9BRnFycErYCex8fg1FhCbRUBVounSEmYQW1QgVmL1
        tVZGiBpBiZMzn4DVcAroSHzfvhCsl1nATGLe5ofMELa8RPPW2VC2uMStJ/OZJjAKzULSPgtJ
        yywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGPnbjv3cvIPx0sbgQ4wCHIxK
        PLwdRjvjhFgTy4orcw8xSnAwK4nwtmQChXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmJTy
        SuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwVuW5PkxnUZo/me+z
        4a8XNRIqwYUdcVfbKyPUinX2ThUP+jFXVuUyi1pNyOL3TuHd5w8vnRvXVHRC86Udp8120S+2
        HrOO7e+JmcngnGH5b6df1qJg97ii568F5vv2yF2XNTi77FddTsAblacKn1knb5sa/HZm4Z/5
        e5nyll7anlNQKmobf6JHiaU4I9FQi7moOBEAk0k3RhIDAAA=
X-CMS-MailID: 20200512090505eucas1p20fdb2ff84bf04f85ba28ae14e6bd5f8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
        <20200505084614.30424-1-m.szyprowski@samsung.com>
        <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com>
        <20200505084614.30424-2-m.szyprowski@samsung.com>
        <20200505101508.GA14860@lst.de>
        <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com>
        <20200505110950.GA19067@lst.de>
        <b887c355-14db-ad37-0e93-733ff2249967@samsung.com>
        <20200508071609.GA31690@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 08.05.2020 09:16, Christoph Hellwig wrote:
> On Fri, May 08, 2020 at 09:12:13AM +0200, Marek Szyprowski wrote:
>> Then we would just need one more helper to construct scatterlist, as the
>> above two are read-only don't allow to modify scatterlist:
>>
>> #define for_each_sgtable_sg(sgt, sg, i)                \
>>          for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
>>
>> With the above 3 helpers we can probably get rid of all instances of
>> sg_table->{nents,orig_nents} from the DRM code. I will prepare patches soon.
> Sounds great, thanks!

It turned out that the 4th helper (for_each_sgtable_dma_sg) was needed 
as some drivers makes use of the larger than the PAGE_SIZE unit for DMA 
mapped pages.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

