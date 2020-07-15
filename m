Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46B02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594832763;
	bh=MVQs60eyaseKttygMi5Okmio5UqpxovjpBaGYM2KopU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=mlNgmczG8tSIYJW/CXyjS9fVp+lSL9wzg45OGL+zyOuniug0RtJTQJJWoRQXhGQl2
	 SoN9PVzOZf0/++TEQlAEnq1RwwWJtP/80l09pM8KCVj4skGRYpEd6WMMmCcuErZdKd
	 XzK3ZlHruQPPQj9d7aBtg/qKfQ6S+8v3PRrn6i+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGORGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgGORGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:06:02 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D53F2065E;
        Wed, 15 Jul 2020 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594832761;
        bh=MVQs60eyaseKttygMi5Okmio5UqpxovjpBaGYM2KopU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CBPLDZ0a2kofL5+ir7rsYDlbbpzpSFpGzRjY5GXtgxKoOkAVo9rx/IXw2nZaAg6FP
         0PGoTpRFSOeEWLcCxLE4J3D3xFoVDU+sXxptoew5BleNGM0IN0YcxXbu+SlhudGRTe
         VCtmQZUU53N6u7CQ+nguMHVqQdrr4STCBfllpVWM=
Date:   Wed, 15 Jul 2020 10:06:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     "Michael S. Tsirkin" <mst@redhat.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        Peng Fan <peng.fan@nxp.com>, konrad.wilk@oracle.com,
        jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200711144334-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
References: <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s> <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s> <20200701133456.GA23888@infradead.org> <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s> <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s> <20200711144334-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 10:23:22AM -0700, Stefano Stabellini wrote:
> > Sorry for the late reply -- a couple of conferences kept me busy.
> > 
> > 
> > On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > > Would you be in favor of a more flexible check along the lines of the
> > > > one proposed in the patch that started this thread:
> > > > 
> > > >     if (xen_vring_use_dma())
> > > >             return true;
> > > > 
> > > > 
> > > > xen_vring_use_dma would be implemented so that it returns true when
> > > > xen_swiotlb is required and false otherwise.
> > > 
> > > Just to stress - with a patch like this virtio can *still* use DMA API
> > > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > > as you seem to be saying, you guys should fix it before doing something
> > > like this..
> > 
> > Yes, DMA API is broken with some interfaces (specifically: rpmesg and
> > trusty), but for them PLATFORM_ACCESS is never set. That is why the
> > errors weren't reported before. Xen special case aside, there is no
> > problem under normal circumstances.
> 
> So why not fix DMA API? Then this patch is not needed.

It looks like the conversation is going in circles :-)

I tried to explain the reason why, even if we fixed the DMA API to work
with rpmesg and trusty, we still need this patch with the following
email:  https://marc.info/?l=linux-kernel&m=159347446709625&w=2


At that time it looked like you agreed that we needed to improve this
check?  (https://marc.info/?l=linux-kernel&m=159363662418250&w=2)
