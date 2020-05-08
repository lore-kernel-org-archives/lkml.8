Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E3D208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vb8aluHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEHHMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:12:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38914 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgEHHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:12:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200508071212euoutp016db841c6e7d8e0e92c049b17c25ed80c~M-BRfpuYV2616026160euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 07:12:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200508071212euoutp016db841c6e7d8e0e92c049b17c25ed80c~M-BRfpuYV2616026160euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588921933;
        bh=MNq8IaWUA6Un4kt7IMAiklPWVR3gf64K43Fn6O07vqs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Vb8aluHNEw2JqOy80I0E6I6Y8ywULeo5y2fJruM/YjEqktoHKqHrnSgLkcX3ZM422
         hpdrckhVsKQQwiMlZOpS+xX2P8OSoQKM8KJZYhOQPPi13GsmPGLQQIhEuIc5nCCTH5
         7kpq//KUDt40Ys1jXlI0DUiDRUPooFwT17sxiUYA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200508071212eucas1p2f160f406bc38d49c40a526e2f90073cd~M-BRGg3qQ0835408354eucas1p2O;
        Fri,  8 May 2020 07:12:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.30.60679.C4605BE5; Fri,  8
        May 2020 08:12:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200508071211eucas1p2c0d71295772b61cd59ea323234374fca~M-BQi3KsU0800008000eucas1p2K;
        Fri,  8 May 2020 07:12:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200508071211eusmtrp1807089cd64cf7c196d7a64f6e784733b~M-BQiFdOl0512605126eusmtrp1M;
        Fri,  8 May 2020 07:12:11 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-24-5eb5064cdf42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.FD.08375.B4605BE5; Fri,  8
        May 2020 08:12:11 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508071211eusmtip2934bd81bad65ddd62f2c0e1050abb486~M-BPtk_EY1877618776eusmtip2B;
        Fri,  8 May 2020 07:12:11 +0000 (GMT)
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
Message-ID: <b887c355-14db-ad37-0e93-733ff2249967@samsung.com>
Date:   Fri, 8 May 2020 09:12:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505110950.GA19067@lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt/vwOr1xnco+rQzWA4zStIgLhhkU3D8iKvpDhGyrbirqlN20
        llT2QG1O8YFlS8o0MtdjtelKS8yVDbGWqZTrZaVJWqalDiqz3K6W/51zvvPxnQMfhcm+EsFU
        kno/r1GrUhSkFLc++uFYuZmsj19VXruQLXC0Sdhb5SaC/WMtxtjuiRGSrb3aKmErm6PY8e73
        Etbc95xguxorSPbit3qczTl1mWBbRvsJtu5LMRFDc9fOX0Nck6sS58zGUyR32/WO4M63beN6
        8+0SznLpKPdqqg/jSntqEHfXmU1yhXVGxFnas7gxc8hWOk66bi+fkpTJa8KjldLEp84JIj03
        6OD1gWNkNioK1CFvCpg1MFmYi+uQlJIxVxDc+/2ZFMk4gvFei5dIxhA0teYRsyv5v5ol4qAG
        galzdIaMILg41IC7Xf7MDqjvtEvcOIBRwMehJ8htwpjnGFgH7R4TyUSAblhHujHNRENtaZmX
        G+PMEtDn6T16ILMT2qstSPT4QdvZ/uldivJmVoDjwRa3jDGL4ET9OUzEcnjZf8ETCJgyClx3
        K2ZibwTD2/wZ7A9D9jovES+A9lI9Li6cQPDecd1LJHoEXcfLkeiKgteOn6T7MsaEgqkxXJQ3
        wJT+i0cGZh70DPuJIeZBifUMJso05OXIRPcyMNhv/Dvb0tGJFSGFYU4zw5w6hjl1DP/vViLc
        iOR8hpCawAuRav5AmKBKFTLUCWF70lLNaPoL26fs43dQ4+RuG2IopPCl2W+WeBmhyhS0qTYE
        FKYIoIsP1sXL6L0q7SFek7ZLk5HCCzY0n8IVcnp11eBOGZOg2s8n83w6r5mdSijv4Gxkit2W
        pFRlbapufDbQlD3WrYvxvRn3wq4xFcTyIRlEQOYFPrljwsdAFJwMehhWdfRD4Jte463Y49IK
        I2/6xFdFhn62pssrHy9uKFnqZM8duTfqdK0RDhu024tCt0+sXzZVczuGPukTpRS+r40+fX/f
        VWXQggBSm9g6/DpOaXtrVOBCoipiOaYRVH8BbttRxYEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4PV1vtq1xBq0nzSx6z51kstg4Yz2r
        xf9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWSz8uJXFoq1zGavFwQ9PWC22
        vJnI6sDrsWbeGkaPvd8WsHhsWtXJ5rH92wNWj3knAz3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9
        s4HNo2/LKkaPzaerPT5vkgvgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLOH/zK2tBu2TF2meNbA2ME0S7GDk5JARMJLp/72fqYuTiEBJYyijx
        8uQiNoiEjMTJaQ2sELawxJ9rXWwQRW8ZJW61XgJLCAuESGy9dJwJxBYRUJJ4+uosI0gRs8AN
        Zolvm3vZITo+MUm8uLWaHaSKTcBQouttF9gKXgE7iZWTp4LFWQRUJHo6esDiogKxEquvtTJC
        1AhKnJz5hKWLkYODU0BH4txhP5Aws4CZxLzND5khbHmJ5q2zoWxxiVtP5jNNYBSahaR7FpKW
        WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw9rcd+7l5B+OljcGHGAU4GJV4
        eC0+bo4TYk0sK67MPcQowcGsJMI7sWJLnBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnA9NS
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRvHpq6P2dSa8OVjH
        Vnnx/YGs1ZcMdwq/K7n9/U7He6XK9JWHT8tsYp7h8JBf8sbi5spdx4KuXOOyr5Xa2tR+VPzt
        87f72QXfNKjcbvS+wG+wXdhJXto6fGJ81+6q3St3/X+9d+1X1Z0qoo/t8vKMnYqbt3IrLJCK
        i961PECs8mq0SuPMHqmKuUosxRmJhlrMRcWJAMJUTm8TAwAA
