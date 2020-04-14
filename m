Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77309C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524E5206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586868457;
	bh=rohU/pNk/NEJ3ruftZTeBtEweHiD6E5lSK9Jtcsrpb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZTaHiG6LfkWgoRWGZttqq9v25GlyV13kk7ILeWY2wGcPJUa8hC1eJ1k6JMeBFk2x6
	 EfFKoSEMRMDvzWv45y7BjQUOuN6nsJXNCQOENuroQENpUioX73OI/un8OKcGzxEAH3
	 ujU7S1GuCjBxFLtCMMbqL0nfbmXtFl6TJMXgb4qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502180AbgDNMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgDNMrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5534B20768;
        Tue, 14 Apr 2020 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586868434;
        bh=rohU/pNk/NEJ3ruftZTeBtEweHiD6E5lSK9Jtcsrpb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6+UuRKXecdjX2i6han5AV7ZYNLnYqonKUbjMYx1Cco2W27c3jFXvhb4Tg6Wuuc5G
         78hZzGDZTBpycjsXM1fhdTYEzYCqnaQHx28KlebKxqDkIzeLT6vYx5j7MUhPKmYCQb
         39wELCBozn9OYUNvL/k4hAqFrInonJT7d2XNN8Tc=
Date:   Tue, 14 Apr 2020 14:47:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200414124712.GA720223@kroah.com>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414122506.438134-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> Several IOMMU drivers have a bypass mode where they can use a direct
> mapping if the devices DMA mask is large enough.  Add generic support
> to the core dma-mapping code to do that to switch those drivers to
> a common solution.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h |  6 ++++
>  kernel/dma/mapping.c   | 70 +++++++++++++++++++++++++++++-------------
>  2 files changed, 55 insertions(+), 21 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
