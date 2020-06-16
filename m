Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC086C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24F3208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnG7x985"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgFPQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFPQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:36:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3880DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:36:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m21so14740106eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o45SzGEhISkHwjx9Xk4Zota2ATe5VzgJHxzdX5yZlQU=;
        b=gnG7x985R1tEYKBnLkUkqIitLuGBbe4oy0tyxAEpf5dAqa8wk5smI8Q0pG0OCsItX9
         Dtq00XodNngQZXU3Dg+2Nt/+mxzu9Or+7h6TwNDXlMz2y2RVzRZZDD4xU5xoIzkyUpSR
         dlZUH/WF8264k1pLGkLagvsL1f2bnzkP2I2Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o45SzGEhISkHwjx9Xk4Zota2ATe5VzgJHxzdX5yZlQU=;
        b=sxiBX7ibMUwYkjs0sSM2iJsr3GxuuBtqLwpXqrJ8BeHbToLc/mLzKQpmuI/ab6IL2t
         95IihFIj3J3eLiq6MOUX7ilZfmMU7yMiAMIFP4PZGjcVO0lKzYHj92K71p6yFV7rty1X
         7gx+F3kKbJYc/Q/mjcm0sQKnaESpyeUnUo6bawSVOYngBD1lfPDsMTTQW1IBfg1/OmJ6
         q1WG93Cc8Fe2pjCBdygPWlkY8+I30BUCiVgL7l7SOiAyK5Xfjmurp8nTzoHQ19Dbf9tD
         pgJfobRLBtgM2OYBPAtHGDFM3SPjtjQyC0QVWJ57XkHZGgOTt5T//UiBEV4i3b2mfoEV
         2rQw==
X-Gm-Message-State: AOAM533hSPpXtYYKdVvouz34tB5umf53Tz8ZFt7BDsvdRzummjrPuQpy
        Eu3o7IenS/AFTb0MjK2+cXUgBsxJNb2crH0GyIiC4w==
X-Google-Smtp-Source: ABdhPJyc7aL3w4XRRIomOZ4mG3n4e8Sc1Y0FRNCDqH9HrUkbAg1OXuTS1fNZ/rLEGJcYfisj5f3DmVKI8970fJ0YBGk=
X-Received: by 2002:a05:6402:b13:: with SMTP id bm19mr3460769edb.82.1592325364666;
 Tue, 16 Jun 2020 09:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
 <alpine.LRH.2.21.2006151517230.9003@namei.org> <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
 <alpine.LRH.2.21.2006160403190.9951@namei.org>
In-Reply-To: <alpine.LRH.2.21.2006160403190.9951@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 16 Jun 2020 09:35:54 -0700
Message-ID: <CAJ-EccNrw6J0-Z2qAMpAT4YUZMmuAN8P33SjN6tGOjekYHggGw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:03 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 15 Jun 2020, Micah Morton wrote:
>
> > On Sun, Jun 14, 2020 at 10:21 PM James Morris <jmorris@namei.org> wrote:
> > >
> > > On Sun, 14 Jun 2020, Micah Morton wrote:
> > >
> > > > This patch was sent to the security mailing list and there were no objections.
> > >
> > > Standard practice for new or modified LSM hooks is that they are reviewed
> > > and acked by maintainers of major LSMs (SELinux, AppArmor, and Smack, at
> > > least).
> > >
> > > "No objections" should be considered "not reviewed".
> > >
> > > Can you add your tree to linux-next?
> > > https://www.kernel.org/doc/man-pages/linux-next.html
> >
> > Sure, I can do that. I should just send an email to Stephen Rothwell
> > asking him to include the -next branch from my tree?
>
> Yep, thanks.

The commit is in -next as of next-20200615

Thanks

>
> >
> > >
> > > --
> > > James Morris
> > > <jmorris@namei.org>
> > >
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
