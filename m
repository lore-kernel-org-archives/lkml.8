Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B8C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F7B20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgD1QDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:03:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1QDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:03:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11FB530E;
        Tue, 28 Apr 2020 09:03:02 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE773F305;
        Tue, 28 Apr 2020 09:02:59 -0700 (PDT)
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
 <20200428132005.21424-1-m.szyprowski@samsung.com>
 <20200428140257.GA3433@lst.de> <20200428153202.GY3456981@phenom.ffwll.local>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c01c9766-9778-fd1f-f36e-2dc7bd376ba4@arm.com>
Date:   Tue, 28 Apr 2020 17:02:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428153202.GY3456981@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-28 4:32 pm, Daniel Vetter wrote:
> On Tue, Apr 28, 2020 at 04:02:57PM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
>>> 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
>>>     a proper sg_table entries and call respective DMA-mapping functions
>>>     and adapt current code to it
>>
>> That sounds reasonable to me.  Those could be pretty trivial wrappers.
>>
>>>
>>>
>>> 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
>>>     which one refers to which part of the scatterlist; I'm open for
>>>     other names for those entries
>>
>> nr_cpu_ents and nr_dma_ents might be better names, but it still would be
>> a whole lot of churn for little gain.  I think just good wrappers like
>> suggested above might be more helpful.
> 
> I guess long-term we could aim for both? I.e. roll out better wrappers
> first, once that's soaked through the tree, rename the last offenders.

Yes, that's what I was thinking too - most of these uses are just 
passing them in and out of the DMA APIs, and thus would be subsumed into 
the wrappers anyway, then in the relatively few remaining places where 
the table is actually iterated for one reason or the other, renaming 
would stand to help review and maintenance in terms of making it far 
more obvious when the implementation and the intent don't match.

Robin.
