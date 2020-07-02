Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66AE2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGBCDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgGBCDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:03:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355F2207E8;
        Thu,  2 Jul 2020 02:03:18 +0000 (UTC)
Date:   Wed, 1 Jul 2020 22:03:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     rananta@codeaurora.org
Cc:     mingo@redhat.com, psodagud@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: Tracing: rb_head_page_deactivate() caught in an infinite loop
Message-ID: <20200701220316.1baf0a50@oasis.local.home>
In-Reply-To: <6f84f449a6951d47e6cbab40bf898a1f@codeaurora.org>
References: <6f84f449a6951d47e6cbab40bf898a1f@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020 10:07:06 -0700
rananta@codeaurora.org wrote:

> Hi Steven and Mingo,
> 

Hi Raghavendra,


> While trying to adjust the buffer size (echo <size> > 
> /sys/kernel/debug/tracing/buffer_size_kb), we see that the kernel gets 
> caught up in an infinite loop
> while traversing the "cpu_buffer->pages" list in 
> rb_head_page_deactivate().
> 
> Looks like the last node of the list could be uninitialized, thus 
> leading to infinite traversal. From the data that we captured:
> 000|rb_head_page_deactivate(inline)
>      |  cpu_buffer = 0xFFFFFF8000671600 = 
> kernel_size_le_lo32+0xFFFFFF652F6EE600 -> (
> ...
>      |    pages = 0xFFFFFF80A909D980 = 
> kernel_size_le_lo32+0xFFFFFF65D811A980 -> (
>      |      next = 0xFFFFFF80A909D200 = 
> kernel_size_le_lo32+0xFFFFFF65D811A200 -> (
>      |        next = 0xFFFFFF80A909D580 = 
> kernel_size_le_lo32+0xFFFFFF65D811A580 -> (
>      |          next = 0xFFFFFF8138D1CD00 = 
> kernel_size_le_lo32+0xFFFFFF6667D99D00 -> (
>      |            next = 0xFFFFFF80006716F0 = 
> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>      |              next = 0xFFFFFF80006716F0 = 
> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>      |                next = 0xFFFFFF80006716F0 = 
> kernel_size_le_lo32+0xFFFFFF652F6EE6F0 -> (
>      |                  next = 0xFFFFFF80006716F0 = 
> kernel_size_le_lo32+0xFFFFFF652F6EE6F0,
> 
> Wanted to check with you if there's any scenario that could lead us into 
> this state.
> 
> Test details:
> -- Arch: arm64
> -- Kernel version 5.4.30; running on Andriod
> -- Test case: Running the following set of commands across reboot will 
> lead us to the scenario
> 
>    atrace --async_start -z -c -b 120000 sched audio irq idle freq
>    < Run any workload here >
>    atrace --async_dump -z -c -b 1200000 sched audio irq idle freq > 
> mytrace.trace
>    atrace --async_stop > /dev/null
>    echo 150000 > /sys/kernel/debug/tracing/buffer_size_kb
>    echo 200000 > /sys/kernel/debug/tracing/buffer_size_kb
>    reboot
> 
> Repeating the above lines across reboots would reproduce the issue.
> The "atrace" or "echo" would just get stuck while resizing the buffer 
> size.

What do you mean repeat across reboots? If it doesn't happen it wont
ever happen, but if you reboot it may have it happen again?

> I'll try to reproduce the issue without atrace as well, but wondering 
> what could be the reason for leading us to this state.

I haven't used arm lately, and I'm unfamiliar with atrace. So I don't
really know what is going on. If you can reproduce this with just a
shell script accessing the ftrace files, that would be much more useful.

Thanks,

-- Steve
