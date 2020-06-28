Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7852071A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593364161;
	bh=ujRD1vrl6K6aQJKih4SurpWBWFGITPMpqSClkMjLQqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iVj0xJhQsomd4++uSHXRhEfqECrYXgCoxpoa9TDYT5B7Igapp8yyKk6js++CUiIkJ
	 AosDmkCrKObRw8s2422Zf4SxFxqDSb02FJ+OT8ja4Ynu8rWQ8b7vArYrjoHCEEBxq1
	 Iw+NTfTLD+pxHlnK65a6ezFD7AcgckRY2kCYN5Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgF1RJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 13:09:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39078 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:09:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id 18so13355758otv.6;
        Sun, 28 Jun 2020 10:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHBo9wbaRoVXLY9NDJVIGwtnv5GehbPHBWMQ1wY/EhI=;
        b=fItJCqm4myUgd2+LuL/Q9OFRg+1GmcR5hcKD4e++SFrvLEDXb3WUD2GyKUDqf4qYHs
         9KeeNyxv2Vk2kUuW9f6/mtxIvEZLOuqy2+ups2AbpSc4JImtBSa842fb4g0Cotn/OcRg
         5ohhvfubaXMRyF+x9y6ewbnwpRzvKOGNUyiV/lG95dmceSGZVtucj5I8Q/tPYRM9xXGI
         HJMpbkl3FMRzJ1XTZhKgQNbr5v0iJ6FD5KJNUUJPUHxBU+agSIqeVdj9oR7ghOuEdxCR
         ayss1uwj9xnrqTDhWfKgVLQrBULYa9vYeZGG9iDJsLB96FYaZa4z3W4et1yMTQtggJKa
         qwTg==
X-Gm-Message-State: AOAM532aN7+1CLPympg6Yn8fB4QPAZn+W9g7qawXNtU8q5E3etxdk3az
        65Kg7rLidxl329AWgZq2AMTBBy4WdfdkeDyibxY=
X-Google-Smtp-Source: ABdhPJwaNxLa9utWgL4ulKbbgtv/kdZW4Bdg8bFZ+HQwwb00UUCEe4sYvKeUlGn7UPuAH99xcAgVC20KCp9+4PA8z0M=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr10130090otn.118.1593364158371;
 Sun, 28 Jun 2020 10:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher> <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
In-Reply-To: <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 28 Jun 2020 19:09:07 +0200
Message-ID: <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > This series is to address the problem with RCU synchronization occurring,
> > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > when the namespace and interpreter mutexes are held.
> > >
> > > Like I said before, I had decided to change the approach used in the previous
> > > iteration of this series and to allow the unmap operations carried out by
> > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > which is done in patches [1-2/4].
> >
> > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > variant of unmapping.
> >
> > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > always defer the final unmapping and the only ACPICA change needed to support
> > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > of the unused mappings when leaving the interpreter (module the extra call in
> > the debug code for consistency).
> >
> > So patches [1-2/4] have been changed accordingly.
> >
> > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > range and so it is introduced by patches [3-4/4].
> >
> > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > after rebasing on top of the new [1-2/4].
> >
> > The below information is still valid, but it applies to the v3, of course.
> >
> > > For details, please refer to the patch changelogs.
> > >
> > > The series is available from the git branch at
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpica-osl
> > >
> > > for easier testing.
> >
> > Also the series have been tested locally.
>
> Ok, I'm still trying to get the original reporter to confirm this
> reduces the execution time for ASL routines with a lot of OpRegion
> touches. Shall I rebuild that test kernel with these changes, or are
> the results from the original RFT still interesting?

I'm mostly interested in the results with the v3 applied.

Also it would be good to check the impact of the first two patches
alone relative to all four.

Thanks!
