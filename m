Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66635C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D620738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=barpilot-io.20150623.gappssmtp.com header.i=@barpilot-io.20150623.gappssmtp.com header.b="0PVwqfMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgHZNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgHZNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:04:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z17so1994289ioi.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barpilot-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMxeFJHei2gYrYNqMG5h+XFJh32oQngK7oPyThCi2kc=;
        b=0PVwqfMpdny/+RG8OH5TGfK+xa3Fh9UNrAE35wFkj1RgEJq8nUxeGQ1UPdMYXiZ54H
         G+IWINHXPR35nb/I1HPbPOdTgyfBj7fsMhpuWSxVqaDRs4Kg3NmHiKuo4JJDkLSOyud4
         9ahSCrH9regrNBhJNAJXLbejjgvVVDrNu7gE0XVICASPX2Gnj2k/qbRIIVDuraxCbaIV
         tQXvCT6ODVpsvmrSwVLR2BmA1G2x2ck/VZ+ft8eGLTzBd1ksYKdXR/czf9WCXsvHFQVR
         A00jCfbQUhEJktjUyXuXQlfjzqA1jivjvxGyQaV5DZyuZ8JkYdm38/CPlDCiofmZ33RE
         c2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMxeFJHei2gYrYNqMG5h+XFJh32oQngK7oPyThCi2kc=;
        b=myZchSJFgFzDZU3xEy6e93enCnvyJxZfwNJO4DySqBZ+bVC9bBhhxi1fERabsuGR+k
         oEDHRUx7jdryIFZJn50118Mr3dHF+3BmCCi98Ea29wKSZ/By9bH4g4Dk030+xnoafiKe
         Vu9/rssxOOXubcMXbdn5gEImcz41UYvdwhT11zGgLBSXjl0WRZDjxX/wQ98wQfkaCP9u
         KkmfebTQlQHiVjDdvwPHnCN1pUsF3qw+Rc5pFRjceoAmfaXShUOOmnYXid6rRiXBs0+7
         lerM/bV0FOCzGcxy9Wsg5crR8TZVpoa+vxuwkgoWIjBxSOibAfy5MC3pyQ4cYqdGcTnv
         CvVw==
X-Gm-Message-State: AOAM531R3+0d21Ge1R6BrK2TRBNAtYMqg+DuWCNvQWYVbh7Bx58nqSCo
        o/k1rQEynkF3z4Yfs2pAjop/oDdPvac61zgvASr9TQ==
X-Google-Smtp-Source: ABdhPJziGcwZmYjXLUNH5+qDsoSHPELg0P9dzg6N2Tx/7MipE0ZmkH1freiHSR4cCbl2IriCsj0FkUeBMHnImwgA+vQ=
X-Received: by 2002:a6b:2c1:: with SMTP id 184mr3045269ioc.137.1598447042854;
 Wed, 26 Aug 2020 06:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
From:   Guilhem Lettron <guilhem@barpilot.io>
Date:   Wed, 26 Aug 2020 15:03:52 +0200
Message-ID: <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 14:43, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 26, 2020 at 2:05 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
> >
> > Use the same C-states as SKL
>
> Why is this change needed?

On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only
report "C1_ACPI", "C2_ACPI" and "C3_ACPI".
After this patch I have "C1", "C1E", "C6", "C7s", "C8", "C9" and "C10".

I tested for some time on idle (without any application launched) and
battery consumption drop ~1W/2W.

But it can be a measurement problem or different context. So don't
hesitate to tell me if I look wrong or if ACPI is a better option for
this specific processor family.

> > Signed-off-by: Guilhem Lettron <guilhem@barpilot.io>
> > ---
> >  drivers/idle/intel_idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 8e0fb1a5bdbd..1bb539f09a4f 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1145,6 +1145,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> >         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &idle_cpu_skl),
> >         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
> >         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,             &idle_cpu_skl),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &idle_cpu_skl),
> >         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
> >         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
> >         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> > --
> > 2.27.0
> >
