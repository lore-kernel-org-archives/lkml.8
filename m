Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E462075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvdpalqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGJUkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:40:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C4C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:40:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so3030620pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHphsaPDEKolcYxtuiEwczCTo9yP0Y4tinyJJRJOiTA=;
        b=AvdpalqT0e7fW4Hor23dGAdTht9tqlqB3sBC5vRgjKGWYmIKu8zreUfCMXUEM4524Q
         5F+hjzPvTtkcprF66FK25Y7oVnfKr+h+HWDzVbll5l2WGMYhYW+UmjY8c8mS1kdlv4an
         5+MsEabi6LfCAxunSNzoRgjYCwr88OO7KlBFG17sDsSfRcIMV1VxzJbRCijZoK33crNn
         Mekr8rNvjuNUNpcDLTzWbza7SgfC2yS3lY3GAkiFYpEFbp0GMY2CYh7Ha6a2G0IjX8SE
         rRTWeZyxPaBof90n1s3ZOt3fggq1Bht3J+U4L73knFt3irm+PtciXuv9pNgRYrt3wMeW
         hFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHphsaPDEKolcYxtuiEwczCTo9yP0Y4tinyJJRJOiTA=;
        b=IwMc30lGN6R7RfWBIICl14juU6URc/BIH5hR6wZ+v+T6WCWiD3dj70lVfxEAiMi47q
         5SEuOV5VOqp/Tdjma53och3O+2WYebaahIoDTId/LhfjrY8PpJBxhig3XTcNwdFo6k2C
         xjnQu4KzT2mOaUhUqb9Vi7wqrImVloof1zqOmKt87RBm68TyztJe0dX3LrrknK93Qsng
         tz13bta3FdZirN62zZ0KgS+fmGXCmQIocnfhG29bd7JTjPNNkgpJFh6wvxlp73aXFF2K
         Z4YIOjUUV5lrD4TIdZupK+P0VQAbOpJ/EVz4dRr4Y4Nc5+C4nsHkRMP6toMdmF6fqG1F
         EFrw==
X-Gm-Message-State: AOAM5309V6Oa7cxqTl2GbNeHjLwdHVcGIJYzxVmSypoRdF6qXHlcGzfF
        hCEJlz+m2YEZ1s6w9klUHOxTSypBDqfEUvp5z9rKIscw
X-Google-Smtp-Source: ABdhPJw7VcFL2m4dgDICeCSmiBnJ2k5SJR6et3ydjG4xXj1Q2iTQGkRhbvIpF/+0G4qBClFyzy8/71+J5P6oZvQJitw=
X-Received: by 2002:a63:495c:: with SMTP id y28mr60595442pgk.30.1594413612107;
 Fri, 10 Jul 2020 13:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com> <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
 <20200529123025.GA1710508@kroah.com> <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
 <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com> <20200710132305.GA1920995@kroah.com>
In-Reply-To: <20200710132305.GA1920995@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Jul 2020 13:39:36 -0700
Message-ID: <CAGETcx8HutYb+LLsmdDyd5uc4Hwf+SGPiFhVQkE0q+8-Xbccvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 6:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 06, 2020 at 03:45:02PM -0700, Saravana Kannan wrote:
> > On Tue, Jun 16, 2020 at 8:45 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > Looks semi-sane, but it's too close to the merge window at the moment
> > > > for me to take this.  If there's no objections by the time 5.8-rc1 is
> > > > out, I'll queue it up in my tree for 5.9-rc1.
> > >
> > > Another friendly reminder :)
> >
> > *nudge* *nudge*
>
> Looks sane, given no objections, let's see what linux-next thinks about
> it...

Thanks!

-Saravana
