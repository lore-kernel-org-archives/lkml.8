Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BCC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7280720748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387298;
	bh=CwV4U8T+RZdhRTtJRV4/TteblebcduQ8ooDhayYjuck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ho9nA+PFo+ezszPtCujoeP9+1fFgE9mmU4gOGp3iLXf8rn7hugrz27K0Mzoop2Ane
	 8ADg+mTgMR+R9WuOv9f5rkd5GVUSAfMCDrd+czbazT+esuIBiLYfOy2aGF1Py4H1ip
	 YUtN0KnOEIYhvbo/S2QUhmfFI6Dn/qMasSKEWcLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGJNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:21:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DBC20748;
        Fri, 10 Jul 2020 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387293;
        bh=CwV4U8T+RZdhRTtJRV4/TteblebcduQ8ooDhayYjuck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBhk2ouz7JehdrM+jTN/hOjnS5EGUeUvdRQo0Fq603rT5ayDGt2v3YgbbEeMyi8Lb
         ItGlP+fzXBFYKgfYeQ/bOJhSdaZ6daM139/GhYzlPu6cV1ZUagv+LYCJruy6XU8UI0
         Hrt8Zi3r9ijiGbe5/V5KGCxyZdGc6WDlA0tgc5BU=
Date:   Fri, 10 Jul 2020 15:21:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
Message-ID: <20200710132138.GA1866890@kroah.com>
References: <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
 <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
 <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
 <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
 <CAJZ5v0joi2YDgAPrPhT8SMXTu-Va7s9DXVs7YDYf87JY_ntONQ@mail.gmail.com>
 <20200630153850.GE1785141@kroah.com>
 <CAJZ5v0jQYK8LHaaJ4-GeJpzGdGY2Csmp_jmHfgc7BOaXyfsZCg@mail.gmail.com>
 <CAGETcx9xCvjZiht4Z_pnFVdaYp9vLPybwZTKNZ9wHGRRCi6VuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9xCvjZiht4Z_pnFVdaYp9vLPybwZTKNZ9wHGRRCi6VuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 10:11:01AM -0700, Saravana Kannan wrote:
> On Tue, Jun 30, 2020 at 9:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jun 30, 2020 at 5:39 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 30, 2020 at 03:50:58PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Jun 26, 2020 at 10:53 PM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > >
> > > > > Hi Saravana,
> > > > >
> > > > > On Fri, Jun 26, 2020 at 10:34 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > On Fri, Jun 26, 2020 at 4:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > > On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > > > Note that deferred probing gets in the way here and so the problem is
> > > > > > > > > related to it.
> > > > > > > >
> > > > > > > > I mean, we officially support deferred probing. Shouldn't we fix it so
> > > > > > > > that it doesn't break suspend/resume?
> > > > > > >
> > > > > > > Yes, we should fix deferred probing.
> > > > >
> > > > > Please take into account that breakage is an actual regression.
> > > > >
> > > > > > > > Also, it's pretty easy to have
> > > > > > > > cases where one module probes multiple device instances and loading it
> > > > > > > > in one order would break dpm_list order for one device and loading it
> > > > > > > > in another order would break it for another device. And there would be
> > > > > > > > no "proper" order to load modules (because module order != device
> > > > > > > > order).
> > > > > > >
> > > > > > > I'm not saying that the current code is perfect.  I'm saying that the
> > > > > > > fix as proposed adds too much cost for everybody who may not care IMO.
> > > > > >
> > > > > > Ok, how about I don't do this reordering until we see the first
> > > > > > deferred probe request? Will that work for you? In that case, systems
> > > > > > with no deferred probing will not incur any reordering cost. Or if
> > > > > > reordering starts only towards the end, all the previous probes won't
> > > > > > incur reordering cost.
> > > > >
> > > > > That first deferred probe request is more or less as of the first probe,
> > > > > since commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing when
> > > > > adding all top level devices"), at least on DT systems.
> > > >
> > > > The deferred probe reordering of devices to the end of dpm_list
> > > > started in 2012, so it is nothing new, and it demonstrably works for
> > > > devices where the dependencies are known to the driver core.
> 
> Isn't "where the dependencies are known to the driver core" this a big caveat?
> 
> > > >
> > > > That said, in the cases when the dependencies are known to the driver
> > > > core, it is also unnecessary to reorder dpm_list in
> > > > deferred_probe_work_func(), because the right ordering of it is going
> > > > to be determined elsewhere.
> 
> Until driver core knows about 100% of the dependencies, we still need
> to do some kind of dpm_list reordering to have correct ordering. Even
> with fw_devlink=on, I'd imagine it'd be difficult to achieve 100%
> dependency being known to driver core.
> 
> > > >
> > > > Also commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking
> > > > suspend resume order") is not the source of the problem here, because
> > > > the problem would have still been there without it, due to the
> > > > device_pm_move_last() that was there before, so the Fixes: tag
> > > > pointing to that commit is misleading.
> > > >
> > > > Now, because 716a7a259690 ("driver core: fw_devlink: Add support for
> > > > batching fwnode parsing") is an optimization and the regression is
> > > > present because of it AFAICS, the best way to address it at that point
> > > > would be to revert commit 716a7a259690 for 5.8 and maybe do the
> > > > optimization more carefully.
> 
> No, this patch is not adding any new issues to deferred probe. It just
> increases the probability of reproducing the issue. That's exactly why
> I wrote the commit text for this patch without the fwnode batch
> processing example. Even if you revert the patch, suspend/resume
> ordering is broken if deferred probe happens.
> 
> > > >
> > > > Greg, what do you think?
> > >
> > > I've been ignoreing this and letting you all sort it out :)
> > >
> > > But if you think that patch should be reverted, I'll not object and will
> > > be glad to to it if this solves the issue.
> >
> > Well, if Geert can confirm that reverting commit 716a7a259690 makes
> > the problem go away, IMO this would be the most reasonable thing to do
> > at this stage of the cycle without risking that more regressions will
> > be introduced.
> 
> I already have a patch to avoid deferred probe during batch fwnode
> parsing. I'm trying to do a few more tests before I send it out. So,
> it'd be nice if we don't revert it right now and give me some time to
> finish testing.

So this series is no longer needed given your other series that I just
took?

thanks,

greg k-h
