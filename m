Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9534C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843FE20731
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hhdJwocm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEGVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:20:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E3C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:20:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p16so6675241edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHG6yTghcibf497dWa0jTcy5wb1cOxvUkXcsCAAAnu0=;
        b=hhdJwocmiOmhRbStlbTJF+p2HOJLzKjtHBW7/pWc2QtLmrhNBExIXrUO2uQY5aJFic
         NPqwRqO/FhcKBHF/m/7sj8CrG7BnmqViC07cpNI3aHZjYqvifvmstOVxRyhtVNXzcaw/
         odCvKvCvH1ts+K/benGuSU6XoYNbAe9XYRePBEsMfRJi35r79vMwY/Cf/d9exGoIO/cM
         i0K74AdGR8TY4T7Qk9WwZjhxA1Y5OmygaBA8PACbgoOiEb3IK8NwuA9XAFhB6Kl4J0w5
         r81WRBbrVsb5OZs5KYgcZZylE6FCNIL9AkQr2yo6e9K3nuwFOmCkxlf5SdIXs7sUpoAI
         LMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHG6yTghcibf497dWa0jTcy5wb1cOxvUkXcsCAAAnu0=;
        b=jXP+1URpSI70vPixC0HPa4KHw6DYSUscZe+EDqV5oJ5IelzEBnQcsDUWHsZEES1ikh
         esJvEbevgQMkpn86Dm9Q2XIQyf/w7yCZZcSyTS7SG5O1zv2PfxTu0leTHnbpVvWd8CoL
         mJ7Zu35Rmh0iOgdkWFsuc8/q0YXhyP2n6ERb0NFP2cAQ3l07R7d7AP/NIiKr0xG57pHr
         N+IKU2t5L2J5pTMa2YtwovE1MMUEFUg9lDA4bYII92aKPZXp9Vl2154zONKEUqnhm6aA
         Va3yHQH46al/TGEGqi2UTLqqklewrgKoAk43W/DqWGaAJ52XzJ5Sc8Bn6VoseSXM34Kk
         lffw==
X-Gm-Message-State: AGi0PuaKt7maTREeNo7ycODobzPjY4CnEbSlNeG4MQbWRSuA7ZNommWN
        4FWpcHH3GZfbfBx4IA2vf7YX1zLx6b9XM4Sqq0XxiQ==
X-Google-Smtp-Source: APiQypIDiQajRa4tQ5UpB7rmME33WGj2fRXc8YbBkxmSYjWsrm7ee61hgisYO4/M3hOn/3+7xRKMFnT6KU6LZryG7mc=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr13702521edr.154.1588886441435;
 Thu, 07 May 2020 14:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
 <bd3963f3-c6d6-f138-331c-9ac065633491@intel.com>
In-Reply-To: <bd3963f3-c6d6-f138-331c-9ac065633491@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 May 2020 14:20:30 -0700
Message-ID: <CAPcyv4ikWy9E8ScM2k1wdxUuPegftvOFwyLr86MupYpHsmxnUg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop rcu usage for MMIO mappings
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:43 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 5/7/2020 1:39 AM, Dan Williams wrote:
> > Recently a performance problem was reported for a process invoking a
> > non-trival ASL program. The method call in this case ends up
> > repetitively triggering a call path like:
> >
> >      acpi_ex_store
> >      acpi_ex_store_object_to_node
> >      acpi_ex_write_data_to_field
> >      acpi_ex_insert_into_field
> >      acpi_ex_write_with_update_rule
> >      acpi_ex_field_datum_io
> >      acpi_ex_access_region
> >      acpi_ev_address_space_dispatch
> >      acpi_ex_system_memory_space_handler
> >      acpi_os_map_cleanup.part.14
> >      _synchronize_rcu_expedited.constprop.89
> >      schedule
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
> > called from an APEI NMI error interrupt? Neither rcu_read_lock() nor
> > ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> > was not serving as a mechanism to avoid direct calls to ioremap(). Even
> > the original implementation had a spin_lock_irqsave(), but that is not
> > NMI safe.
> >
> > APEI itself already has some concept of avoiding ioremap() from
> > interrupt context (see erst_exec_move_data()), if the new warning
> > triggers it means that APEI either needs more instrumentation like that
> > to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> > the resources it needs in NMI context.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 620242ae8c3d ("ACPI: Maintain a list of ACPI memory mapped I/O remappings")
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Cc: Myron Stowe <myron.stowe@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> linux-acpi is kind of relevant for this too, so please CC it.

Whoops, my bad. Will resend with some of Andy's cleanup suggestions.
