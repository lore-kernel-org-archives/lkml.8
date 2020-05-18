Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3997120829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bgaWUWFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgERTpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgERTpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:45:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27BC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:45:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l25so4865485edj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98AvPLVUFFiv8829bVvMBDsSV4ORTaaKvOxhTAw6au4=;
        b=bgaWUWFS8BQa27P81AmG/w9hGlORYFhFFEVixIKGbalMrY+SzrbARefgkNpirjGoYI
         F26Z5l7yKrmjse3GY/98043ujFVAWV9pKs8aclgUWlahTMbt3HWVCLwAtfGXc1huxbaY
         nzRCqNEqdn8kNpyKSa23/PGY53VfXNcec4u3J5lI3jeYv+RYxiJllO8htErQ88yg1vim
         Cdmb7L9yAwhWZ8eh6Ucg/0XbFLRT8AlJXFxU6PVAitYBJInEOk2EdPeaZLq61ua/6Pt4
         AcSXIiSSk5XR2oOOr1/Zw8JnNWN2iCiR1v1l4PwtAQG3sMRD9Vm06/JLx0eTvGxQ+DUz
         /nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98AvPLVUFFiv8829bVvMBDsSV4ORTaaKvOxhTAw6au4=;
        b=J3QOE90raXPGZH6phVmPQdMlYuIF5dlll9625TvAlWTZkV9Hwz9S+2f41dPGmqH0pb
         p4k7W/V3uRGzaygdkZlVYC9rP3jEdLAb1zTvcGVr4Dr4G2/asEM9nsRx9Q8woErwC6DK
         zHdUhuGjVdV0/vFCDceH0GJJEmPoiyJdLYVHynhjn0J8rGNVARVp94CDjuqfousdma0t
         aEq+5ZoE5uOXYYNgc78yl+cvX7+5qTKh1cemCUFnrqNPPhySxONgG6B6l85qqXCJx0x3
         qcRVAf64bg/sQEVLeaOnfJ7KAnjETL3uzdoXufWvda6+TzNz2rBnfw+D944ruc9xdiNr
         24sw==
X-Gm-Message-State: AOAM5333KHhfG4lRapMUU75NI9t7+v582DPHOl9FNvNa2nTwY5tHAb8Q
        rnm0wbEAZCN859xllO/fvzWaxPMGPyC0gQTnNQbbyw==
X-Google-Smtp-Source: ABdhPJxPSkNBXQqdwy3+WaOEI9qyJGv/GoSr3pXUWmXyeJvuVZ5OleDuHHY5nQ/2I+LrDbv6A7cc3OdmEYHc+akuda4=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr10732201edt.383.1589831107355;
 Mon, 18 May 2020 12:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511090034.GX5770@shao2-debian> <440dae1b-9146-0bc3-e8f2-bd3cb3aa89bb@intel.com>
 <CAPcyv4jKZp2bOZZ+ZMrcbFw9fPzeDu8waqwG6mBVpWwGq2DGtw@mail.gmail.com> <438c1743-5c8a-287d-3f97-e4a451ae8027@arm.com>
In-Reply-To: <438c1743-5c8a-287d-3f97-e4a451ae8027@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 May 2020 12:44:55 -0700
Message-ID: <CAPcyv4i=Mty-rvXFXNU85VJpB0zB445Gu9-J5qadHftYmpVEXg@mail.gmail.com>
Subject: Re: [ACPI] b13663bdf9: BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, lkp@lists.01.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:08 AM James Morse <james.morse@arm.com> wrote:
>
> Hi guys,
>
> On 12/05/2020 19:05, Dan Williams wrote:
> > On Tue, May 12, 2020 at 9:28 AM Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> >> Dan,
> >>
> >> Has this been addressed in the v2?
> >
> > No, this looks like a case I was concerned about, i.e. the GHES code
> > is not being completely careful to avoid calling potentially sleeping
> > functions with interrupts disabled. There is the nice comment that
> > indicates that the fixmap should be used when ghes_notify_lock_irq()
> > is held, but there seems to be no infrastructure to use / divert to
> > the fixmap in the ghes_proc() path.
>
> ghes_map()/ghes_unmap() use the fixmap for reading the firmware provided records,
> but this came through apei_read(), which claims to be IRQ and NMI safe...
>
>
> > That needs to be reworked first.
> > It seems the implementation was getting lucky before to hit the cached
> > acpi_ioremap in this path under rcu_read_lock(), but it appears it
> > should have always been using the fixmap. Ying, James, is my read
> > correct?
>
> The path through this thing is pretty tortuous: The static HEST contains the address of
> the pointer that firmware updates to point to CPER records when they are generated. This
> pointer might be static (records are always in the same place), it might not.
>
> The address in the tables is static. ghes.c maps it in ghes_new():
> |       rc = apei_map_generic_address(&generic->error_status_address);
>
> which happens before the ghes_add_timer()/request_irq()/ghes_nmi_add() stuff, so we should
> always use the existing mapping.
>
> __ghes_peek_estatus() reads the pointer with apei_read(), which should use the mapping
> from ghes_new(), then uses ghes_copy_tofrom_phys() which uses the fixmap to read the CPER
> records.
>
>
> Does apei_map_generic_address() no longer keep the GAR/address mapped?
> (also possible I've totally mis-understood how ACPIs caching of mappings works!)

Upon further investigation the problem appears to be that
System-Memory OperationRegions are dynamically mapped at runtime for
ASL code. This results in every unmap event triggering eviction from
the cache and incurring synchronize_rcu_expedited(). The APEI code
avoids this path by taking an extra reference at the beginning of time
such that the rcu-walk through the cache at NMI time is guaranteed to
both succeed, and not trigger an unmap event.

So now I'm looking at whether System-Memory OperationRegions can be
generically pre-mapped in a similar fashion.
