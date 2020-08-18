Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F68AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5A6206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597758628;
	bh=omiWsQfnzSBaf81C+C5v56nWimMqUyxwiQky0T6QpcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqkjItJsy/gac17QIOFEWtijh4Lqy52JwOlFUtdZswuAhW1IAtFQbjjQZn4RGcUSn
	 AHkWR1XKH54tLvIfhiARXvxk1hny1VBMSqURcP4OVbD5YMzNtkOMmfRKZSpaO0iAh8
	 FoRmwIwIgEBVH4EzqQl7CABCBVJaxMYvaJOvXgxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHRNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHRNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:50:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63D4206DA;
        Tue, 18 Aug 2020 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597758622;
        bh=omiWsQfnzSBaf81C+C5v56nWimMqUyxwiQky0T6QpcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbqRxEerJGafXIATjU+Q/2wDTKtKmbe6ixV3RQrJVo6WtjJNhgykwBkVj9bM6o/MZ
         1UojFmy5fWQvESZVLPaeZhTCj2sq5KMNAtNvQK9A0rGVCmpVaYzKJZ9liMEIzFB1Jh
         fsHgRoNgWVorHmarCEMu0aFtYF+Zn28sMyOoxV5Q=
Date:   Tue, 18 Aug 2020 15:50:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200818135045.GA495837@kroah.com>
References: <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils>
 <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
 <20200727193512.GA236164@kroah.com>
 <alpine.LSU.2.11.2008052221440.8716@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008052221440.8716@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:46:12PM -0700, Hugh Dickins wrote:
> On Mon, 27 Jul 2020, Greg KH wrote:
> > 
> > Linus just pointed me at this thread.
> > 
> > If you could run:
> > 	echo -n 'module xhci_hcd =p' > /sys/kernel/debug/dynamic_debug/control
> > and run the same workload to see if anything shows up in the log when
> > xhci crashes, that would be great.
> 
> Thanks, I tried that, and indeed it did have a story to tell:
> 
> ep 0x81 - asked for 16 bytes, 10 bytes untransferred
> ep 0x81 - asked for 16 bytes, 10 bytes untransferred
> ep 0x81 - asked for 16 bytes, 10 bytes untransferred
>    a very large number of lines like the above, then
> Cancel URB 00000000d81602f7, dev 4, ep 0x0, starting at offset 0xfffd42c0
> // Ding dong!
> ep 0x81 - asked for 16 bytes, 10 bytes untransferred
> Stopped on No-op or Link TRB for slot 1 ep 0
> xhci_drop_endpoint called for udev 000000005bc07fa6
> drop ep 0x81, slot id 1, new drop flags = 0x8, new add flags = 0x0
> add ep 0x81, slot id 1, new drop flags = 0x8, new add flags = 0x8
> xhci_check_bandwidth called for udev 000000005bc07fa6
> // Ding dong!
> Successful Endpoint Configure command
> Cancel URB 000000006b77d490, dev 4, ep 0x81, starting at offset 0x0
> // Ding dong!
> Stopped on No-op or Link TRB for slot 1 ep 2
> Removing canceled TD starting at 0x0 (dma).
> list_del corruption: prev(ffff8fdb4de7a130)->next should be ffff8fdb41697f88,
>    but is 6b6b6b6b6b6b6b6b; next(ffff8fdb4de7a130)->prev is 6b6b6b6b6b6b6b6b.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> RIP: 0010:__list_del_entry_valid+0x8e/0xb0
> Call Trace:
>  <IRQ>
>  handle_cmd_completion+0x7d4/0x14f0 [xhci_hcd]
>  xhci_irq+0x242/0x1ea0 [xhci_hcd]
>  xhci_msi_irq+0x11/0x20 [xhci_hcd]
>  __handle_irq_event_percpu+0x48/0x2c0
>  handle_irq_event_percpu+0x32/0x80
>  handle_irq_event+0x4a/0x80
>  handle_edge_irq+0xd8/0x1b0
>  handle_irq+0x2b/0x50
>  do_IRQ+0xb6/0x1c0
>  common_interrupt+0x90/0x90
>  </IRQ>
> 
> Info provided for your interest, not expecting any response.
> The list_del info in there is non-standard, from a patch of mine:
> I find hashed addresses in debug output less than helpful.

Thanks for this, that is really odd.

> > 
> > Although if you are using an "older version" of the driver, there's not
> > much I can suggest except update to a newer one :)
> 
> Yes, I was reluctant to post any info, since really the ball is at our
> end of the court, not yours. I did have a go at bringing in the latest
> xhci driver instead, but quickly saw that was not a sensible task for
> me. And I did scan the git log of xhci changes (especially xhci-ring.c
> changes): thought I saw a likely relevant and easily applied fix commit,
> but in fact it made no difference here.
> 
> I suspect it's in part a hardware problem, but driver not recovering
> correctly. I've replaced the machine (but also noticed that the same
> crash has occasionally been seen on other machines). I'm sure it has
> no relevance to this unlock_page() thread, though it's quite possible
> that it's triggered under stress, and Linus's changes allowed greater
> stress.

I will be willing to blame hardware problems for this as well, but will
save this report in case something else shows up in the future, thanks!

greg k-h
