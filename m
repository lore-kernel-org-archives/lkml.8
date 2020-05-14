Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2F5207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589455325;
	bh=HyGY0khgwqFwhv7+vcxB8uAUHWDSBrDB80SWjydlCDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1E7FrhggH0hTNSc59LDDq0UkAj6u7vZv9WUnRruQh6seiHLtkDv1B7GzMpn2nhZFq
	 mx6AplZrpDUDNK8ic3qZl/T5pUnRIWWOsY5NJBijtXLpDBWQl0KeNRz+2JofMcQNy2
	 0+13bTLVFs9QMU4WRltS+kyqQPXZBH3lKKA2Z4NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:22:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94B9206A5;
        Thu, 14 May 2020 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589455323;
        bh=HyGY0khgwqFwhv7+vcxB8uAUHWDSBrDB80SWjydlCDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwrT4lA/S8fB+vjmejav4EtBtU1SYVn1SszBodfdw31PDe+AYNtHo7Inl29XNet0m
         Eu4rZDyBuJOCPHFdtjCkWZBSn8tgb6zHn6/pAPbCBGSXnK0CVgOd1gY9EBFKlGmZOk
         bPydrAFcQxgmtfrS0oIlNF22eU3RvIeeK+jnvHTw=
Date:   Thu, 14 May 2020 13:22:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was
 Re: WARNING in memtype_reserve)
Message-ID: <20200514112200.GA1847837@kroah.com>
References: <20200509074507.GC1831917@kroah.com>
 <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
 <20200513124445.GA1082735@kroah.com>
 <87zhab249p.fsf@nanos.tec.linutronix.de>
 <20200514035458.14760-1-hdanton@sina.com>
 <20200514061417.GA8367@lst.de>
 <20200514062750.GA1488715@kroah.com>
 <20200514063158.GA8780@lst.de>
 <20200514074659.GA1569055@kroah.com>
 <d4657561-63b2-21a3-9db3-99f3f91aea3e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4657561-63b2-21a3-9db3-99f3f91aea3e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 06:17:41AM -0500, Jeremy Linton wrote:
> On 5/14/20 2:46 AM, Greg KH wrote:
> > On Thu, May 14, 2020 at 08:31:58AM +0200, Christoph Hellwig wrote:
> > > On Thu, May 14, 2020 at 08:27:50AM +0200, Greg KH wrote:
> > > > On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
> > > > > Guys, can you please start formal thread on this?  I have no
> > > > > idea where this came from and what the rationale is.  Btw, if the
> > > > > pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
> > > > > crap, as it is derived from that.  What is the caller, and how is
> > > > > this triggered?
> > > > 
> > > > 
> > > > Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
> > > > page attribute mismatch") changed a call from remap_pfn_range() to
> > > > dma_mmap_coherent() for usb data buffers being sent from userspace.
> > > 
> > > I only need to look at the commit for 3 seconds to tell you that it is
> > > completely buggy.  While using dma_mmap_coherent is fundamentally the
> > > right thing and absolutely required for dma_alloc_* allocations, USB
> > > also uses it's own local gen pool allocator or plain kmalloc for not
> > > DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
> > > sure you hit one of those cases.
> > > 
> > > The logic should be something like:
> > > 
> > > 	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
> > > 		remap_pfn_range()
> > > 	else
> > > 		dma_mmap_coherent()
> > 
> > Ok, that's simple enough, patch is below.
> > 
> > Jeremy, any objection to this change?
> 
> No, thats fine but since I just translated usb_alloc_coherent() to
> dma_map_coherent in my not fully away head. Putting this as
> "usb_map_cohernet()" sort of makes more sense.

Thanks, I'll turn this into a "real" patch now...

greg k-h
