Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6018C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7407520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYXAsHe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCZSqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:46:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41587 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgCZSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:46:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id f52so7011247otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSaPi1qX32z4R5hBNdjTSka9jPbPxfHe58KpVQ2pneg=;
        b=BYXAsHe9fDFiKQbkaEpYLrNdYpxCE2v5G6VFQHxCpBGHPCnN03bKIX0cr1VCAEu9Rg
         0u0HgwpXi3GMGR9xw+I0FW42IlN/vuGOf9rb7J7W1mod/M2cK7tigZBbXm1OrZVZ5nF5
         /ch76GZA+uxnx8Lv/5fIAE2nNlMg51xb2mLdTQV6oCrQ3rjG/1emnwYN5Ds+69xK8u6s
         0ZQsdzsKiK7YSCcC0K9lvBJW742xWWN0ONeh5y/5Sfjg8CpsPRwf27PTuXTfV5HFD+34
         l3TsxMQNM64kOstFhVSyTwfwxVG4Ux2OvdfP4KjKmtzL/f7ykX3qIRwtmt/hL+HXMQQM
         EdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSaPi1qX32z4R5hBNdjTSka9jPbPxfHe58KpVQ2pneg=;
        b=sfUwETqoQCKUFoMw+RyXUwUaIQ/G9wHIrxZsroFIpW37xT80S2LMuXnJvKpYN+t0pw
         n6Fk6h5r6eFlvHTdIun8wefPAU5lCgZVFnL9i1kKlKKKe9EwbQKCi8T+sJu7cmJTGjeI
         mkORkaLrLWpmDE32BPolctqVybfrtMs+bPo/UhvOFoSs1lsuCjdRzgrNGT+RXHpyFw3Z
         +PYlSf8vyhWisjVP4t/jNlEwIvbjNLpa1bhxRPFAgfFO001won15EqQxaEe5wcg5Dyu5
         qgxHx5OcTLnHHxGOFm6W1okfPw4gQGikODn+Q3dsGWzJsdW75HsSKzY9JZrdVLA7sVKE
         8RNQ==
X-Gm-Message-State: ANhLgQ0WAn67iS2h0JZQyqgJg5khD9vZbzMl7iz/h154iTKAzi76iu5g
        AEBBmQVvVDIhetyiSugnZnpF48oQmF5xgX2Fs1taQA==
X-Google-Smtp-Source: ADFU+vtzg+a7ZQexHtE4pMNO2X9rdMsKebqldlLPwKcI7thZoZW5JdSClsEyMSIJZH29yvaoRdaCI/72/CgZLGRMZrE=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr7376213otc.236.1585248364557;
 Thu, 26 Mar 2020 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com> <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 11:45:28 -0700
Message-ID: <CAGETcx8kqBsqMLm4gqY83dd0mSxucVbk7VWGXu4dKqya9nsbsg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        grant.likely@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 1:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
>
> [cut]
>
> > >
> > > Yes, it's (unlikely) possible (*), but it will give one more iteration per such
> > > case. It's definitely better than infinite loop. Do you agree?
> >
> > Sorry I wasn't being clear (I was in a rush). I'm saying this patch
> > can reintroduce the bug where the deferred probe isn't triggered when
> > it should be.
> >
> > Let's take a simple execution flow.
> >
> > probe_okay is at 10.
> >
> > Thread-A
> >   really_probe(Device-A)
> >     local_probe_okay_count = 10
> >     Device-A probe function is running...
> >
> > Thread-B
> >   really_probe(Device-B)
> >     Device-B probes successfully.
> >     probe_okay incremented to 11
> >
> > Thread-C
> >   Device-C (which had bound earlier) is unbound (say module is
> > unloaded or a million other reasons).
> >   probe_okay is decremented to 10.
> >
> > Thread-A continues
> >   Device-A probe function returns -EPROBE_DEFER
> >   driver_deferred_probe_add_trigger() doesn't do anything because
> >     local_probe_okay_count == probe_okay
> >   But Device-A might have deferred probe waiting on Device-B.
> >   Device-A never probes.
> >
> > > *) It means during probe you have _intensive_ removing, of course you may keep
> > > kernel busy with iterations, but it has no practical sense. DoS attacks more
> > > effective in different ways.
> >
> > I wasn't worried about DoS attacks. More of a functional correctness
> > issue what I explained above.
>
> The code is functionally incorrect as is already AFAICS.
>
> > Anyway, if your issue and similar issues can be handles in driver core
> > in a clean way without breaking other cases, I don't have any problem
> > with that. Just that, I think the current solution breaks other cases.
>
> OK, so the situation right now is that commit 58b116bce136 has
> introduced a regression and so it needs to be fixed or reverted.  The
> cases that were previously broken and were unbroken by that commit
> don't matter here, so you cannot argue that they would be "broken".
>
> It looks to me like the original issue fixed by the commit in question
> needs to be addressed differently, so I would vote for reverting it
> and starting over.

I'm fine with whatever approach. My only point is that code that's
been there for 5+ years might be preventing that race in a multitude
of platforms. So I'm just reviewing to make sure fixes aren't
introducing regressions. I'm all for anyone cleaning up/redoing
deferred probe.

> > As an alternate solution, assuming "linux,extcon-name" is coming
> > from some firmware, you might want to look into the fw_devlink
> > feature.
>
> That would be a workaround for a driver core issue, though, wouldn't it?

I'm not saying don't fix it in the driver core if it can be done
without adding regressions.

> > That feature allows driver core to add device links from firmware
> > information. If you can get that feature to create device links from
> > your dwc3.0.auto (or its parent pci_dev?) to the extcon supplier
> > device, all of this can be sidestepped and your dwc3.0.auto's (or the
> > dwc pci_dev's) probe will be triggered only after extcon is probed.
> >
> > I have very little familiarity with PCI/ACPI. I spent about an hour or
> > two poking at ACPI scan/property code. The relationship between a
> > pci_dev and an acpi_device is a bit confusing to me because I see:
> >
> > static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> > {
> >         struct property_entry *p = (struct property_entry *)id->driver_data;
> >         struct dwc3_pci         *dwc;
> >         struct resource         res[2];
> >         int                     ret;
> >         struct device           *dev = &pci->dev;
> > ....
> >         dwc->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
> > ....
> >         ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
> >
> > And ACPI_COMPANION returns an acpi_device by looking at dev->fwnode.
> > So how the heck is a pci_device.dev.fwnode pointing to an
> > acpi_device.fwnode?
>
> acpi_device is an of_node counterpart (or it is an fwnode itself if you will).

If I understand correctly, you are saying it's similar to struct
device_node for OF -- as in, a data struct that stores the unpacked
ACPI firmware data. That helps me understand what is going on with
ACPI_COMPANION_SET() in the PCI driver.

But then, why does it have a "struct device dev" field embedded in it?
Does the acpi_device.dev ever get registered with driver core?

Thanks,
Saravana
