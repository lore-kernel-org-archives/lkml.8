Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFFAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438082065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H9p2ftgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgF2Uu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgF2TNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:36 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304DCC00860F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:24:27 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id y3so3312140vkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXIzNUJKIGOWB+vmizHHKW6F1IB6+PeDc+RdNQZfG4E=;
        b=H9p2ftgM6BDXXXU7ok8FHRr0sq4G6s1m37NDNFG1eDXJ2qFH1yJopBKuPGyReljBc2
         kwUimi0R9cmeDvpOSRiQyQhHNeL/nurHP9Jh+UQbHEFANJyAEqzIRzvwW8/RZGiBJf0s
         dBKMsE70llEhUl45joNctOxC5GYrj+/jp30sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXIzNUJKIGOWB+vmizHHKW6F1IB6+PeDc+RdNQZfG4E=;
        b=l5Biyyahr6XKwTdp3oBXtzVRKvEhElthUj+qsP5Wtat41EPFjyvh9bOu4CqCMpnC5E
         H0W5IZaiWUW4hsQuZgqvcqdUEDWqGOiCLDE7oMzCz1JXrk9vDYqSWPSVOs5iKV+U8idv
         z8DLHXjjB1ZXXvjf8llZityVsRf1dAlq8o4H8J+zR+2kpVVby15RFfsXjJKfF2TVXcsX
         KqO1AEGA2qyRGlYkNyj6r23QWhQy6ohk9lQelXozmb9ITmqFl2yIe+oowZaCrXnSVFIf
         eBsldnWeKC/dGE5RzPoB3JyfE7FbFzGbGxYkv0MeJYqoy4MdyWkZB+6UI7X1aAsbAqgq
         kMHQ==
X-Gm-Message-State: AOAM530GCs1j9Opgh3UxLDqYeC++cUo2xZpZW1at8T9jiZ9i8O+kDlXY
        fzMw/sMRN+uu+jmJtl5/7sgHAIV5c/kPVblUnh+Nvg==
X-Google-Smtp-Source: ABdhPJwbhBKd5emQSa+NeM2N/t2NxnVvt7PQYuLqxuOf9/8087m6YgWuvv1HZwoG38pvPAxhwYkyo0VJbv0pY52R32g=
X-Received: by 2002:a1f:17c1:: with SMTP id 184mr9308345vkx.51.1593426266169;
 Mon, 29 Jun 2020 03:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616055223.119360-1-ikjn@chromium.org> <159293933210.62212.706350398043250620@swboyd.mtv.corp.google.com>
In-Reply-To: <159293933210.62212.706350398043250620@swboyd.mtv.corp.google.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 29 Jun 2020 18:24:15 +0800
Message-ID: <CAATdQgA4aoGWtuWb6AWpzD-VSfPV5u7++0rUoQN-cjwA7UpcVA@mail.gmail.com>
Subject: Re: [PATCH] clk: Provide future parent in clk notification
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:08 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Ikjoon Jang (2020-06-15 22:52:23)
> > Current clk notification handlers cannot know its new parent in
> > PRE_RATE_CHANGE event. This patch simply adds parent clk to
> > clk_notifier_data so the child clk is now able to know its future
> > parent prior to reparenting.
>
> Yes, but why is that important?

Basically I wondered if there are some cases needed to check more
conditions other than
clock rate (e.g. parent clock's internal properties).

In my case,  now I'm trying to make a wrapper clock on a mux clock which has
a rate adjustable PLL clock and a fixed temporary clock as its parents.

clkPLL   clkTMP
        \     /
      clkMUX

Current device driver is using three different clocks specified from
the device tree
and the driver handles clocks like this way to change operating clock speed.

clk_set_parent(clkMUX, clkTMP);
clk_set_rate(clkPLL, HZ);
udelay(10);
clk_set_parent(clkMUX, clkPLL);

Now what I want to do is to supply only one clock to a device node,
make the driver
call clk_set_rate() only, and clkMUX 's notification handler does
set_parent() things instead.
So it's good to know that clkMUX's rate changing is not caused by
clk_set_parent() and
deny its rate changing when an inappropriate parent is set.

Sorry for the long story for a simple reason, and maybe there could be
a more plausible reason
for this in near future?

>
> >
> > Change-Id: I099a784d5302a93951bdc6254d85f8df8c770462
>
> Please remove these.

Oops, thanks!

>
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> >  drivers/clk/clk.c   | 30 +++++++++++++++++-------------
> >  include/linux/clk.h |  9 ++++++---
> >  2 files changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 3f588ed06ce3..62c4e7b50ae5 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1846,7 +1849,7 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
> >   * take on the rate of its parent.
> >   */
> >  static int __clk_speculate_rates(struct clk_core *core,
> > -                                unsigned long parent_rate)
> > +                                struct clk_core *parent)
> >  {
> >         struct clk_core *child;
> >         unsigned long new_rate;
> > @@ -1854,11 +1857,12 @@ static int __clk_speculate_rates(struct clk_core *core,
> >
> >         lockdep_assert_held(&prepare_lock);
> >
> > -       new_rate = clk_recalc(core, parent_rate);
> > +       new_rate = clk_recalc(core, parent ? parent->rate : 0);
> >
> >         /* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STOP */
> >         if (core->notifier_count)
> > -               ret = __clk_notify(core, PRE_RATE_CHANGE, core->rate, new_rate);
> > +               ret = __clk_notify(core, parent, PRE_RATE_CHANGE,
> > +                                  core->rate, new_rate);
> >
> >         if (ret & NOTIFY_STOP_MASK) {
> >                 pr_debug("%s: clk notifier callback for clock %s aborted with error %d\n",
> > @@ -1867,7 +1871,7 @@ static int __clk_speculate_rates(struct clk_core *core,
> >         }
> >
> >         hlist_for_each_entry(child, &core->children, child_node) {
> > -               ret = __clk_speculate_rates(child, new_rate);
> > +               ret = __clk_speculate_rates(child, core);
>
> How does this work? core->rate isn't assigned yet when we're speculating
> rates down the tree to the leaves. So that clk_recalc() in the above
> hunk would need to save the rate away, which is wrong because it isn't
> changed yet, for this line to make sense.
>
Yes, you're right, this was simply wrong..

> Given that I had to read this for a few minutes to figure this out it
> seems that trying to combine the parent and the rate as arguments is
> actually more complicated than adding another parameter. Please just add
> another argument.
>
> >                 if (ret & NOTIFY_STOP_MASK)
> >                         break;
> >         }

Agree,
Thank you for the review.
