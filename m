Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D33C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2F206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kooq3mZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBNBlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:41:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37427 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgBNBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:41:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so3239360pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 17:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2ojux6FXooiV+cY1VHCB4d8TJTAMOsLW/ga74jHrnI=;
        b=Kooq3mZ8zJw5wVcmKrFeSvbQ95GWdZbqTW/U9u066iso/gdBz9rgicyPA6gmmPS07w
         3ZCwwgy7iu7uSjkho0/9aUisW7DTRu+xUXImwlzqGMmYCkVhdwvl6OFrFcQl7hf0SiJ7
         6IvN/RiKcRoA8viEwDJIJwmwN1+Jp/I3jAvgqQuGelonzOtapFGfdF92tLKmMsDn+0IO
         oJ/8Uu6N7IFVko6hFD36GVdYHveIGlr4/sl0XX2MjLyqmR136JmxYKJzoqOol7D3r6fX
         oBC533l652zJFSVFb4TJKQscEjF1RIzGfJTIN/ZZeh8yJrJPITX00SCLE9pxb6EM+NV9
         9JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2ojux6FXooiV+cY1VHCB4d8TJTAMOsLW/ga74jHrnI=;
        b=mXuRMn4H6eFwRDmAKRzJnsZkFQ0kIU51LbQ679IfZT4PPz4HjJV1Fq5HTBTkiRujTq
         fAWedKWYtSdivKSXSUZ0Enhvz3jXhHMtQ0MojaqnAyw2yzJRzneOzOkaeZGzUiIzmCVm
         ome/tPCxBKUCN0HxoFMIBx5N4yWUbYJjlfJUSwK6qyDdMzCuOJs35h2H3IMcpRw0nh73
         jIugmILnj2nUzEeMeOSxvCcNsaxosqA5eZrURIbNqJ4KH3ol8YHTBGPFXwbxtB0fdBme
         K+5iucxic7sKdlsGVoQjr65Mqsesd9E8IrH8Cm7M/SSxd+NDlvdg5+kitbSNw00QQqqm
         OqQg==
X-Gm-Message-State: APjAAAWnXUdKurEcWZVdD2nqXo/VpIk8oaxYqBX/fpcGIrgvCx4tCNrx
        F0BvKwyruaExW+kuC8rUiJM=
X-Google-Smtp-Source: APXvYqxACI5wvy1P+Ss2WDCfxZR2etZcuD5WjozSgkzxkUFlyakumVDXYF9Ju5+WUTLCXGPA4TrqqA==
X-Received: by 2002:a17:902:bf41:: with SMTP id u1mr784632pls.207.1581644476512;
        Thu, 13 Feb 2020 17:41:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id f3sm4612335pga.38.2020.02.13.17.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 17:41:15 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:41:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200214014113.GE36551@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <20200213090757.GA36551@google.com>
 <87v9oarfg4.fsf@linutronix.de>
 <20200213115957.GC36551@google.com>
 <87pneiyv12.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pneiyv12.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/13 23:36), John Ogness wrote:
> >> Here prb_read_valid() was successful, so a record _was_ read. The
> >> kerneldoc for the prb_read_valid() says:
> >
> > Hmm, yeah. That's true.
> >
> > OK, something weird...
> >
> > I ran some random printk-pressure test (mostly printks from IRQs;
> > + some NMI printk-s, but they are routed through nmi printk-safe
> > buffers; + some limited number of printk-safe printk-s, routed
> > via printk-safe buffer (so, once again, IRQ); + user-space
> > journalctl -f syslog reader), and after the test 'cat /dev/kmsg'
> > is terminally broken
> >
> > [..]
> > cat /dev/kmsg
> > cat: /dev/kmsg: Broken pipe
>
> In mainline you can have this "problem" as well. Once the ringbuffer has
> wrapped, any read to a newly opened /dev/kmsg when a new message arrived
> will result in an EPIPE. This happens quite easily once the ringbuffer
> has wrapped because each new message is overwriting the oldest message.

Hmm. Something doesn't add up.

Looking at the numbers, both r->info->seq and prb_first_seq(prb)
do increase, so there are new messages in the ring buffer

                           u->seq    r->seq    prb_first_seq
[..]
cat: devkmsg_read() error 1981080   1982633   1981080
cat: devkmsg_read() error 1981080   1982633   1981080
cat: devkmsg_read() error 1981095   1982652   1981095
cat: devkmsg_read() error 1981095   1982652   1981095
cat: devkmsg_read() error 1981095   1982652   1981095
[..]

but 'cat' still wouldn't read anything from the logbuf - EPIPE.

NOTE: I don't run 'cat /dev/kmsg' during the test. I run the test first,
then I run 'cat /dev/kmsg', after the test, when printk-pressure is gone.

I can't reproduce it with current logbuf. 'cat' reads from /dev/kmsg after
heavy printk-pressure test. So chances are some loggers can also experience
problems. This might be a regression.

> > ...
> > systemd-journal: devkmsg_read() error 1979281 1982465 1980933
> > systemd-journal: corrected seq 1982465 1982465
> > cat: devkmsg_read() error 1980987 1982531 1980987
> > cat: corrected seq 1982531 1982531
> > cat: devkmsg_read() error 1981015 1982563 1981015
> > cat: corrected seq 1982563 1982563
>
> The situation with a data-less record is the same as when the ringbuffer
> wraps: cat is hitting that EPIPE. But re-opening the file descriptor is
> not going to help because it will not be able to get past that data-less
> record.

So maybe this is the case with broken 'cat' on my system?

> We could implement it such that devkmsg_read() will skip over data-less
> records instead of issuing an EPIPE. (That is what dmesg does.) But then
> do we need EPIPE at all? The reader can see that is has missed records
> by tracking the sequence number, so could we just get rid of EPIPE? Then
> cat(1) would be a great tool to view the raw ringbuffer. Please share
> your thoughts on this.

Looking at systemd/src/journal/journald-kmsg.c : server_read_dev_kmsg()
-EPIPE is just one of the erronos they handle, nothing special. Could it
be the case that some other loggers would have special handling for EPIPE?
I'm not sure, let's look around.

I'd say that EPIPE removal looks OK to me. But before we do that, I'm
not sure that we have clear understanding of 'cat /dev/kmsg' behaviour
change.

> On a side note (but related to data-less records): I hacked the
> ringbuffer code to inject data-less records at various times in order to
> verify your report. And I stumbled upon a bug in the ringbuffer, which
> can lead to an infinite loop in console_unlock(). The problem occurs at:
> 
>     retry = prb_read_valid(prb, console_seq, NULL);
> 
> which will erroneously return true if console_seq is pointing to a
> data-less record but there are no valid records after it. The following
> patch fixes the bug. And yes, for v2 I have added comments to the
> desc_read_committed() code.

That's great to know!

	-ss
