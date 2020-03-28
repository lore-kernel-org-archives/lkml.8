Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5A720716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjZXpr+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1LNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:13:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39142 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:13:54 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so4394144pjr.4;
        Sat, 28 Mar 2020 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHKDu3SHaGK6jliTTjKmnnyNvNI2zpe4g9Mnvcse/6U=;
        b=JjZXpr+faWoFwnjljT/0aLpOMDk8TEgnmJo5L/tJtSac1bSLEI/7nzIMDDflEAndud
         t04+2fwxNWfa0/yVL2EOOrh+dJBumrDRR1PUQO2nZ4GqhHxiSMvwhStGoyOmQNv+tgPn
         ieKULnxkXw0O7XA0pzo4/0XtZf3KuaKGcq8BQF3aEviBvQHf3ICILu1RyallfDi6BzbD
         wLZXwJzSL27Kn/ygUc2MQoul2uuqnmnW6rtwEZBP3lNiEGgIOSfsVgDbzRu7GcodnI7T
         lDuUoDF5AqRN4qTNX75v7s4odfqgWZbZFzNDq6/u4fD7K6DMu2A4jfMZw+GawwCHXnGL
         ODEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHKDu3SHaGK6jliTTjKmnnyNvNI2zpe4g9Mnvcse/6U=;
        b=f9/Nl03TiRGUEFkuRWC+5SHJoJexdTtGIczpxwQeiAbnQgHXh6NKKzLctlINJGCqwe
         vtMoGIvnrKa19ca4jXCXjk5pJHjVUi01YR9xPn2IrEiQrspYQGd0QSTfxmBg1SU7ab4d
         m9mvz+qp+27S3gHe4g8Vyz4+YkmtATBOKtSGNscPB9zowgUtBscf6GpkCabI7zxMY09g
         VqWK7j/l/7Ae8G6aJhCVzR//+4OylL0Dfuygf696XppDpaalI70Sg8QOIwyn2g8pVbKn
         oDhfOmTDTk4EuBzIF9E67R4AK8kUNe8JtDP+6EXA511EoSoIGKICjVY0hdj9bH86bR1C
         IWXQ==
X-Gm-Message-State: ANhLgQ2MyhmuyzlG6Ao5NpMxex0wm4Y3qyqNVx/XWRN7L3c2zRKYNW0Y
        Hnj34NBQ7FQlm6nrbe03TOisS2aWFmlXDEAXh70=
X-Google-Smtp-Source: ADFU+vsPlAnVEJwYfCnbQleJ81FB80fakkIOo5K9e6HANE1E53SCYgT1ENfkiEGwEuoODWldO34h3mWNIPElz3W8eqY=
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr3440708pll.255.1585394033590;
 Sat, 28 Mar 2020 04:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170132.17275-1-grant.likely@arm.com> <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
 <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com> <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
In-Reply-To: <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 13:13:42 +0200
Message-ID: <CAHp75VdXG2vGNp-0DLqAMx377nwyjzEt5=+Nakg4_vhaDGZB-A@mail.gmail.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
To:     Saravana Kannan <saravanak@google.com>
Cc:     Grant Likely <grant.likely@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 1:57 AM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Mar 27, 2020 at 4:25 PM Grant Likely <grant.likely@arm.com> wrote:
> > On 27/03/2020 18:10, Saravana Kannan wrote:
> > > On Fri, Mar 27, 2020 at 10:01 AM Grant Likely <grant.likely@arm.com> wrote:
> > >>
> > >> Add a bit of documentation on what it means when a driver .probe() hook
> > >> returns the -EPROBE_DEFER error code, including the limitation that
> > >> -EPROBE_DEFER should be returned as early as possible, before the driver
> > >> starts to register child devices.

...

> > >> +Optionally, probe() may return -EPROBE_DEFER if the driver depends on
> > >> +resources that are not yet available (e.g., supplied by a driver that
> > >> +hasn't initialized yet).  The driver core will put the device onto the
> > >> +deferred probe list and will try to call it again later. If a driver
> > >> +must defer, it should return -EPROBE_DEFER as early as possible to
> > >> +reduce the amount of time spent on setup work that will need to be
> > >> +unwound and reexecuted at a later time.
> > >> +
> > >> +.. warning::
> > >> +      -EPROBE_DEFER must not be returned if probe() has already created
> > >> +      child devices, even if those child devices are removed again
> > >> +      in a cleanup path. If -EPROBE_DEFER is returned after a child
> > >> +      device has been registered, it may result in an infinite loop of
> > >> +      .probe() calls to the same driver.
> > >
> > > The infinite loop is a current implementation behavior. Not an
> > > intentional choice. So, maybe we can say the behavior is undefined
> > > instead?

Why? *Good* documentation must describe the actual behaviour, not hide it.

> > If you feel strongly about it, but I don't have any problem with
> > documenting it as the current implementation behaviour, and then
> > changing the text if that ever changes.
>
> Assuming Greg is okay with this doc update, I'm kinda leaning towards
> "undefined"

I think it should not distort the reality.

> because if documented as "infinite loop" people might be
> hesitant towards removing that behavior.

This is funny argument. Won't we do kernel better?

>  But I'll let Greg make the
> final call. Not going to NACK for this point.

-- 
With Best Regards,
Andy Shevchenko
