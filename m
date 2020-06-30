Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2808206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593525073;
	bh=hp9YsaFh9SLUD3lW1hpjUklDzQI+r1KAAnSa/QTsuQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mRi+8/XvjF7/UH4ZBN3xlFV0KlTC/IlqHHVXLn/YPNrxOCgQM9+zWxz62avNw3SnR
	 018qwn2gmVEkxl2vT6qbFj4Mj8tulrl1s9iPnzyPGc8PjNACYoLd6t+9EOz13pmFO3
	 3sr7UVbNhVZb/fKqp/Z9WQ0Z52q1Lu6LkhfoNnmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgF3NvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45065 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgF3NvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so18432253otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ejj1G0YSGoBvVl7uByu3sBEnG7igdoEhYevkJ1IcpxE=;
        b=ETUyGKa/33UjamPvmhNnM9dAnCYH56YYaJrOHawyaGkO9IISmwA6D65EWneuA2NCoK
         pl4wR8jqY1ywOcbP6vQEhIFV9ODOitu1s6Xx2A+7v9KsqLhd1o/U5OWIJmQtfDLtG/V7
         d+6BU/qhOpVLmKo9R4i1QuPryFMzadHt6sg7KbG4159weM3BD4IVl9eNKG5DRWSX6Bz9
         vSezWqWAbY6xm1YRLLiTCIycKD09SJEe/WmzOe3DLuz57u8jihmHAQbtApB+ZOhtRplr
         WlKalhP/g1PQp/maYrGhpeUg7C9inus2eqb6OVfBjX/nkBInwj4Cf29DRkJV3OryjS5W
         w0GA==
X-Gm-Message-State: AOAM5326PUANgn0fmbZfcidiNlI2Z7fi8DRnHBznFzT/PfsJY3yWqDMx
        jjckq5CIsEb/O95aGd3VTgIwjWhTA9FPG+yf0vRAOOFY
X-Google-Smtp-Source: ABdhPJxLzjHDHQHwGnLiVgjt/l/MhNwB3BmrzQp4hxACyWqlp/zqZrkod3ek0pXcULvy/JOuF26n0IE31y4TLN8DydQ=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr17346602otn.118.1593525069269;
 Tue, 30 Jun 2020 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
 <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
 <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
 <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com> <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
In-Reply-To: <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 15:50:58 +0200
Message-ID: <CAJZ5v0joi2YDgAPrPhT8SMXTu-Va7s9DXVs7YDYf87JY_ntONQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:53 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Jun 26, 2020 at 10:34 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Fri, Jun 26, 2020 at 4:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > Note that deferred probing gets in the way here and so the problem is
> > > > > related to it.
> > > >
> > > > I mean, we officially support deferred probing. Shouldn't we fix it so
> > > > that it doesn't break suspend/resume?
> > >
> > > Yes, we should fix deferred probing.
>
> Please take into account that breakage is an actual regression.
>
> > > > Also, it's pretty easy to have
> > > > cases where one module probes multiple device instances and loading it
> > > > in one order would break dpm_list order for one device and loading it
> > > > in another order would break it for another device. And there would be
> > > > no "proper" order to load modules (because module order != device
> > > > order).
> > >
> > > I'm not saying that the current code is perfect.  I'm saying that the
> > > fix as proposed adds too much cost for everybody who may not care IMO.
> >
> > Ok, how about I don't do this reordering until we see the first
> > deferred probe request? Will that work for you? In that case, systems
> > with no deferred probing will not incur any reordering cost. Or if
> > reordering starts only towards the end, all the previous probes won't
> > incur reordering cost.
>
> That first deferred probe request is more or less as of the first probe,
> since commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing when
> adding all top level devices"), at least on DT systems.

The deferred probe reordering of devices to the end of dpm_list
started in 2012, so it is nothing new, and it demonstrably works for
devices where the dependencies are known to the driver core.

That said, in the cases when the dependencies are known to the driver
core, it is also unnecessary to reorder dpm_list in
deferred_probe_work_func(), because the right ordering of it is going
to be determined elsewhere.

Also commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking
suspend resume order") is not the source of the problem here, because
the problem would have still been there without it, due to the
device_pm_move_last() that was there before, so the Fixes: tag
pointing to that commit is misleading.

Now, because 716a7a259690 ("driver core: fw_devlink: Add support for
batching fwnode parsing") is an optimization and the regression is
present because of it AFAICS, the best way to address it at that point
would be to revert commit 716a7a259690 for 5.8 and maybe do the
optimization more carefully.

Greg, what do you think?
