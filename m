Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB404C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1915206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgENLKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:10:06 -0400
Received: from foss.arm.com ([217.140.110.172]:34344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:10:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3E0230E;
        Thu, 14 May 2020 04:10:04 -0700 (PDT)
Received: from [192.168.122.166] (unknown [10.119.48.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CA6F3F305;
        Thu, 14 May 2020 04:10:04 -0700 (PDT)
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was Re:
 WARNING in memtype_reserve)
To:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
 <20200513124445.GA1082735@kroah.com> <87zhab249p.fsf@nanos.tec.linutronix.de>
 <20200514035458.14760-1-hdanton@sina.com> <20200514061417.GA8367@lst.de>
 <20200514062750.GA1488715@kroah.com> <20200514063158.GA8780@lst.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <8bdb3488-59d0-67ce-4822-e25dbd0dc42a@arm.com>
Date:   Thu, 14 May 2020 06:10:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514063158.GA8780@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/14/20 1:31 AM, Christoph Hellwig wrote:
> On Thu, May 14, 2020 at 08:27:50AM +0200, Greg KH wrote:
>> On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
>>> Guys, can you please start formal thread on this?  I have no
>>> idea where this came from and what the rationale is.  Btw, if the
>>> pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
>>> crap, as it is derived from that.  What is the caller, and how is
>>> this triggered?
>>
>>
>> Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
>> page attribute mismatch") changed a call from remap_pfn_range() to
>> dma_mmap_coherent() for usb data buffers being sent from userspace.
> 
> I only need to look at the commit for 3 seconds to tell you that it is
> completely buggy.  While using dma_mmap_coherent is fundamentally the
> right thing and absolutely required for dma_alloc_* allocations, USB
> also uses it's own local gen pool allocator or plain kmalloc for not
> DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
> sure you hit one of those cases.

? The code path in question is usbdev_mmap() and the allocation is done 
~13 lines lines before as a usb_alloc_coherent().


> 
> The logic should be something like:
> 
> 	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
> 		remap_pfn_range()
> 	else
> 		dma_mmap_coherent()
> 

That sort of makes sense, except for the above, and the fact that I 
would imagine the dma_mmap_coherent should be dealing with that case. 
I'm not really clear about the details of the GCE usb device here, but 
my first guess at this was the dma_pgprot() in dma_direct_mmap() is 
incorrectly picking a pgprot...

