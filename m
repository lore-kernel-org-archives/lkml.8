Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E126920760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj2HOLr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFJX3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:29:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08344C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:29:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s135so1010248pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TzxZ6stD3PZjH0rWRteIpP64wnrZhSQ8+LWOmjBhiU=;
        b=lj2HOLr9iGR0sii8IdZYZlccMRuGca3x5VcEhEGrSh34BhdgEFcSdgBk8bJsoYMUx1
         prS9LECFeLy4xxl5E9OYJaZeRZpY9gzb3EnaA4hxO4bXaCi++Ob5GRDUsGLykemwPyVX
         UCoDPMAPXBGy+ZPUg+DDgKVgcdUabL38lJ7bLWewlJFB+xJ5OhsDY/M99TZgcX3gaZX+
         UlsHEGmjL0mK8c2UP2x7t8h4JyvX2ZxL4Ghf5SL74brwo/8Ypi1sZIKuhz9L2/57OAaN
         4foUYKfm3kChXnBkT6NdsxYwXfo5a3FWsfWFQhINnYsk+NZwJ/itpj+c+hGLboSWCgwT
         l0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TzxZ6stD3PZjH0rWRteIpP64wnrZhSQ8+LWOmjBhiU=;
        b=D6uuzMZhBU25fkIh3TLbervXC3IZX+/2i3idHqWk/ugN7quYVhokF3VDDTN+qnGDRq
         0aQjDba3JzUQgSN+EkJLJDgt3TbMb+9kevgxZw+LPpPUngPYufwHFgVQWDLEzwwp6BiZ
         2rWZPjwLe7g2vn+zZYqsRB0tYw0QN4MJyeTG9TKM5gPxUcmOTDHWaucofzJts/ZUr6x9
         lQ8FkjV3FseKE4rTFqRfqQa0RhKTsegQp9S91nF3d6AJWucLWyKUEaGTatSDP6Q0bLpY
         BD/PyKB6sL5A9WYfi9/NBB2QQzFSKXphQj4XJ36ZZ7VE0oMQPboyb/J/RBf4f3RJoROh
         AQng==
X-Gm-Message-State: AOAM530sl4Oykjug7KBENMx2Qgqmf8AYwF5BXPW1oCzY1z4gAt24L6/k
        Bx7Z0AITlZEqPynBDI87inQkwjsohGGlQ9A2ZR4qTQ==
X-Google-Smtp-Source: ABdhPJxQRDNnAU0Fg7jLTwWaxkipk37vBBsJBUw1TBH6wYrDUsNqKgyiSXPYWOFrzX3DfS/Sn15K1bfnQtN/cMO4w5M=
X-Received: by 2002:a63:5644:: with SMTP id g4mr4354362pgm.381.1591831754212;
 Wed, 10 Jun 2020 16:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
 <20200601231805.207441-1-ndesaulniers@google.com> <BYAPR11MB3096A0EA2D03BCB76C91F80AF0830@BYAPR11MB3096.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3096A0EA2D03BCB76C91F80AF0830@BYAPR11MB3096.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Jun 2020 16:29:02 -0700
Message-ID: <CAKwvOdnh6Zh+P9SM_qFiy-9u7Y21fn=byTJtG4fTTRJqqU9bcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Jung-uk Kim <jkim@freebsd.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        "will@kernel.org" <will@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 4:07 PM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
> +JKim (for FreeBSD's perspective)
>
> > -----Original Message-----
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Sent: Monday, June 1, 2020 4:18 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> > Len Brown <lenb@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>; dvyukov@google.com;
> > glider@google.com; guohanjun@huawei.com; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > lorenzo.pieralisi@arm.com; mark.rutland@arm.com;
> > ndesaulniers@google.com; pcc@google.com; rjw@rjwysocki.net;
> > will@kernel.org; stable@vger.kernel.org; linux-acpi@vger.kernel.org;
> > devel@acpica.org
> > Subject: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
> >
> > Will reported UBSAN warnings:
> > UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
> > UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
> >
> Hi,
>
> > Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
> > can avoid this by using the compiler builtin, __builtin_offsetof.
> >
> This doesn't really fly because __builtin_offsetof is a compiler extension.
>
> It looks like a lot of stddef.h files do this:
>
> #define offsetof(a,b) __builtin_offset(a,b)
>
> So does anyone have objections to ACPI_OFFSET being defined to offsetof()?
>
> This will allow a host OS project project to use their own definitions of offsetof in place of ACPICA's.
> If they don't have a definition for offsetof, we can supply the old one as a fallback.
>
> Here's a patch:
>
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -504,11 +504,17 @@ typedef u64 acpi_integer;
>  #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>
> +/* Use an existing definiton for offsetof */

s/definiton/definition/

> +
> +#ifndef offsetof
> +#define offsetof(d,f)                   ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> +#endif

If this header doesn't explicitly include <stddef.h> or
<linux/stddef.h>, won't translation units that include
<acpi/actypes.h> get different definitions of ACPI_OFFSET based on
whether they explicitly or transitively included <stddef.h> before
including <acpi/actypes.h>?  Theoretically, a translation unit in the
kernel could include actypes.h, have no includes of linux/stddef.h,
then get UBSAN errors again from using this definition?

I don't mind using offsetof in place of the builtin (since it
typically will be implemented in terms of the builtin, or is at least
for the case specific to the Linux kernel). But if it's used, we
should include the header that defines it properly, and we should not
use the host's <stddef.h> IMO.  Is there a platform specific way to
include the platform's stddef.h here?

Maybe linux/stddef.h should be included in
include/acpi/platform/aclinux.h, then include/acpi/platform/acenv.h
included in include/acpi/actypes.h, such that ACPI_OFFSET is defined
in terms of offsetof defined from that transitive dependency of
headers? (or do we get a circular inclusion trying to do that?)

> +
>  /* Pointer/Integer type conversions */
>
>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
>  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> +#define ACPI_OFFSET(d, f)               offsetof (d,f)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>
> Thanks,
> Erik
>
> > The non-kernel runtime of UBSAN would print:
> > runtime error: member access within null pointer of type for this macro.
> >
> > Link: https://lore.kernel.org/lkml/20200521100952.GA5360@willie-the-truck/
> > Cc: stable@vger.kernel.org
> > Reported-by: Will Deacon <will@kernel.org>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/acpi/actypes.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > 4defed58ea33..04359c70b198 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -508,7 +508,7 @@ typedef u64 acpi_integer;
> >
> >  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> >  #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> > -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *)
> > 0)
> > +#define ACPI_OFFSET(d, f)               __builtin_offsetof(d, f)
> >  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> >  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
> >
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
>


-- 
Thanks,
~Nick Desaulniers
