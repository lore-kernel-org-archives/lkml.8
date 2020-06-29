Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47498206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xabakTlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgF2TR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgF2TRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:17:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5BC03079C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:38:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so17000691wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ShhE7g5SJz1A2LdeoWPLePC7l35fgsx0zx/wDQfKJTI=;
        b=xabakTlTYmtpEyDxEa7yDPe7DMOMxN6AqQMck23F6MmQi9YTgUxfraCYFu3KPQ6uEA
         Nzx5KBfZrhmF1SeYQT4keNVs3KIGJgsAO1wgjGE1ivCJ5Zk4OLRKDiv3SFXo716cfv/c
         ijch2hqp6P7/zzg06QYa5s+GF+US5RChmsNGKhdxI6sXjB3DL5SEtIX08aSAsOHEfAph
         Qf5L18elCCk1rY2JVhBJ3DCM9GYN/WWvTApmKdlO88JWK6SRzXr0nmP0/opCQPi0EUKg
         MVydtly7U8O3gokNeY3QDC1FhZj9TCINr5JntGlRrd8mc9X5Ym2p17ZeQuVSl8xRmDol
         L32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShhE7g5SJz1A2LdeoWPLePC7l35fgsx0zx/wDQfKJTI=;
        b=MBmxGVBGBQTGt4or49ESCzRd5x7vBpQkkWMCf7S+EkUi4Zz5XEPh6dFFtDCD5ongF4
         Ht4DkExCChQbu2RGQ7z8E2p/FAlNsr8Zid0udztOTJhj4Vm4l9XAwtJKUxOdGr0Lju7B
         XAfpRQljfsZWUsVyloN6u/YsFtHQrhtBpROPB1XBdmMA+pkUEZv7wtF/u1NNcizpC/5j
         s85Sv52fqBEWcXKMQyST65WdapGeHrnmdEhAICCXh5IyPyB/fFbQ+E6DfmiOV4HqWS3N
         xsqIooB5STfZBBoid+AoxfAZu+mzrnd7gUksr9B6v+b9jKnECLpUTlJc7RVz38V5GmGA
         cMJg==
X-Gm-Message-State: AOAM531JGsMqM6tSrFVE2/TCf21VgA9APtcIAXnsORAovlk0e/e71iVt
        vkjzo4+7DgCQQjBG6yNRujQxfw==
X-Google-Smtp-Source: ABdhPJzWB6poC4LpTU3NkcmJJ1oY9B/oljvOMDKa4t38dBstjpwMNtrI5BzUy3wr3kxD0q7Ug0kRnw==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr16754914wrp.183.1593445078758;
        Mon, 29 Jun 2020 08:37:58 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v18sm105056wrv.49.2020.06.29.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:37:58 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:37:56 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Cengiz Can <cengiz@kernel.wtf>, Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] kdb: prevent possible null deref in kdb_msg_write
Message-ID: <20200629153756.cxg74nec3repa4lu@holly.lan>
References: <20200629135923.14912-1-cengiz@kernel.wtf>
 <20200629145020.GL6156@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629145020.GL6156@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:50:20PM +0200, Petr Mladek wrote:
> On Mon 2020-06-29 16:59:24, Cengiz Can wrote:
> > `kdb_msg_write` operates on a global `struct kgdb_io *` called
> > `dbg_io_ops`.
> > 
> > Although it is initialized in `debug_core.c`, there's a null check in
> > `kdb_msg_write` which implies that it can be null whenever we dereference
> > it in this function call.
> > 
> > Coverity scanner caught this as CID 1465042.
> > 
> > I have modified the function to bail out if `dbg_io_ops` is not properly
> > initialized.
> > 
> > Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 683a799618ad..85e579812458 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -549,14 +549,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
> >  	if (msg_len == 0)
> >  		return;
> >  
> > -	if (dbg_io_ops) {
> > -		const char *cp = msg;
> > -		int len = msg_len;
> > +	if (!dbg_io_ops)
> > +		return;
> 
> This looks wrong. The message should be printed to the consoles
> even when dbg_io_ops is NULL. I mean that the for_each_console(c)
> cycle should always get called.
> 
> Well, the code really looks racy. dbg_io_ops is set under
> kgdb_registration_lock. IMHO, it should also get accessed under this lock.
> 
> It seems that the race is possible. kdb_msg_write() is called from
> vkdb_printf(). This function is serialized on more CPUs using
> kdb_printf_cpu lock. But it is not serialized with
> kgdb_register_io_module() and kgdb_unregister_io_module() calls.

We can't take the lock from the trap handler itself since we cannot
have spinlocks contended between regular threads and the debug trap
(which could be an NMI).

Instead, the call to kgdb_unregister_callbacks() at the beginning
of kgdb_unregister_io_module() should render kdb_msg_write()
unreachable prior to dbg_io_ops becoming NULL.

As it happens I am starting to believe there is a race in this area but
the race is between register/unregister calls rather than against the
trap handler (if there were register/unregister races then the trap
handler is be a potential victim of the race though).


> But I might miss something. dbg_io_ops is dereferenced on many other
> locations without any check.

There is already a paranoid "just in case there are bugs" check in
kgdb_io_ready() so in any case I think the check in kdb_msg_write() can
simply be removed.

As I said in my other post, if dbg_io_ops were ever NULL then the
system is completely hosed anyway: we can never receive the keystroke
needed to leave the debugger... and may not be able to tell anybody
why.


> >  
> > -		while (len--) {
> > -			dbg_io_ops->write_char(*cp);
> > -			cp++;
> > -		}
> > +	const char *cp = msg;
> > +	int len = msg_len;
> > +
> > +	while (len--) {
> > +		dbg_io_ops->write_char(*cp);
> > +		cp++;
> >  	}
> >  
> >  	for_each_console(c) {
> 
> You probably got confused by this new code:
> 
> 		if (c == dbg_io_ops->cons)
> 			continue;
> 
> It dereferences dbg_io_ops without NULL check. It should probably
> get replaced by:
> 
> 		if (dbg_io_ops && c == dbg_io_ops->cons)
> 			continue;
> 
> Daniel, Sumit, could you please put some light on this?

As above, I think the NULL check that confuses coverity can simply be
removed.


Daniel.
