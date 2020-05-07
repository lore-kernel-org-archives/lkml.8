Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E27C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C112208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB+cvXpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgEGJfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:35:08 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EBAC061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 02:35:08 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j16so4611411oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cahzpbTf0SUTONv4Oc4dlWOWG1dLD0UTEN01WnEA1bg=;
        b=sB+cvXpjSs3AonkAHGdzo61kc0V6MO35qvFlBZk6PJuerkQfupOhCpjW5jRFRb9Nhk
         t5DhNhxSe2cl1tLcmr8BGUDdiyjPYBMzd9VZUH1yt2oykHR108x2bvudCIE8OvhQC6q6
         sVlxqXej2AkbQlTtRgUlUiyUEeNOx4oPuYgZxjxF94HfN6GoS8X42q/oIhc+JJxz3+Ht
         dt+Dl+3gAXXjsxneuB+TD9KQ0qq7xeSH5KVR1S3RoInu4LDzE34pXhMQOCRpELjUCVNn
         kEQqRmb6yECYsGCgCYO10DaWK0qzaKhfEGtqvZ8tuEdm2g8IX4wHUbMEgkyq1GgaD/GJ
         qIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cahzpbTf0SUTONv4Oc4dlWOWG1dLD0UTEN01WnEA1bg=;
        b=gTSpLOJ2yd6m9jb5qqYu1+dtmTAa0AuhPu7bCAPLyUYBf2t9A0ToQXYNFcEk6iNzyW
         codx3x2EFwlIy4IB23xAdbtu/NN97bBFNWpxvKD/9jgo158c8rLuN+HoTMeBiStIjrOn
         PvHOUvgL/73TIFgjzNX7osLx19VHE/o7cfXW/7LCyR4OUDYtCQn42vkkc0vFQsFdsV4K
         pgH3vN3fXKGyD8fWHR0QNe+sU6btCHRuUa9s8Iu+upvxT31Ni33h7fgduLAH9+NSORTm
         ihcc/0rrDox2ihB/7zqfP0oSswz57HvLAfUnwHQm0b81xdGEKCRis4jaRW/bXPJT9vS0
         jGGw==
X-Gm-Message-State: AGi0PuY45Hs0FjZXajUZ+IuU/eNNNiHX1TMGuLRSu65z0TLLxcN+ESte
        v5Ra9aCdSdOAGTN7dxCKVmCMHAEK2wOY0kxB3tkM+53L
X-Google-Smtp-Source: APiQypIugmQsTko33VfSMgr6X6oStN4gmmFhMoOdVUqWPl5MIIYT3qytEmPYLOWqVbZALTsKLqvDK3uS/mQBhJ1CUbs=
X-Received: by 2002:aca:c646:: with SMTP id w67mr6001691oif.70.1588844107814;
 Thu, 07 May 2020 02:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200506132816.GJ8043@willie-the-truck> <20200506143616.GY2869@paulmck-ThinkPad-P72>
 <20200506144141.GA12919@willie-the-truck> <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
 <20200506180232.GB2869@paulmck-ThinkPad-P72> <CANpmjNP1v8wORd_nfQb7hVH2EY5P565uJYsRFt0dXi4KZvQ46A@mail.gmail.com>
 <20200506193713.GG2869@paulmck-ThinkPad-P72> <20200506214727.GA27039@paulmck-ThinkPad-P72>
In-Reply-To: <20200506214727.GA27039@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 May 2020 11:34:55 +0200
Message-ID: <CANpmjNObCdQ-QnawW+gz5aAwM7AVSgRe4yptyavyQGG20bp5-Q@mail.gmail.com>
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 23:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 06, 2020 at 12:37:13PM -0700, Paul E. McKenney wrote:
> > On Wed, May 06, 2020 at 09:11:23PM +0200, Marco Elver wrote:
> > > On Wed, 6 May 2020 at 20:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, May 06, 2020 at 05:26:56PM +0200, Marco Elver wrote:
> > > > > On Wed, 6 May 2020 at 16:41, Will Deacon <will@kernel.org> wrote:
> > > > > >
> > > > > > Hi Paul,
> > > > > >
> > > > > > Cheers for the quick reply!
> > > > > >
> > > > > > On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> > > > > > > On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > > > > > > > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > > > > > > > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > > > > > > > missing some bits:
> > > > > > > >
> > > > > > > >   * An update to checkpatch.pl to warn about missing comments for
> > > > > > > >     data_race():
> > > > > > > >
> > > > > > > >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> > > > > > >
> > > > > > > For some reason, I thought this was going up some other tree, but I do
> > > > > > > not see it in -next.  So unless I hear otherwise, I will pull it into
> > > > > > > the v5.8 kcsan branch.
> > > > > >
> > > > > > Brill, thanks.
> > > > > >
> > > > > > > >   * I'm unable to apply these two patches from Marco that are needed for
> > > > > > > >     my READ_ONCE() work:
> > > > > > > >
> > > > > > > >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > > > > > > >
> > > > > > > >     I think these depend on stuff that has been queued by Paul, and appears
> > > > > > > >     in linux-next, but to be honest with you I'm quite confused about what
> > > > > > > >     is queued for 5.8 and what isn't.
> > > > > > >
> > > > > > > This one is queued, but I currently have it in the v5.9 pile (but
> > > > > > > tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> > > > > > > to the v5.8 branch, which will be part of my pull request next week.
> > > > > >
> > > > > > Great, then this would all show up on tip/locking/kscan, right?
> > > > > >
> > > > > > > > What's the best base for me to use?
> > > > > > >
> > > > > > > The -next tree has the latter, but not yet the former.
> > > > > >
> > > > > > That probably means -next is good enough for me to cook a new version of my
> > > > > > series, and then I can make a proper branch next week.
> > > > > >
> > > > > > > Hopefully we can get this straightened out, and please accept my apologies
> > > > > > > for the hassle!
> > > > > >
> > > > > > No need to apologise, I just couldn't figure out what was what and decided
> > > > > > it was easier to ask the experts ;)
> > > > >
> > > > > Just confirming that I don't see any issues with the plan -- the
> > > > > patches that Will needs are good to go into the v5.8 branch.
> > > >
> > > > OK, I have updated -rcu's kcsan and kcsan-dev branches.  Could you please
> > > > double-check, given that pull-request time is quite soon?
> > >
> > > I believe "objtool, kcsan: Add kcsan_disable_current() and
> > > kcsan_enable_current_nowarn()" is missing, which should go after
> > > "kcsan: Add __kcsan_{enable,disable}_current() variants".
> >
> > Thank you for checking!  I will move that one also.
>
> And it is moved.  FYI, I will likely be sending my KCSAN pull request
> late tomorrow (Thursday) Pacific Time, a few days earlier than normal.

Looks good, thank you!

-- Marco
