Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3C1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158B42068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0NhFHpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgFOKBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:01:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB132C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:01:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m2so6912328pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SM4junO6RsxYtsNidTq+rujDE8gOtQN9q2DY15B+ppc=;
        b=X0NhFHpHPSiSyhPZWUuIZqarNW63bMJRXZj0lVecPsoxNwkxJHx8isErxhHHG+Yutg
         f98JMoCY9GOqNahjTK94Ws1EUOtbKzFKSZMPCQdJKUzVzXzAqKrWgWY4VjA9f3iuZfqA
         2rt+EXe7fhnDXajvkrjr7SE4s+RbacQtfX431IZg9pr7qvA3HuJaHDYOuLouFFMj/JPi
         aSSyukV87RPp1PWptJNdbC17BvMuxTKdlmCu4wCokxPpKKbMASmKz3jbeiUvJa+l1JLD
         W3ASv60AtidpudKLFtis7EyqZcvyLts8tlfiXxeV0/nbrX1a8xmh+oo8JNgKk7tw0XtL
         hqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SM4junO6RsxYtsNidTq+rujDE8gOtQN9q2DY15B+ppc=;
        b=LaN+d8I+3pQBXEokWo0IU1YTjFOS03+I/5cTigStxXiiAdPaK0obgom2qOREQ+E0XC
         aVm5iTNrZPwgi1OOUlvXSFf4tG6XTW1YltcqMHgFt5sovRZcra0jK1y7btUW96kKGZoi
         8ZgTH6cXy/UTGQV7VtQ7RsRznUHVuzFqem1taH9oKC27k/vUN0LWm+uu5cCdHCF183fC
         CZPGDdG83Bwd6lBjA26K7i4zUwPpuRlV4X94utXZj4GNukU/g1/7HTWNKzXhTSeBluRy
         Rx30Yq+wt86wEvQqnZlUCtPtPqtqDhoWJkaJKhm/qDOBaaEpAu4VbCP01qemRJ0r8h3c
         lnDg==
X-Gm-Message-State: AOAM533x0l9a0G/9B+U0mbG1tN+I7uJn7w016s2sRkin5+1B58puaIor
        AGFb0OpQvLxOlPB5K5MLhH12OenSxTs=
X-Google-Smtp-Source: ABdhPJxNTo8OpibLA7vYR59eJ4apzhhKEEDyKcdjlb0z+L4e7GXG6HnQEzJeOMPvfO3eKziIynTe/g==
X-Received: by 2002:a17:902:7c16:: with SMTP id x22mr5570064pll.66.1592215291236;
        Mon, 15 Jun 2020 03:01:31 -0700 (PDT)
Received: from localhost ([49.207.193.84])
        by smtp.gmail.com with ESMTPSA id w6sm11991849pjy.15.2020.06.15.03.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 03:01:30 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:31:29 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200615100129.GB5921@afzalpc>
References: <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <20200607161116.GN1551@shell.armlinux.org.uk>
 <20200608110902.GA5736@afzalpc>
 <CACRpkdboPBGBdHaRtZ=OAFvikYZVh=BVu192uyiB8T=yeHHEbA@mail.gmail.com>
 <20200612102551.GA5377@afzalpc>
 <CACRpkdZB5usrY1HkunoceFtz8-QhtTAojJftD=-n0s6fBB2j1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZB5usrY1HkunoceFtz8-QhtTAojJftD=-n0s6fBB2j1g@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jun 15, 2020 at 11:11:04AM +0200, Linus Walleij wrote:

> OK I would be very happy to look at it so I can learn a bit about the
> hands-on and general approach here. Just send it to this address
> directly and I will look!

Have sent it

> > For the next 3 weeks, right now, i cannot say whether i would be able
> > to spend time on it, perhaps might be possible, but only during that
> > time i will know.
> 
> I'm going for vacation the next 2 weeks or so, but then it'd be great if
> we can start looking at this in-depth!

Yes for me too

Regards
afzal
