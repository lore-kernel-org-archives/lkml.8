Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC68EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE6206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0hfLaWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGFXfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGFXfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:35:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A01C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:35:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t25so43111284lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
        b=h0hfLaWYG1MhCTz6J6AARwPIxYT3gBIha6jL6xVvSUaBoYkx4N94teWLPVBCAUX5Rb
         Mgd6ZfbpomMbwqCIpw6IvR/7+AWSOpd9wxAQaDAndSKUttK7AHQnKPfJUCMld+DdpHSu
         sJug6LFr6dSpqEUPZ5+6SlqOSKPcU4TvkSh0i9oHDdnjmCAeCWWfxOD48hkHGmZ5zzLT
         Qw7h+MQdQuwG++aYuXtmJyJHTeCIayb3GEpeIJHOrsJgSiF0lfhgl6O+IMdV0iCHo6Vj
         tWwgOV29i5d0C37Jw3GV3DT1i0KRM1Kjtu1dClAUAbtDG5GPGRG8YydqDFCi9bBjresk
         O/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
        b=cjyZ4qOj7Oh8XH+hwCL1cVmDdnxdzeNYo7mnTPjVNudMjMMic/IW2l68J1xrVlemze
         1xpwBuUo46fCm8p6mL53L1YZBAd9n4wW7DTM8pi7zdYuCQ5qoPS2w+HE/WGAl03ztJ2z
         2jPC01fhYBNsYhdGaSiPYs+oysQcQN/gXiUCKByJLL4xNjgty6E03O26uUQ9wtSCjlip
         0G/f+EdocGet2Az6MlR8wJ68X1HTDFK8ghq92y0SuWza5K3JKPAG0aN+XeQa5VGtKHeY
         eg5KKV3GsldHfJygNOD/q0Uh+cmefUFQVxL9Rz/mgKbg8MI5iw0KzTL422xy2wjmM7kq
         jd5Q==
X-Gm-Message-State: AOAM533pgasj/Ta8S+ZwV+JXOnKWCfok7noN01Mg1IqNkKbP6awVPnDA
        1FcxKmR1tQE/6DEnH2Wm/YTdykyMyLXXHA9pQB1UMA==
X-Google-Smtp-Source: ABdhPJw6dXXwcyv4KY9Jl80FcEosFSoQoaGDHkx+0zdTw4HjncZQDYJNWjTLcwx9UlAXOCwdVnow/Rw2NoDsjZTLErM=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr30021146lji.301.1594078541252;
 Mon, 06 Jul 2020 16:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200630044943.3425049-5-rajatja@google.com>
 <20200630080220.GC619174@kroah.com>
In-Reply-To: <20200630080220.GC619174@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 16:35:05 -0700
Message-ID: <CACK8Z6FdWqx5oSXtAtZR7MN_yL0CS5g3yOmGeL5J9sZPHK_MYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] PCI: Add device even if driver attach failed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 1:02 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:40PM -0700, Rajat Jain wrote:
> > device_attach() returning failure indicates a driver error while trying to
> > probe the device. In such a scenario, the PCI device should still be added
> > in the system and be visible to the user.
> >
> > This patch partially reverts:
> > commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: Cosmetic change in commit log.
> >     Add Greg's "reviewed-by"
> >
> >  drivers/pci/bus.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77d..3cef835b375fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >
> >       dev->match_driver = true;
> >       retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER) {
> > +     if (retval < 0 && retval != -EPROBE_DEFER)
> >               pci_warn(dev, "device attach failed (%d)\n", retval);
> > -             pci_proc_detach_device(dev);
> > -             pci_remove_sysfs_dev_files(dev);
> > -             return;
> > -     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
>
> This should go first in the series, and cc: stable and get merged now.
> No need to tie it to this series at all.
>
> Or just an independant patch, it doesn't have much to do with this
> series, it's a bugfix.

Resent this patch as an independent patch with cc:stable here:
https://lore.kernel.org/patchwork/patch/1268456/

Thanks,

Rajat

>
> thanks,
>
> greg k-h
