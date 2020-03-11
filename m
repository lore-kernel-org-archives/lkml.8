Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from foss.arm.com ([217.140.110.172]:51416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgCKQPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:15:35 -0400
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To: "Artem S. Tashkinov" <aros@gmx.com>, Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
 <20200311154328.GA24044@lst.de> <20200311154718.GB24044@lst.de>
 <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <eadd21f1-c618-9523-fa14-e862dfa256ac@arm.com>
Date: Wed, 11 Mar 2020 16:15:31 +0000
MIME-Version: 1.0
In-Reply-To: <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11/03/2020 4:02 pm, Artem S. Tashkinov wrote:
> On 3/11/20 3:47 PM, Christoph Hellwig wrote:
>> And actually one more idea after looking at what slab interactions
>> could exist.  platform_device_register_full frees the dma_mask
>> unconditionally, even if it didn't allocated it, which might lead
>> to weird memory corruption if we hit the failure path.  So let's try
>> something like this, replacing the earlier patch in that file.
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index b230beb6ccb4..04080a8d94e2 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -632,19 +632,6 @@ struct platform_device 
>> *platform_device_register_full(
>>       pdev->dev.of_node_reused = pdevinfo->of_node_reused;
>>
>>       if (pdevinfo->dma_mask) {
>> -        /*
>> -         * This memory isn't freed when the device is put,
>> -         * I don't have a nice idea for that though.  Conceptually
>> -         * dma_mask in struct device should not be a pointer.
>> -         * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>> -         */
>> -        pdev->dev.dma_mask =
>> -            kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
>> -        if (!pdev->dev.dma_mask)
>> -            goto err;
>> -
>> -        kmemleak_ignore(pdev->dev.dma_mask);
>> -
>>           *pdev->dev.dma_mask = pdevinfo->dma_mask;
>>           pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
>>       }
>> @@ -670,7 +657,6 @@ struct platform_device 
>> *platform_device_register_full(
>>       if (ret) {
>>   err:
>>           ACPI_COMPANION_SET(&pdev->dev, NULL);
>> -        kfree(pdev->dev.dma_mask);
>>           platform_device_put(pdev);
>>           return ERR_PTR(ret);
>>       }
>>
> 
> With this patch the system works (I haven't created an initrd, so it
> doesn't completely boot and panics on not being able to mount root fs
> but that's expected).

Yup, a few lines earlier in the log you can see the wdat_wdt driver 
failing in platform_device_add(), which since it called into 
platform_device_register_full() with pdevinfo.dma_mask = 0, will have 
unwound into that kfree() of pdev.dma_mask corrupting the heap.

Robin.

