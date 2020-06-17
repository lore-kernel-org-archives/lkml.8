Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E5EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B763F206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R04g9HSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFQSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:36:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC05C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:36:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so2665538oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m743QY4j4N0DmjtOs9fMZ2T8zbdzv+0xDLVnEkgz8Xs=;
        b=R04g9HSVEDCQQpAj4Fk2rkQDJgelNkX6wYPlwKU4hWgdpTKguFVt0V0/I7rk+UWoC7
         y16mWHOEbe169ktuBkCp5ctFMIQnGqToadXzfD5XQGYb/+gRjCqWJfua2tV/HuvWGNmP
         EL9ZaGmrYL6uCuxqjTW4Uu36mEK9mu29OG+zh8dEJj2MKZTUGnOcT6bsRf3CwqdiGo5l
         rEqQrRnZzWxfp33TrhalkbIM24y97ZOLaoRuyfEqfsFm2ZPjy2Kg7OT2b12zzSWgg7Tn
         j7N6sWyQQoYrKctp+dnnTnqwJ0tFdObNQD+maCXc9VGKdFjrtD+nFF+2Tb6iCby/vR8A
         KDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m743QY4j4N0DmjtOs9fMZ2T8zbdzv+0xDLVnEkgz8Xs=;
        b=agN/nJbb0WdUIh6iTqKU9798dS6HBomiwpXMT1Uh2p50LEdBDgW/rJQ/Ukb0JnhwvK
         e0TQVTXbv0llVZoVCo7PumDsJvFsG2kB4Pk+PUQXJtHP9Ak7Alwgbrpv1qv/mVmvjOzW
         BygbCOAuLEGzjk+aIzk+8U3z4r0WcnF3R0zToKzL5XbnV1lkcmEn6sV4jUZ/l93qX665
         zosAX95dYQq932pPv0n+A/CKkg2MGxCdXkKUzIWy2mU3TuNgHyeSrD+XTUOC3KQ4yvcv
         a6pJER4u2MOZg519+8Z7bUzqPbpuOBf9obs7CjvNGK0kqqp3ibRJZSPW6YG7Ix4fB4Y7
         80GA==
X-Gm-Message-State: AOAM533zj6KYpJ+le6rZLRnR3bkHoVNBJA1KFwB+AIF8OWXgO7xG4at0
        6+S0VcCxvh5RoMTfalhZjvtEvMb0+5AQbpt434C09A==
X-Google-Smtp-Source: ABdhPJy1DeZtFko5KqEH1OkAXfc+QWxNhghwaA9TZRXvML2oplG4BdrzrsqYZHmUTIvdb3uTTchPN7CNviG7SM1cpt0=
X-Received: by 2002:aca:530e:: with SMTP id h14mr86929oib.172.1592419011313;
 Wed, 17 Jun 2020 11:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
In-Reply-To: <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Jun 2020 11:36:15 -0700
Message-ID: <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Jun 17, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > parsing of the device tree nodes when a lot of devices are added. This
> > will significantly cut down parsing time (as much a 1 second on some
> > systems). So, use them when adding devices for all the top level device
> > tree nodes in a system.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
> when adding all top level devices") in v5.8-rc1, and I have bisected a
> regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
> no longer be woken up from s2ram by a GPIO key. Reverting the commit
> fixes the issue.
>
> On these systems, the GPIO/PFC block has its interrupt lines connected
> to intermediate interrupt controllers (Renesas INTC), which are in turn
> connected to the main interrupt controller (ARM GIC).  The INTC block is
> part of a power and clock domain.  Hence if a GPIO is enabled as a
> wake-up source, the INTC is part of the wake-up path, and thus must be
> kept enabled when entering s2ram.
>
> While this commit has no impact on probe order for me (unlike in Marek's
> case), it does have an impact on suspend order:
>   - Before this commit:
>       1. The keyboard (gpio-keys) is suspended, and calls
>          enable_irq_wake() to inform the upstream interrupt controller
>          (INTC) that it is part of the wake-up path,
>       2. INTC is suspended, and calls device_set_wakeup_path() to inform
>          the device core that it must be kept enabled,
>       3. The system is woken by pressing a wake-up key.
>
>   - After this commit:
>       1. INTC is suspended, and is not aware it is part of the wake-up
>          path, so it is disabled by the device core,
>       2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
>       3. Pressing a wake-up key has no effect, as INTC is disabled, and
>          the interrupt does not come through.
>
> It looks like no device links are involved, as both gpio-keys and INTC have
> no links.
> Do you have a clue?
>
> Thanks!

That patch of mine defers probe on all devices added by the
of_platform_default_populate() call, and then once the call returns,
it immediately triggers a deferred probe.

So all these devices are being probed in parallel in the deferred
probe workqueue while the main "initcall thread" continues down to
further initcalls. It looks like some of the drivers in subsequent
initcalls are assuming that devices in the earlier initcalls always
probe and can't be deferred?

There are two options.
1. Fix these drivers.
2. Add a "flush deferred workqueue" in fw_devlink_resume()

I'd rather we fix the drivers so that they handle deferred probes
correctly. Thoughts?

-Saravana
