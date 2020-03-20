Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336532072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584716532;
	bh=abV8/ZN//3YrBYbpASQEcaHQnh62HmxBKB67ullzIGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y9pA5K/Fl4uFURbLpQZ6HiM7osGO0vXneN5eAaBrSVTFX1J5U9d21PTq1pgRBT/nn
	 XNBsDBh973CW4Z1QbELiV1eFbuVvDC6WTGIb2hOniS1BEhyoYzqdemIF3lAq0EPQyw
	 t+bUDTeZHQlDKpEkQ7PgH2LcWYVjjiAizZ6TxtFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCTPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgCTPCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:02:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F7720714;
        Fri, 20 Mar 2020 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584716530;
        bh=abV8/ZN//3YrBYbpASQEcaHQnh62HmxBKB67ullzIGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzOLV/nbV2X1/L58dQ3IkZlLSycU8DKOQKketOO4IOKdxd2U2/rYT7SkwTah5EjVJ
         iQx82GFrYHrxhgi6UBGnAO02z0cmJpplNHGbUdy4HeQi3Ds72dU53yoowTfDpIdU5U
         OPE+lL5UAbxawylQefAwtClInfYGFVljyJcPApTM=
Date:   Fri, 20 Mar 2020 16:02:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200320150208.GA761915@kroah.com>
References: <20200320141640.366360-1-hch@lst.de>
 <20200320141640.366360-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320141640.366360-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:16:39PM +0100, Christoph Hellwig wrote:
> Several IOMMU drivers have a bypass mode where they can use a direct
> mapping if the devices DMA mask is large enough.  Add generic support
> to the core dma-mapping code to do that to switch those drivers to
> a common solution.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h      |  6 ++++++
>  include/linux/dma-mapping.h | 30 ++++++++++++++++++------------
>  kernel/dma/mapping.c        | 36 +++++++++++++++++++++++++++---------
>  3 files changed, 51 insertions(+), 21 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
