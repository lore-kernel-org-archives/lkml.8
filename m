Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E35C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7971207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTrlVXYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFZUeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:34:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213EC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:34:50 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so9150462oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOIOlSh4r4yo+YnR7R6tTIWnABCIxUskTdOr1JXoK7s=;
        b=LTrlVXYIvYk7L1NUVIYQdd54pKIFnHfzVpAr6k2KTuSv55DP1vdO1UKsEUgkC/Qq4o
         EYSR9aquAKuLJeO1XgQ2yZvS7j7Daa+FGoQlhe7MWa36+43J+ap08xMTI2G4pxQHGKpW
         KDeF953pBqbrDwyCp+jWwLxyq0hSSS1zdLHDz41yhhjQDyUpgxB8KIaMKDzLfzsLMYY3
         ySCZwzJ2qShmzmgoeDpdJBp45J+SZt4IzU+qWJwR9y0xr00Z6BKT/zSRgL+rOnb/xZk3
         pN49RqOFsQ/6Ul0Zkpt2EGbhyn/Yzxi11EYw42tHN59xxpm3fakWabr2it7z3H2t7nJo
         FdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOIOlSh4r4yo+YnR7R6tTIWnABCIxUskTdOr1JXoK7s=;
        b=IHKYeeK7DcrbANzDFTd1vXrgCGZwJ9BDU1ma4HpPvhYmEzBUiEPDw+EupJl8veZ0aA
         HLMn/SeCubWaVpX85e8h/EzTNLJKSO7QfuyJDWhnruiiIpaxivWdsgikIrtjqAw6d2Dk
         lVNR3o9gZ/LHIwY4B44oumvWWdunLyFdRFfZQ7vh0+ZaTVvd8iHkGu5oB0T65Q9afbyd
         ETLumpCtfZW+W34Av9WVDNuZsNKRyBhUJr0suk+QQfBGaCw1Yz3uGlLsQCFS9w+oEKTr
         7T3vCxxA1FxONL/fWf8f9nYrklTEzJCINvnd0pD2XZd4fmu+146h3e2N7AbLH2Oujv9q
         vu1A==
X-Gm-Message-State: AOAM531ap1tHyA3jyBHx2AxYTPqRd9n5kC4tx8MiFn1df6VozXawpz5+
        eFhh/ijEUiLXs9oheKRm+oMADAICpbXi0WHhPOCEVA==
X-Google-Smtp-Source: ABdhPJxIiX0UOydRFqi8eKVyZixDvXbvGKDoFl2inqIQEXmkCTNS269FiALsmSpa7TazSjWV9qVafZIcXOHagn0ee+Q=
X-Received: by 2002:a54:449a:: with SMTP id v26mr3939422oiv.172.1593203689542;
 Fri, 26 Jun 2020 13:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
 <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com> <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
In-Reply-To: <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Jun 2020 13:34:13 -0700
Message-ID: <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 4:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > Note that deferred probing gets in the way here and so the problem is
> > > related to it.
> >
> > I mean, we officially support deferred probing. Shouldn't we fix it so
> > that it doesn't break suspend/resume?
>
> Yes, we should fix deferred probing.
>
> > Also, it's pretty easy to have
> > cases where one module probes multiple device instances and loading it
> > in one order would break dpm_list order for one device and loading it
> > in another order would break it for another device. And there would be
> > no "proper" order to load modules (because module order != device
> > order).
>
> I'm not saying that the current code is perfect.  I'm saying that the
> fix as proposed adds too much cost for everybody who may not care IMO.

Ok, how about I don't do this reordering until we see the first
deferred probe request? Will that work for you? In that case, systems
with no deferred probing will not incur any reordering cost. Or if
reordering starts only towards the end, all the previous probes won't
incur reordering cost.

I'm open to other suggestions too.

>
> > >
> > > Yes, it is, I'm afraid.  There are devices without drivers. :-)
> >
> > Devices that still suspend/resume without drivers?! I didn't know that
> > was possible.
>
> There are "class" devices, "type" devices and devices that simply have
> no drivers, but the bus type code may still want to touch them during
> system-wide suspend/resume.
>
> Modules may still not be loaded when the system is suspended for the
> first time etc.

Thanks for the context.


-Saravana
