Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B7C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B924654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="si77ZFwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBSUGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:06:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:19141 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgBSUGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:06:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582142793; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=//g+fSyDRPG/v+45Xg82m3qHmJx/MoVeSp+8QT8ucjw=;
 b=si77ZFwnUQ0gY0knaxtK/Do0i0YKkYdA1Wqm7kyqJwRKqQUjZSgPqu5ubIfNxZ1W/vYCC15n
 BjDIM66XO97jKA1Tb+ffKm/od9/0c8ccmrxUQcj1BTqvgWt4yX3XvZVoVTDsyPKwsoV42+4K
 EF2BvOYnKN8GB0NBa5vql45S2ok=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4d9545.7f0d07d515a8-smtp-out-n03;
 Wed, 19 Feb 2020 20:06:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6FADC447A3; Wed, 19 Feb 2020 20:06:28 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D272C43383;
        Wed, 19 Feb 2020 20:06:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Feb 2020 12:06:28 -0800
From:   isaacm@codeaurora.org
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, pratikp@codeaurora.org,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
In-Reply-To: <20200219111501.GA19400@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
Message-ID: <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-19 03:15, Will Deacon wrote:
> On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
>> On 2020-02-17 07:50, Robin Murphy wrote:
>> > On 17/02/2020 8:01 am, Christoph Hellwig wrote:
>> > > On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
>> > > > From: Liam Mark <lmark@codeaurora.org>
>> > > >
>> > > > Some devices have a memory map which contains gaps or holes.
>> > > > In order for the device to have as much IOVA space as possible,
>> > > > allow its driver to inform the DMA-IOMMU layer that it should
>> > > > not allocate addresses from these holes.
>> > >
>> > > Layering violation.  dma-iommu is the translation layer between the
>> > > DMA API and the IOMMU API.  And calls into it from drivers performing
>> > > DMA mappings need to go through the DMA API (and be documented there).
>> >
>> > +1
>> >
>> > More than that, though, we already have "holes in the address space"
>> > support for the sake of PCI host bridge windows - assuming this is the
>> > same kind of thing (i.e. the holes are between memory regions and
>> > other resources in PA space, so are only relevant once address
>> > translation comes into the picture), then this is IOMMU API level
>> To make sure that we're on the same page, this support alludes to the
>> handling in
>> dma-iommu.c that reserves portions of the IOVA space for the PCI host 
>> bridge
>> windows,
>> correct? If so, then yes, this is similar.
>> > stuff, so even a DMA API level interface would be inappropriate.
>> Does this mean that the driver should be managing the IOVA space and
>> mappings for this device using the IOMMU API? If so, is the rationale 
>> for
>> this because the device driver can have the information of what IOVA 
>> ranges
>> can and cannot be used? Shouldn't there be a generic way of informing 
>> an
>> IOMMU driver about these reserved ranges? Perhaps through a device 
>> tree
>> property, instead of deferring this type of management to the driver?
> 
> Before we dive into designing that, can you please clarify whether the
> reserved IOVA range applies to all DMA masters mastering through a
> particular SMMU, or whether it's just about one specific master? I was
> assuming the former, but wanted to be sure.
> 
This situation currently applies to one master.
> Thanks,
> 
> Will

Thanks,
Isaac
