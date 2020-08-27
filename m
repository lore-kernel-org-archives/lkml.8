Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D074C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243E222CBE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKVMeJcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgH0MWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgH0MCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:02:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A6C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:02:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so3198023pgh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wwPhOxGIRjLkN/opTRViTv7LvuoBwuvf4nfx6OU/cE=;
        b=CKVMeJcBEircN6dVAHJ/bskVCId7inXED/HGe3X/FQRoqV+Io7AGOKBBKJA6zHxFAb
         gOn0NYY+FFf5FSS/W81X3jXiwyuhLAc5MTSzWMajcklKc25MDYprwShYHStiq5mSQv5Q
         8hb5qC1ml7G3dDeLhMSKix96eh+uRdo1PvleeDysANFs0criSweSzIMp/OprHbw61+AO
         dvO6+G10hwQ0awgaIqpYyR4H6TsYZKWjRnd2EOk1PkiO/9407dL5bkK5nMn+/yoZShxY
         RW4YdOLbm80pahqHVwOXVPKbZtJROCMUwjfJHuSmnXAk/xaIzG8mh/0Pr+DI2YKTdHpq
         jM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wwPhOxGIRjLkN/opTRViTv7LvuoBwuvf4nfx6OU/cE=;
        b=hhqDp407D9M/q+n9rH96mGXFePDmmAjw81uPFEH3ibS7g4SCYzluj0iRPEUWYMJEHI
         Av7/cGirpniEwVPNvhFjHWo/ZeAjDOqMlWi94WiMVeuPijnl1W0B7Lc1MZ1zzUwsey4c
         x5v7xyb0K6GM0bmQPK378AvlIn7Qw902bpxiIhtnxYcErrXGlI2iak9VzRxhaE5aFxNP
         28nrewsAVnfGYOP0cyblWvwZLptBzQcICKu9SPb9ITUIdnvXAEB6fGXTXHOZ1fK08K4b
         apxHPa1yuMAwFSGC2jEFV6Tqpl+MaAy5lSbZIgmo+BZ/3ljtBV6bjGW/rpKNJgXA+Jn8
         EsnQ==
X-Gm-Message-State: AOAM532MFVY+KPo1vDXP1BNKJY8xfmRGTp5ywpL3iexsKuzg1fY95g8h
        2MSyL8TPIegY1Ksf7bcAZK7xQHmNp5JHLFwVI6AbPQ==
X-Google-Smtp-Source: ABdhPJxWTmElGdsbHABsAV6DJ0YuQtSHjUbzvfvruuAVjBFut8sQeWqYvmsUPFtMJVgNihgR1cKI/TJQCPNGqjnhchE=
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr15849073plo.289.1598529756898;
 Thu, 27 Aug 2020 05:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <5185661d553238884613a432cf1d71b1480a23ba.1597425745.git.andreyknvl@google.com>
 <20200827080442.GA29264@gaia> <56ba1b14-36af-31ea-116b-23300525398d@arm.com>
In-Reply-To: <56ba1b14-36af-31ea-116b-23300525398d@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:02:25 +0200
Message-ID: <CAAeHK+yYeYJqkxiQD7F_VBzUmJ3Tx4W6huUUJ4Sk7auiA=UkoQ@mail.gmail.com>
Subject: Re: [PATCH 19/35] kasan: don't allow SW_TAGS with ARM64_MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Aug 27, 2020 at 11:52 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 8/27/20 9:04 AM, Catalin Marinas wrote:
> > On Fri, Aug 14, 2020 at 07:27:01PM +0200, Andrey Konovalov wrote:
> >> Software tag-based KASAN provides its own tag checking machinery that
> >> can conflict with MTE. Don't allow enabling software tag-based KASAN
> >> when MTE is enabled.
> >>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >> ---
> >>  lib/Kconfig.kasan | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> >> index b4cf6c519d71..e500c18cbe79 100644
> >> --- a/lib/Kconfig.kasan
> >> +++ b/lib/Kconfig.kasan
> >> @@ -69,6 +69,7 @@ config KASAN_GENERIC
> >>  config KASAN_SW_TAGS
> >>      bool "Software tag-based mode"
> >>      depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> >> +    depends on !ARM64_MTE
> >
> > I think that's better as:
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 10cf81d70657..736c32bd8905 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -131,7 +131,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > -     select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> > +     select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN && !ARM64_MTE
> >       select HAVE_ARCH_KGDB
> >       select HAVE_ARCH_MMAP_RND_BITS
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >
>
> I agree with Catalin here, "select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN &&
> !ARM64_MTE" should be sufficient.

Sounds good, will do in v2, thanks!
