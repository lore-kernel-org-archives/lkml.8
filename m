Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FBC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0034B2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRmE9Gb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgEAUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEAUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:24:17 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:24:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so3507665otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLrxYxE4KXWJWxSR6j790DuMjgjgLciZtoYfOBBD2XM=;
        b=jRmE9Gb0nYNOE+Gavs6LlCDzaHXpMvA6/ancYUlIUj40/huBaYsxa6CR3lXiBODPnq
         ovGFy/mbQb8ZPe3F7AeF+k8Zix5htq4pol8EJ7Ar+yqxtXAC6DhmEZCaNDTluqCb4aDF
         PBgesgxCzr7aOW1xZ9PfBrcUUAPXe9Ot6H4dD6Btdja08ZKVc5hnKYqUZbGRZK8jtuka
         HnypsZJlgl3w6yyTU/Ph2zveCvWnYDcJLMTHX3rkt7xdpioEptH27a7RtxBQjzVc9pUJ
         YxQXhioMnOHSacKIDd/c/5LI/SnrCBvJVZ3e5O/6MPBdt0/45psnpiIv1s//X8vlqe8G
         LCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLrxYxE4KXWJWxSR6j790DuMjgjgLciZtoYfOBBD2XM=;
        b=XIfkqYAHAhY7M/0Z3IRiG13n7zBBIipe57cA6E/BEL1f+MsJKco82KoDzqcEL5Hxcb
         HAsmBch8i3re67bcrIy0UyoK7oxCC95cRAOvdpxtHnxkCjYBMM6DxmFwAa5sosOB+pWr
         Ls6xBa7zpoVORSXLYi6nsftOLZgFKouzXSGjfXYo66FV8kTsMY+wy8QAAFWMsYEx0lzQ
         6NeSlW+o05O12OC1KKY4ldj8nnNqrr/jJFyPBISRPgRWkmX5k2HBidGtLx00+iJadA5A
         Y8IxgpfIpYWFZCChfsaU/Q9Edw1/LX6hCwBunQhuFyzDOjvj292EDsLFeSsMf0tCqKx0
         7daw==
X-Gm-Message-State: AGi0PuYbqlk7MR09vTuDyu807L0WBXPbsk+JZWAVrGN6C1jeNTs3uKcJ
        OSlg3RZiPVW3ol1QKzgaYEEgsnsgt2zxjS0OVWXC7IT8pio=
X-Google-Smtp-Source: APiQypJvQMFd1/tXMffA+HP4JyFa6GJMbmz3cbYhTudBmpe5z1c/z3d+Q4N06aE2tR5yaKqNePvywrz1zJ+hYsZnlYI=
X-Received: by 2002:a9d:2622:: with SMTP id a31mr5303176otb.231.1588364656534;
 Fri, 01 May 2020 13:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200411045918.179455-1-saravanak@google.com> <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
 <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
 <20200429102832.4eee22b4@why> <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
 <5b605bd46d3ef213c7ec82d02967e4bb@kernel.org>
In-Reply-To: <5b605bd46d3ef213c7ec82d02967e4bb@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 May 2020 13:23:40 -0700
Message-ID: <CAGETcx9kYKOEAmLbJzmOucR2Z4qy9PCY2=UCYdYTJWTL=BeZNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 1:48 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-04-29 20:04, Saravana Kannan wrote:
> > On Wed, Apr 29, 2020 at 2:28 AM Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> >> One thing though: this seems to be exclusively DT driven. Have you
> >> looked into how that would look like for other firmware types such as
> >> ACPI?
> >
> > I'm not very familiar with ACPI at all. I've just started to learn
> > about how it works in the past few months poking at code when I have
> > some time. So I haven't tried to get this to work with ACPI nor do I
> > think I'll be able to do that anytime in the near future. I hope that
> > doesn't block this from being used for DT based platforms.
>
> As long as you don't try to modularise a driver that does both DT and
> ACPI, you'll be safe. I'm also actively trying to discourage people
> from inventing custom irqchips on ACPI platforms (the spec almost
> forbids them, but not quite).
>
> >> Another thing is the handling of dependencies. Statically built
> >> irqchips are initialized in the right order based on the topology
> >> described in DT, and are initialized early enough that client devices
> >> will find their irqchip This doesn't work here, obviously.
> >
> > Yeah, I read that code thoroughly :)
> >
> >> How do you
> >> propose we handle these dependencies, both between irqchip drivers and
> >> client drivers?
> >
> > For client drivers, we don't need to do anything. The IRQ apis seem to
> > already handle -EPROBE_DEFER correctly in this case.
> >
> > For irqchip drivers, the easy answer can be: Load the IRQ modules
> > early if you make them modules.
>
> Uhuh. I'm afraid that's not a practical solution. We need to offer the
> same behaviour for both and not rely on the user to understand the
> topology of the SoC.
>
> > But in my case, I've been testing this with fw_devlink=on. The TL;DR
> > of "fw_devlink=on" in this context is that the IRQ devices will get
> > device links created based on "interrupt-parent" property. So, with
> > the magic of device links, these IRQ devices will probe in the right
> > topological order without any wasted deferred probe attempts. For
> > cases without fw_devlink=on, I think I can improve
> > platform_irqchip_probe() in my patch to check if the parent device has
> > probed and defer if it hasn't.
>
> Seems like an interesting option. Two things then:
>
> - Can we enforce the use of fw_devlink for modularized irqchips?

fw_devlink doesn't have any config and it's a command line option. So
not sure how you can enforce that.

> - For those irqchips that can be modularized, it is apparent that they
>    should have been written as platform devices the first place. Maybe
>    we should just do that (long term, though).

I agree. If they can be platform devices, they should be. But when
those platform device drivers are built in, you'll either need:
1) fw_devlink=on to enforce the topological init order
Or
2) have a generic irqchip probe helper function that ensures that.
My patch with some additional checks added to platform_irqchip_probe()
can provide (2).

In the short term, my patch series also makes it easier to convert
existing non-platform drivers into platform drivers.

So if I fix up platform_irqchip_probe() to also do -EPROBE_DEFER to
enforce topology, will that make this patch acceptable?

-Saravana