X-CMS-MailID: 20200508071211eucas1p2c0d71295772b61cd59ea323234374fca
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 05.05.2020 13:09, Christoph Hellwig wrote:
> On Tue, May 05, 2020 at 12:51:58PM +0200, Marek Szyprowski wrote:
>> On 05.05.2020 12:15, Christoph Hellwig wrote:
>>>> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
>>>> +		for_each_sg_page(st->sgl, &sg_iter, st->orig_nents, 0)
>>> Would it make sense to also add a for_each_sgtable_page helper that
>>> hides the use of orig_nents?  To be used like:
>>>
>>> 		for_each_sgtable_page(st, &sg_iter, 0) {
>> We would need two helpers:
>>
>> for_each_sgtable_cpu_page() and for_each_sgtable_dma_page().
>>
>> I considered them, but then I found that there are already
>> for_each_sg_page(), for_each_sg_dma_page() and various special iterators
>> like sg_page_iter, sg_dma_page_iter and sg_mapping_iter. Too bad that
>> they are almost not used, at least in the DRM subsystem. I wonder if it
>> make sense to apply them or simply provide the two above mentioned
>> wrappers?
> None of the helpers helps with passing the right parameters from the
> sg_table.  So in doube we'd need wrappers for all of the above, or
> none..

I've played a bit with the code and the existing scatterlist iterators - 
for_each_sg_page() and for_each_sg_dma_page(). I've found them quite handy!

The biggest advantage of them is that they always iterate over 
scatterlist in PAGE_SIZE units, what should make the code much easier to 
understand. Here is example of their application to the function that 
started this thread:

int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page 
**pages,
                                      dma_addr_t *addrs, int max_entries)
{
         struct sg_dma_page_iter dma_iter;
         struct sg_page_iter page_iter;

         if (addrs)
                 for_each_sgtable_dma_page(sgt, &dma_iter, 0)
                         *addrs++ = sg_page_iter_dma_address(&dma_iter);
         if (pages)
                 for_each_sgtable_page(sgt, &page_iter, 0)
                         *pages++ = sg_page_iter_page(&page_iter);
         return 0;
}

After applying those iterators where possible (they can be used only for 
reading the scatterlist), we would just need to add 2 trivial wrappers 
to use them with sg_table objects:

#define for_each_sgtable_page(sgt, piter, pgoffset)    \
        for_each_sg_page(sgt->sgl, piter, sgt->orig_nents, pgoffset)

#define for_each_sgtable_dma_page(sgt, dma_iter, pgoffset)     \
        for_each_sg_dma_page(sgt->sgl, dma_iter, sgt->nents, pgoffset)

Then we would just need one more helper to construct scatterlist, as the 
above two are read-only don't allow to modify scatterlist:

#define for_each_sgtable_sg(sgt, sg, i)                \
        for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)

With the above 3 helpers we can probably get rid of all instances of 
sg_table->{nents,orig_nents} from the DRM code. I will prepare patches soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

