Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5899EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44443206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgENGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:32:02 -0400
Received: from verein.lst.de ([213.95.11.211]:50261 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgENGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:32:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 98AFF68C7B; Thu, 14 May 2020 08:31:58 +0200 (CEST)
Date:   Thu, 14 May 2020 08:31:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was
 Re: WARNING in memtype_reserve)
Message-ID: <20200514063158.GA8780@lst.de>
References: <000000000000f0d8d205a531f1a3@google.com> <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de> <20200513124445.GA1082735@kroah.com> <87zhab249p.fsf@nanos.tec.linutronix.de> <20200514035458.14760-1-hdanton@sina.com> <20200514061417.GA8367@lst.de> <20200514062750.GA1488715@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514062750.GA1488715@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:27:50AM +0200, Greg KH wrote:
> On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
> > Guys, can you please start formal thread on this?  I have no
> > idea where this came from and what the rationale is.  Btw, if the
> > pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
> > crap, as it is derived from that.  What is the caller, and how is
> > this triggered?
> 
> 
> Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
> page attribute mismatch") changed a call from remap_pfn_range() to
> dma_mmap_coherent() for usb data buffers being sent from userspace.

I only need to look at the commit for 3 seconds to tell you that it is
completely buggy.  While using dma_mmap_coherent is fundamentally the
right thing and absolutely required for dma_alloc_* allocations, USB
also uses it's own local gen pool allocator or plain kmalloc for not
DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
sure you hit one of those cases.

The logic should be something like:

	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
		remap_pfn_range()
	else
		dma_mmap_coherent()
