Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6834AC4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3820720724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvRFQfNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCVQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:37:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40450 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgCVQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:37:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id e19so10990663otj.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GRKFaCcXJ7mdsvy6NUcpQNVCNNISDlTqxog704JRIs=;
        b=tvRFQfNiD4QieIcurY5uIxY68I7r4dirD+9m/gx1ebXGGB/f/fOqlVi+iUP1q7iX4l
         QlZ6nfeCtzcob9S6go+lz1o+N20wI2lOIGJy38i8KoXrV6qmrL58UwgCSPu2FA3x3EPQ
         EouWUxFsnGEl0kFOBxOotjQuXsm0cPSgRB+aCCXRHJNN0yDGeIW9K3tcUw24FFu0sdfv
         gCPMfsGvgv83/EVtsKbnIbpa0x6fEgwEZugjOtgkTQZCGHtDufb0/340NhW4cvoQhaPI
         YmdxCrOtPNNIZoHjEpJCQfk9QDWSn+OpxsBVDkTfsp/Nt9ZTSaQ93wXy1k5HxjlU881w
         WlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GRKFaCcXJ7mdsvy6NUcpQNVCNNISDlTqxog704JRIs=;
        b=oK2hAZ7TjfTn6Gjd+nKmtknh3gOoseYXUDekOvsp0vp8m6WtXIaCbCGwOMZXvfekFy
         RFcnx6HM6jrPZsS4iZRia+XchJh4octvuKQOGmOUpb6kUDBOZDoXpsntH4GnMsb04o06
         RFAmQ/YjYbnoodczYj8aaFpFmjBiZWTyRqjc3C7TV2D5qEgbPWGoZl5FBEHy1q8Q0K1m
         ZrsFsn1+b0nnD5zJBjszgBvmotPpquiapLeOeX2RcCYH0CYpAiEwHJ43eBdPSGaRiOoo
         zDnGgSxNuglDsIqOILApwxORKtJWl24yGxfaf+2QlhPC0OzrAcqyPWTUIwizPk7I3US2
         bjvg==
X-Gm-Message-State: ANhLgQ3sKzqWKOQskbJJHPRQKQYUawIuuohTLymsb+oIfZ6Fst9U9PWy
        wQ6HbK9PFcwYxggH6cxewhfWTlBgIev+yXhMViy1CgpfSjE=
X-Google-Smtp-Source: ADFU+vsSP7GimuLHJKtzBEPg3zUHwQK1tIO0UcChLo5j9UqtFQQL/YtMYuBFA5ZfCdI5L3etshgrsJzMNdGsYzRsHpA=
X-Received: by 2002:a9d:1a2:: with SMTP id e31mr15534935ote.30.1584895020899;
 Sun, 22 Mar 2020 09:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200322013525.1095493-1-aquini@redhat.com> <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s> <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
In-Reply-To: <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 22 Mar 2020 09:36:49 -0700
Message-ID: <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
>
> > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > + */
> > > > +static void force_lru_add_drain_all(void)
> > > > +{
> > > > + sched_yield();
> > > > + system("echo 1 > /proc/sys/vm/compact_memory");
> > > > +}
> > >
> > > What is the sched_yield() for?
> > >
> >
> > Mostly it's there to provide a sleeping gap after the fault, whithout
> > actually adding an arbitrary value with usleep().
> >
> > It's not a hard requirement, but, in some of the tests I performed
> > (whithout that sleeping gap) I would still see around 1% chance
> > of hitting the false-negative. After adding it I could not hit
> > the issue anymore.
>
> It's concerning that such deep machinery as pagevec draining is visible
> to userspace.
>

We already have other examples like memcg stats where the
optimizations like batching per-cpu stats collection exposes
differences to the userspace. I would not be that worried here.

> I suppose that for consistency and correctness we should perform a
> drain prior to each read from /proc/*/pagemap.  Presumably this would
> be far too expensive.
>
> Is there any other way?  One such might be to make the MLOCK_ONFAULT
> pages bypass the lru_add_pvecs?
>

I would rather prefer to have something similar to
/proc/sys/vm/stat_refresh which drains the pagevecs.
