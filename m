Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79484C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E25B206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aHJYJsMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgFEQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgFEQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:18:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2FC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:18:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f7so10733983ejq.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vpo49UJFTmSx2mVUsrH28W7y/nNRaB3b36oLAS+p92Q=;
        b=aHJYJsMb22tG8d+gaPHApZ/tpiU+Utl/q5ezXcD7IBh6i14VFMTNAn3iKGTYzl9+oZ
         fXMlTcG2luZhZla1FdD+RJp2R5ShgCq/lzOj9Uild832J5HmD4Oe5Zcn4qTJ9D1sFJ5R
         o61nFJEdB/JCfG1Rr5kUUl7T//qEt2dyJp/hBhG96v7ghOCEzSJ7nyY+SMoxHw4YSR38
         weJDn3jbdMQH4CUxySkqrBPY1tGSS0up8IS6usWN93qdJbFSHWZJSJpz5gHU9EDb+I9N
         8xc4edyapwLnCSTxPiYhIu1JUw26ZUqPTrCzMGqqXVPXT44/qpynOg2FUMaXC8dpB2n/
         HoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpo49UJFTmSx2mVUsrH28W7y/nNRaB3b36oLAS+p92Q=;
        b=sziZKi/MlDj/czM4KesbgEjRAP5S/NMLccqK5p+d3ihckO/4FoE9qQ4WxUc9RpPE31
         44NEPTjvCVJ8u9rzKbgrnDUFm/LFWNU7JIxqsDkX1cO4CcBJ8nlV21SXv9dEDSmyfjmi
         3Q8ZohM9a9hd52q0jm7hU7Hb4vTVhZ2WnyhR3KglZqmuB2TsbJqF8OOGBaBeOBqPJR3I
         8QlcDXddzdFegzvcg2xbH6Q4iANHiXaN6AWh9tXnvDoOpem1jHh43nq5K+B9H2Emjmcs
         9OeZhE12zmooQs5edOfTNSqXIYHcg8NghahCaK93zu1b4keGRa/EDcdLKRtILEH1hlFT
         kUkA==
X-Gm-Message-State: AOAM530w+P/sttUGRKstq4QbtbhqRUrCvrnNG1q1a8BMFMe8cWEOvAsT
        JVrrMqrzcf3bAK7HaVosWxWnlkakGs+Zvl98pl7a8g==
X-Google-Smtp-Source: ABdhPJw1DRbILjMBDs/PGCB8WikMVjkwtv8vwPKMzkgz902Ioiz5SZnc1WlrFrqZ7fC4TSn++yU0F1pQ9TBruhSDbsQ=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr4055950ejb.237.1591373900985;
 Fri, 05 Jun 2020 09:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jun 2020 09:18:09 -0700
Message-ID: <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 6:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 8, 2020 at 1:55 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Recently a performance problem was reported for a process invoking a
> > non-trival ASL program. The method call in this case ends up
> > repetitively triggering a call path like:
> >
> >     acpi_ex_store
> >     acpi_ex_store_object_to_node
> >     acpi_ex_write_data_to_field
> >     acpi_ex_insert_into_field
> >     acpi_ex_write_with_update_rule
> >     acpi_ex_field_datum_io
> >     acpi_ex_access_region
> >     acpi_ev_address_space_dispatch
> >     acpi_ex_system_memory_space_handler
> >     acpi_os_map_cleanup.part.14
> >     _synchronize_rcu_expedited.constprop.89
> >     schedule
> >
> > The end result of frequent synchronize_rcu_expedited() invocation is
> > tiny sub-millisecond spurts of execution where the scheduler freely
> > migrates this apparently sleepy task. The overhead of frequent scheduler
> > invocation multiplies the execution time by a factor of 2-3X.
> >
> > For example, performance improves from 16 minutes to 7 minutes for a
> > firmware update procedure across 24 devices.
> >
> > Perhaps the rcu usage was intended to allow for not taking a sleeping
> > lock in the acpi_os_{read,write}_memory() path which ostensibly could be
> > called from an APEI NMI error interrupt?
>
> Not really.
>
> acpi_os_{read|write}_memory() end up being called from non-NMI
> interrupt context via acpi_hw_{read|write}(), respectively, and quite
> obviously ioremap() cannot be run from there, but in those cases the
> mappings in question are there in the list already in all cases and so
> the ioremap() isn't used then.
>
> RCU is there to protect these users from walking the list while it is
> being updated.
>
> > Neither rcu_read_lock() nor ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> > was not serving as a mechanism to avoid direct calls to ioremap().
>
> But it would produce false-positives if the IRQ context was not NMI,
> wouldn't it?
>
> > Even the original implementation had a spin_lock_irqsave(), but that is not
> > NMI safe.
>
> Which is not a problem (see above).
>
> > APEI itself already has some concept of avoiding ioremap() from
> > interrupt context (see erst_exec_move_data()), if the new warning
> > triggers it means that APEI either needs more instrumentation like that
> > to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> > the resources it needs in NMI context.
>
> Well, I'm not sure about that.

Right, this patch set is about 2-3 generations behind the architecture
of the fix we are discussing internally, you might mention that.

The fix we are looking at now is to pre-map operation regions in a
similar manner as the way APEI resources are pre-mapped. The
pre-mapping would arrange for synchronize_rcu_expedited() to be elided
on each dynamic mapping attempt. The other piece is to arrange for
operation-regions to be mapped at their full size at once rather than
a page at a time.
