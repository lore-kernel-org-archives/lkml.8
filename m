Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E773C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB62222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvgDCrN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgBMMAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:00:01 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55035 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:00:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so2292970pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xnv9vcJaJ4RlveRKToDkYvSVpq7pujagpdh/v4epNFU=;
        b=MvgDCrN6Rt30rPxtVLP6viebK9w3JJ359bCVm42oY401byO1RpR1SfyVW1fORNChy1
         xT/CgOuKHsn6gU8qSn7pR9o/y3HRWLevdwEi2DUcq5eMtUDU2e/lPsnhYUVtuSl33wxu
         68DxPa+lSNwqgFHa5SqImkj1C0tHnulKnghv0fHz4C0fu3X8wK6nm8K4eXlXZG8BPBur
         U80udLDF2WT2KWlw11aajMcdsVwgrbIKjY+hsUlVG6fsjDQ/+GfLD20lMPms5wj65cAP
         FBZ/40HMh/Ma9CIqfqWVL0tjQCpK/PrIm5P8ApVcMMqYMlBqXjdzuTUg7qkp0tQ8Fz7z
         yLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xnv9vcJaJ4RlveRKToDkYvSVpq7pujagpdh/v4epNFU=;
        b=tKksojxykBE5tfp8h0weUH8lyavc0hlRwnK9YU1Mf1ORWt27BdIasfPNLiWB8kNNbM
         rt7Rg4hVMHU9OM8mb1ItMVQqh95UhHmSBMrok15EyzmIvO4AAx0x4ifIVQULfgo7OoqH
         1YxAH1ax42aVAUIfoByUtZD8dNQSQMPd1IVo1Ex+4fLu3aUYOF7wmVJB13DizYYnPQg4
         VV2gXibCUi9Dmr+Vy0GrTKlZAXhiNgF8cOlcYuPKyj8DrXkVFAnW6FzgwIDofCG/Lc5U
         beAI0qTodkRkhNHZ0523AFqjUwFW09wgOZEgApsdnaTVWvPggucJUyPmZG5Ri88D6Dl8
         6/RQ==
X-Gm-Message-State: APjAAAVJHdy9T2cjZkWkReqKQExtGPCf95ahVHF6AXRxdUNDmpHH2KSG
        mEXOYMhiP9tBnP3y3e3SxAw=
X-Google-Smtp-Source: APXvYqzzsUDvn0Nu0CrpQv0rcR200zqrZ1/2L0Iww16mmu5xqpE9XiMfM9AxTfZmf9GzYoZDWf9MeA==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr4879055pjn.87.1581595200123;
        Thu, 13 Feb 2020 04:00:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e4sm2797045pgg.94.2020.02.13.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 03:59:59 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:59:57 +0900
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
Message-ID: <20200213115957.GC36551@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <20200213090757.GA36551@google.com>
 <87v9oarfg4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9oarfg4.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/13 10:42), John Ogness wrote:
> On 2020-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> -	while (user->seq == log_next_seq) {
> >> +	if (!prb_read_valid(prb, user->seq, r)) {
> >>  		if (file->f_flags & O_NONBLOCK) {
> >>  			ret = -EAGAIN;
> >>  			logbuf_unlock_irq();
> >> @@ -890,30 +758,26 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
> >>  
> >>  		logbuf_unlock_irq();
> >>  		ret = wait_event_interruptible(log_wait,
> >> -					       user->seq != log_next_seq);
> >> +					prb_read_valid(prb, user->seq, r));
> >>  		if (ret)
> >>  			goto out;
> >>  		logbuf_lock_irq();
> >>  	}
> >>  
> >> -	if (user->seq < log_first_seq) {
> >> -		/* our last seen message is gone, return error and reset */
> >> -		user->idx = log_first_idx;
> >> -		user->seq = log_first_seq;
> >> +	if (user->seq < r->info->seq) {
> >> +		/* the expected message is gone, return error and reset */
> >> +		user->seq = r->info->seq;
> >>  		ret = -EPIPE;
> >>  		logbuf_unlock_irq();
> >>  		goto out;
> >>  	}
> >
> > Sorry, why doesn't this do something like
> >
> > 	if (user->seq < prb_first_seq(prb)) {
> > 		/* the expected message is gone, return error and reset */
> > 		user->seq = prb_first_seq(prb);
> > 		ret = -EPIPE;
> > 		...
> > 	}
> 
> Here prb_read_valid() was successful, so a record _was_ read. The
> kerneldoc for the prb_read_valid() says:

Hmm, yeah. That's true.

OK, something weird...

I ran some random printk-pressure test (mostly printks from IRQs;
+ some NMI printk-s, but they are routed through nmi printk-safe
buffers; + some limited number of printk-safe printk-s, routed
via printk-safe buffer (so, once again, IRQ); + user-space
journalctl -f syslog reader), and after the test 'cat /dev/kmsg'
is terminally broken

[..]
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
cat /dev/kmsg
cat: /dev/kmsg: Broken pipe
[..]

dmesg works. Reading from /dev/kmsg - doesn't; it did work, however,
before the test.

So I printed seq numbers from devksmg read to a seq buffer and dumped
it via procfs, just seq numbers before we adjust user->seq (set to
r->seq) and after

+                       offt += snprintf(BUF + offt,
+                                       sizeof(BUF) - offt,
+                                       "%s: devkmsg_read() error %llu %llu %llu\n",
+                                       current->comm,
+                                       user->seq,
+                                       r->info->seq,
+                                       prb_first_seq(prb));


...
systemd-journal: devkmsg_read() error 1979235 1979236 1979236
systemd-journal: corrected seq 1979236 1979236
systemd-journal: devkmsg_read() error 1979237 1979243 1979243
systemd-journal: corrected seq 1979243 1979243
systemd-journal: devkmsg_read() error 1979244 1979250 1979250
systemd-journal: corrected seq 1979250 1979250
systemd-journal: devkmsg_read() error 1979251 1979257 1979257
systemd-journal: corrected seq 1979257 1979257
systemd-journal: devkmsg_read() error 1979258 1979265 1979265
systemd-journal: corrected seq 1979265 1979265
systemd-journal: devkmsg_read() error 1979266 1979272 1979272
systemd-journal: corrected seq 1979272 1979272
systemd-journal: devkmsg_read() error 1979272 1979273 1979273
systemd-journal: corrected seq 1979273 1979273
systemd-journal: devkmsg_read() error 1979274 1979280 1979280
systemd-journal: corrected seq 1979280 1979280
systemd-journal: devkmsg_read() error 1979281 1982465 1980933
systemd-journal: corrected seq 1982465 1982465
cat: devkmsg_read() error 1980987 1982531 1980987
cat: corrected seq 1982531 1982531
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981015 1982563 1981015
cat: corrected seq 1982563 1982563
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981080 1982633 1981080
cat: corrected seq 1982633 1982633
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
cat: devkmsg_read() error 1981095 1982652 1981095
cat: corrected seq 1982652 1982652
...


What's up with that user->seq counter?

	-ss
