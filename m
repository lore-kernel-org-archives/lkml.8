Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E7EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED302086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOiGaZJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgHCWuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:50:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:50:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so928866pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwNg4eO7sP2LsilWkU4USYbXbucaXDAZ6g6o30FpFGE=;
        b=KOiGaZJZjbZGHflHsSPpcBy+qaeE3nrukVys4V8FTyl+aCxbSrhzmwZD9BpxBwMkGe
         KB4DrddqsBn3hBt/bB6SVI3Nue8tOYvMbnGfFJLrj4bkd2boG7N8Xg1qRiFX7OZQQBN1
         QPbf6TAqiWr4pkP7keN+CwW8e7n9Lqi7jTWPxx1Uy9NvJohuEG65Bh1mgHOTvO0PWTfj
         Qtt22ShrE6dbqgt333fqlQtVJ8ESnofq5pf5mBiZAenjtVIdD/qL4ECOt28T9mE8QTMt
         fNl/WPxwsPaJBwDCHDxU460jHispUqFTmARBgE4elB52Ujp6lopaoiwxzID9YJiBsT+u
         agcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwNg4eO7sP2LsilWkU4USYbXbucaXDAZ6g6o30FpFGE=;
        b=uDrNqZ6vZ4WSE4sbyp+lhbgfyFE8v2lMVWIUf0GA5P1jFQhzK5NGfJxqtTl/V1sluv
         L9cg3VefLsTYzx9bNlNS+NpPgMM1aiIuDRUnu+nSBahw7sBM+T9ouMokhKtDWw295EPg
         TGjaZ4TUGvp05lllGinxNPl3vNQP2q7ljmNF2qtErCLyeVZm4MEhOsktM41ddV9fX7PC
         1D1vlq/Qzd0SVBasTtu3A0ycFRiQ39mr8CXIn3IayoQg7aiC9sv0hZlA8ySjV/W+JPQP
         NEwJBKGKNiPaIcqR9miGrLiUnxD67AKu3FKVuBduwBQ/mo0COYF2Q6J6EitmEHtZp+K2
         g1TA==
X-Gm-Message-State: AOAM533pVtEGCJD7pQ2tvCZnqF06nUUj2Aix8nAWhWrdRO7+Ipbru6p4
        cJDypDqDUrmXtvvWpknvUD5//d8=
X-Google-Smtp-Source: ABdhPJxU6YmCoTiD3viViXTkhomcbFFY9g6T0kU0yjjkDmgPykXnywY1YQvNiFu9W/M73Oz58ofRNQ==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr16317326plk.331.1596495016681;
        Mon, 03 Aug 2020 15:50:16 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:ce2:8573:dcc2:2473:2418:32ef])
        by smtp.gmail.com with ESMTPSA id a17sm18810672pgw.60.2020.08.03.15.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 15:50:15 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Tue, 4 Aug 2020 04:20:10 +0530
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     madhuparnabhowmik10@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers: char: applicom.c: Add lock for protecting
 DeviceErrorCount
Message-ID: <20200803225010.GA8670@madhuparna-HP-Notebook>
References: <20200803105049.11089-1-madhuparnabhowmik10@gmail.com>
 <20200803115328.GA955269@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803115328.GA955269@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:53:28PM +0200, Greg KH wrote:
> On Mon, Aug 03, 2020 at 04:20:49PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > The variable DeviceErrorCount is used to keep track of the number of
> > errors in read, write and interrupt routines, however it was not
> > protected by proper locking.
> > Therefore, this patch adds a spinlock: error_lock to protect the
> > variable.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  drivers/char/applicom.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> > index 14b2d8034c51..6df7450b8b99 100644
> > --- a/drivers/char/applicom.c
> > +++ b/drivers/char/applicom.c
> > @@ -106,6 +106,7 @@ static DECLARE_WAIT_QUEUE_HEAD(FlagSleepRec);
> >  static unsigned int WriteErrorCount;	/* number of write error      */
> >  static unsigned int ReadErrorCount;	/* number of read error       */
> >  static unsigned int DeviceErrorCount;	/* number of device error     */
> > +DEFINE_SPINLOCK(error_lock);		/* lock to protect error count variables */
> 
> That's a horrible global name, shouldn't it be static?
> 
> >  
> >  static ssize_t ac_read (struct file *, char __user *, size_t, loff_t *);
> >  static ssize_t ac_write (struct file *, const char __user *, size_t, loff_t *);
> > @@ -428,7 +429,9 @@ static ssize_t ac_write(struct file *file, const char __user *buf, size_t count,
> >  		spin_unlock_irqrestore(&apbs[IndexCard].mutex, flags);
> >  		printk(KERN_WARNING "APPLICOM driver write error board %d, DataFromPcReady = %d\n",
> >  		       IndexCard,(int)readb(apbs[IndexCard].RamIO + DATA_FROM_PC_READY));
> > +		spin_lock_irqsave(&error_lock, flags);
> 
> Why all of these irqsave?
> 
> >  		DeviceErrorCount++;
> 
> Does this really matter?  Who cares if we drop one of these, or any
> other of these debugging-only values?
>
Yes, since the error count variables are just for debugging, it is not
really necessary to have an exact count, but I just thought it would
be nice if it is precise, rest it is upto you if these changes are
required or not. Let me know, if required then I can think of a better name
for the lock.

Also, one other thing that I noticed in this code is that some of the
variables (WriteErrorCount and ReadErrorCount) are just initialized
and never incremented after that. So, if you could confirm that they
were supposed to be used in ac_write and ac_read instead of
using DeviceErrorCount, or otherwise, then I can make this change as
well.

Thanks,
Madhuparna

> thanks,
> 
> greg k-h
