Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE1C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7775217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgBMIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgBMIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35667AFCE;
        Thu, 13 Feb 2020 08:39:43 +0000 (UTC)
Date:   Thu, 13 Feb 2020 09:39:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20200213083942.6ue3ehaaycourgfi@pathway.suse.cz>
References: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
 <20200213055236.GE13208@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213055236.GE13208@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-02-13 14:52:36, Sergey Senozhatsky wrote:
> On (20/02/06 15:02), Benjamin Herrenschmidt wrote:
> [..]
> >  static int __add_preferred_console(char *name, int idx, char *options,
> > -				   char *brl_options)
> > +				   char *brl_options, bool user_specified)
> >  {
> >  	struct console_cmdline *c;
> >  	int i;
> > @@ -2131,6 +2131,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
> >  		if (strcmp(c->name, name) == 0 && c->index == idx) {
> >  			if (!brl_options)
> >  				preferred_console = i;
> > +                       if (user_specified)
> > +                               c->user_specified = true;
> >  			return 0;
> >  		}
> >  	}
> > @@ -2140,6 +2142,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
> >  		preferred_console = i;
> >  	strlcpy(c->name, name, sizeof(c->name));
> >  	c->options = options;
> > +	c->user_specified = user_specified;
> >  	braille_set_options(c, brl_options);
> >  
> >  	c->index = idx;
> > @@ -2194,7 +2197,7 @@ static int __init console_setup(char *str)
> >  	idx = simple_strtoul(s, NULL, 10);
> >  	*s = 0;
> >  
> > -	__add_preferred_console(buf, idx, options, brl_options);
> > +	__add_preferred_console(buf, idx, options, brl_options, true);
> >  	console_set_on_cmdline = 1;
> >  	return 1;
> >  }
> > @@ -2215,7 +2218,7 @@ __setup("console=", console_setup);
> >   */
> >  int add_preferred_console(char *name, int idx, char *options)
> >  {
> > -	return __add_preferred_console(name, idx, options, NULL);
> > +	return __add_preferred_console(name, idx, options, NULL, false);
> >  }
> 
> A silly question:
> 
> Can the same console first be added by
> 	console_setup()->__add_preferred_console(true)
> and then by
> 	add_preferred_console()->__add_preferred_console(false)

I guess that this might happen. It should be safe because
user_specified flag is set only to true when found again,
see:

                       if (user_specified)
                               c->user_specified = true;

Best Regards,
Petr
