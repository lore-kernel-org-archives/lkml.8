Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448AAC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EC820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGA10LSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1Jha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:37:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40358 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgA1Jh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:37:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so6675617pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 01:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cWPpo+JboGnintSd8zwFs8NMb29/E+sQ20smaqzcvA=;
        b=PGA10LSXyDmz2JOek4Re1Jt1c27N7Xn1opWiQHVC+oCL+YGlHWlQEmQGK9xOopi0a/
         RCBDMO5u06EPDogTd8NLWuH412lPsX4/I6z3TFYlUAfw5oYKOGn5AOw1NlGtjmReXoNs
         3lcrX5ANvY4IJVx5SMky+y2lOn0kLfANp7fzNzf0kCDp+/dTMG+2BEXRJ9+W69QykHNr
         hFRJpqy0ab/zBoDcKHR/lP4mXAiW2icCUVgM3050nyehzSfBXa1mce3J9igGmWAYakzs
         RjHsMOgxJszzArYpyxQfiGDnfH0thk8yc/RnjYXiTPthN21GlSXbqfpC//gg3qn4z4Af
         TWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cWPpo+JboGnintSd8zwFs8NMb29/E+sQ20smaqzcvA=;
        b=QzCCCQzaE+6YvT/+ijxCmt6McRErGqo+guImShAP0hKTPecEVfel+6iQXNHL24bGqS
         5mgYjcHfNOojghRL+GsYaMlKGCWzsKnwfEBiJrd4Nbh9DHuIAy7P5tX0cy1mRtbwLcX9
         tXCxsqOdpbw1FujKoOKXmE5tOLwk2Y9jeajEWaA4t4yyHh3Hd4XwICg8UpeCowLUv2rK
         v+FH0xsbY56eDVsIQqYOj20AetkBtoBhVGoLLjtaVc1nJKMkxJ9Q4HjXqY0/TJzjeUnV
         VbP0dam5CMmaquMlIWPmYeUf+enLRrdeQKlhNCzwB11Idw+RqBnKlu8J3GH+vGQ3hblB
         3e/A==
X-Gm-Message-State: APjAAAVYz3JJRIr/qw6fe0IXVo66IOWYvu3Qz8Dno63NLcklL84rol2r
        oyEJs9LhM7ESmQfnzPDx6C4vRPC6
X-Google-Smtp-Source: APXvYqz7EI8uZApqRo9ucWVFVd9sQLcWFN3yQwep9F1+ZWwCJo0/RcYc+wUzrBeMRNpVRU09nKjjFw==
X-Received: by 2002:a63:447:: with SMTP id 68mr25029230pge.364.1580204249251;
        Tue, 28 Jan 2020 01:37:29 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d22sm18955568pgg.52.2020.01.28.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 01:37:28 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:37:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200128093726.GE115889@google.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
 <20200128044332.GA115889@google.com>
 <20200128092235.GX32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128092235.GX32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 11:22), Andy Shevchenko wrote:
> On Tue, Jan 28, 2020 at 01:43:32PM +0900, Sergey Senozhatsky wrote:
> > On (20/01/27 13:47), Andy Shevchenko wrote:
> > [..]
> > >  	res = _braille_unregister_console(console);
> > > -	if (res)
> > > +	if (res < 0)
> > >  		return res;
> > > +	if (res > 0)
> > > +		return 0;
> > >  
> > > -	res = 1;
> > > +	res = -ENODEV;
> > >  	console_lock();
> > >  	if (console_drivers == console) {
> > >  		console_drivers=console->next;
> > > @@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
> > >  	if (!res && (console->flags & CON_EXTENDED))
> > >  		nr_ext_console_drivers--;
> > >  
> > > +	if (res && !(console->flags & CON_ENABLED))
> > > +		res = 0;
> > 
> > Console is not on the console_drivers list. Why does !ENABLED case
> > require extra handling?
> 
> It's mirroring (to some extend) the register_console() abort conditions.

Could you please explain?

I see the "newcon->flags & CON_ENABLED" error out path. I'm guessing,
that the expectation is that this is how we filter out consoles which
were not matched (there is that "newcon->flags |= CON_ENABLED" several
lines earlier.) So this looks like the assumption is that consoles don't
have CON_ENABLED bit set prior to register_console(), as far as I understand.

Well, look at these
...
drivers/net/netconsole.c:       .flags  = CON_ENABLED,
drivers/tty/ehv_bytechan.c:     .flags  = CON_PRINTBUFFER | CON_ENABLED,
drivers/tty/serial/mux.c:	.flags = CON_ENABLED | CON_PRINTBUFFER,
...

	-ss
