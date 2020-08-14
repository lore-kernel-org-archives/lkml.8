Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A04C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A8620885
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHNNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:40:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgHNNkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:40:10 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7163B571FFE3D7393BC5;
        Fri, 14 Aug 2020 14:40:08 +0100 (IST)
Received: from [127.0.0.1] (10.47.4.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 14 Aug
 2020 14:40:07 +0100
Subject: Re: nvme crash - Re: linux-next: Tree for Aug 13
From:   John Garry <john.garry@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     linux-nvme <linux-nvme@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <chaitanya.kulkarni@wdc.com>
References: <20200813155009.GA2303@infradead.org>
 <81e42d30-ede3-d7b0-ad7b-8192bcf27a4c@huawei.com>
 <20200814120824.GB1872@infradead.org>
 <895b0c2f-52eb-bd72-7cbf-aa6808c018d2@huawei.com>
Message-ID: <4f01dd86-62da-84bd-0ae4-7e31b5484514@huawei.com>
Date:   Fri, 14 Aug 2020 14:37:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <895b0c2f-52eb-bd72-7cbf-aa6808c018d2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2020 14:07, John Garry wrote:
> 
> BTW, as for the DMA/sg scatterlist code, it so happens in this case that 
> we try the dma alloc for size=0 in nvme_alloc_queue() - I know an 
> allocation for size=0 makes no sense, but couldn't we bit a bit more 
> robust?

it's giving ZERO_SIZE_PTR, which we deference, so ignore me...
