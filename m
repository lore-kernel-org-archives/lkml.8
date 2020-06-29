Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB60C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40A4206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tJVaTG8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgF2Xhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgF2Xhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:37:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03706C03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:37:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so7869413edz.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwGMNUNs/JpMc5DSoLRSUO97aO1NzqYspijhzCsT3GM=;
        b=tJVaTG8Ioo3QDYLqA2NorkRkWscX2xscfS9R3XtwLQT+rEbMNfHaRL6Bk8rbIh/uej
         AirGgQjjiRF694c7hRnFoUIDjYthVHFz6bRJBUJFohQvLdhkGhE/S7tpJfGL8qKlKXzf
         36cjc+IDG5LeSMPtCEtMFbzZkuC+sqjzBsuU2PertFvpBf2lDxJf2LDOSaY9AJY9BXQI
         ZfqoEtBtaoAqu7lRliNKXcaeGV3xkAyWfYCVwrTanz69SWWOazrnnM8z4g7GYY38t0Li
         jcljrAgsitEkk8cvpAF5tSVvL/XJ5zbIei/T1HHccrU8m4NbabY/JdBO8WNC90ih55ki
         LZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwGMNUNs/JpMc5DSoLRSUO97aO1NzqYspijhzCsT3GM=;
        b=J5jsb5cIHTNv1wdSfUGF0xc4qeRq/Q3yqrsLCPV1feGJGigGFRUz93j8LtEaVbMEV6
         CQK747yz6ENCTakdw4bq02RHQFTHgywQ/zI8qZ5UzFWPQHcC+YJY0s4v3s78kLOYh+WN
         MDiGjjwcpSbxs4xC2cOxChhK+EQLMNMgOBbodDWShcwMQYcB3LnwxnCmq8LGtfEmeVlO
         pFLJb5D6kMEubvgOGkFON/FQikaV8RBU+XGsGdO7dvDPic02kColTROzdharz3eUqZMI
         XUJbZEFWdyVgMFaRnyZwY7aMJwoLDD4es1w5mX4fDhVKQELcizkCl+S9l+NaoyCTfkHy
         O9Zg==
X-Gm-Message-State: AOAM532hEM3JH86UKiYGdg46Q07BkVT8VGCE1obj/rktbjYT0kYoyYch
        OtZNSAqEwOaBSiOszXZqMbXKrYc17fShq612BBWsBQ==
X-Google-Smtp-Source: ABdhPJzQhcOxd2UjylkoFHPRkO2RKSOL4IEFC19z2HjxnalZ4UmhNLPAAjlC35GC3qVFCBzqwYSLeVHAtanKB7jTuKE=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr19699724edk.165.1593473854631;
 Mon, 29 Jun 2020 16:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0h8Eg5_FVxz0COLDMK8cy72xxDk_2nFnXDJNUY-MvdBEQ@mail.gmail.com>
 <CAPcyv4jqShnZr1b0-upwWf8L3JjKtHox_pCuu229630rXGuLkg@mail.gmail.com> <CAJZ5v0i=SkqtgcXzq0oYNEAuYA-FvBEG-bm6fyidzAsYSNcEdQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=SkqtgcXzq0oYNEAuYA-FvBEG-bm6fyidzAsYSNcEdQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Jun 2020 16:37:23 -0700
Message-ID: <CAPcyv4iTJcjbfeBHbOJEai4gZyD7m79AmqQrtdkEtEUOvXaYAA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ACPI/NVDIMM: Runtime Firmware Activation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Stable <stable@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 8:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 26, 2020 at 7:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 2:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Quoting the documentation:
> > > >
> > > >     Some persistent memory devices run a firmware locally on the device /
> > > >     "DIMM" to perform tasks like media management, capacity provisioning,
> > > >     and health monitoring. The process of updating that firmware typically
> > > >     involves a reboot because it has implications for in-flight memory
> > > >     transactions. However, reboots are disruptive and at least the Intel
> > > >     persistent memory platform implementation, described by the Intel ACPI
> > > >     DSM specification [1], has added support for activating firmware at
> > > >     runtime.
> > > >
> > > >     [1]: https://docs.pmem.io/persistent-memory/
> > > >
> > > > The approach taken is to abstract the Intel platform specific mechanism
> > > > behind a libnvdimm-generic sysfs interface. The interface could support
> > > > runtime-firmware-activation on another architecture without need to
> > > > change userspace tooling.
> > > >
> > > > The ACPI NFIT implementation involves a set of device-specific-methods
> > > > (DSMs) to 'arm' individual devices for activation and bus-level
> > > > 'trigger' method to execute the activation. Informational / enumeration
> > > > methods are also provided at the bus and device level.
> > > >
> > > > One complicating aspect of the memory device firmware activation is that
> > > > the memory controller may need to be quiesced, no memory cycles, during
> > > > the activation. While the platform has mechanisms to support holding off
> > > > in-flight DMA during the activation, the device response to that delay
> > > > is potentially undefined. The platform may reject a runtime firmware
> > > > update if, for example a PCI-E device does not support its completion
> > > > timeout value being increased to meet the activation time. Outside of
> > > > device timeouts the quiesce period may also violate application
> > > > timeouts.
> > > >
> > > > Given the above device and application timeout considerations the
> > > > implementation defaults to hooking into the suspend path to trigger the
> > > > activation, i.e. that a suspend-resume cycle (at least up to the syscore
> > > > suspend point) is required.
> > >
> > > Well, that doesn't work if the suspend method for the system is set to
> > > suspend-to-idle (for example, via /sys/power/mem_sleep), because the
> > > syscore callbacks are not invoked in that case.
> > >
> > > Also you probably don't need the device power state toggling that
> > > happens during regular suspend/resume (you may not want it even for
> > > some devices).
> > >
> > > The hibernation freeze/thaw may be a better match and there is some
> > > test support in there already that may be kind of co-opted for your
> > > use case.
> >
> > Hmm, yes I guess freeze should be sufficient to quiesce most
> > device-DMA in the general case as applications will stop sending
> > requests.
>
> It is expected to be sufficient to quiesce all of them.
>
> If that is not the case, the integrity of the hibernation image cannot
> be guaranteed on the system in question.
>

Ah, indeed, I was overlooking that property.

> > I do expect some RDMA devices will happily keep on
> > transmitting, but that likely will need explicit mitigation. It also
> > appears the suspend callback for at least one RDMA device
> > mlx5_suspend() is rather violent as it appears to fully teardown the
> > device context, not just suspend operations.
> >
> > To be clear, what debug interface were you thinking I could glom onto
> > to just trigger firmware-activate at the end of the freeze phase?
>
> Functionally, the same as for suspend, but using the hibernation
> interface, so "echo platform > /sys/power/pm_test" followed by "echo
> disk > /sys/power/state".
>
> But it might be cleaner to introduce a special "hibernation mode", ie.
> is one more item in /sys/power/disk, that will trigger what you need
> (in analogy with "test_resume").

I'll move the trigger to be after process freeze, but I'll keep it
tied to suspend-debug vs hibernate-debug. It appears the hibernate
debug path still goes through the exercise of allocating memory for
the hibernation image which is unnecessary if the goal is just to
'freeze', 'activate', and 'thaw'.
