Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2EC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8567020731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqcFUMIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgELWkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:40:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8834C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:40:19 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p127so255497oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bNM+LRXQLhfM15f0jdqGWESmx5RlpJDftO3Gg7t7cc=;
        b=KqcFUMIh8UWJgK/XmrpXu/XGO7eVFNuuffr7cgx0aJ3uMowg6wgmZwTVf4foF6sOH3
         WGRd6gxRKqaBmoAJtZrzpRlRZw+MbVM06eBrM5Px87f9bx053ZKc32AwuLkJiEOjKm/+
         SLBZe1muK8gOWfdqjAIqA44fMbncncbxI844Jt4BfJw24VRY7S9NxUpoRPis/wR9tGna
         /3KZoVKmwU/qQ0gsSHNtJeic16cI700H+eu0RjP6qupwhhzjaSr1jnfvcL1doqTS+dYl
         rbcrMTibClY8QLK6TQaTUcj1OGWziDR7iYQiT6/yfJFxaUVOc1RnStIsvEDzGjY2R/ND
         55zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bNM+LRXQLhfM15f0jdqGWESmx5RlpJDftO3Gg7t7cc=;
        b=k1RUHzAJCZdwWIcGUX90w0InR+x9fg/5i+znjYauYGCun5M7prtcnnY0eGrOldhKGJ
         BotpK52al7hkyZK9yxhZYy4XenB4i1698kJq2dtpRF4m8U0AwscGUqHfr6MjsudY7wbP
         Huc+PNHmzvtBgoZ4uCgfqb/teiv06rDAp7xMFLc71zFTYlNtjHa/yCD6rXZPIOSoT5rV
         COXBfK6Sai5SwoYQeMoGQEAIwIGk/nKbcxhI3iwWgiy6SEHbdy6MJH4lXyYw/zzADccK
         6SRRhD18DqWlfCatIf982oop5dGRmn+KGayZnknEy9qE5/cQL+5dOuAFv83MFKuOjDpo
         CFVQ==
X-Gm-Message-State: AGi0PuYBAwv6RfAud1cNLG6y4TC9ywi8gPC92oNPudN0QT6Gb3Bc0ncp
        UWZEjAr+j07AyFn1cywqxrtR9VBfrvw+NzEfGIkSBA==
X-Google-Smtp-Source: APiQypKMZeGh7xoGuZo21D3/NppWJJViD2A3wd4mjABwsrdzfU1ijASAeU6npG2Mk6qHVi9PAOFtIW+LzaJGeh6hEYE=
X-Received: by 2002:aca:3c09:: with SMTP id j9mr15778393oia.169.1589323219125;
 Tue, 12 May 2020 15:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190923130531.GA27774@asgard.redhat.com> <87y2pxvsbr.fsf@osv.gnss.ru>
 <20200512223103.GC1016@asgard.redhat.com>
In-Reply-To: <20200512223103.GC1016@asgard.redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 May 2020 15:40:07 -0700
Message-ID: <CALAqxLUGr=+UjYhQSN34fUMCqj1Ya85tbFKu685cN+XTWYfgXg@mail.gmail.com>
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros and
 functions to UAPI
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 3:31 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> On Tue, May 12, 2020 at 10:58:16PM +0300, Sergey Organov wrote:
> > Eugene Syromiatnikov <esyr@redhat.com> writes:
> >
> > > As of now, there is no interface exposed for converting pid/fd into
> > > clockid and vice versa; linuxptp, for example, has been carrying these
> > > definitions in missing.h header for quite some time[1].
> > >
> > > [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
> > >
> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > > ---
> > > Changes since v1[1]:
> > >  * Actually tried to build with the patch and fixed the build error
> > >    reported by kbuild test robot[2].
> > >
> > > [1] https://lkml.org/lkml/2019/9/20/698
> > > [2] https://lkml.org/lkml/2019/9/22/13
> > > ---
> > >  include/linux/posix-timers.h | 47 +------------------------------------------
> > >  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 49 insertions(+), 46 deletions(-)
> >
> > Was this patch applied, rejected, lost?
> >
> > I can't find it in the current master.
>
> IIRC, it was ignored.

Overlooked. :)  Not intentionally ignored.

I don't have any major objection with adding helpers, though I feel
like you're exporting a lot more to the uapi then applications likely
need.

Would it be better to add just the bits from the missing.h header you
pointed to:
#define CLOCKFD 3
#define FD_TO_CLOCKID(fd) ((~(clockid_t) (fd) << 3) | CLOCKFD)
#define CLOCKID_TO_FD(clk) ((unsigned int) ~((clk) >> 3))

 to the uapi header?

thanks
-john
