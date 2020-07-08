Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7990D20773
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594192158;
	bh=rHOulDo124Liq2EGXRwvQ6OiyVaGckCmrxScyta+9xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZVvAhwueQPOsB9kXmnzrEa+TEI6HYbLcj4saP26bwRESgSySSvbDxRRR/V7sLvbV
	 9WpMF7m/tRvXA9LC1SyMbPsYHywIi+xii8zeJQtmW1eYgvmAStx/b6H5xvbgehsAgw
	 1OlhVbR/8VzSkyezlaDn6yQy7rKan8HioaW9rB5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgGHHJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgGHHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:09:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FFF206DF;
        Wed,  8 Jul 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594192156;
        bh=rHOulDo124Liq2EGXRwvQ6OiyVaGckCmrxScyta+9xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3j/u+u9spT8gnCzMCkgwg/K1QFFKQ0rOx8IRsOUdrSDcFpXoFr8vPcWU5adRpKLu
         41xusDKZhTnUZv8c7jDpWivTFwLYZhqQ8A5cxlrl0IL6jH9haKF6BZ1RfPtnPQtR11
         9n9L6L27EEgPwoIhEifE4R8jmy3FXooLo0CbtfFU=
Date:   Wed, 8 Jul 2020 09:09:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: Bug Report High CPU Usage events_power_efficient
Message-ID: <20200708070912.GA351187@kroah.com>
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
 <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
 <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:50:49AM +0300, Martin Zaharinov wrote:
> Add Greg , Florian, Eric to this bug 
> 
> > On 7 Jul 2020, at 22:54, Martin Zaharinov <micron10@gmail.com> wrote:
> > 
> > And this is log from /sys/kernel/debug/tracing/trace
> > 
> > 
> > # entries-in-buffer/entries-written: 32410/32410   #P:64
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> >           <...>-57259 [005] .... 29619.680698: workqueue_execute_start: work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
> >           <...>-57259 [005] .... 29623.811407: workqueue_execute_end: work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
> >           <...>-57259 [005] .... 29623.811410: workqueue_execute_start: work struct 0000000000aeec55: function fb_flashcursor
> >           <...>-57259 [005] .... 29623.811421: workqueue_execute_end: work struct 0000000000aeec55: function fb_flashcursor
> >           <...>-57259 [005] .... 29623.811422: workqueue_execute_start: work struct 00000000a6d382bb: function vmstat_update
> >           <...>-57259 [005] .... 29623.811435: workqueue_execute_end: work struct 00000000a6d382bb: function vmstat_update
> > 
> >> On 7 Jul 2020, at 22:44, Martin Zaharinov <micron10@gmail.com> wrote:
> >> 
> >> the problem is hear with kernel 5.7.7 
> >> 
> >> last work kernel without this problem is 5.6.7
> >> 
> >> hear is more info:
> >> 
> >> cat /proc/57259/stack
> >> root@megacableamarilis:~# cat /proc/57259/stack
> >> [<0>] gc_worker+0x1be/0x380 [nf_conntrack]
> >> [<0>] process_one_work+0x1bc/0x3b0
> >> [<0>] worker_thread+0x4d/0x460
> >> [<0>] kthread+0x10d/0x130
> >> [<0>] ret_from_fork+0x1f/0x30
> >> 
> >> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                            57259 root      28   0       0      0      0 R  69.8   0.0  82:42.14 kworker/5:2+events_power_efficient                                                          
> >> 32 root      21   0       0      0      0 R  31.0   0.0  87:06.33 ksoftirqd/4
> >> 
> >> 
> >> Please help to fix this problem
> >> 
> >>> On 22 Apr 2020, at 15:55, Martin Zaharinov <micron10@gmail.com> wrote:
> >>> 
> >>> Hello Qian and Greg 
> >>> With latest 5.6.x kernel have problem with events_power_efficient 28488 root      28   0       0      0      0 R  95.5   0.0 101:38.19 kworker/2:1+events_power_efficient Process start to load machine after 3-4 hour and load not stop only reboot machine remove process . Server runing on AMD EPIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when machine load over 1G traffic machine locked and only restart fix problem to next load . After move traffic and server stop load process still hear and load server ?
> >>> And after reboot process move to other core .

Have you used 'git bisect' to try to find the offending commit?

Without that, it's going to be hard to help you out here.

thanks,

greg k-h
