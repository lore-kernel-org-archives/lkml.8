Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E99C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1959D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fn/uls6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHSBbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:31:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52389 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHSBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:31:45 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200819013141epoutp02cea772c91760950dad5d644390d3005e~sh0WrBGYZ0784607846epoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:31:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200819013141epoutp02cea772c91760950dad5d644390d3005e~sh0WrBGYZ0784607846epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597800701;
        bh=fsdGVoN9IlF7OqHRzConARmrumvhxv5lInQcxH9Rlf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fn/uls6iwvBej403aEatoGowPEHjBVqIJpwJQiQwLMGD7T39tgjqRw2Sj7tlQLMf8
         g3mGPQKDEOVYi+G448vyH5LsBnpQQ1DavqX1juqiOUymTpH7DSlSKPIqaeOz6Sqp+/
         k4aBJ4p3+pjDZ/Qg8yRBW4CuP2H8fKIBlSBq7qnQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200819013140epcas2p11de18ca871873afc9f43f8395bb38254~sh0WFIGF31376313763epcas2p1m;
        Wed, 19 Aug 2020 01:31:40 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BWVcV1CN0zMqYm0; Wed, 19 Aug
        2020 01:31:38 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.95.27013.9F08C3F5; Wed, 19 Aug 2020 10:31:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200819013137epcas2p33575306f4c1c6ca015198ed7aec41168~sh0TNUldM1227512275epcas2p3-;
        Wed, 19 Aug 2020 01:31:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819013137epsmtrp2552a5278d0cd38c4bf0e9674aee22c6e~sh0TMfo8u2783427834epsmtrp27;
        Wed, 19 Aug 2020 01:31:37 +0000 (GMT)
X-AuditID: b6c32a48-d1fff70000006985-02-5f3c80f90ccb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.5A.08382.9F08C3F5; Wed, 19 Aug 2020 10:31:37 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819013137epsmtip197cd0f2b93ee39661004ce03ca908f47~sh0S-jHT22432624326epsmtip1m;
        Wed, 19 Aug 2020 01:31:37 +0000 (GMT)
