Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F9AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AF6207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="o4cabljz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGITEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGITEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:04:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C4C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:04:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so3431782ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HVrknSfL8ql+C23zw01ZWqmehR9FZjHU4JZV921bnc=;
        b=o4cabljzdVbvDH8O8NkX8+BhJj0J92SAVsLoM3pNwetYQiDTkMzoiHBSoqyaRCcbpK
         bN3H0cE8VPe0X8dPdyd/BZYyO+ePbrAUQeTD7LGWSgFlwWmvOq1I4F8T9cXBObRwQrfb
         xRsYODmdA8314Xm7gGM+KNWAbt51b9QDUygBTUXBh8Xm0dHfvJ1WUpm0UCoz8Jw3Hhba
         fV23BgNXazQOXhAW9gek7HPXWykmppTF8Wc1jXbRlz40p5qbgf0OebvTVWFAxmt7CfSF
         LtfGadVLwFXU7Xfp5ZdVQCjvZoXK5ec7UnKtie+S8Sjfg3ZDbDegw+0zJ/gMp4vDAUIN
         5m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HVrknSfL8ql+C23zw01ZWqmehR9FZjHU4JZV921bnc=;
        b=KPGY6YCOlIKqUcBHNNWzVNYqB8hnjDfILY1nYoogUccl2tLI++crLiQh4nTVxSyzTV
         Lzzul6oOd8HIClIdV6NQMdr5U1AZOg1+LVtFQEF0/zOx5Cq/lf6XAmf/o2cKZTVWNbrP
         uqqF1nEhMOGBjDPuj5x9En+Y1iPm3HmQ9om5O5MT5PVgA9Co2/iPWFXAwvIod5x9y/08
         K0rZ8KBz55WtldIb1BHsaGBeT4mO8z7+dOABdDtW/pSi1cihyqYyahnYuhyt7c27ow/Y
         yRCJlBqGIIFTe8Fg5W/3gdQovPPguEjp/yeacf1taTVbgZZXTpmRojI2tt1/sV07azk0
         CcOA==
X-Gm-Message-State: AOAM533f506NePrbHsvovVhEK9wStYApmUlEPLq1T5AfICkWBGW/am/n
        F+8O9BdxfS3okAUwpVkjgdOUk5kqtjoh9nk2C25YqA==
X-Google-Smtp-Source: ABdhPJzUIwtwWlF5/vzyXp5OGJ+9E9DozhqBCwMNVckhSLhoi82zOvGsERiI6MqqXzGdkmHx0OKIBGLsGNdCW4aEY40=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr56909701ejf.455.1594321482210;
 Thu, 09 Jul 2020 12:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23449996.3uVv1d17cZ@kreacher>
In-Reply-To: <23449996.3uVv1d17cZ@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 12:04:30 -0700
Message-ID: <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 7:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
> > The runtime firmware activation capability of Intel NVDIMM devices
> > requires memory transactions to be disabled for 100s of microseconds.
> > This timeout is large enough to cause in-flight DMA to fail and other
> > application detectable timeouts. Arrange for firmware activation to be
> > executed while the system is "quiesced", all processes and device-DMA
> > frozen.
> >
> > It is already required that invoking device ->freeze() callbacks is
> > sufficient to cease DMA. A device that continues memory writes outside
> > of user-direction violates expectations of the PM core to be to
> > establish a coherent hibernation image.
> >
> > That said, RDMA devices are an example of a device that access memory
> > outside of user process direction. RDMA drivers also typically assume
> > the system they are operating in will never be hibernated. A solution
> > for RDMA collisions with firmware activation is outside the scope of
> > this change and may need to rely on being able to survive the platform
> > imposed memory controller quiesce period.
>
> Thanks for following my suggestion to use the hibernation infrastructure
> rather than the suspend one, but I think it would be better to go a bit
> further with that.
>
> Namely, after thinking about this a bit more I have come to the conclusion
> that what is needed is an ability to execute a function, inside of the
> kernel, in a "quiet" environment in which memory updates are unlikely.
>
> While the hibernation infrastructure as is can be used for that, kind of, IMO
> it would be cleaner to introduce a helper for that, like in the (untested)
> patch below, so if the "quiet execution environment" is needed, whoever
> needs it may simply pass a function to hibernate_quiet_exec() and provide
> whatever user-space I/F is suitable on top of that.
>
> Please let me know what you think.

This looks good to me in concept.

Would you expect that I trigger this from libnvdimm sysfs, or any
future users of this functionality to trigger it through their own
subsystem specific mechanisms?

I have a place for it in libvdimm and could specify the activation
method directly as "suspend" vs "live" activation.
