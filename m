Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD2B2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B68EEV62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH0T23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0T20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:28:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71CC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:28:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so4265523pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tq7WHMShXg9WbLOqRG2/S7BNpF/nlvN0HdClfYEOFg0=;
        b=B68EEV62Jfl1cxvZpogWR1YngoJm76etcVXcU7qN8MI9ptiZbKstQRH3aV/NtL8lSB
         TmQEFvJMFn/1kPQaawkaGs/hitBPhE9vK4hKbOE2roXkx3cr16x1fkWLsPCOXWCCUX38
         9THlnh7Nj5SHdlW+HTa+VuNpzvruYqBuZQauw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tq7WHMShXg9WbLOqRG2/S7BNpF/nlvN0HdClfYEOFg0=;
        b=dacToL63YvbZmHookzFweYN5+rwE1ENid5V/ymLAnnfheOMonUQgMTPux0nsqAGTsa
         xhR04KDbFIK6/AhYdlad+me7CDt8drCVljU1ktlpiy9HkvofhqwkIGtwYcow5mA5Bscg
         8grztK3ma0XLlTIY9BMK71orC31Hu3XTX58cII05g3uMOXw/OTRc3otqhzfUmj/12A2V
         l2QgQvfV2nFfgdvGE0BJAgar7NXxv+Rm/zsgD437hmxXBROAAr5GZXMfY0LlmfRFboPt
         gNiUUaGHO4hMjJVjX2RWHuHZqidvBqaRahJ4dCjF3XNHpGU0AmIqGIrNDBI8GzEzERzZ
         kiNg==
X-Gm-Message-State: AOAM5318CbvBCA/0AVb01ZNnCgQbPvHPX0M8g/AOmAvU6H6DXNXEHmma
        3uFpyOC3eDRW9a6sQsdDGZjUHbVF+hkS3Q==
X-Google-Smtp-Source: ABdhPJyqcr6SjgxNUH59wXrODC0Y8Z6DIj/pE6pkutHgNcddyiSKgwxvQ1IRqObtexRF1elnaS9KiA==
X-Received: by 2002:aa7:91d9:: with SMTP id z25mr6552891pfa.116.1598556502787;
        Thu, 27 Aug 2020 12:28:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q82sm4028418pfc.139.2020.08.27.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:28:21 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:28:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <202008271150.7231B901@keescook>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
 <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com>
 <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:48:19AM -0700, Linus Torvalds wrote:
> On Thu, Aug 27, 2020 at 11:40 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Aug 27, 2020 at 11:32 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > >
> > > The tasklet rework people don't want to use container_of, which was our
> > > first suggestion, because it produces lines which are "too long".
> >
> > WTF?
> 
> Side note: I'm entirely serious. If somebody has problems with "too
> long lines", they are doing things wrong. Just ignore them.
> 
> Changing standard kernel interfaces is the wrong solution. What's
> next? Using 2-character indentation like some broken projects do just
> to make lines shorter and encourage people to do deep nesting?
> 
> No. The solution is to not write crap code with overly complex expressions.
> 
> "container_of()" has been a _very_ successful model, and the only
> reason to ever wrap it is if you already *know* the type, and you wrap
> it with an inline function that actually checks it.

This works for the case where it's a known 1-to-1 conversion, as you
showed. It doesn't work well for the 1-to-many (like timer_struct before,
and tasklet now), where each user of the infrastructure contains the
callback handle struct in their specific containing struct, which is
common for these kinds of callbacks.

> which now results in a type-checked *true* simplification of container-of.

More important than the aesthetics is the type checking, for sure.

The common raw pattern for callbacks is:

void callback(struct callback_handle *inner)
{
	struct outer *instance;
	...
	instance = container_of(inner, struct outer, member_name_of_inner);

There's so much redundancy here. And while mismatches between "instance"
and the "struct outer" type argument will be caught by the compiler,
it's weird to repeat it. Some places will make this less weird by doing:

	instance = container_of(inner, typeof(*instance), member_name_of_inner);

and when doing the timer_struct replacement, people didn't like the line
wraps making their drivers "ugly", and the compromise was to implement
from_timer()[1]:

  Since the regular pattern of using container_of() during local variable
  declaration repeats the need for the variable type declaration
  to be included, this adds a helper modeled after other from_*()
  helpers that wrap container_of(), named from_timer(). This helper uses
  typeof(*variable), removing the type redundancy and minimizing the need
  for line wraps in forthcoming conversions from "unsigned data long" to
  "struct timer_list *" in the timer callbacks:

  -void callback(unsigned long data)
  +void callback(struct timer_list *t)
  {
  -   struct some_data_structure *local = (struct some_data_structure *)data;
  +   struct some_data_structure *local = from_timer(local, t, timer);

I still didn't like this because "local" got repeated. I still think
some kind of DECLARE*() would be best. Like:

#define DECLARE_CONTAINER(outer_type, outer, member_name_of_inner, inner) \
	outer_type outer_name = container_of(inner, typeof(*outer),       \
                                             member_name_of_inner)

Then the above old timer_struct example becomes:

  -void callback(unsigned long data)
  +void callback(struct timer_list *t)
  {
  -   struct some_data_structure *local = (struct some_data_structure *)data;
  +   DECLARE_CONTAINER(struct some_data_structure *, local, timer, t);

> Seriously. It sounds to me like the tasklet rework people are people
> we want to avoid. They're doing completely the wrong thing.

So, when it's only directed at me, I just delete the personal attacks
from the quoted sections in my replies and ignore it. When it splashes
on other people, though, I think I have a duty to object to the
behavior:

This is a particularly unfriendly way to mentor new contributors and to
treat existing contributors (and reinforces a false "we"/"them" split,
when everyone just wants to see the kernel be better). And to paint
what is a 300 patch effort that cleans up a poor API that no one else
has been willing to do as "doing completely the wrong thing" when the
complaint is mainly bikeshedding over a mostly mechanical step seems
like quite an overreaction.

But, yes, let's get the right API here. I think container_of() is a mess
for these 1-to-many cases. What do you suggest here? I'll change all of
from_timer() to use it too.

-Kees

[1] https://lore.kernel.org/lkml/20170928133817.GA113410@beast/

-- 
Kees Cook
