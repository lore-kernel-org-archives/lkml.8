Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3781920717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JPSVdh9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgGVIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGVIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:07:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B991C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:07:18 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k6so1097703oij.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOy7v3hfT/utQT3C9G3K+8RtCzbiTsBHt7vvQa8xceo=;
        b=JPSVdh9idiN0Up4ibzccMsoV86w485WS4bmMB7o8cngcTQKmUWXuOg45HnkCXh7Z9m
         rJ2EnrDrVQMzeE2+3r2zS6sZClAZKnxbEr4gf4Bk2cBwL+KmikN4Zwd3oAeSvowgW33C
         cqwu0LUPOLEili0aFnDflsr7HDOO9Q/+g0zMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOy7v3hfT/utQT3C9G3K+8RtCzbiTsBHt7vvQa8xceo=;
        b=a6yNIGmvjXFXAx6+vTMPzvNaDUfB0Iesgtqr6OOzFg4KQ+KmgwMp4khXTSztbNW/Qa
         oUWneqOX9pOIibtOdI+ELNWaqDnoCK5tZC/C7KqIE08ZD/vCW1Bi8QIM7/NKKt5EydMg
         Vqn2ZS+Jlbn0q27o0/pf8YwzYyNQ8NjImY/bYsyFarsHEMbumm4LapsJU8nElwoBfVto
         YPL7S+Qdn7Foga5JWApueon3U24FLFt/Q55VJtUOPQB9Ry+s1fS3C6vxxc6ZWQ3Ho0iU
         oaY8kMTatS0QGdDLzdSnBlRLxdNzaMMH9gLm5d6z12FhjfiK5kwOwILtLhNhrDkVZj8p
         gB+A==
X-Gm-Message-State: AOAM5300wJdzzmbAGwt11UyRnkCPmjJ9bt6GeWfnThK+WrpJKmk/F6UC
        MJN2Z3Xa1F9NPNGLduSKW0M1kq0dNpXgIkjuT3BSdg==
X-Google-Smtp-Source: ABdhPJzq8mU6U0neT362ppAInRVQZhwjY0sqr8Tk++7PkdwpIPEpXPOOgY91NHX8PUlb02j2SoGhjC2YQxJ8rExyWjQ=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr6219460oig.128.1595405237785;
 Wed, 22 Jul 2020 01:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam> <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
 <20200715151220.GE2571@kadam> <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
 <20200716100006.GN3278063@phenom.ffwll.local> <b202b74b-6a7b-e2be-2350-72144331303b@i-love.sakura.ne.jp>
 <20200721160836.GA2109047@kroah.com>
In-Reply-To: <20200721160836.GA2109047@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 22 Jul 2020 10:07:06 +0200
Message-ID: <CAKMK7uGtDQKkSJhvr4YrGOmcbfVyTeEvSD-QSoHhUtH8=D856w@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 08:27:21PM +0900, Tetsuo Handa wrote:
> > On 2020/07/16 19:00, Daniel Vetter wrote:
> > > On Thu, Jul 16, 2020 at 12:29:00AM +0900, Tetsuo Handa wrote:
> > >> On 2020/07/16 0:12, Dan Carpenter wrote:
> > >>> I've complained about integer overflows in fbdev for a long time...
> > >>>
> > >>> What I'd like to see is something like the following maybe.  I don't
> > >>> know how to get the vc_data in fbmem.c so it doesn't include your checks
> > >>> for negative.
> > >>
> > >> Yes. Like I said "Thus, I consider that we need more sanity/constraints checks." at
> > >> https://lore.kernel.org/lkml/b1e7dd6a-fc22-bba8-0abb-d3e779329bce@i-love.sakura.ne.jp/ ,
> > >> we want basic checks. That's a task for fbdev people who should be familiar with
> > >> necessary constraints.
> > >
> > > I think the worldwide supply of people who understand fbdev and willing to
> > > work on it is roughly 0. So if someone wants to fix this mess properly
> > > (which likely means adding tons of over/underflow checks at entry points,
> > > since you're never going to catch the driver bugs, there's too many and
> > > not enough people who care) they need to fix this themselves.
> >
> > But I think we can enforce reasonable constraint which is much stricter than Dan's basic_checks()
> > (which used INT_MAX). For example, do we need to accept var->{xres,yres} >= 1048576, for
> > "32768 rows or cols" * "32 pixels per character" = 1045876 and vc_do_resize() accepts only
> > rows and cols < 32768 ?
> >
> > >
> > > Just to avoid confusion here.
> > >
> > >> Anyway, my two patches are small and low cost; can we apply these patches regardless
> > >> of basic checks?
> > >
> > > Which two patches where?
> >
> > [PATCH v3] vt: Reject zero-sized screen buffer size.
> >  from https://lkml.kernel.org/r/20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp
>
> This is now in my tree.
>
> > [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
> >  from https://lkml.kernel.org/r/20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp
>
> That should be taken by the fbdev maintainer, but I can take it too if
> people want.

Just missed this weeks pull request train and feeling like not worth
making this an exception (it's been broken forever after all), so
maybe best if you just add this to vt.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also this avoids the impression I know what's going on in fbdev code,
maybe with sufficient abandon from my side someone will pop up who
cares an fixes the bazillion of syzkaller issues we seem to have
around console/vt and everything related.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
