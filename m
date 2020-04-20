Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208BC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5152C20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuIILliR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDTUDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgDTUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:03:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:03:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i22so9255563otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmIL5crnJ6coQ/xisfoITs7FajvHe0i8ibpe9qH1tOw=;
        b=xuIILliRNJohVGgFgY8Ms3DxS6dM2StIfONK2qFe0AJUBtvHWTQ+PuLfZ8iVFAaLyl
         FqlWJBi359Otp3AFIB7rdOUDIzzrDAK0yNelRgxBIzrNdfPIjMaIokCtpSNpP2g4X8/V
         2X04SfMv9FkywwCay+XPYQCQmO4Lckm5nPdKUlGRnLQS1AHH2Vj3XqXkvufoH19haXXQ
         ih3EaGimgqsAXoyr7rpJC2k3/5hdLXkwT9rxvWl1xgge15HPAPQ36dA9OgkKz25jB429
         miykesCoC5NyBfgxteOC6N+LQIber5p7oZtX01rwDBFEnvh0pWgkqXfjEQvSTbmavZ+3
         LK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmIL5crnJ6coQ/xisfoITs7FajvHe0i8ibpe9qH1tOw=;
        b=o6DR4yb4i2yyDaCQFwpKNoYxVMnLePJm0YpA6fAwBGDZfNr6NxpGnj/79liXv8mY8w
         PC2JKh2We2+7LycIqmD3Pv23DcGcHkcy0r1HEmYKdApRpvf7txTTUvUUyX+cV/bEac9v
         2nzAjN9LQXCAXhUizqCwRrsTph/YIElaBYxgrWihmjnwXAGFeyI9Joph8egzyzKppl4x
         e9gnVnHMGScz1kwVyPwSkZPmFl2SxudDHQ3EgtgdU2DiWMSGM/E6PzSGRnr58yuFYmtv
         KIWYTFmdk1JA9gOGxkhBEAxzpQyW2t7/hC5DIPwPnQ1YM+4CDsk1Ykm1w0+s7kuR4zMB
         ixKw==
X-Gm-Message-State: AGi0PuYaC54A33EaguqwN9JcAQh4wkZVpIJXjnFZNOd5Wwn4yEs0xSIn
        3EIiKDCZCrjRLaTZWpwKDh2u3xhQOUPcR4AsdVza+SOQ
X-Google-Smtp-Source: APiQypK2nqgSukevEMOkrgEiY+Twkm4ExNtv93iL2MCVA6EiSnE9I0/kG/gRCZfwm2sf3tRai+xV044YMqqalBHAyGM=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr10406884otc.221.1587413029451;
 Mon, 20 Apr 2020 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200414134629.54567-1-orjan.eide@arm.com> <20200414141849.55654-1-orjan.eide@arm.com>
 <20200414142810.GA958163@kroah.com> <CALAqxLX-SUhHPH6ewt-s9cEMc8DtMTgXem=JruAkLofuJf1syg@mail.gmail.com>
 <20200416102508.GA820251@kroah.com> <20200420082207.ui7iyg7dsnred2vv@wittgenstein>
In-Reply-To: <20200420082207.ui7iyg7dsnred2vv@wittgenstein>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 20 Apr 2020 13:03:39 -0700
Message-ID: <CALAqxLW-txNEqW=P_9VTxvOVu_fgpjzHHDbR5BhtpYwhg1SXgw@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: Skip sync if not mapped
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Laura Abbott <labbott@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Anders Pedersen <anders.pedersen@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        nd <nd@arm.com>, Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>,
        linux-media@vger.kernel.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:22 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Thu, Apr 16, 2020 at 12:25:08PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 14, 2020 at 09:41:31PM -0700, John Stultz wrote:
> > > But I do think we can mark it as deprecated and let folks know that
> > > around the end of the year it will be deleted.
> >
> > No one ever notices "depreciated" things, they only notice if the code
> > is no longer there :)
> >
> > So I'm all for just deleting it and seeing who even notices...
>
> Agreed.

I mean, I get there's not much love for ION in staging, and I too am
eager to see it go, but I also feel like in the discussions around
submitting the dmabuf heaps at talks, etc, that there was clear value
in removing ION after a short time so that folks could transition
being able to test both implementations against the same kernel so
performance regressions, etc could be worked out.

I am actively getting many requests for help for vendors who are
looking at dmabuf heaps and are starting the transition process, and
I'm trying my best to motivate them to directly work within the
community so their needed heap functionality can go upstream. But it's
going to be a process, and their first attempts aren't going to
magically land upstream.  I think being able to really compare their
implementations as they iterate and push things upstream will help in
order to be able to have upstream solutions that are also properly
functional for production usage.

The dmabuf heaps have been in an official kernel now for all of three
weeks. So yea, we can "delete [ION] and see who even notices", but I
worry that may seem a bit like contempt for the folks doing the work
on transitioning over, which doesn't help getting them to participate
within the community.

thanks
-john