Date:   Wed, 19 Aug 2020 10:24:05 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, catalin.marinas@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, janghyuck.kim@samsung.com,
        hyesoo.yu@samsung.com
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200819012405.GA130135@KEI>
MIME-Version: 1.0
In-Reply-To: <20200818100756.GA15543@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmme7PBpt4gyPn9C3eL+thtPjbeYHV
        YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
        VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GT8PP2OveCORsXJZTOYGxgvKHQxcnJICJhIbDl1
        n7mLkYtDSGAHo8TFm/OZIJxPjBIbz3awQTjfGCVOT5nNDNPSsP0eVNVeRomPR2exQjgPGSWe
        n/jGAlLFIqAq8eLif3YQm01AS2L13OOMILaIgKLEju1/wBYyC/xilLix8DdYg7CAt8SaFc1M
        IDavgKbEgyO/oGxBiZMzn4DVcAqYSZw9PgNoGweHqICKxKuD9SBzJARmckhs2nKSDeI8F4ll
        7/ZCnSos8er4FnYIW0ri87u9bBAN0xkl3s0/BNWwmVHi225BCNtYYtazdrBLmQUyJM4eeMsC
        skxCQFniyC0WiDCfRMfhv+wQYV6JjjYhiE4ViZ1Tr7HArOrbewOq00Pi70QhSPhMYJJ49eg6
        ywRG+VlIPpuFZBmErSOxYPcntllA7cwC0hLL/3FAmJoS63fpL2BkXcUollpQnJueWmxUYIIc
        25sYwQlXy2MH4+y3H/QOMTJxMB5ilOBgVhLh7d1rHS/Em5JYWZValB9fVJqTWnyI0RQYTxOZ
        pUST84EpP68k3tDUyMzMwNLUwtTMyEJJnPed1YU4IYH0xJLU7NTUgtQimD4mDk6pBia9xxeq
        87L/1e52un6/YtMLTe4svS9fGay3fYsI+y0Z+au2OvqzTITZey5+c0OGwlMSBc59M58KZkxh
        TynxXLPcrrHvYqzkxYqFqS8unC2ef359zYb0mO4G5Y7r61aURvJMPrsgT+Gyb6dgpcqKay4n
        +hJ32r7zWG0S91RU2GW+4vG8s3t5+iUWzGZONfZy/6I2h8Uqq9y1f/aDt86ekz/oXetzVfNo
        WB6x4omkuUtp/BTBSd4FCgt266bsL1lWxW2RNF8vYFPA1w9p6854cvu5ZigqST3Y817jx4Oy
        WvM93/vNPoZkODZPEzr97vg1pn0ROSGOHnvP1yVmpUgwzz/68NOGByJ7Q9mVet5tV2Ipzkg0
        1GIuKk4EAIgweFlBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO7PBpt4g1ur+S3eL+thtPjbeYHV
        YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
        VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy5jw/wFgwR61i5ofTbA2M
        K+W6GDk5JARMJBq232PqYuTiEBLYzSgxb/txFoiElMS87rVMELawxP2WI6wQRfcZJRrX3GQD
        SbAIqEq8uPifHcRmE9CSWD33OCOILSKgKLFj+x9mkAZmgT+MEg+P3gcrEhbwllizohlsKq+A
        psSDI7+gVk9ikrj04AsLREJQ4uTMJ2A2M9DUG/9eAhVxANnSEsv/cYCEOQXMJM4en8EKEhYV
        UJF4dbB+AqPgLCTNs5A0z0JoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhe
        tDR3MG5f9UHvECMTB+MhRgkOZiUR3t691vFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowT
        EkhPLEnNTk0tSC2CyTJxcEo1MGmJhiRtSYg9s2Zhmn8KY3Go3CHRjv3Xj3/5cdWnO3zWyQaN
        RQ83cD25Hxal96aMJTzDzvaZnW9uX4v/lhXiRdOPM+9StVp66FxN8u1k5YcdV4rnhknJzw0z
        e2bWGrumgf9dh57s3IZpTOqnmhzezRFmviNZ6j7lep/Ez2tNKr73zq/NYRHrl5E55LR7Zezp
        BZl13O5+s2985XPPyREOlXE5LG2UsN1rTonApOUvcl1DO0LC5sdLn53Au6/tmeGsyG0Ckw0F
        uYzyHG4y9n48tbf1Zs6ehnXLn+gfKVjV7aZn+SX532an/CsWH08Yy+odyquK3XRZ7/Tm9ZWi
        KfNV7rzd5NLo0qIlVZT6l2GGEktxRqKhFnNRcSIAyWY+lwYDAAA=
X-CMS-MailID: 20200819013137epcas2p33575306f4c1c6ca015198ed7aec41168
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----jP-8ngVnC3Gj3kiV8vG8DjBEMhmSuhMP5MYu.QTDVwZYRgT_=_30927_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
        <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
        <20200818082852.GA15145@willie-the-truck> <20200818093739.GB191752@KEI>
        <20200818100756.GA15543@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------jP-8ngVnC3Gj3kiV8vG8DjBEMhmSuhMP5MYu.QTDVwZYRgT_=_30927_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 18, 2020 at 11:07:57AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 06:37:39PM +0900, Cho KyongHo wrote:
