Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E41C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF35E208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585692811;
	bh=rFvt+ToLBB95MFxc/H8l53W1M0wuKHcQEL61VsTaY90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lACxvatVFOh/M7MWcbgeZmvr0PYBVBL/on33EjehbOXKH0APSRrlA+P/1N9O5sIza
	 QQO3J2SAIq6rmtnreg6mcoW+PVCgRaMfTj0VrPMu4fykj5c4xmrR0S8b3c3+yJ5A0V
	 7g2FS/CsH1d8qE+aJt/W/tm5C19R1XjXy6Wx8u4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgCaWN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:13:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45600 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:13:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so18658627lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtbYTciJK07jpdPYpkNJRH8jV4d1kYg8E62AbUGe3pw=;
        b=HE60VHr7dC08AjHaH2CgEeHp+dZk7gZqcXrCAw5ifgJOucC6ubxyOlVQwquxMFIsF5
         O6NSLvh2yE3irvxWcdx+uCSeJo3zKjKq1sRi3XBH/Ek+Vj7dHkcye6EDJRRI6WOUV++t
         61C7te9TAISjpbHISGWt0qjBDA6+IaHouXsas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtbYTciJK07jpdPYpkNJRH8jV4d1kYg8E62AbUGe3pw=;
        b=Up1+C8Z9ASg+/VUQN64ROJRd0No6lnnNGDhu0cQ14MxKwDbjn+wy8rC/kMPx66o8VA
         a8OTAVgdIoQVKmn5DNATigdXx0b2Ua9BLAqyqfTXKk3VV+GskZg7xxVAcbNTdgi84jxG
         56As+yIwNMxA7R6ymLYnrA7ruWk1mizxfeHReqVO2KLNTVYLsdxDaUl9Nj2/ljxueMnq
         BLiz2KNGEB+hrbkK1B4iqxW2J7DMBZfA39vwt2eXFGF9hlZ3EnSMQ1OIal8OScGV7EZ/
         dzBMD/oUA1Obs3T2vpTWKmeA9pRmCxN1kQi4ehHISBpBxILiuN1kOEfwIC58I2EeEU1W
         ca9A==
X-Gm-Message-State: AGi0PubvIzvD324lrLQHJlCV+j9dAJetzUYpfXjyvsHaDymSSVZsiMTy
        rE2BhAM5pzOg4o1JaopmwMcRCWmOXP8=
X-Google-Smtp-Source: APiQypJsb6KXHjMilNHfOE/Mblc2HDKdpOkL/lVIRmXZNDJ0/i73V6bliIOwmZ8EXVBy2H+eYX3gyQ==
X-Received: by 2002:ac2:5327:: with SMTP id f7mr10348987lfh.214.1585692803545;
        Tue, 31 Mar 2020 15:13:23 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f2sm9268199ljn.101.2020.03.31.15.13.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 15:13:22 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u15so9607257lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:13:22 -0700 (PDT)
X-Received: by 2002:a19:7f96:: with SMTP id a144mr12862417lfd.31.1585692801950;
 Tue, 31 Mar 2020 15:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
In-Reply-To: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 15:13:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ6WCa_8dK4=DBiFMqP5yHzmSgZHqdXuEqHUcejUtw2A@mail.gmail.com>
Message-ID: <CAHk-=wgZ6WCa_8dK4=DBiFMqP5yHzmSgZHqdXuEqHUcejUtw2A@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.7
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 5:38 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The merge conflict is in security/selinux/hooks.c and is against a
> binder fs name fix we sent during the v5.6-rcX cycle; the fixup is
> trivial but if you need me to fix it, let me know.

No problem, it was as trivial as you said, and I don't think I screwed it up.

I appreciate the heads-up, though, since not only does it mean I don't
get nasty surprises, it also means that I get that warm and fuzzy
feeling of knowing you're on the ball..

> The maintainer
> screw-up deals with the second patch from the top of the pull request,
> the NFS fix.  The screw-up isn't the fact that this is a NFS patch, we
> talked to the NFS guys and they are okay with it.  The issue is that
> the commit date is today - during the merge window - which doesn't
> reflect the testing the patch received.  The reality is that I merged
> this patch back on March 12th, and it has been part of our testing
> ever since, but when putting this pull request together I noticed that
> I had dropped the subject line from the patch when I was merging it.
> Not wanting a malformed commit, I popped the top two patches from the
> stack and restored the missing subject line; this had the unfortunate
> side effect of making it look like the two top patches were just
> merged today - my apologies.

Again, this is very much the way to let me know, so that I don't get
that uneasy feeling about anything.

Thanks.

               Linus
