Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64C6C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974422464
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgBQPuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:50:51 -0500
Received: from foss.arm.com ([217.140.110.172]:37772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgBQPuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:50:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14BF430E;
        Mon, 17 Feb 2020 07:50:51 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9833F6CF;
        Mon, 17 Feb 2020 07:50:50 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
To:     Christoph Hellwig <hch@infradead.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
        Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
Date:   Mon, 17 Feb 2020 15:50:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217080138.GB10342@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2020 8:01 am, Christoph Hellwig wrote:
> On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
>> From: Liam Mark <lmark@codeaurora.org>
>>
>> Some devices have a memory map which contains gaps or holes.
>> In order for the device to have as much IOVA space as possible,
>> allow its driver to inform the DMA-IOMMU layer that it should
>> not allocate addresses from these holes.
> 
> Layering violation.  dma-iommu is the translation layer between the
> DMA API and the IOMMU API.  And calls into it from drivers performing
> DMA mappings need to go through the DMA API (and be documented there).

+1

More than that, though, we already have "holes in the address space" 
support for the sake of PCI host bridge windows - assuming this is the 
same kind of thing (i.e. the holes are between memory regions and other 
resources in PA space, so are only relevant once address translation 
comes into the picture), then this is IOMMU API level stuff, so even a 
DMA API level interface would be inappropriate.

Robin.
