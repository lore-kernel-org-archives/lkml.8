Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D625C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D64B207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="S+ggohbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFZSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:43:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C0C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 11:43:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so7662956edm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fViRCPiGbmFQGGxHysM7A/NvrpkiAu6F1Ew2P8DlPc=;
        b=S+ggohbfJIpW4SOtY2JQU7s9jtaYl1FmP4FczLGl76p7cr93CQt5d8sNohtmfXufOB
         Jf2BVaclP0C52cTiBknVLTAvbRo0dU/8lhqa1Q/Ch00umrHCHfse21oXsot0DBaAg5+4
         /FLfT5Xum/GeWU6Bmpeo5yLj/J9TlBoZtHP/jJKLg5Y94N3FcF7Q/fQvWCl8pFPLX6Ip
         dZfE7yCO4fA4D3RtnowyY+XdZ7DdYOZOE74pYabr0SDyhZIMUBAdE0NLS3+FDWYzOYx0
         V3bJcrugFwIxyQHfRH9Kz0DwteS2N4Nc/709Eogcccb5E6j5PG1yrJYuDqYQizRf/J/h
         WXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fViRCPiGbmFQGGxHysM7A/NvrpkiAu6F1Ew2P8DlPc=;
        b=HpKrcukWkUl2zkrGRqgfFWySxBppJkfFUlO6ywir0hA+t9Np+vpquMMbaSglG0/pGp
         hl/3E9VAhy26YUdyCSfBHMdIfRfGBG8kookPUlytjgTpdsa+KUEpODE4PVmkY2JV366k
         vmZxRFR8xyHavx1e8JuPl2yumaM1eKto4T/926eTJWvNYv39OwEYn0hItvszA+q+uTWA
         HCxnkO3xb4G8YjzJ604CPgTJcKcpkew2J8jLJIm8fEo9wkZe0AWuuUoJsL5KGKNRxqxk
         E8vVqFZWV8EVEwJYsD+Lfv5/tf1sakQ5mMnGizp5hYu8BM5HmREhqOlbTTGf3rbhIgsZ
         RlGg==
X-Gm-Message-State: AOAM532KAL1w6u6EBLx6lwJ1LbaBUavrOTjYcQ824+mFYhnx0xA5Lu/d
        9M0B3uHIuxdBubB/JeKrIxrQTuHNgeNLYeuEzTB/xw==
X-Google-Smtp-Source: ABdhPJwlQ42Qr7ZtTaRCNXZWEnGE4iSIeD4BD4JeqhE9xMkDCc8/N5pEp7pGYcJtNL5pMeodJb1BjK4hdu7J2sgv6EU=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr4554546edj.93.1593197002827;
 Fri, 26 Jun 2020 11:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0h8Eg5_FVxz0COLDMK8cy72xxDk_2nFnXDJNUY-MvdBEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8Eg5_FVxz0COLDMK8cy72xxDk_2nFnXDJNUY-MvdBEQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Jun 2020 11:43:11 -0700
Message-ID: <CAPcyv4jqShnZr1b0-upwWf8L3JjKtHox_pCuu229630rXGuLkg@mail.gmail.com>
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

On Fri, Jun 26, 2020 at 7:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 2:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Quoting the documentation:
> >
> >     Some persistent memory devices run a firmware locally on the device /
> >     "DIMM" to perform tasks like media management, capacity provisioning,
> >     and health monitoring. The process of updating that firmware typically
> >     involves a reboot because it has implications for in-flight memory
> >     transactions. However, reboots are disruptive and at least the Intel
> >     persistent memory platform implementation, described by the Intel ACPI
> >     DSM specification [1], has added support for activating firmware at
> >     runtime.
> >
> >     [1]: https://docs.pmem.io/persistent-memory/
> >
> > The approach taken is to abstract the Intel platform specific mechanism
> > behind a libnvdimm-generic sysfs interface. The interface could support
> > runtime-firmware-activation on another architecture without need to
> > change userspace tooling.
> >
> > The ACPI NFIT implementation involves a set of device-specific-methods
> > (DSMs) to 'arm' individual devices for activation and bus-level
> > 'trigger' method to execute the activation. Informational / enumeration
> > methods are also provided at the bus and device level.
> >
> > One complicating aspect of the memory device firmware activation is that
> > the memory controller may need to be quiesced, no memory cycles, during
> > the activation. While the platform has mechanisms to support holding off
> > in-flight DMA during the activation, the device response to that delay
> > is potentially undefined. The platform may reject a runtime firmware
> > update if, for example a PCI-E device does not support its completion
> > timeout value being increased to meet the activation time. Outside of
> > device timeouts the quiesce period may also violate application
> > timeouts.
> >
> > Given the above device and application timeout considerations the
> > implementation defaults to hooking into the suspend path to trigger the
> > activation, i.e. that a suspend-resume cycle (at least up to the syscore
> > suspend point) is required.
>
> Well, that doesn't work if the suspend method for the system is set to
> suspend-to-idle (for example, via /sys/power/mem_sleep), because the
> syscore callbacks are not invoked in that case.
>
> Also you probably don't need the device power state toggling that
> happens during regular suspend/resume (you may not want it even for
> some devices).
>
> The hibernation freeze/thaw may be a better match and there is some
> test support in there already that may be kind of co-opted for your
> use case.

Hmm, yes I guess freeze should be sufficient to quiesce most
device-DMA in the general case as applications will stop sending
requests. I do expect some RDMA devices will happily keep on
transmitting, but that likely will need explicit mitigation. It also
appears the suspend callback for at least one RDMA device
mlx5_suspend() is rather violent as it appears to fully teardown the
device context, not just suspend operations.

To be clear, what debug interface were you thinking I could glom onto
to just trigger firmware-activate at the end of the freeze phase?
