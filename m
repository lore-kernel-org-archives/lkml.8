Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB6AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B990F20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENLRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:17:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgENLRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:17:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E827F30E;
        Thu, 14 May 2020 04:17:42 -0700 (PDT)
Received: from [192.168.122.166] (unknown [10.119.48.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6E53F305;
        Thu, 14 May 2020 04:17:42 -0700 (PDT)
Subject: Re: Validating dma_mmap_coherent() parameters before calling (was Re:
 WARNING in memtype_reserve)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
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
 <20200514074659.GA1569055@kroah.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <d4657561-63b2-21a3-9db3-99f3f91aea3e@arm.com>
Date:   Thu, 14 May 2020 06:17:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514074659.GA1569055@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 2:46 AM, Greg KH wrote:
> On Thu, May 14, 2020 at 08:31:58AM +0200, Christoph Hellwig wrote:
>> On Thu, May 14, 2020 at 08:27:50AM +0200, Greg KH wrote:
>>> On Thu, May 14, 2020 at 08:14:17AM +0200, Christoph Hellwig wrote:
>>>> Guys, can you please start formal thread on this?  I have no
>>>> idea where this came from and what the rationale is.  Btw, if the
>>>> pfn is crap in dma_direct_mmap then the dma_addr_t passed in is
>>>> crap, as it is derived from that.  What is the caller, and how is
>>>> this triggered?
>>>
>>>
>>> Ok, to summarize, commit 2bef9aed6f0e ("usb: usbfs: correct kernel->user
>>> page attribute mismatch") changed a call from remap_pfn_range() to
>>> dma_mmap_coherent() for usb data buffers being sent from userspace.
>>
>> I only need to look at the commit for 3 seconds to tell you that it is
>> completely buggy.  While using dma_mmap_coherent is fundamentally the
>> right thing and absolutely required for dma_alloc_* allocations, USB
>> also uses it's own local gen pool allocator or plain kmalloc for not
>> DMA capable controller.  This need to use remap_pfn_range.  I'm pretty
>> sure you hit one of those cases.
>>
>> The logic should be something like:
>>
>> 	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
>> 		remap_pfn_range()
>> 	else
>> 		dma_mmap_coherent()
> 
> Ok, that's simple enough, patch is below.
> 
> Jeremy, any objection to this change?

No, thats fine but since I just translated usb_alloc_coherent() to 
dma_map_coherent in my not fully away head. Putting this as 
"usb_map_cohernet()" sort of makes more sense.


> 
> thanks,
> 
> greg k-h
> 
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index b9db9812d6c5..d93d94d7ff50 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -251,9 +251,19 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>   	usbm->vma_use_count = 1;
>   	INIT_LIST_HEAD(&usbm->memlist);
>   
> -	if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle, size)) {
> -		dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
> -		return -EAGAIN;
> +	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
> +		if (remap_pfn_range(vma, vma->vm_start,
> +				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
> +				    size, vma->vm_page_prot) < 0) {
> +			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
> +			return -EAGAIN;
> +		}
> +	} else {
> +		if (dma_mmap_coherent(hcd->self.sysdev, vma, mem, dma_handle,
> +				      size)) {
> +			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
> +			return -EAGAIN;
> +		}
>   	}
>   
>   	vma->vm_flags |= VM_IO;
> 

