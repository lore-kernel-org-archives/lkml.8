Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55322C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3DC20835
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591426599;
	bh=lM5S52Diqu+WWWPjjJQKhkrp3vetrqz6gZnl8hzaTR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JH7YHL5wdpkJM/6Kkli+W4U/sCY/NocJG3hC49glxzRLGUypelxPPUsLi4k/63qZO
	 IE0vLCU3mtZGDKb/mUwYmpRVD9FhD/I8rYNJtwcLlQTIfwmsBCmzkTq9Fx8t4jpIm2
	 FPAkIAcxmcS6Wu6yykREHfDk51ssTZcvcJ9mSdFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgFFG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 02:56:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36917 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgFFG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:56:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id v13so9492439otp.4;
        Fri, 05 Jun 2020 23:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQUek8YBI/Ra2tT9dStFeBAAq+j/b7SMm32naih+7IE=;
        b=g/BNmS+nt1Hp+fI8wygGKZZ1JIRr4HE9IHnBqVxgEKDJySHqbeDQxSfjQIhP5FcbdN
         KVc97Vb4AyBmhnOOClfcnKiayarjgrjJ9BbhiT50tW8Gn3oohVRbMEyG/IrCVB1i5cLJ
         VcsVDVv8Owun+4hawVDlgTloiEi15pmhnnlUPy0GOH0pFwZ9oYRGLxrr5BF4H/DeGr+T
         gL04O6KNEyhCIiTe/S0FLNJaZzEmuyLkSNlqmnhk508fm0T/o0vXm2W2/fwTzDe1rzR4
         wrCGx37dfjhRivYHKfMwnYJtx+b0GyeHgvXOLS3CcB4uMJR0nzh0PnioTvtj/w7BN+8y
         7fkA==
X-Gm-Message-State: AOAM530PjjDwz36RiqoEWTQaGxJjY5fDckZVKuQE0/MOgh3s9d6MDoTO
        QBPuM+UPwbQEU0QPxoK1xwsRpbSpU0ugH4snnYk=
X-Google-Smtp-Source: ABdhPJy5G9cnRHYIUiUNNY9zRXhvU1FrRDkIKTt5EqvrkkpoPAAkazH16Q+MOIvluty4GDmy6mdsJACPkDR8keWm4k0=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr3763834otb.262.1591426597228;
 Fri, 05 Jun 2020 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher> <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com>
In-Reply-To: <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jun 2020 08:56:26 +0200
Message-ID: <CAJZ5v0gAJyCi4YiVP4LuH3sCBWMArODDxkjKqk28Svug1+bTtw@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 7:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 5, 2020 at 7:06 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
> >
> > The ACPI OS layer uses RCU to protect the list of ACPI memory
> > mappings from being walked while it is updated.  Among other
> > situations, that list can be walked in non-NMI interrupt context,
> > so using a sleeping lock to protect it is not an option.
> >
> > However, performance issues related to the RCU usage in there
> > appear, as described by Dan Williams:
> >
> > "Recently a performance problem was reported for a process invoking
> > a non-trival ASL program. The method call in this case ends up
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
> > migrates this apparently sleepy task. The overhead of frequent
> > scheduler invocation multiplies the execution time by a factor
> > of 2-3X."
> >
> > In order to avoid these issues, replace the RCU in the ACPI OS
> > layer by an rwlock.
> >
> > That rwlock should not be frequently contended, so the performance
> > impact of it is not expected to be significant.
> >
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Dan,
> >
> > This is a possible fix for the ACPI OSL RCU-related performance issues, but
> > can you please arrange for the testing of it on the affected systems?
>
> Ugh, is it really this simple? I did not realize the read-side is NMI
> safe. I'll take a look.

But if an NMI triggers while the lock is being held for writing, it
will deadlock, won't it?

OTOH, according to the RCU documentation it is valid to call
rcu_read_[un]lock() from an NMI handler (see Interrupts and NMIs in
Documentation/RCU/Design/Requirements/Requirements.rst) so we are good
from this perspective today.

Unless we teach APEI to avoid mapping lookups from
apei_{read|write}(), which wouldn't be unreasonable by itself, we need
to hold on to the RCU in ACPI OSL, so it looks like addressing the
problem in ACPICA is the best way to do it (and the current ACPICA
code in question is suboptimal, so it would be good to rework it
anyway).

Cheers!
