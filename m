Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D96C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B5120826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590091738;
	bh=vEJTuttOxs4JpAIMsGvnSXLjxqVm1B/URIYI7oYtQbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=daPwjBSPVujk27z8pWCOr8h9qxvR3sgwl+h3OGVSFUkWMOWrxc2LgB+2wRyqsWpd1
	 c/tuVQ8pt4UiUZoGnsmy0lofvAQehMP7XmQYXqtyaiWDxdobi+sKZSrJGQTHkmdVri
	 ZRtuAo2Xx3lzJNZEoxhUrpfeZ0qRM3SgMcsAL5MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgEUUI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUUI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:08:57 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C84207D3;
        Thu, 21 May 2020 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590091737;
        bh=vEJTuttOxs4JpAIMsGvnSXLjxqVm1B/URIYI7oYtQbk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TRQaadxHYfti3eW2b+FoYOFMPyROpwEIbtKj2CuoXe/gsth2rSYpPkyxC2bCY2ld+
         H7f7yW0zmuCF4wvtXlGgLOeG46DSJIRKkfz3SK4yZfm4ElplcFkB5qoxb2rU/gC/SL
         1ne6kHxu9PzSY7msjlXmfe6JAp5tY2tYcMpikrms=
Date:   Thu, 21 May 2020 13:08:56 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Julien Grall <julien@xen.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH 09/10] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
In-Reply-To: <83c1120f-fe63-dc54-7b82-15a91c748de8@xen.org>
Message-ID: <alpine.DEB.2.21.2005211247461.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <20200520234520.22563-9-sstabellini@kernel.org> <83c1120f-fe63-dc54-7b82-15a91c748de8@xen.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020, Julien Grall wrote:
> > @@ -97,8 +98,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> >   			   phys_addr_t phys,
> >   			   dma_addr_t dev_addr)
> >   {
> > -	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
> > -	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
> > +	unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
> >     	/*
> >   	 * The swiotlb buffer should be used if
> > @@ -115,7 +115,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> >   	 * require a bounce buffer because the device doesn't support coherent
> >   	 * memory and we are not able to flush the cache.
> >   	 */
> > -	return (!hypercall_cflush && (xen_pfn != bfn) &&
> > +	return (!hypercall_cflush && !pfn_valid(bfn) &&
> 
> I believe this change is incorrect. The bfn is a frame based on Xen page
> granularity (always 4K) while pfn_valid() is expecting a frame based on the
> Kernel page granularity.

Given that kernel granularity >= xen granularity it looks like it would
be safe to use PFN_DOWN instead of XEN_PFN_DOWN:

  unsigned int bfn = PFN_DOWN(dma_to_phys(dev, dev_addr));
  return (!hypercall_cflush && !pfn_valid(bfn) &&
