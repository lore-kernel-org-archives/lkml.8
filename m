Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687D62068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofod8KOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFCJSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFCJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:18:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC135C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:18:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so1517328wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lC+yaFN5vqc/aVbyNoEXwYFQWDaby68sSTwiOnwtwTs=;
        b=ofod8KOHtXbZVUwpsoXnjSbVzBlN/vkZpExe7bFZ1xIu+y4lSTiShRRrKsVXaQpjet
         jRerdIe5syxoF6sVqjNYbtId0YU5Fd33uYYWuXbjaFMw5O8eLoLxSXXdAyIdZ/byK2ut
         OEStls5AAOJUYPSBY4fDoNlgiTwc2tCtOJeDu/NklMeMnEUwF6yThRuLsovJAuaTpoQK
         QIsnyyEjcDY44PvQZezVmWSbF0POjccEZz0AJraZ9tLnN3nsq42RYSvDe0B3eHlmeumb
         FHqMlqbjZEHqWJke3IMxb8gZeyqAn4Ydzt/CjrQ/Y1r36HkjVa3RvVnWmsn0IsKND17k
         /m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lC+yaFN5vqc/aVbyNoEXwYFQWDaby68sSTwiOnwtwTs=;
        b=Za4m28ZEvEJgdAhzoBFKx3dqRVayupmtNuvmLdf9GImjUSo6Z6cNQh/L1JEgBlHeAV
         3cnRhuNkX/6BM0+Z9++elxiWDN8y0OL414epL53X/QcquGCe0vnA15xDvAH8tdIWn8La
         QCIh5l6YPvV8t6N2ZSBrp0b85yzHOpyHkiKAdvH+Vhmv72bZqwBvvo43dJztb+m7iVsM
         rz/wkaMGVgXW2X0imZi5mWEAQ2qbQXL4p08slG9GtfQU3U6FxAKYa1NrbAP3QcqsLkgQ
         n08mXRoYQ65llFK3Z6kuCOcJqR2CmqVYn+q2PNeSRC4OP+pO4eIEulkApED3S8W37tFp
         /jcQ==
X-Gm-Message-State: AOAM531emWkoxCbadk+r3evbdCuQn1ts+djXJG5h49czvkBhtFyFlqx8
        /uOeMdXIepf0fw4QsjKnpqrOeQ==
X-Google-Smtp-Source: ABdhPJzrjB3ao0sWWKCA+EfaW/ASvKGJcBR3ptKjutcrPJXvUzAYEGSsczu/mQTJYdlBKssj7rSPKQ==
X-Received: by 2002:adf:f389:: with SMTP id m9mr28272738wro.195.1591175913374;
        Wed, 03 Jun 2020 02:18:33 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d191sm1619668wmd.44.2020.06.03.02.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:18:32 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:18:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, sergey.senozhatsky@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200603091830.azwneja736lvqo4n@holly.lan>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-5-git-send-email-sumit.garg@linaro.org>
 <20200603082503.GD14855@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603082503.GD14855@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:25:04AM +0200, Petr Mladek wrote:
> On Wed 2020-06-03 12:52:15, Sumit Garg wrote:
> > In kgdb context, calling console handlers aren't safe due to locks used
> > in those handlers which could in turn lead to a deadlock. Although, using
> > oops_in_progress increases the chance to bypass locks in most console
> > handlers but it might not be sufficient enough in case a console uses
> > more locks (VT/TTY is good example).
> > 
> > Currently when a driver provides both polling I/O and a console then kdb
> > will output using the console. We can increase robustness by using the
> > currently active polling I/O driver (which should be lockless) instead
> > of the corresponding console. For several common cases (e.g. an
> > embedded system with a single serial port that is used both for console
> > output and debugger I/O) this will result in no console handler being
> > used.
> > 
> > In order to achieve this we need to reverse the order of preference to
> > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > store "struct console" that represents debugger I/O in dbg_io_ops and
> > while emitting kdb messages, skip console that matches dbg_io_ops
> > console in order to avoid duplicate messages. After this change,
> > "is_console" param becomes redundant and hence removed.
> > 
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index 4139698..6e182aa 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -558,6 +557,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> >  	}
> >  
> >  	earlycon = con;
> > +	kgdboc_earlycon_io_ops.cons = con;
> >  	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> >  	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> >  		earlycon = NULL;
> 
> Should we clear kgdboc_earlycon_io_ops.cons here when
> kgdb_register_io_module() failed?
> 
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index c62d764..529116b 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -276,8 +276,7 @@ struct kgdb_arch {
> >   * the I/O driver.
> >   * @post_exception: Pointer to a function that will do any cleanup work
> >   * for the I/O driver.
> > - * @is_console: 1 if the end device is a console 0 if the I/O device is
> > - * not a console
> > + * @cons: valid if the I/O device is a console; else NULL.
> >   */
> >  struct kgdb_io {
> >  	const char		*name;
> > @@ -288,7 +287,7 @@ struct kgdb_io {
> >  	void			(*deinit) (void);
> >  	void			(*pre_exception) (void);
> >  	void			(*post_exception) (void);
> > -	int			is_console;
> > +	struct console		*cons;
> 
> Nit: I would call it "con". The trailing 's' makes me feel that that the
>      variable points to an array or list of consoles.

How strongly do you feel about it?


I'd probably agree with you except that the uart subsystem, which is by
far the most prolific supplier of consoles for kgdb to use, calls
pointers to single consoles "cons" so I'd prefer to be aligned on
terminology.


Daniel.
