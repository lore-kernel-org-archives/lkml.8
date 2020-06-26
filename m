Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825E1207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="R11LKguw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFZSll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:41:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEFC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 11:41:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cy7so7668018edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K5VPNdmXZlTpEK22Z0aFSoTEURNY4RlCyiO1qXhgPg=;
        b=R11LKguwqjk59xIplUm8flq2KsUfM9ZSKQ+ue3XNEh3xaqcql/A1LqO8WqJ2Z0wMrV
         Ja9C3T76hLGzXQ6SEL9dPdb9+PQ0VpDbwayD/jWxW/g5k+HEXyjnmM+GXQqOQL6QrmHN
         80fH4SbcRIalhTYJvMKi+6WEIquUl4hGKjK3C9XqBwenis3qOqdrc1ThO/IggREuQAPh
         vibdjUr77+63gg0nZo76QAHi1mMjwWr3+xjUamopUOg+V3bzZH+axB565gDM3tcVybn9
         r7rWU4XpJuxXdpUBSDHlgtVca7Z5vuIkFCYvjvpWeWvJwehTcf10duJT2lsqPqEieNRr
         Xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K5VPNdmXZlTpEK22Z0aFSoTEURNY4RlCyiO1qXhgPg=;
        b=Q6XOzhy3OJq9oXtShoWZ7dJyNQ06aVEwo21RroNTvGTPUmkt/floCWA/ufJUGGKKge
         m664GjCrhQDBQPYURXEzZGoarLklkcTrLpHXlIh1jzw+CLRTjkUIV3hLABNBeM1ycOMG
         u7GR4Vs+ZsJXxCo4Yn/clpeOf+/umiwIrK5eIlYcmGyz9GZ23dFRw3Cd6ggIwbIqLz0e
         PFzeIhP1I0p9dLcBO1ry02qDLZ5zfS8iM+mEokNJOeP4Rmnhk0hHceVXW+olxeVonwHL
         2YNGDzdacq7g3izEXjEKKrjXm0+24KUlqIVzOKfT+DX7Jj2lWAP9fypt5YnaemRyPDvH
         9o3w==
X-Gm-Message-State: AOAM533c4jJtuDhWnmKNWI9VeJ2r6uOgOxuBqsup7RsyAkEXxrgg4HIU
        m+iZSx3hFtKefArCO5n2zWnHaI4soRHclmhm7KrCdw==
X-Google-Smtp-Source: ABdhPJyot1xiFZLUjntQDRxbUfJEXI+PfIkPQ6MlPsJnQU2vuAcJyNfh4brPbGRTQjAQygy+GdtrpLfUUTnFVLC1nCI=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr4977457edo.123.1593196898995;
 Fri, 26 Jun 2020 11:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Jun 2020 11:41:27 -0700
Message-ID: <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
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

On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This series is to address the problem with RCU synchronization occurring,
> > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > when the namespace and interpreter mutexes are held.
> >
> > Like I said before, I had decided to change the approach used in the previous
> > iteration of this series and to allow the unmap operations carried out by
> > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > which is done in patches [1-2/4].
>
> In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> "tables" mutex within ACPICA is not quite a good idea too and that there is no
> reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> variant of unmapping.
>
> So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> always defer the final unmapping and the only ACPICA change needed to support
> that is the addition of the acpi_os_release_unused_mappings() call to get rid
> of the unused mappings when leaving the interpreter (module the extra call in
> the debug code for consistency).
>
> So patches [1-2/4] have been changed accordingly.
>
> > However, it turns out that the "fast-path" mapping is still useful on top of
> > the above to reduce the number of ioremap-iounmap cycles for the same address
> > range and so it is introduced by patches [3-4/4].
>
> Patches [3-4/4] still do what they did, but they have been simplified a bit
> after rebasing on top of the new [1-2/4].
>
> The below information is still valid, but it applies to the v3, of course.
>
> > For details, please refer to the patch changelogs.
> >
> > The series is available from the git branch at
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpica-osl
> >
> > for easier testing.
>
> Also the series have been tested locally.

Ok, I'm still trying to get the original reporter to confirm this
reduces the execution time for ASL routines with a lot of OpRegion
touches. Shall I rebuild that test kernel with these changes, or are
the results from the original RFT still interesting?
