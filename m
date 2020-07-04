Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E08C2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7q7SjXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGDLhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGDLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:37:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE7C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 04:37:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm21so5530266pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4plqkhvVW/dHuIMMbhq1LQlta+pdw76VHrKkcf+m5iQ=;
        b=o7q7SjXmYnY30eDj0Sa+Ilrh7Nbozwd343h6x09nNYV6HKAPXg5MLJ0YSzSKtG4laz
         lSOAZJ62klEIMeDTY1m80EXHJp2NBqyvadia3ut9igvApRfwDgN10JOCBEKQYGY7GnjO
         6tvFsI+YUxPCZGjS0/rmAJohvDoyuQQAT+RXEvh9Fdj6zFlMOeQGojpMMRYYQCBcwkPa
         055NYk2wCcA3BwJRjCWg1sW/wRNIrW6a31NPaS1Obpwx5TNLZTOJMNsfni9IrBrUbdAw
         mIYVztcCi+e53ph9SnZGE3nDCEdbCJQ46El82W48EQasgmKVxbwMD7Avmzio68xvtF+j
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4plqkhvVW/dHuIMMbhq1LQlta+pdw76VHrKkcf+m5iQ=;
        b=tktK/DPr46mWz8M2eJSS9AAFbtZKq4ZdqAgtDCsWahYxDN5T5urxzMxcxLZkLO3MEf
         lA6jeLotim8lITpEkrDST4cK5++18LfoGiTMWnhIUa3J00fdi967yYjqdbw4Zu+NwNxD
         7YQeIL7TuAyLOWTOadxtveFzO/wB+GFmuqXBdb0TBBG92QABRRRdBzq1RCbaoC6qxpMT
         G+Ff7eeH59BkRx8R0LIKBTjxkpnHkNRriqVXxoOR/xVcqpPqtYmyUYEaB72Y38zSY7+f
         tbZm7VITU8ohrnAqkxsZ9nIk616DtR0XbSVusj4T2yy0OJ/RttuJlCJ6JXdkYPJ31TBe
         KRzg==
X-Gm-Message-State: AOAM533lc0tUEO6sNwpkLVabqGmWE0KRuwxDE/N9iXfWjSzRQCO7cTsD
        d8V6dcbOd5rt9U3+Tbj9OWNmGmteAwAmHa7YF+Q=
X-Google-Smtp-Source: ABdhPJwyL6hejhdOKtLk/8BNlcTJZtRGhcJrJxoAS5Tf95pbjgX8rcextWE547S3/0FtbsgkGF5z2RrY+5rxYa5DJv4=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr16736902pjb.181.1593862650846;
 Sat, 04 Jul 2020 04:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain> <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain> <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain> <20200702054033.GC3450@jagdpanzerIV.localdomain>
 <20200702082008.GE3703480@smile.fi.intel.com> <20200703105302.GC182102@jagdpanzerIV.localdomain>
In-Reply-To: <20200703105302.GC182102@jagdpanzerIV.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 14:37:14 +0300
Message-ID: <CAHp75Vc42k2G5VJDECBQ=HkkMoQq_VX+rpxVrjZHwMyAQ6O7gw@mail.gmail.com>
Subject: Re: UART/TTY console deadlock
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:53 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/07/02 11:20), Andy Shevchenko wrote:
> >
> > I didn't look into this deeply, but my understanding that this is something for
> > special case when you have several UART ports sharing the IRQ (multi-port card)
> > and IRQ even maybe undesirable b/c it will confuse real IRQ handler. I don't
> > remember details, but AFAIR IRQ handler does a busyloop to service as much as
> > possible and in between it may release the lock (again, multi-port UART cards),
> > that's why we better avoid IRQ event in the first place.
> > But it's my pure speculation.
>
> Hmm. Would different IRQ handlers use different UART port structures? ->irq
> might be the only thing they share. Even if they use the same port, we
> keep IRQs disabled on local CPU, and UART port locked. To unlock the UART
> port during IRQ, the handler (on another CPU) first needs to acquire the
> port->lock, which is locked by serial8250_do_startup().

It appears to be a RT kernel related. Don't know the state of affairs
in RT nowadays, but maybe still relevant.
See the commit 768aec0b5bcc ("serial: 8250: fix shared interrupts
issues with SMP and RT kernels").


-- 
With Best Regards,
Andy Shevchenko
