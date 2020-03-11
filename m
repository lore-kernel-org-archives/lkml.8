Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C384C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22420737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgCKSrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:47:32 -0400
Received: from ale.deltatee.com ([207.54.116.67]:56804 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbgCKSr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:47:28 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jC6O6-0006LQ-9P; Wed, 11 Mar 2020 12:47:27 -0600
To:     "Nath, Arindam" <Arindam.Nath@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
 <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
 <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <214f3ef3-853d-6b0d-0fed-5bb6c1f1de1f@deltatee.com>
Date:   Wed, 11 Mar 2020 12:47:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Shyam-sundar.S-k@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, Sanju.Mehta@amd.com, Arindam.Nath@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-03-11 12:11 p.m., Nath, Arindam wrote:
>> -----Original Message-----
>> From: Logan Gunthorpe <logang@deltatee.com>
>> Sent: Wednesday, March 11, 2020 03:01
>> To: Mehta, Sanju <Sanju.Mehta@amd.com>; jdmason@kudzu.us;
>> dave.jiang@intel.com; allenbh@gmail.com; Nath, Arindam
>> <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
>> k@amd.com>
>> Cc: linux-ntb@googlegroups.com; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
>>
>>
>>
>> On 2020-03-10 2:54 p.m., Sanjay R Mehta wrote:
>>> From: Arindam Nath <arindam.nath@amd.com>
>>>
>>> perf_spad_cmd_send() and perf_msg_cmd_send() return
>>> -EAGAIN after trying to send commands for a maximum
>>> of MSG_TRIES re-tries. But currently there is no
>>> handling for this error. These functions are invoked
>>> from perf_service_work() through function pointers,
>>> so rather than simply call these functions is not
>>> enough. We need to make sure to invoke them again in
>>> case of -EAGAIN. Since peer status bits were cleared
>>> before calling these functions, we set the same status
>>> bits before queueing the work again for later invocation.
>>> This way we simply won't go ahead and initialize the
>>> XLAT registers wrongfully in case sending the very first
>>> command itself fails.
>>
>> So what happens if there's an actual non-recoverable error that causes
>> perf_msg_cmd_send() to fail? Are you proposing it just requeues high
>> priority work forever?
> 
> The intent of the patch is to handle -EAGAIN, since the error code is
> an indication that we need to try again later. Currently there is a very
> small time frame during which ntb_perf should be loaded on both sides
> (primary and secondary) to have XLAT registers configured correctly.
> Failing that the code will still fall through without properly initializing the
> XLAT registers and there is no indication of that either until we have
> actually tried to perform 'echo 0 > /sys/kernel/debug/.../run'.
> 
> With the changes proposed in this patch, we do not have to depend
> on whether the drivers at both ends are loaded within a fixed time
> duration. So we can simply load the driver at one side, and at a later
> time load the driver on the other, and still the XLAT registers would
> be set up correctly.
> 
> Looking at perf_spad_cmd_send() and perf_msg_cmd_send(), if the
> concern is that ntb_peer_spad_read()/ntb_msg_read_sts() fail because
> of some non-recoverable error and we still schedule a high priority
> work, that is a valid concern. But isn't it still better than simply falling
> through and initializing XLAT register with incorrect values?

I don't think it's ever acceptable to get into an infinite loop.
Especially when you're running on the system's high priority work queue...

At the very least schedule a delayed work item to try again in some
number of seconds or something. Essentially just have more retires,
perhaps with longer delays in between.

Falling through and continuing with the wrong values is certainly wrong.
I didn't notice that. If an error occurs, it shouldn't continue, it
should print an error to dmesg and stop.

> 
>>
>> I never really reviewed this stuff properly but it looks like it has a
>> bunch of problems. Using the high priority work queue for some low
>> priority setup work seems wrong, at the very least. The spad and msg
>> send loops also look like they have a bunch of inter-host race condition
>> problems as well. Yikes.
> 
> I am not very sure what the design considerations were when having
> a high priority work queue, but perhaps we can all have a discussion
> on this.

I'd change it. Seems completely wrong to me.

Logan
