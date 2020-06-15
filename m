Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8894A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCPakgZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgFOJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgFOJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:11:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3438C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:11:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z9so18223769ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93ubyv2ijLwXe19Tt9xKHMpu+ryEtkx/l2lbgqZwMeI=;
        b=WCPakgZHAyE5H1SLatFgGwqf6A4OfabHc2p767umdV2YAAxUx7txfN6D+hiyJu8lxT
         3+vCpSgLgSeD6K//prLSYvb4LKFQrA79O+7Xy7E1xq9SBKLZTK9a3hG3cX4VSUNkVzyV
         80KOK+qpXdv33Mg5XsTkXRQ1DmYTdXSiXnng50jqFnSKlzD742VJYgjlb4lpP3D7D4mU
         ay2OFUZqOBbgVEJgWsHAq5hlYwU0oAY3r2F6X1gDJTEKPxmo1z6vg6k41VMLDSdQkhGY
         SbrO/5D+Xty8GcdADeNcZxYnC4EWrBg3fdR7wq9uFlxl08qiqipWrYa0zr04EX7sGBvY
         46vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93ubyv2ijLwXe19Tt9xKHMpu+ryEtkx/l2lbgqZwMeI=;
        b=O92cDBXczs87EMlSvdsSvtIbalH6qlWGLaCsd6khyuYTXrcmod2ZVO8091vvrhT1I+
         r7/MTDJAqYAeoTxUGbCABUDXqnjf6G7z377JuLtRww7ZfqDWaU6SFcJxtGUgIioP699E
         HmC864wSvwBkST+ipJvjH0kvUCTqXF++7MGbQRykIDF7iURCNvaCRslKMDeZApZYV+c6
         nNr+c/XsWj2q35QzLH334Jf9wlH9qpf2gN/0MN6htFRPs2cLWg4I6Qk7H/wdRuZlMUpS
         6c2x4ew4t5DY8pwkM+dspTk7IMoJs/5LQkUN2EsxKATIv3U6G0qoOfRbKhtT3ND+I026
         ESrQ==
X-Gm-Message-State: AOAM533q2FNEmd8E2xEhv2oOUNAnpj1ye2ALXg4xPp3ugZrl3bJrkxvC
        Z59wdtc1AvQ/3UlNe541538HdGo0vkPxNhoJIgiK8A==
X-Google-Smtp-Source: ABdhPJyTD1GjFMv10HFxk4EWmy+eG+SttC1xdYuvb+Pcr1HZqJT4elQemSSNYBchplU9b6uQI1C2Di2UTh9WaG1DjOI=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr13189882ljn.286.1592212274961;
 Mon, 15 Jun 2020 02:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc> <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc> <20200607161116.GN1551@shell.armlinux.org.uk>
 <20200608110902.GA5736@afzalpc> <CACRpkdboPBGBdHaRtZ=OAFvikYZVh=BVu192uyiB8T=yeHHEbA@mail.gmail.com>
 <20200612102551.GA5377@afzalpc>
In-Reply-To: <20200612102551.GA5377@afzalpc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Jun 2020 11:11:04 +0200
Message-ID: <CACRpkdZB5usrY1HkunoceFtz8-QhtTAojJftD=-n0s6fBB2j1g@mail.gmail.com>
Subject: Re: ARM: vmsplit 4g/4g
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal!

On Fri, Jun 12, 2020 at 12:25 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > > Note that this was done on a topic branch for user copy. Changes for
> > > kernel static mapping to vmalloc has not been merged with these.
> > > Also having kernel lowmem w/ a separate asid & switching at kernel
> > > entry/exit b/n user & kernel lowmem by changing ttbr0 is yet to be
> > > done. Quite a few things remaining to be done to achieve vmsplit 4g/4g
> >
> > I will be very excited to look at patches or a git branch once you have
> > something you want to show. Also to just understand how you go about
> > this.
>
> Don't put too much expectation on me, this is more of a learning for
> me. For user copy, the baby steps has been posted (To'ed you). On the
> static kernel mapping on vmalloc front, i do not want to post the
> patches in the current shape, though git-ized, will result in me
> getting mercilessly thrashed in public :). Many of the other platforms
> would fail and is not multi-platform friendly. i do not yet have a
> public git branch, i can send you the (ugly) patches separately, just
> let me know.

OK I would be very happy to look at it so I can learn a bit about the
hands-on and general approach here. Just send it to this address
directly and I will look!

My interest is mainly to see this progress so any way I can help or
tinker I'm happy to do. You can just incorporate my contributions if
any, I don't care much about code authorship and such things, it
just makes things more complex.

> If you would like, we can work together, at the same time keep in mind
> that me spending time on it would be intermittent & erratic (though i
> am trying to keep a consistent, but slow pace) perhaps making it
> difficult to coordinate. Or else i will continue the same way & request
> your help when required.
>
> For the next 3 weeks, right now, i cannot say whether i would be able
> to spend time on it, perhaps might be possible, but only during that
> time i will know.

I'm going for vacation the next 2 weeks or so, but then it'd be great if
we can start looking at this in-depth!

Thanks!
Linus Walleij
