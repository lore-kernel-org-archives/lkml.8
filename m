Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616E120786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZYrbaDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgHZKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgHZKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:01:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:01:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m71so724151pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lN7CDYsBp+g8H+Q27SUJ+E2mec/tKF8dfPsVSHDg050=;
        b=rZYrbaDKZEGSb9NrM2Wt0vKPzu5pSLr7Z4soaF4BK4oG6IipXyLFdENSTzR4AXtYBp
         L9wZEWqNiqlq+e1Ehqss9bk8toyUAh/MRXvdjVU41UmfjkIgOL/Nl5nYwY56g+5OtCXD
         1VduYt2QKNS+wORnDVcOEmFtpCMlsdM5TU7WADFxW/w0ZxNJLSgJgd1vtaN5ziSTYERh
         qrh2gko/0nAWQ1FnuPVeqNhihUO4Vi7+glLJ6C3Pp9lQ8K1jlDB8aW7JSpDS2FgDeOOF
         9oamUieaJr3PetzWIJeYJCYnvbEM1IMuunwNh9GXFGkXDPE04lA225VhJBGuHhoI1z6V
         cqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lN7CDYsBp+g8H+Q27SUJ+E2mec/tKF8dfPsVSHDg050=;
        b=kdEJjiH70OKAq+g+jErybiHRBolGRRYkSEXlDktSrImVL+xXq3fjcBSB68FqZHnuF2
         C4IngypyKdn2LEn0OBepUHQSpcAbOabQNlhu4nBbu6OQ/SDBGffQIqR7cZGYHFjWqBxc
         VnVP9kiUL8yy9d0sWRuvNxhUhGZkY8zwI4qg1kA2DpO7AZ7GoObfzZ1O7t7bHsC4a8xI
         5NYMzkdZRL2o5SysBrQe/A3a+HtHPdM0tFyGptaZAsSu6DA8tAKLfwY/OO9WqsmU93So
         Wsz9x5c5RjsrUh8gmLMRWeOFXyKR8j7KZPcsytLTFrNWLMhBhVsrfG4+2qXleBJ9/MVd
         3Dcg==
X-Gm-Message-State: AOAM5310GcDK96awuLxXuIi5DdWBaBgMInMhmc0mL8bXx4LOn5OwdA2v
        99G0/4V2lSXvphP8KB2iDqY=
X-Google-Smtp-Source: ABdhPJxYhjBzb/1wST94Ldy6U50tkVIofIqQYck5r6/B+ywfwdF7ykYwG15AippqtuGIGa8U2xmnKg==
X-Received: by 2002:aa7:8490:: with SMTP id u16mr5709733pfn.258.1598436077192;
        Wed, 26 Aug 2020 03:01:17 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o2sm1762049pjh.4.2020.08.26.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 03:01:16 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:01:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200826100113.GA8849@jagdpanzerIV.localdomain>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfi1ls2g.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/26 10:45), John Ogness wrote:
> On 2020-08-24, John Ogness <john.ogness@linutronix.de> wrote:
> > @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> >  		goto fail;
> >  	}
> >  
> > +	/*
> > +	 * New data is about to be reserved. Once that happens, previous
> > +	 * descriptors are no longer able to be extended. Finalize the
> > +	 * previous descriptor now so that it can be made available to
> > +	 * readers (when committed).
> > +	 */
> > +	desc_finalize(desc_ring, DESC_ID(id - 1));
> > +
> >  	d = to_desc(desc_ring, id);
> >  
> >  	/*
> 
> Apparently this is not enough to guarantee that past descriptors are
> finalized. I am able to reproduce a scenario where the finalization of a
> certain descriptor never happens. That leaves the descriptor permanently
> in the reserved queried state, which prevents any new records from being
> created. I am investigating.

Good to know. I also run into problems:
- broken dmesg (and broken journalctl -f /dev/kmsg poll) and broken
  syslog read

$ strace dmesg

...
openat(AT_FDCWD, "/dev/kmsg", O_RDONLY|O_NONBLOCK) = 3
lseek(3, 0, SEEK_DATA)                  = 0
read(3, 0x55dda8c240a8, 8191)           = -1 EAGAIN (Resource temporarily unavailable)
close(3)                                = 0
syslog(10 /* SYSLOG_ACTION_SIZE_BUFFER */) = 524288
mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f43ea847000
syslog(3 /* SYSLOG_ACTION_READ_ALL */, "", 524296) = 0
munmap(0x7f43ea847000, 528384)          = 0
...

	-ss
