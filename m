Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560EC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F5D20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgBQOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:50:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgBQOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:50:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23A52B47D;
        Mon, 17 Feb 2020 14:50:17 +0000 (UTC)
Date:   Mon, 17 Feb 2020 15:50:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200217145016.7r6b7i5o6tqkaa2x@pathway.suse.cz>
References: <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
 <20200205110522.GA456@jagdpanzerIV.localdomain>
 <87wo919grz.fsf@linutronix.de>
 <20200214155639.m5yp3rd2t3vdzfj7@pathway.suse.cz>
 <87blpxbh62.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blpxbh62.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-02-17 12:13:25, John Ogness wrote:
> On 2020-02-14, Petr Mladek <pmladek@suse.com> wrote:
> >> I oversaw that devkmsg_open() setup a printk_record and so I did not
> >> see to add the extra NULL initialization of text_line_count. There
> >> should be be an initializer function/macro to avoid this danger.
> >> 
> >> John Ogness
> >> 
> >> The quick fixup:
> >> 
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index d0d24ee1d1f4..5ad67ff60cd9 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
> >>  	user->record.text_buf_size = sizeof(user->text_buf);
> >>  	user->record.dict_buf = &user->dict_buf[0];
> >>  	user->record.dict_buf_size = sizeof(user->dict_buf);
> >> +	user->record.text_line_count = NULL;
> >
> > The NULL pointer hidden in the structure also complicates the code
> > reading. It is less obvious when the same function is called
> > only to get the size/count and when real data.
> 
> OK.
> 
> > I played with it and created extra function to get this information.
> >
> > In addition, I had problems to follow the code in
> > record_print_text_inline(). So I tried to reuse the new function
> > and the existing record_printk_text() there.
> >
> > Please, find below a patch that I ended with. I booted a system
> > with this patch. But I guess that I actually did not use the
> > record_print_text_inline(). So, it might be buggy.
> 
> Yes, there are several bugs. But I see where you want to go with this:
> 
> - introduce prb_count_lines() to handle line counting
> 
> - introduce prb_read_valid_info() for only reading meta-data and getting
>   the line count
> 
> - also use prb_count_lines() internally

In addition, I would like share the code between
record_print_text_inline() and record_print_text().

They both do very similar thing and the logic in far from
trivial.

Alternative solution would be to get rid of record_print_text()
and use record_print_text_inline() everywhere. It will have some
advantages:

  + _inline() variant will get real testing
  + no code duplication
  + saving the extra buffer also in console, sysfs, and devkmsg interface.


> I will include these changes in v2. I will still introduce the static
> inlines to initialize records because readers and writers do it
> differently.

Sounds good.

Best Regards,
Petr
