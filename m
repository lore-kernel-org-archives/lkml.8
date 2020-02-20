Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09581C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58F42467B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ogz19Yk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBTVHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:07:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40508 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:07:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so29007737oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEqpM8pTtaa8kBXvkF2afExhU5VE6hhbxQEYZLM9f9o=;
        b=Ogz19Yk9H5XLTzlI+qsBb9pKsbfdiaNb5kF79rjKWhBEiVTuvEgj5EsUj9ruE3km4w
         M+PE0CvSxQ5sgsNeolKQP8tCMFBCNvJRgdjo/gElctJ6SP0CewQp7aYQkEGw+UIjRTFg
         vt7lBLrKyCfnh29JuTNTZnjtzY463oih6WInzqzHqB/+VTDEUTKHp2QCWkiEJKGN7iow
         GRxD4epiqERA1pKy1YHUrVkVjOiGawggCRZrdSWCG75/OcF94SjTlrTUcF4pyRMvzeOy
         uoET6vHol5z9RTvtD7HcW3kJ76gnNqt3KIEMVP5y3cTKAWn//lGtjwd3XD1wjUN3p0Pc
         w2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEqpM8pTtaa8kBXvkF2afExhU5VE6hhbxQEYZLM9f9o=;
        b=Dagu7E5bxoRqjXZpWMbaz9H7rL8iAgTSHVsIA3LsKDRfKbBdHjQ/CJ8fHRg/Chkn6d
         YugyPhHBOktHBh1i49InAlB2Ka9Od94kbw6NVcaSUu5JHSxxJKTbwDmeS3c9BRzGXH8t
         2CCvyWavaCjB8AGmmdtBb4QWIHSowjd+3UZeFGHjiF7MPT1F9mxEHY+Lu4Txfs3n3Evw
         zjqQPpifXPyvSWnHFoQOlfo9uidunL6FWxpz3BRRcLaFuNY+nrVOFZ5d7TZsIiYV6tL1
         4jp8LFcOiCa6TfFvfyJPE1ZAmcrrD5hd5Ckn1YaP9c79haiaLeIEh8wchoozZ5Zm4TBf
         HrsA==
X-Gm-Message-State: APjAAAXV9mTDl+wmn/yGF1ABEtl6qjgr9tgIOekETf+l8+GVbUiFapmL
        ik9UTdP17SRUlpHrIFqjS1E+nREM8VneCdkjGF3bqw==
X-Google-Smtp-Source: APXvYqxP9PKok58LLUUNG7nVhdeqHClNCruXo6w/QQOGtYMT/Kv9n9pcPat7eHyeC0AxTQIEXiJHdcvVDAbN5BCqY34=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr3628425oih.30.1582232824291;
 Thu, 20 Feb 2020 13:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200220052739.87057-1-saravanak@google.com> <CAHp75VfodUCQWRcPB08Qmp8o+BxwL4j4aAgqt9cuJ=mHLLAQyQ@mail.gmail.com>
In-Reply-To: <CAHp75VfodUCQWRcPB08Qmp8o+BxwL4j4aAgqt9cuJ=mHLLAQyQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Feb 2020 13:06:28 -0800
Message-ID: <CAGETcx-ZbU2qWTyi_Np_YsgDEBYWk2dhJoYMjxJknZT_FiWvGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Kjos <tkjos@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:09 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 20, 2020 at 7:29 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > at the end of initcall"), along with commit 25b4e70dcce9
> > > ("driver core: allow stopping deferred probe after init") after
> > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > instead see an error causing the driver to fail to load.
> >
> > Both of those patches were the best solution at that point in time. But
> > the kernel has changed a lot since then. Power domain and IOMMU drivers
> > can work as modules now. We have of_devlink and sync_state().
> >
> > So, while a delay might have been the ideal solution back then, I think
> > we need to work towards removing arbitrary timeouts instead of making
> > the timeout mechanism more elaborate.
> >
> > I think driver_deferred_probe_check_state() logic should boiled down
> > to something like:
>
> ...
>
> > Once we add of_devlink support for power-domains, you won't even hit the
> > genpd error path if you have of_devlink enabled. I believe in the case
> > you are testing DB 845c, of_devlink is enabled?
> >
> > If of_devlink is enabled, the devices depending on the unprobed power
> > domains would be deferred without even calling the driver's probe()
> > function.
> >
> > Adding power-domain support to of_devlink is a 2 line change. I'll send
> > it out soon.
>
> ...
>
> Pardon me for not knowing the OF and devlink stuff in particular, but
> have you had a chance to test your changes on some (rather complex)
> ACPI enabled platforms?
> Would it have any complications there?

Hi Andy,

I'm not sure which changes you are referring to. So I'll try to answer
all possibilities :)

If you are referring to the pseudo code proposal, it's mostly
narrowing down the conditions under which the timeout will matter.
1. It's ignoring the timeout stuff if modules are not supported and
all initcall levels are done.
2. If modules are enabled and of_devlink is enabled, it's making sure
the timeout doesn't apply.

(1) seems like a straightforward assumption. (2) is functionally a NOP
for ACPI based platforms. So I don't think we'd have ACPI specific
complications here.

If you were referring to the "of_devlink support for power-domains"
that also won't have any impact on ACPI platforms because right not it
only runs for OF based systems. So again a NOP for ACPI.

Hope that answers your questions.

Thanks,
Saravana
