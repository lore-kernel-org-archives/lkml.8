Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE320842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgBKPeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:34:08 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55458 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgBKPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:34:08 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01BFXxMK017696
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Feb 2020 09:34:02 -0600
Message-ID: <52b18db7c4c74fc759bf455e7e4acfb1a404951b.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 2/3] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Feb 2020 16:33:57 +0100
In-Reply-To: <20200211144134.fyxxphyr32dkmhsw@pathway.suse.cz>
References: <97dc50d411e10ac8aab1de0376d7a535fea8c60a.camel@kernel.crashing.org>
         <20200211144134.fyxxphyr32dkmhsw@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-11 at 15:41 +0100, Petr Mladek wrote:
> 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 17602d7b7ffc..5cf47a7b880c 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2674,8 +2679,13 @@ static int try_enable_new_console(struct console *newcon)
> >  	/*
> >           * Some consoles, such as pstore and netconsole, can be enabled even
> >           * without matching.
> > +	 *
> > +	 * Note: We only do this test on the !user_specified pass so that such
> > +	 * a statically enabled console that isn't user specified gets a chance
> > +	 * to have its match() or setup() function called on our second pass
> > +	 * through this function.
> 
> I had some troubles to part the comment. I wonder if the following is
> more clear:
> 
> 	* Accept pre-enabled consoles only when match() and setup()
> 	* was called.

Yeah the sentence is a bit convoluted, I agree. As for the fix, see
below

> And I would do the same check as in the for cycle:
> 
> 	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
> 		return 0;

Fair enough, this is simpler.

> With the above change:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I could do the change when pushing if you agree and v4 is not needed
> for other reasons.

Of course. I'm travelling this week (which is why I somewhat rushed
sending you the patches last week, hence the glitches you noted), so I
won't have a chance to repost until sometime next week.

> 
> PS: JFYI, I am going to look at the 3rd patch tomorrow. I have to go now.

No worries. It's not super important, it's a minor thing I noticed
while testing (when I artifically make my consoles not match to test
the "default" fallback). It's not directly related to the fix in patch
2, but is completely standlaone.

Cheers,
Ben.


