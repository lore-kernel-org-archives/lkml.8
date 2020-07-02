Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF20C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E134320780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Omd66MTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGBTuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:50:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54620 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGBTuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:50:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593719454; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=K3B8WGVy41bSlc2yD1RjVh1+IaDG7mzcNGo5djhEYWc=;
 b=Omd66MTQb/www/vLcct4lMGT1+0RCwOqTZq/YcZ8R5ve/WHpFYouL9F+z5twGHfgEtzgNaq8
 aihWEQY2LwklEq3vjd98u9qZiwFGqPMOwuQKslxvC0QqJtJVdBw5df/keG1jAeYo2hh6X0jk
 Ubkjf14rvQY00e1/9tJYhMzwveI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5efe3a9cc4bb4f886d12c72f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 19:50:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F419C433CA; Thu,  2 Jul 2020 19:50:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rananta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B94C5C433C8;
        Thu,  2 Jul 2020 19:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 12:50:50 -0700
From:   rananta@codeaurora.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, psodagud@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: Tracing: rb_head_page_deactivate() caught in an infinite loop
In-Reply-To: <20200701220316.1baf0a50@oasis.local.home>
References: <6f84f449a6951d47e6cbab40bf898a1f@codeaurora.org>
 <20200701220316.1baf0a50@oasis.local.home>
Message-ID: <086e8f3e4a924849fb7f057961df29c2@codeaurora.org>
X-Sender: rananta@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for responding.

On 2020-07-01 19:03, Steven Rostedt wrote:
> On Wed, 01 Jul 2020 10:07:06 -0700
> rananta@codeaurora.org wrote:
> 
>> Hi Steven and Mingo,
>> 
> 
> Hi Raghavendra,
> 
> 
>> While trying to adjust the buffer size (echo <size> >
>> /sys/kernel/debug/tracing/buffer_size_kb), we see that the kernel gets
>> caught up in an infinite loop
>> while traversing the "cpu_buffer->pages" list in
>> rb_head_page_deactivate().
>> 
>> Looks like the last node of the list could be uninitialized, thus
>> leading to infinite traversal. From the data that we captured:
>> 000|rb_head_page_deactivate(inline)
>>      |  cpu_buffer = 0xFFFFFF8000671600 =
>> kernel_size_le_lo32+0xFFFFFF652F6EE600 -> (
>> ...
>>      |    pages = 0xFFFFFF80A909D980 =
>> kernel_size_le_lo32+0xFFFFFF65D811A980 -> (
>>      |      next = 0xFFFFFF80A909D200 =
>> kernel_size_le_lo32+0xFFFFFF65D811A200 -> (
>>      |        next = 0xFFFFFF80A909D580 =
>> kernel_size_le_lo32+0xFFFFFF65D811A580 -> (
>>      |          next = 0xFFFFFF8138D1CD00 =
>> kernel_size_le_lo32+0xFFFFFF6667D99D00 -> (
>>      |            next = 0xFFFFFF80006716F0 =
>> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>>      |              next = 0xFFFFFF80006716F0 =
>> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>>      |                next = 0xFFFFFF80006716F0 =
>> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>>      |                  next = 0xFFFFFF80006716F0 =
>> kernel_size_le_lo32+0xFFFFFF652F6EE6F0,
>> 
>> Wanted to check with you if there's any scenario that could lead us 
>> into
>> this state.
>> 
>> Test details:
>> -- Arch: arm64
>> -- Kernel version 5.4.30; running on Andriod
>> -- Test case: Running the following set of commands across reboot will
>> lead us to the scenario
>> 
>>    atrace --async_start -z -c -b 120000 sched audio irq idle freq
>>    < Run any workload here >
>>    atrace --async_dump -z -c -b 1200000 sched audio irq idle freq >
>> mytrace.trace
>>    atrace --async_stop > /dev/null
>>    echo 150000 > /sys/kernel/debug/tracing/buffer_size_kb
>>    echo 200000 > /sys/kernel/debug/tracing/buffer_size_kb
>>    reboot
>> 
>> Repeating the above lines across reboots would reproduce the issue.
>> The "atrace" or "echo" would just get stuck while resizing the buffer
>> size.
> 
> What do you mean repeat across reboots? If it doesn't happen it wont
> ever happen, but if you reboot it may have it happen again?
> 
Actually, ignore the reboot part. I was able to reproduce with the 
reboot.
>> I'll try to reproduce the issue without atrace as well, but wondering
>> what could be the reason for leading us to this state.
> 
> I haven't used arm lately, and I'm unfamiliar with atrace. So I don't
> really know what is going on. If you can reproduce this with just a
> shell script accessing the ftrace files, that would be much more 
> useful.
> 
I tried to reproduce it without atrace, but couldn't. It's a simple 
wrapper utility
to collect ftraces. You can find the source here:
https://android.googlesource.com/platform/system/extras/+/jb-mr1-dev-plus-aosp/atrace/atrace.c
> Thanks,
> 
> -- Steve
