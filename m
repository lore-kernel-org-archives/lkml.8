Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B90C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5BA24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582115339;
	bh=pZqcXAmiIFw4IeJtWb4Wcj8aOi5Y83+K1GOOaMEDO7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=raltK+T3w+rKQY3eWnw2tI4px0/lVfDcY+pQiNMbyX0KbjibEMlpNPVjPegV1RvlV
	 E+4aZ8Bt1GdeOfZSoZjQBU2JT3vadBbvYqKsaEIazROe2+oRub5yVfcoB++HyZ5bEo
	 YBRgQp4nSdD5YaXdEKZmgXe9K72gJsyCm0WuJpAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBSM26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:28:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:28:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F004B21D56;
        Wed, 19 Feb 2020 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582115337;
        bh=pZqcXAmiIFw4IeJtWb4Wcj8aOi5Y83+K1GOOaMEDO7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Umn/1xgaV43oz7F197cgo+A0c9gYfvgLHah+dwfpDMlsoOlwhteZSYiflE5BPlul/
         DX1Ql9t919o+Z0DaA7Z7VQQKBfY019XpUOFh7TO8hKi2JKQYjXO1rIu44zNL5jANbV
         ZCHllR7RHSdLV8ZMw/usUo5/sCFW64rEnm3GA6uM=
Date:   Wed, 19 Feb 2020 12:28:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, pratikp@codeaurora.org,
        Liam Mark <lmark@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Message-ID: <20200219122852.GB19400@willie-the-truck>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
 <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:03:54PM +0000, Robin Murphy wrote:
> On 14/02/2020 11:06 pm, Isaac J. Manjarres wrote:
> > From: Liam Mark <lmark@codeaurora.org>
> > 
> > Using the best-fit algorithm, instead of the first-fit
> > algorithm, may reduce fragmentation when allocating
> > IOVAs.
> 
> What kind of pathological allocation patterns make that a serious problem?
> Is there any scope for simply changing the order of things in the callers?
> Do these drivers also run under other DMA API backends (e.g. 32-bit Arm)?
> 
> More generally, if a driver knows enough to want to second-guess a generic
> DMA API allocator, that's a reasonable argument that it should perhaps be
> properly IOMMU-aware and managing its own address space anyway. Perhaps this
> effort might be better spent finishing off the DMA ops bypass stuff to make
> that approach more robust and welcoming.

Anecdotally, it appears to be a fairly common problem for 32-bit capable
DMA masters to hit fragmentation problems with the current IOVA allocator
but yes, some numbers to show how that is improved using best-fit (as
opposed to e.g. worst-fit) are definitely required here.

It might be that we can simply swizzle the algorithm to focus on reduced
fragmentation for smaller (i.e. 32-bit) address spaces, but leave larger
domains with the current approach to avoid increasing the allocation
overhead.

Will
