Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC01C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A963220789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHRKzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:55:02 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:2028 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRKy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:54:59 -0400
IronPort-SDR: WlyE8QrVPyGOa90CAF0uAqRrsVrjRuh/1EAcRrGW3vpckos3KO6sDmrVqJkLHxay90J6KFYv0k
 fNmMFDqBc7+L+DWEvWC78a1ubUp+kol8mlpoe1KdK7LYC4cjcOQPadzBBOJdCle8zagNSvSMqP
 cjP0/ARzBZpfGqCqFewwDgRjiPx1kOpWt6lh8Y/v/84RlBTRlXbcFAMEFc7LGGWarnrU4wGXNu
 c+9Xwcz4TJY8Ijenaq3aT4EEwi18+gfZTjCp2U9FV/JDo4Krvqx6yTuFwoZPMEVj2UPWGHvEXp
 YY8=
X-IronPort-AV: E=Sophos;i="5.76,327,1592899200"; 
   d="scan'208";a="52035206"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 18 Aug 2020 02:54:57 -0800
IronPort-SDR: l6vG8IyywSfuGOUGMYKwnlSW55Izkbe8QU9xRXxWDhtrwhYh+vp6bo/gtoZ0S8YTOkXPPlESvD
 H1tLMeBNgHyyYbGTX+XKVXC3yZ68tUeDl1Pj2cOd5Ps4KDfU/38v01HbPF8nLzROeZihWyeLHG
 ocNLR8tw9hxU/QUduVhqaTXdyeBBBHFWNXqfCSpdllgjfmdo7fLpplJITtWrhOhsP04j2ImFt3
 4V/Hy+5RVt0IBikNv/FAqwBBDNRTt13njv62t6SjMPYEfvELZfr5ZEPFGNPYFhqWwDku0rpYSg
 XEc=
From:   Jim Baxter <jim_baxter@mentor.com>
Subject: Re: PROBLEM: Long Workqueue delays.
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-usb@vger.kernel.org>,
        "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
 <20200817115744.GA3985908@kroah.com>
 <57a7841d-86e3-b6df-1488-a252a68a9ee0@mentor.com>
 <20200817184753.GA120209@rowland.harvard.edu>
Message-ID: <1838f2c3-7915-9e5b-3112-6b082b945410@mentor.com>
Date:   Tue, 18 Aug 2020 11:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817184753.GA120209@rowland.harvard.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 19:47, Alan Stern wrote:
> 
> Unplugging a R/W USB drive without unmounting it first is a great way to 
> corrupt the data.
> 
Thank you, post development we will only mount the USB stick as R/O.

>> Using perf Iidentified the hub_events workqueue was spending a lot of time in
>> invalidate_partition(), I have included a cut down the captured data from perf in
>> [2] which shows the additional functions where the kworker spends most of its time.
> 
> invalidate_partition() is part of the block layer, not part of USB.  It 
> gets called whenever a drive is removed from the system, no matter what 
> type of drive it is.  You should ask the people involved in that 
> subsystem why it takes so long.
> 

I included the linux-mm list but missed the filesystem, I will ask the question
to the linux-fsdevel too.

>> I realise that not unmounting the USB stick is not ideal, though I wonder what 
>> additional work is done when unplugging the USB stick compared to unmounting it.
> 
> Unmounting a drive flushes all the dirty buffers from memory back to the 
> drive.  Obviously that can't be done if the drive is unplugged first.
> 
> As far as the USB subsystem is concerned, exactly the same amount of 
> work is done during disconnect regardless of whether or not the drive is 
> mounted.  (In fact, the USB subsystem doesn't even know whether a drive 
> is mounted; that concept is part of the block and filesystem layers.)
>>> I guess it may be waiting for a time-out during the operation without the unmount.
> 
> That seems very unlikely.  When a USB device gets unplugged the system 
> realizes it.  Any I/O meant for that device is immediately cancelled; 
> there are no timeouts.
> 
> (Okay, not strictly true; there is a fraction-of-a-second timeout during 
> which the system waits to see whether the disconnect was permanent or 
> just a temporary glitch.  But you're talking about 6-second long 
> delays.)
> 

Thank you, no I don't expect that to cause the issue and it is very likely the delay
is in another subsystem.

Regards,
Jim Baxter


> Alan Stern
> 
