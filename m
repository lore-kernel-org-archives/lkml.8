Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F603C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCB520760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pw8Bxdhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgFHU35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:29:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5458DC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:29:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so274575pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/ePEPr3ygUN4g38F3++3TkPRxfaceUs+kBlSlUSKY0=;
        b=pw8Bxdhl9XS8tPgtRzulSMnEvJeKhw67A+rrpfiRgoNRVcVxkndGIyj1Htofn7jVH4
         QQfC8wwV1c2hsbd3F+BArgJJLlVJygelysnZp9v8OWukz4LhpZm+mPNjLH12Rd6OrYqv
         FEepyuJwLd31BVubTZVtn1FwTiI9AReTM8JynaA0xsEGX3ndHt2r47Zqeq30tgQZ8wVC
         8g6XsZLQuN3A2UBO1Vc4xRfN66xu2jdQFy7ZOSpEIlWqwg+LIA2MCYx82el77wcfvMaA
         K7z7TSrp13wbs0s5jkpBtBoquIhBmNnU+rdDHrJolRI2C6P7l78M4Jbr0MihSflNPFXb
         +zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/ePEPr3ygUN4g38F3++3TkPRxfaceUs+kBlSlUSKY0=;
        b=a2GHWAOlFEImiQBoDvJPM0zUhQgWPwtxun7ctpjYWcuFf8o+3qBF+bu+e7OHhtPeoy
         eDbFaaB+FECsp6Hu0RT2hAA+qYFzIfRXgNB8O6Z9oyutohqmhTGSCkqHna1sZCejYdZ4
         bDdgp2nfM8kuPWnE+Sx0bSOkuBCP5Xzed/0SnzkS4t49vQ6HGHCfnEOK6dQOhkibP5LZ
         jFkjsNrS7ssuuH5E45Y4unsJFNNvs+uRh8AQ8CRTILyE2b7skWTn2854o3AgPNbTnS2m
         hAOiDVIoqGjZOcj7+AgqzL2PU3bkCHyoplM/V2ARyQK9vJ33sF/h3MPlaHDxAX8Ufidy
         eYhw==
X-Gm-Message-State: AOAM531wQteRX9AWP1UWfbwJBNGcVsPvzQk5FtnXlAkyC1EuIKFiXTtN
        7X6sZJxVjBaGN/DQQNXI8CXOeqgvP3jCigPFTjl/rg==
X-Google-Smtp-Source: ABdhPJxqTvjFFkKCm0i/uL4/XPDo2bwuLtgj0Uxawq6E2pFoZqBvslwKDi6qgeiJF1A8ll3duqQhBNh0BQd5R/EezHw=
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr1046413pjb.32.1591648195517;
 Mon, 08 Jun 2020 13:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
 <20200601231805.207441-1-ndesaulniers@google.com> <BYAPR11MB30969737340044437013BF44F08B0@BYAPR11MB3096.namprd11.prod.outlook.com>
 <CAKwvOdmsCmPFiDOq7AYUyEx=60B=qo8u9yhnJDQ6nd6Ew7xDkQ@mail.gmail.com> <20200608145150.GA7418@willie-the-truck>
In-Reply-To: <20200608145150.GA7418@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Jun 2020 13:29:44 -0700
Message-ID: <CAKwvOdnBhHnhUZ9MHgqEQ4nEyzHWUH+DPV-J0KoYyWNEnsDHbg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
To:     Will Deacon <will@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pcc@google.com" <pcc@google.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 7:51 AM Will Deacon <will@kernel.org> wrote:
>
> Hey Nick,
>
> On Tue, Jun 02, 2020 at 11:46:31AM -0700, Nick Desaulniers wrote:
> > On Mon, Jun 1, 2020 at 5:03 PM Kaneda, Erik <erik.kaneda@intel.com> wrote:
> > > > Will reported UBSAN warnings:
> > > > UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
> > > > UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
> > > >
> > > > Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
> > > > can avoid this by using the compiler builtin, __builtin_offsetof.
> > >
> > > I'll take a look at this tomorrow
> > > >
> > > > The non-kernel runtime of UBSAN would print:
> > > > runtime error: member access within null pointer of type for this macro.
> > >
> > > actypes.h is owned by ACPICA so we typically do not allow compiler-specific
> > > extensions because the code is intended to be compiled using the C99 standard
> > > without compiler extensions. We could allow this sort of thing in a Linux-specific
> > > header file like include/acpi/platform/aclinux.h but I'll take a look at the error as well..
> >
> > If I'm not allowed to touch that header, it looks like I can include
> > <linux/stddef.h> (rather than my host's <stddef.h>) to get a
> > definition of `offsetof` thats implemented in terms of
> > `__builtin_offsetof`.  I should be able to use that to replace uses of
> > ACPI_OFFSET.  Are any of these off limits?
>
> It's not so much about not being allowed to touch the header, but rather
> that the kernel imports the code from a different project:
>
> https://acpica.org/community
>
> > $ grep -rn ACPI_OFFSET
> > arch/arm64/include/asm/acpi.h:34:#define ACPI_MADT_GICC_MIN_LENGTH
> > ACPI_OFFSET(  \
> > arch/arm64/include/asm/acpi.h:41:#define ACPI_MADT_GICC_SPE
> > (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
>
> I'm happy to take patches to the stuff under arch/arm64/, fwiw.

Not really sure how to untangle this.  Those two cases under
arch/arm64/ are straightforward to fix:
```
diff --git a/arch/arm64/include/asm/acpi.h
b/arch/arm64/include/asm/acpi.h
index b263e239cb59..a45366c3909b 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
+#include <linux/stddef.h>

 #include <asm/cputype.h>
 #include <asm/io.h>
@@ -31,14 +32,14 @@
  * is therefore used to delimit the MADT GICC structure minimum length
  * appropriately.
  */
-#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
+#define ACPI_MADT_GICC_MIN_LENGTH   offsetof(  \
        struct acpi_madt_generic_interrupt, efficiency_class)

 #define BAD_MADT_GICC_ENTRY(entry, end)
         \
        (!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
        (unsigned long)(entry) + (entry)->header.length > (end))

-#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+#define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
        spe_interrupt) + sizeof(u16))

 /* Basic configuration for ACPI */
```

But for one of the warnings you reported, as an example:
UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37

```
$ ag ACPI_FADT_V2_SIZE
include/acpi/actbl.h
394:#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET
(minor_revision) + 1)

drivers/acpi/acpica/tbfadt.c
459:    if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {

$ ag ACPI_FADT_OFFSET
...
include/acpi/actbl.h
376:#define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct
acpi_table_fadt, f)
...
```
So the use of ACPI_FADT_V2_SIZE in drivers/acpi/acpica/tbfadt.c is
triggering one of the warnings.  ACPI_FADT_V2_SIZE is defined in terms
of ACPI_FADT_OFFSET which is defined in terms of ACPI_OFFSET in
include/acpi/actbl.h.  From the link you posted, include/acpi/actbl.h
is from the project under source/include/.

Further, drivers/acpi/acpica/tbfadt.c seems to also be from the
upstream project under source/components/tables/tbfadt.c.

Regardless, the second of the two warnings is definitely fixed by my
above diff, so let me rephrase the previous commit message with that
diff and resend.
-- 
Thanks,
~Nick Desaulniers
