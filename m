Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE91C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6356520767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHaIZH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:25:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:44058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727910AbgHaIZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:25:00 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id ADA9A5D06E1A34BB50C0;
        Mon, 31 Aug 2020 16:24:57 +0800 (CST)
Received: from dggema723-chm.china.huawei.com (10.3.20.87) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 31 Aug 2020 16:23:54 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema723-chm.china.huawei.com (10.3.20.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 16:23:54 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 16:23:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangdaode <huangdaode@huawei.com>
Subject: RE: [PATCH v6 0/2] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Topic: [PATCH v6 0/2] make dma_alloc_coherent NUMA-aware by per-NUMA
 CMA
Thread-Index: AQHWd2Lc8c1DGcwANEy/0S0zVDdod6lBkR4AgBBdgfA=
Date:   Mon, 31 Aug 2020 08:23:55 +0000
Message-ID: <05dad074e0624367a3fc0dfd0b96a352@hisilicon.com>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821061918.GA28559@lst.de>
In-Reply-To: <20200821061918.GA28559@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> Sent: Friday, August 21, 2020 6:19 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; huangdaode <huangdaode@huawei.com>
> Subject: Re: [PATCH v6 0/2] make dma_alloc_coherent NUMA-aware by
> per-NUMA CMA
> 
> FYI, as of the last one I'm fine now, bit I really need an ACK from
> the arm64 maintainers.

Hi Christoph,

For the changes in arch/arm64, Will gave his ack here:
https://lore.kernel.org/linux-iommu/20200821090116.GB20255@willie-the-truck/

and the patchset has been refined to v8
https://lore.kernel.org/linux-iommu/20200823230309.28980-1-song.bao.hua@hisilicon.com/
with one additional patch to remove magic number:
[PATCH v8 3/3] mm: cma: use CMA_MAX_NAME to define the length of cma name array
https://lore.kernel.org/linux-iommu/20200823230309.28980-4-song.bao.hua@hisilicon.com/

Hopefully, you didn't miss it:-)
Does the new one need an Ack from Linux-mm maintainer?

Thanks
Barry