> > On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> > > On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > > > Cache maintenance operations in the most of CPU architectures needs
> > > > memory barrier after the cache maintenance for the DMAs to view the
> > > > region of the memory correctly. The problem is that memory barrier is
> > > > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > > > involves the memory barrier per every single cache sg entry. In some
> > > > CPU micro-architecture, a single memory barrier consumes more time than
> > > > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > > > are larger.
> > > 
> > > Have you got higher-level performance data for this change? It's more likely
> > > that the DSB is what actually forces the prior cache maintenance to
> > > complete,
> > 
> > This patch does not skip necessary DSB after cache maintenance. It just
> > remove repeated dsb per every single sg entry and call dsb just once
> > after cache maintenance on all sg entries is completed.
> 
> Yes, I realise that, but what I'm saying is that a big part of your
> justification for this change is:
> 
>   | The problem is that memory barrier is very expensive and dma_[un]map_sg()
>   | and dma_sync_sg_for_{device|cpu}() involves the memory barrier per every
>   | single cache sg entry. In some CPU micro-architecture, a single memory
>   | barrier consumes more time than cache clean on 4KiB.
> 
> and my point is that the DSB is likely completing the cache maintenance,
> so as cache maintenance instructions retire faster in the micro-architecture,
> the DSB becomes absolutely slower. In other words, it doesn't make much
> sense to me to compare the cost of the DSB with the cost of the cache
> maintenance; what matters more is the code of the high-level unmap()
> operation for the sglist.
> 
I now understand your point. But I still believe that repeated DSB in
the middle of cache maintenance wastes redundant CPU cycles. Avoiding
that redundancy causes extra complexity to implmentation of dma API. But
I think it is valuable.

> > > so it's important to look at the bigger picture, not just the
> > > apparent relative cost of these instructions.
> > > 
> > If you mean bigger picture is the performance impact of this patch to a
> > complete user scenario, we are evaluating it in some latency sensitve
> > scenario. But I wonder if a performance gain in a platform/SoC specific
> > scenario is also persuasive.
> 
> Latency is fine too, but phrasing the numbers (and we really need those)
> in terms of things like "The interrupt response time for this in-tree
> driver is improved by xxx ns (yy %) after this change" or "Throughput
> for this in-tree driver goes from xxx mb/s to yyy mb/s" would be really
> helpful.
> 

Unfortunately, we have no in-tree driver to show the performance.
Instead, we just evaluated the speed of dma_sync_sg_for_device() to see
the improvements of this patch.
For example, Cortex-A55 in our 2-cluster, big-mid-little system gains 28%
(130.9 usec. -> 94.5 usec.) during dma_sync_sg_for_device(sg, nents,
DMA_TO_DEVICE) is running with nents = 256 and length of each sg entrh is 4KiB.
Let me describe the detailed performance results in the next patch
series which will include some fixes to errata in commit messages.

> > > Also, it's a miracle that non-coherent DMA even works,
> > 
> > I am sorry, Will. I don't understand this. Can you let me know what do
> > you mena with the above sentence?
> 
> Non-coherent DMA sucks for software.

I agree. But due to the H/W cost, proposals about coherent DMA are
always challenging.

> For the most part, Linux does a nice
> job of hiding this from device drivers, and I think _that_ is the primary
> concern, rather than performance. If performance is a problem, then the
> solution is cache coherence or a shared non-cacheable buffer (rather than
> the streaming API).
We are also trying to use non-cacheable buffers for the non-coherent
DMAs. But the problem with the non-cacheable buffer is CPU access speed.
> 
> > > so I'm not sure
> > > that we should be complicating the implementation like this to try to
> > > make it "fast".
> > > 
> > I agree that this patch makes the implementation of dma API a bit more
> > but I don't think this does not impact its complication seriously.
> 
> It's death by a thousand cuts; this patch further fragments the architecture
> backends and leads to arm64-specific behaviour which consequently won't get
> well tested by anybody else. Now, it might be worth it, but there's not
> enough information here to make that call.
> Will
> 

------jP-8ngVnC3Gj3kiV8vG8DjBEMhmSuhMP5MYu.QTDVwZYRgT_=_30927_
Content-Type: text/plain; charset="utf-8"


------jP-8ngVnC3Gj3kiV8vG8DjBEMhmSuhMP5MYu.QTDVwZYRgT_=_30927_--
