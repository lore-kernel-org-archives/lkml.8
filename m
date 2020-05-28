Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8226FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA19206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590695459;
	bh=AcPsFtHL+MyHrOGa1NuVI3QUD1Ry+V7uwlBazCrL2UE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=itoCSwTWKWzYkfCg1/Cdh5wcg8Kfx+GxkQz+8J0SvR5xSlXJ8wMGfZfcSJOgdyIRD
	 uvRID0XW9aRfEBY6DozEmD0d8nT6/F8T9uGjfNUYTbU2qij93H4tzPX3EqZnfjMSPI
	 5m7NyuFMXqe16/hN6qq7baUFnh8SHHgqiJo9+4Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406854AbgE1Tu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406652AbgE1Tu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:50:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391A2C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:50:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so34604631lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=El/p9r24TOPRpB9T6UTyy59hq4IR8nkl7m3A7iSsHiY=;
        b=DdZKu36PhDKIF5XAdFzdvJB2Us+QMvDQU8YSb5wgbFwKYJgBPUOnSDHUbXqFVJ2ZZs
         NuRUtl9I3aLcLs3iM4S9yYhir4Js8xEsB7bMwcLG7TPn4yw1cGJhsEWDb7Re161yE8dV
         rOpGIjYyqDIdyOpaN1ShEF+AY/sp2VeZjq6nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=El/p9r24TOPRpB9T6UTyy59hq4IR8nkl7m3A7iSsHiY=;
        b=cb5IvpqJVaqoh0stTHULuTIzutVwzh0HNLAkDi8b/3TRQxkVggMftAfw2uZjxxOmFk
         /IOB1uH697ivNHhl3XJ/h1ZfBXFGvqJUiLc5gpx1LibvbWQeJaA/V4VUeDK1lax924ob
         Y+FhIl3QU18M7au5QfomdMfFZmnWyt3m4xSpNM8baQFATmD3lu2ud8p8ExRc2leNB1AW
         smxNbsIVfImdPg9d8y38FIrzrbGnf4wdGgMnfVPjuh371W7L+IaFJGnrmiy5iiQHIkzw
         5to/vgOYfvzwf1/Qu9mkwhwcPD2LXsWe6r3m6Ap0HPWaNxqGw1AaqsKWPDMZfOL5UNym
         Vikg==
X-Gm-Message-State: AOAM530mEREXUDCj42kzRXw3kKi4XGw+AK+rsSc+cbYVZEws4jyMhxJ0
        mSkyAgfFWb8V3rzeDOxIg9zQ2nTHGNA=
X-Google-Smtp-Source: ABdhPJwP09AagUSZh27kftG+rHN6QCvvbxHERDoVDjsSPjfl5QYtPEo5uWN4WBCP0l5z7Ibnjryw4w==
X-Received: by 2002:a2e:917:: with SMTP id 23mr2248512ljj.7.1590695453598;
        Thu, 28 May 2020 12:50:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y16sm1604449ljn.49.2020.05.28.12.50.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:50:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z22so17343144lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:50:52 -0700 (PDT)
X-Received: by 2002:a19:4048:: with SMTP id n69mr2461790lfa.31.1590695451707;
 Thu, 28 May 2020 12:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
In-Reply-To: <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:50:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
Message-ID: <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:17 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> CONFIG_TWIST_FOR_SYZKALLER_TESTING is meant for linux-next only.
> But CONFIG_TWIST_KERNEL_BEHAVIOR is meant for Linus's tree.

I really absolutely still detest this all. I don't see the point. The
naming is completely random (both "twist" and then options like
"TWIST_FOR_SYZKALLER_TESTING" that have no conceptual meaning.

I still don't understand why this small set of random options couldn't
just be kernel options that get set on the command line, and that have
independent and sane and explainable behavior? Why this odd mentality
of "syzkaller is special"?

I've complained about this whole thing before. I'm getting really fed
up with this whole concept of "magic crazy config options".

The kernel configuration phase is just about the _worst_ part of the
kernel, we shouldn't make these pointless things make it even worse.

                   Linus
