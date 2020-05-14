Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18FC206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:16:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgENLQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E605A30E;
        Thu, 14 May 2020 04:16:11 -0700 (PDT)
Received: from [192.168.122.166] (unknown [10.119.48.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780353F305;
        Thu, 14 May 2020 04:16:11 -0700 (PDT)
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was Re:
 WARNING in memtype_reserve)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509074507.GC1831917@kroah.com> <87wo5l4ecm.fsf@nanos.tec.linutronix.de>
 <20200513124445.GA1082735@kroah.com> <87zhab249p.fsf@nanos.tec.linutronix.de>
 <20200514035458.14760-1-hdanton@sina.com> <20200514061417.GA8367@lst.de>
 <20200514062750.GA1488715@kroah.com> <20200514063158.GA8780@lst.de>
 <8bdb3488-59d0-67ce-4822-e25dbd0dc42a@arm.com>
 <20200514111442.GA13813@lst.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <83544950-e946-b696-9cf4-c7df097332b4@arm.com>
Date:   Thu, 14 May 2020 06:16:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514111442.GA13813@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 6:14 AM, Christoph Hellwig wrote:
> On Thu, May 14, 2020 at 06:10:03AM -0500, Jeremy Linton wrote:
>>> I only need to look at the commit for 3 seconds to tell you that it is
>>> completely buggy.  While using dma_mmap_coherent is fundamentally the
>>> right thing and absolutely required for dma_alloc_* allocations, USB
>>> also uses it's own local gen pool allocator or plain kmalloc for not
>>> DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
>>> sure you hit one of those cases.
>>
>> ? The code path in question is usbdev_mmap() and the allocation is done ~13
>> lines lines before as a usb_alloc_coherent().
> 
> And did you take a look at how usb_alloc_coherent is implemented?  That
> should make it completely obvious that not all allocations come
> from dma_alloc_*.

No, your right, I noticed/remembered the usb_alloc vs dma_alloc 
difference right after sending that email, and was just about to say so.

  Sorry, you right.

> 
>> That sort of makes sense, except for the above, and the fact that I would
>> imagine the dma_mmap_coherent should be dealing with that case. I'm not
>> really clear about the details of the GCE usb device here, but my first
>> guess at this was the dma_pgprot() in dma_direct_mmap() is incorrectly
>> picking a pgprot...
> 
> No, dma_mmap_* / dma_direct_mmap has absolutely no business dealing
> with memory that did not come from the DMA allocator.
> 

