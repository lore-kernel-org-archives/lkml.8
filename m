Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6975EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EFB206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzzh0sjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgIHQh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgIHQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0899C0610E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:13:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so11063470pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMcWrEBFn4y8oWuAmn2eZMWAoBr3QRyf1vevmm6kpYs=;
        b=Jzzh0sjM+sebliF2+g0oD6UV30lD8Je25a3ORZDUih+SpSCxXDxxYCU+2gGsh9/OkJ
         70s3sTKNRMsamCYPAapkWhpvADc+OyCyeznmqk45YsWg8gFtDxSYjWXriqEh3urgYvoy
         tebnU1yTEvrd+phD+7FT8IeEymsitQrYPaUBiKH2kR+9ZsLjwx2c/axjW9Y6HLpLPT55
         ViDKdLPdp5ygXnpd9fq7J2GGefutFP4GG3PkwixuiI9Pc63x7sraVe8wC3jcawGBX9oP
         YJGU47XU8QZ1K0ai+PaP/jVxRUABdUb0B1JEBXUt1yo+63SthraFPxk3JDq17Req8iAK
         Az3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMcWrEBFn4y8oWuAmn2eZMWAoBr3QRyf1vevmm6kpYs=;
        b=W/vN4k3BXB/u/znssDVQpBGe7BO1x5uzWBDRog1Fdhqyfm2xDps1mqBZSlT5GvxxuD
         ennQRBeYvC8vaMMEj0ofsADvmwbNEomPnq+PgHhLPiwNS/oGwZS/J/dPV6/cMR6bqnZs
         TpMieMmIlI5jv6dcVcPg6+5RYYZeT6qApDr4i+XzuQKb4MKQQ0jrhYgwD9RkoR8rSYAf
         swV8FuB+eftWwdsCLcqVbeHpUv08IyXQ5W7fmIFZmbAVl6MCMfh7Xfso9qPAY9FwDsuy
         Bkql4ewxPbHW93VSeh3sH3ttfEnckRomflSQGWNWHf276Uh2wW9RDamw1RfiWWCbalti
         UvHQ==
X-Gm-Message-State: AOAM533qRD0sMh4o8twosb+egz+BJdXmjHAj1LwLrifki7aZKjOPXDIE
        48gV93NL/c8mc9qCD8BKpdv2aVIJYX02GCM7eFCzQg==
X-Google-Smtp-Source: ABdhPJyefGenq86vwXxC8byR1bbNo446im+Q1wzZOY2tOktJ+HGERi+qxWaH7CgzJBKUU7/QW+Q68vuVcA9ikxvsBxY=
X-Received: by 2002:a62:c2:: with SMTP id 185mr25215607pfa.11.1599574380885;
 Tue, 08 Sep 2020 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia> <CAAeHK+x_B+R3VcXndaQ=rwOExyQeFZEKZX-33oStiDFu1qePyg@mail.gmail.com>
 <20200908140620.GE25591@gaia>
In-Reply-To: <20200908140620.GE25591@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 16:12:49 +0200
Message-ID: <CAAeHK+zkWojbbq1WgoC2D6JuR=Jy+jSU78PF74qdmD0aTg6cQQ@mail.gmail.com>
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 4:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Sep 08, 2020 at 03:18:04PM +0200, Andrey Konovalov wrote:
> > On Thu, Aug 27, 2020 at 12:40 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> > > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > > index 152d74f2cc9c..6880ddaa5144 100644
> > > > --- a/arch/arm64/mm/proc.S
> > > > +++ b/arch/arm64/mm/proc.S
> > > > @@ -38,7 +38,7 @@
> > > >  /* PTWs cacheable, inner/outer WBWA */
> > > >  #define TCR_CACHE_FLAGS      TCR_IRGN_WBWA | TCR_ORGN_WBWA
> > > >
> > > > -#ifdef CONFIG_KASAN_SW_TAGS
> > > > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > > >  #define TCR_KASAN_FLAGS TCR_TBI1
> > > >  #else
> > > >  #define TCR_KASAN_FLAGS 0
> > >
> > > I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> > > user series, just do this in __cpu_setup.
> >
> > Started working on this, but realized that I don't understand what
> > exactly is suggested here. TCR_KASAN_FLAGS are used in __cpu_setup(),
> > so this already happens in __cpu_setup().
> >
> > Do you mean that TBI1 should be enabled when CONFIG_ARM64_MTE is
> > enabled, but CONFIG_KASAN_HW_TAGS is disabled?
>
> What I meant is that we should turn TBI1 only when the MTE is present in
> hardware (and the ARM64_MTE option is on). But I probably missed the way
> MTE is used with KASAN.
>
> So what happens if CONFIG_KASAN_HW_TAGS and CONFIG_ARM64_MTE are both on
> but the hardware does not support MTE? Does KASAN still generate tagged
> pointers? If yes, then the current patch is fine, we should always set
> TBI1.

No, the tag is always 0xFF when MTE is not supported.

Should we then only enable TBI1 if system_supports_mte() or something like that?
