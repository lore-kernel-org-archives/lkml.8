Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD58120708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShIXuYRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgBJNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35455 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbgBJM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:59:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so3895563pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y0lLKcIRcrKBMjOb2t3dxuaz/hreV2rj4w3yWI5N9yg=;
        b=ShIXuYRhJDp0KzLzF6UZgMsniFpEjmFjc61ljrmLMLTsjcl0HWTyMdFVPpbE+DPf/3
         Zi/mg0ie+/dS9yy/39sLKz52WRV9E1CFI6L7ldSw4Vmst5iRVq/Ydqf3NYw2TF2cxjHL
         /j2DZNJBe2+MQRlC9yBlwF2/HEUz/BXB+rVuJKItBpjjV31vkqa4QgJGA/HzEryusoJz
         +uzigk7tPzocPlnwtJifPJJ8RZeaALg3Eh/WGiQ+U4LCx2lRjXp6ruH5YKAYH7LAM9TR
         3S94DwDVd6T+IPzBoA31PGOOBqcy2UQ04iZ9Jv6Q2kEzdzqOtKB5x4XC76XWbS4HCtq4
         YuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0lLKcIRcrKBMjOb2t3dxuaz/hreV2rj4w3yWI5N9yg=;
        b=ruzCiW2Ire6/sHecN33QScmnLzkO61uD2GGIXFnXlofqlb6Bvy4zQzrDkKGAwMYrTG
         31aykdBIBlnzlyxs8AmTd+Lc/LFe+LDeWvvQcCxZeY+oQVMJAqrVkvek+KpkfCnTtIdq
         KXrwI4mvi5z8Mi0c8lnJSTdv2kZ5anJtoKEzAoAup86vY1EFCOXowuuy1jk8+1vOnrsM
         45otTLKebia3QD4oyb5Av+zTkD6aIG/VxsgeExYryHhCFZqDZZWNI9g4UqedXtsKRyvK
         yOScHdjteqoPk41v5HjwYUZvBHiT+jJEezV9q93tgsSiLpto6SBRtz5DWcuALWhKaqr2
         Xmpw==
X-Gm-Message-State: APjAAAXqqnkm+Q8F5cvGETZacmaSktFLYY0bqEyoRw7zYEwv52pM3uem
        IcrGKqH+ioB9oie9VWf2YIE=
X-Google-Smtp-Source: APXvYqz4vzr5UgDqPluKWTZ8VLa/KFqXFz0dLU85nHG63YroIBTbumvq+jFBGBxdER0F04KDELp1mg==
X-Received: by 2002:a63:3688:: with SMTP id d130mr1568945pga.422.1581339595955;
        Mon, 10 Feb 2020 04:59:55 -0800 (PST)
Received: from workstation-portable ([146.196.37.217])
        by smtp.gmail.com with ESMTPSA id w8sm455068pfj.20.2020.02.10.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:59:55 -0800 (PST)
Date:   Mon, 10 Feb 2020 18:29:48 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] events: Annotate parent_ctx with __rcu
Message-ID: <20200210125948.GA16485@workstation-portable>
References: <20200208144648.18833-1-frextrite@gmail.com>
 <20200210093624.GB14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210093624.GB14879@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:36:24AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 08, 2020 at 08:16:49PM +0530, Amol Grover wrote:
> > parent_ctx is used under RCU context in kernel/events/core.c,
> > tell sparse about it aswell.
> > 
> > Fixes the following instances of sparse error:
> > kernel/events/core.c:3221:18: error: incompatible types in comparison
> > kernel/events/core.c:3222:23: error: incompatible types in comparison
> > 
> > This introduces the following two sparse errors:
> > kernel/events/core.c:3117:18: error: incompatible types in comparison
> > kernel/events/core.c:3121:30: error: incompatible types in comparison
> > 
> > Hence, use rcu_dereference() to access parent_ctx and silence
> > the newly introduced errors.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> >  include/linux/perf_event.h |  2 +-
> >  kernel/events/core.c       | 11 ++++++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 6d4c22aee384..e18a7bdc6f98 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -810,7 +810,7 @@ struct perf_event_context {
> >  	 * These fields let us detect when two contexts have both
> >  	 * been cloned (inherited) from a common ancestor.
> >  	 */
> > -	struct perf_event_context	*parent_ctx;
> > +	struct perf_event_context __rcu	*parent_ctx;
> >  	u64				parent_gen;
> >  	u64				generation;
> >  	int				pin_count;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2173c23c25b4..2a8c5670b254 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> >  static int context_equiv(struct perf_event_context *ctx1,
> >  			 struct perf_event_context *ctx2)
> >  {
> > +	struct perf_event_context *parent_ctx1, *parent_ctx2;
> > +
> >  	lockdep_assert_held(&ctx1->lock);
> >  	lockdep_assert_held(&ctx2->lock);
> >  
> > +	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
> > +	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);
> 
> Bah.
> 
> Why are you  fixing all this sparse crap and making the code worse?

Hi Peter,

Sparse is quite noisy and we need to eliminate false-positives, right?
__rcu will tell the developer, this pointer could change and he needs to
take the required steps to make sure the code doesn't break.

Thanks
Amol
