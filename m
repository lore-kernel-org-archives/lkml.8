Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4191A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbgHQSY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:24:26 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:49379 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390940AbgHQSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:24:09 -0400
IronPort-SDR: G2ANti31s1ZU3FYJ6sf/ZgXAJVGXwuVQq/vPABPgKPkYKWMFO/PQtujA7EAjUglvGAOrG3jXth
 AkBPbSgyOZ5Wx7TN5U5THEZDhb6Suv0H1d/jPWAAw1J4JAoh+UvIUteRHAWziV4JtrtezVPiov
 7ExiGnxoohP5ayNiZ7MrTGPUBe/8cDwB7uCJfPYlSfpqBQE4WvUBFX4qc3iGVuHRqvEYv3A5X4
 iOGL8mwKmYhtoy39DmnbH99sAfGfqZqPAVxsF3XCNYxvprhzDEdVAictGRUPVIm8eI/F46wPAI
 uGw=
X-IronPort-AV: E=Sophos;i="5.76,324,1592899200"; 
   d="scan'208";a="52111682"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 17 Aug 2020 10:24:07 -0800
IronPort-SDR: ToVR6YUYiFLED4f7TyLPCb76YYE4RyQYIkb/RVKa+y2NJZJJc9Br2Nbxt7IxP04SB4VuZZ8qYz
 qFUWSxePybGpHXN0v3Z0GlxrAt+S8x2hyXQKXX+sZPnaV9MOcCl6NB9op+D/hXRv/9zl65mk82
 95NsJRREfN0cr3z+uR4c2PY4WxBaf8jPFTwGNuCRjSKgEJb76NRmDcMluBPDOJNW5i4p2oA+jM
 ofaL9IHmaArtglsagpqQ+h3gx84cktLw5RmkkZ1B55lDuo8P2eGY4DpZ9Sq8dLmJPlIl8ato+Y
 s7U=
Subject: Re: PROBLEM: Long Workqueue delays.
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-usb@vger.kernel.org>,
        "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
 <20200817115744.GA3985908@kroah.com>
From:   Jim Baxter <jim_baxter@mentor.com>
Message-ID: <57a7841d-86e3-b6df-1488-a252a68a9ee0@mentor.com>
Date:   Mon, 17 Aug 2020 19:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817115744.GA3985908@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 12:57, Greg KH wrote:
> On Mon, Aug 17, 2020 at 12:40:03PM +0100, Jim Baxter wrote:
>> We have issues with the workqueue of the kernel overloading the CPU 0 
>> when we we disconnect a USB stick.
>>
>> This results in other items on the shared workqueue being delayed by
>> around 6.5 seconds with a default kernel configuration and 2.3 seconds
>> on a config tailored for our RCar embedded platform.
>>
> 
> Is this data really flushed out to the device?
> 
I am unsure if the delay is due to a single system or a combination of memory,
usb or filesystem operations, the delay also occurs if the device is mounted
as ro and using the sync option.

Using umount stops the issue occurring but is unfortunately not guaranteed in
our particular system.

>> - Disconnect the USB stick:
>> [ 1551.796792] usb 2-1: USB disconnect, device number 2
>> [ 1558.625517] DELAY: 6782
>>
>>
>> The Delay output 6782 is in milliseconds.
> 
> What USB workqueue is taking so long?> 
> The one trying to deal with the filesystem flushing out the data that it
> can't do now that the device is removed?  :)
> 
From my analysis it is the hub_event workqueue shown to be using most of the CPU,
the kworker/0:1+usb thread uses around 98% of the CPU.

I have traced the workqueue:workqueue_queue_work function while unplugging the USB
but not found a particular workqueue function being called a lot.

Using perf Iidentified the hub_events workqueue was spending a lot of time in
invalidate_partition(), I have included a cut down the captured data from perf in
[2] which shows the additional functions where the kworker spends most of its time.


I realise that not unmounting the USB stick is not ideal, though I wonder what 
additional work is done when unplugging the USB stick compared to unmounting it.
I guess it may be waiting for a time-out during the operation without the unmount.


Thanks,
Jim Baxter

> thanks,
> 
> greg k-h
> 

[2] perf trace:
    95.22%     0.00%  kworker/0:2-eve  [kernel.kallsyms]
    |
    ---ret_from_fork
       kthread
       worker_thread
       |          
        --95.15%--process_one_work
		  |          
		   --94.99%--hub_event
			 |          
			  --94.99%--usb_disconnect
			  <snip>
				|  
				--94.90%--invalidate_partition
				   __invalidate_device
				   |          
				   |--64.55%--invalidate_bdev
				   |  |          
				   |   --64.13%--invalidate_mapping_pages
				   |     |          
				   |     |--24.09%--invalidate_inode_page
				   |     |   |          
				   |     |   --23.44%--remove_mapping
				   |     |     |          
				   |     |      --23.20%--__remove_mapping
				   |     |        |          
				   |     |         --21.90%--arch_local_irq_restore
				   |     |          
				   |     |--22.44%--arch_local_irq_enable
				   |          
					--30.35%--shrink_dcache_sb 
					<snip>
					  |      
					  --30.17%--truncate_inode_pages_range
