Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18836206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593533517;
	bh=tgBDp+Top99y81FLgUaeB6O4/B3F9JIPwChS0Vfhuao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NcJyOy5kWnAFlEX5nGjzH07pqtnD4G1bp7ioJpThQjhk9Mai7v3RF39jJxtsN0Tk8
	 /pdfSWpnGb5uCbf/tabArlCVwXPOkacRltbcNMvkJg816B4BgrP58a+CL4X31Sdbn0
	 RRlExLYjvHY2skmL07awejPwgPkjisS2/PCO8vso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgF3QL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:11:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36327 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgF3QLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:11:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id h17so17955390oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oAJS7/DxFK7NP/QVZx01GX55au59FRD499DS77RrNE=;
        b=JyHGNUBYCOYMYA8UscQWQ3wwMudmHu1UkXxqJUOBqiZuFsMD4f5gpdBMBfgcUgKFoB
         N+Spj6r3X6mj9N2Tn7WcWaymWbQ3rv0RYc3QVDC19t/fsh1eXXr2LVBeMoUORlLasgUe
         BvDT34x5gUSD/3YT/J5GSILbhldO2RvfDxfmedMNVeyINswTV2iUVzjFqhXA9BccCXP5
         Zn3m0QkSaut2/cgN9t/Z/5h1UgewUebIuMuY3tMGjPQeWN1xJMCLf3XRfojgz2HBZioh
         hHGqu7tsqucfvHCO4G9oF5baY90ERVXDLkS7MCBd6peo/1k42NnMgDPgXZlJbBSUp8Tz
         19TA==
X-Gm-Message-State: AOAM533QpYBT91Ay/SiVh2Vz/VsL5vSo1n+CQexAeDw1t/3uwp3giYqD
        06vVqGmU+Del2zMq7L1FKuI4LIGgCL60n9Y+XxU=
X-Google-Smtp-Source: ABdhPJxlgZLytjHpRis+AQD7jkCCoO3zd23Sk0EDa+GQHXIirPT0fUBX2nOXuK2l9F+DZELyG282WCzkBxR/lqS6AyA=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr17455519oia.103.1593533514180;
 Tue, 30 Jun 2020 09:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
 <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
 <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
 <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
 <CAJZ5v0joi2YDgAPrPhT8SMXTu-Va7s9DXVs7YDYf87JY_ntONQ@mail.gmail.com> <20200630153850.GE1785141@kroah.com>
In-Reply-To: <20200630153850.GE1785141@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 18:11:42 +0200
Message-ID: <CAJZ5v0jQYK8LHaaJ4-GeJpzGdGY2Csmp_jmHfgc7BOaXyfsZCg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 5:39 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 03:50:58PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 26, 2020 at 10:53 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On Fri, Jun 26, 2020 at 10:34 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Fri, Jun 26, 2020 at 4:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > Note that deferred probing gets in the way here and so the problem is
> > > > > > > related to it.
> > > > > >
> > > > > > I mean, we officially support deferred probing. Shouldn't we fix it so
> > > > > > that it doesn't break suspend/resume?
> > > > >
> > > > > Yes, we should fix deferred probing.
> > >
> > > Please take into account that breakage is an actual regression.
> > >
> > > > > > Also, it's pretty easy to have
> > > > > > cases where one module probes multiple device instances and loading it
> > > > > > in one order would break dpm_list order for one device and loading it
> > > > > > in another order would break it for another device. And there would be
> > > > > > no "proper" order to load modules (because module order != device
> > > > > > order).
> > > > >
> > > > > I'm not saying that the current code is perfect.  I'm saying that the
> > > > > fix as proposed adds too much cost for everybody who may not care IMO.
> > > >
> > > > Ok, how about I don't do this reordering until we see the first
> > > > deferred probe request? Will that work for you? In that case, systems
> > > > with no deferred probing will not incur any reordering cost. Or if
> > > > reordering starts only towards the end, all the previous probes won't
> > > > incur reordering cost.
> > >
> > > That first deferred probe request is more or less as of the first probe,
> > > since commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing when
> > > adding all top level devices"), at least on DT systems.
> >
> > The deferred probe reordering of devices to the end of dpm_list
> > started in 2012, so it is nothing new, and it demonstrably works for
> > devices where the dependencies are known to the driver core.
> >
> > That said, in the cases when the dependencies are known to the driver
> > core, it is also unnecessary to reorder dpm_list in
> > deferred_probe_work_func(), because the right ordering of it is going
> > to be determined elsewhere.
> >
> > Also commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking
> > suspend resume order") is not the source of the problem here, because
> > the problem would have still been there without it, due to the
> > device_pm_move_last() that was there before, so the Fixes: tag
> > pointing to that commit is misleading.
> >
> > Now, because 716a7a259690 ("driver core: fw_devlink: Add support for
> > batching fwnode parsing") is an optimization and the regression is
> > present because of it AFAICS, the best way to address it at that point
> > would be to revert commit 716a7a259690 for 5.8 and maybe do the
> > optimization more carefully.
> >
> > Greg, what do you think?
>
> I've been ignoreing this and letting you all sort it out :)
>
> But if you think that patch should be reverted, I'll not object and will
> be glad to to it if this solves the issue.

Well, if Geert can confirm that reverting commit 716a7a259690 makes
the problem go away, IMO this would be the most reasonable thing to do
at this stage of the cycle without risking that more regressions will
be introduced.

Geert?
