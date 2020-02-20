Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D8C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F924673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582188359;
	bh=M6GGXuQ/D6jiRe6KPYbT3GWIqkyMWWqU9w9MfTEu9pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1bdb6wh2OEXMgIVknbhW8h+kHo5txI9uYTfEaYRiciL4MAwPd4MbvCTwIJemj0q17
	 heuly4EtNaUgwTQHxkX7H6bVq2u6+A14Y9F0osfyAWwRbLYCWvQx/kYUSCD35QWPie
	 TWxDW45oGRc5okui1mUWOXtoIhe/Mq77haz62sYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTIp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:45:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBD9207FD;
        Thu, 20 Feb 2020 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582188357;
        bh=M6GGXuQ/D6jiRe6KPYbT3GWIqkyMWWqU9w9MfTEu9pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lI95RFO8JMLFC9bEmf1jbUprqiB7R/md/sR6FxYDha9JFtReCPlJ8MzUa8NB4H7yn
         elIzgxmFyp4jHkujurvO69MXlPwSkJHAxULUB0mTK8rEzCAJqLKDq/eGxbqzbVYOX1
         75GGZ4a4pc3c6KF0Jp8wmYBF1HTwpHWB98LbtTNU=
Date:   Thu, 20 Feb 2020 08:45:52 +0000
From:   Will Deacon <will@kernel.org>
To:     isaacm@codeaurora.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, pratikp@codeaurora.org,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200220084552.GB11827@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
 <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:06:28PM -0800, isaacm@codeaurora.org wrote:
> On 2020-02-19 03:15, Will Deacon wrote:
> > On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> > > Does this mean that the driver should be managing the IOVA space and
> > > mappings for this device using the IOMMU API? If so, is the
> > > rationale for
> > > this because the device driver can have the information of what IOVA
> > > ranges
> > > can and cannot be used? Shouldn't there be a generic way of
> > > informing an
> > > IOMMU driver about these reserved ranges? Perhaps through a device
> > > tree
> > > property, instead of deferring this type of management to the driver?
> > 
> > Before we dive into designing that, can you please clarify whether the
> > reserved IOVA range applies to all DMA masters mastering through a
> > particular SMMU, or whether it's just about one specific master? I was
> > assuming the former, but wanted to be sure.
> > 
> This situation currently applies to one master.

Interesting. Is it problematic if the range is reserved for all masters
sharing that SMMU?

Will
