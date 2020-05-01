Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E0524957
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgEAPgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbgEAPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:36:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53DA130E;
        Fri,  1 May 2020 08:36:21 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050AD3F68F;
        Fri,  1 May 2020 08:36:19 -0700 (PDT)
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     git@thegavinli.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        stern@rowland.harvard.edu, linux-arm-kernel@lists.infradead.org
References: <20200430211922.929165-1-jeremy.linton@arm.com>
 <20200501070500.GA887524@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1ce8224-db38-c0c6-02c0-2032f4165903@arm.com>
Date:   Fri, 1 May 2020 16:36:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501070500.GA887524@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 8:05 am, Greg KH wrote:
> On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
>> On arm64, and possibly other architectures, requesting
>> IO coherent memory may return Normal-NC if the underlying
>> hardware isn't coherent. If these pages are then
>> remapped into userspace as Normal, that defeats the
>> purpose of getting Normal-NC, as well as resulting in
>> mappings with differing cache attributes.
> 
> What is "Normal-NC"?
> 
>> In particular this happens with libusb, when it attempts
>> to create zero-copy buffers as is used by rtl-sdr, and
> 
> What is "rtl-sdr"
> 
>> maybe other applications. The result is usually
>> application death.
> 
> So is this a new problem?  Old problem?  Old problem only showing up on
> future devices?  On current devices?  I need a hint here as to know if
> this is a bugfix or just work to make future devices work properly.
> 
>>
>> If dma_mmap_attr() is used instead of remap_pfn_range,
>> the page cache/etc attributes can be matched between the
>> kernel and userspace.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/usb/core/devio.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
>> index 6833c918abce..1e7458dd6e5d 100644
>> --- a/drivers/usb/core/devio.c
>> +++ b/drivers/usb/core/devio.c
>> @@ -217,6 +217,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>>   {
>>   	struct usb_memory *usbm = NULL;
>>   	struct usb_dev_state *ps = file->private_data;
>> +	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
>>   	size_t size = vma->vm_end - vma->vm_start;
>>   	void *mem;
>>   	unsigned long flags;
>> @@ -250,9 +251,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>>   	usbm->vma_use_count = 1;
>>   	INIT_LIST_HEAD(&usbm->memlist);
>>   
>> -	if (remap_pfn_range(vma, vma->vm_start,
>> -			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
>> -			size, vma->vm_page_prot) < 0) {
>> +	if (dma_mmap_attrs(hcd->self.sysdev, vma, mem, dma_handle, size, 0)) {
> 
> Given that this code has not changed since 2016, how has no one noticed
> this issue before?

They have. Here's where the most recent one in my inbox ended, which has 
breadcrumbs to a couple more:

https://lore.kernel.org/linux-arm-kernel/20190808130525.GA1756@kroah.com/

Note the author ;)

 From memory, all the previous attempts wound up getting stuck on the 
subtlety that buffers from hcd_alloc() may or may not actually have come 
from the DMA API. Since then, the localmem_pool rework has probably 
helped a bit, but I'm not sure we've ever really nailed down whether 
kmalloc()ed buffers from PIO-mode controllers (i.e. the !hcd_uses_dma() 
case) can end up down this devio path.

Robin.
