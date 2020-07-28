Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78B82074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FqmzxzkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgG1NuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgG1NuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:50:02 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6199C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:50:01 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y22so17470776oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDN77Lrfz/4eRA2yxskplNqAM1qbrVrjlOL5wSU34FU=;
        b=FqmzxzkD8IClJdHk+HR2T0YqIbe0lvvgqv4SYRe+hCCjsQVDU5W/C00IiVTzClet+Y
         yQ314AlPyT4f0d/uhKD/sz2iD17msEkspp0yj8Jg0gqeF6kdPx/vOay9gKBXfKfCo9m/
         7luHR8a0QlCBqxilJBBTLxDwdB+dHpzPDs12M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDN77Lrfz/4eRA2yxskplNqAM1qbrVrjlOL5wSU34FU=;
        b=L9t6WyLQ7HWCdF+uKSjeaBFkMAGpXAdUlcr01V2fTpVICuQcTgPfPaVkTRbOOw9FUP
         I8EYiBUqyVYOiplRU6uDLbFpSZRQYSUyi1/QrwJqrWtYELClOD4ZjaUGztQVl31vacY8
         vEokXeAqWd/xdBCF2VI6tbzVNvURk2khD07DJc3W2J0F3jns4D+EelX2czgDQAoUl3T3
         MiUEswp9Vb7RfgcX6zeHi/ooTqU6OIulnXAXWV6Wbp1L1YVvQIVqV6Xqk7Tl07rtMiOk
         6c+mQOe0CUEg06t6FIYj2eYMfzoX4PQdjzioLVKIFWWpGJeJjgeSYt68VxPfF57jFXHV
         pk8g==
X-Gm-Message-State: AOAM531L+yCctQj5wgwE0noFaQ/M+pNZRwOHkWusc7mpqBayU4cFhNG8
        14wl2oJgY1sBw6EaT7NOlNLg4DE1PKaAobTb+IctjiXK
X-Google-Smtp-Source: ABdhPJwv1l0B9a9dsp3grX1uTbpQJkbhMbzTu5vflZR4A++OnC2EeBD4DP1gOya0hOOxGlSmmGux6JtPIJKLJaA2uMY=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr3296613oic.101.1595944201037;
 Tue, 28 Jul 2020 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name> <CY4PR13MB1175DCFB41F2FB2F47E43A9CFD720@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB1175DCFB41F2FB2F47E43A9CFD720@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 28 Jul 2020 15:49:49 +0200
Message-ID: <CAKMK7uFqDej_qfd3ANHx3FS4_QSvoB3j=424uNKjs28FK6PppQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- voting procedures
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Laura Abbott <laura@labbott.name>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:44 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From:  Laura Abbott
> >
> > On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd
> > like to announce the voting procedures for the 2020 TAB elections.
> > The pool of eligible voters will consist of the following:
> >
> > 1) All attendees of the Linux Plumbers conference (i.e. kernel summit)
> >
> > 2) Anyone who is not a kernel summit attendee will also be eligible to
> > vote if the following criteria are met:
> > -- There exists three kernel commits in a mainline or stable released
> > kernel that
> > --- Have a commit date in the year 2019 or 2020
> > --- Contain an e-mail address in one of the following tags or merged
> > tags (e.g. Reviewed-and-tested-by)
> > ---- Signed-off-by
> > ---- Tested-by
> > ---- Reported-by
> > ---- Reviewed-by
> > ---- Acked-by
> >
> > We will be using the electronic voting method that we used in 2019. All
> > Linux Plumbers Attendees will automatically receive a ballot. Anyone
> > who is otherwise eligible to vote should e-mail
> > tab-elections@lists.linuxfoundation.org to request a ballot. The deadline
> > for requesting a ballot is August 17, 00:00 UTC (one week before
> > Linux Plumbers)
> >
> > For those who would like to know the thought process behind this:
> >
> > Last year, we successfully used electronic voting for the TAB
> > elections. Given the circumstances of this year, we have no other
> > reasonable option for voting. While we could continue to limit voting to
> > kernel summit attendees, one of the goals of moving away from in person
> > voting was to potentially expand the voter pool. Since kernel summit is
> > not being held in person this year, it makes sense to expand the voting
> > pool at the same time.
> >
> > We will be sending a call for nominations and announcements about
> > when voting will start at a later date.
> >
> > If you have any questions, feel free to reach out to the tab at
> > tab@lists.linuxfoundation.org
>
> I know it's a lot of work to put this together.  Thanks very much for this
> new process.  I think it's a great change.

Same here, I think this is excellent.

I do think the big masses of contributors have fairly different pain
points and issues from what makes maintainer's lifes hard, so for the
imo very unlikely outcome that this will shift the TAB to be one-sided
representing contributors only, no maintainers, we can easily fix that
by formalizing a subset of the maintainer summit as a permanent thing.
De facto this is how things work anyway, can't merge stuff without
maintainers :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
