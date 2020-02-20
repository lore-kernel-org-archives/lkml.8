Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C711C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC9520722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgBTQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:41 -0500
Received: from verein.lst.de ([213.95.11.211]:50298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgBTQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07B1C68BFE; Thu, 20 Feb 2020 17:31:36 +0100 (CET)
Date:   Thu, 20 Feb 2020 17:31:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200220163135.GA13192@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-2-pasic@linux.ibm.com> <20200220161146.GA12709@lst.de> <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> >From a users perspective it makes absolutely perfect sense to use the
> bounce buffers when they are NEEDED. 
> Forcing the user to specify iommu_platform just because you need bounce buffers
> really feels wrong. And obviously we have a severe performance issue
> because of the indirections.

The point is that the user should not have to specify iommu_platform.
We need to make sure any new hypervisor (especially one that might require
bounce buffering) always sets it, as was a rather bogus legacy hack
that isn't extensibe for cases that for example require bounce buffering.
