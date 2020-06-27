Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C52080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="Y/cIGhRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgF0I64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgF0I64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:58:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B69C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:58:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y13so6371045lfe.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKV1r6C8//IPYV99TpfkgFMNXesYLRNzzT96YTJF3tw=;
        b=Y/cIGhRz04nSz/e1Yb6lbZ8Wjx6MM8VMB/3BhWbxV6sQZtPC8xKKgHfQk3iBCUDqdx
         8mWobVejsEXpiRZMsGbkDwPT0/9wMTdFfvmF8SP6F7slI09RNNyPdF/mLmAl/wm0Tf95
         iHmPWAv9yIpqr0YBmciPlRNHrYsbzSaDJxxsX7syTSqGwd8bs6I6yThGsCLfw+pm8xwP
         I3qwDfLpX4FU6mfoIadrCWAqWPvsHPEwYt6c1K5QW5YfS7G86W0fLwfF9chjBvq8HS8n
         u+WO1cDk8FDlYzo8GHUV9sag1ps9iRvQRhnunakTi4HGtvQv675ewdusehB4/PpR8a8/
         y8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKV1r6C8//IPYV99TpfkgFMNXesYLRNzzT96YTJF3tw=;
        b=q9ejHYMmpCgFOmVHq1ncNrevViFuifjUHEuwljeE8uk0IJqmx5q+6UQysvlVf6XJuf
         vW/pqTcj6ol3Y188XrXCY+3aaS6joqctW6TUtAKQCK+lWLtnKlSMpoDu1h1eK5TLu5jA
         dq6fiGTBm4+nvpoapfzPAYCV30twmLxU57eyqEh9aAval9mTkM2m9H7KLot0u6TQ7tcp
         +HMrRWnaw1v2ZlWAb/vb2uCdpwiROS3PWAemEgbLJG6kZ3C8rF+5zZL3svIxqRegO00Y
         /VlVwRpo+OdmnWkJywUkSlCy27Z1lbojwmKJEvE7n/IWjl1buYJxvjyUCqG4WDEUlJNW
         G4dQ==
X-Gm-Message-State: AOAM533on0G3ErP6QcL6FH981bDpGjsvbCj/qqcIAhzPH51gsm0Eve5N
        1Be1QNRqii8JuSdQ9LITnQCKbTVi0tq9Ipj/YeV13w==
X-Google-Smtp-Source: ABdhPJx7U2X5RD8sayxg4a0IOn4pwsm3iim1b+b6ncO8SyHU+UV4FzHo/35eWqkovOhidBlzpqApnsRg0BJKkO21cfQ=
X-Received: by 2002:a19:c797:: with SMTP id x145mr4068841lff.143.1593248334135;
 Sat, 27 Jun 2020 01:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200626143205.xns6nwggskssujao@pesu-pes-edu> <CAAhDqq0tSftPxMWGeVy3mp4DGDN3o0uQwTqVbjYUwjqzWpbibQ@mail.gmail.com>
 <20200627050745.GD226238@kroah.com> <f73c5a69-1bf9-d80d-2399-ef18ce78b8ac@xs4all.nl>
 <20200627084932.GA1560170@kroah.com>
In-Reply-To: <20200627084932.GA1560170@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Sat, 27 Jun 2020 04:58:41 -0400
Message-ID: <CAAhDqq1g5WYL07F68Dy2mvPuQTabYcqSwOFOjBU1nccWxSL5rg@mail.gmail.com>
Subject: Re: [PATCH] staging: media: usbvision: removing prohibited space
 before ',' (ctx:WxW)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the information.
I will take care of all these things from the next time.

sorry for wasting your time

thanks,

karthik

On Sat, Jun 27, 2020 at 4:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jun 27, 2020 at 10:28:31AM +0200, Hans Verkuil wrote:
> > On 27/06/2020 07:07, Greg Kroah-Hartman wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Fri, Jun 26, 2020 at 11:42:49AM -0400, B K KARTHIK PES2201800185STUDENT ECE DeptPESU EC Campus wrote:
> > >> Oh, I'm sorry but wouldn't it be helpful if we had a file that lists
> > >> all drivers that are scheduled for removal?
> > >
> > > The TODO file in the directory for the driver should have this
> > > information in it.  I don't know if all of the media drivers have this,
> > > if not, then there is no way you could have known this.
> >
> > They have, and in addition the Kconfig entry will mention that the driver
> > is deprecated.
> >
> > TODO of usbvision:
> >
> > The driver is deprecated and scheduled for removal by the end
> > of 2020.
> >
> > In order to prevent removal the following actions would have to
> > be taken:
> >
> > - clean up the code
> > - convert to the vb2 framework
> > - fix the disconnect and free-on-last-user handling (i.e., add
> >   a release callback for struct v4l2_device and rework the code
> >   to use that correctly).
>
> Ah, great, nevermind then!
>
> B K, your wish is already granted, the text is present, you just needed
> to have noticed it :)
>
> greg k-h
