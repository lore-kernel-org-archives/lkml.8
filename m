Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCDC2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24AF2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgIHRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbgIHQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:19 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A062074B;
        Tue,  8 Sep 2020 14:06:22 +0000 (UTC)
Date:   Tue, 8 Sep 2020 15:06:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
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
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
Message-ID: <20200908140620.GE25591@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia>
 <CAAeHK+x_B+R3VcXndaQ=rwOExyQeFZEKZX-33oStiDFu1qePyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+x_B+R3VcXndaQ=rwOExyQeFZEKZX-33oStiDFu1qePyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:18:04PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 12:40 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index 152d74f2cc9c..6880ddaa5144 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -38,7 +38,7 @@
> > >  /* PTWs cacheable, inner/outer WBWA */
> > >  #define TCR_CACHE_FLAGS      TCR_IRGN_WBWA | TCR_ORGN_WBWA
> > >
> > > -#ifdef CONFIG_KASAN_SW_TAGS
> > > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > >  #define TCR_KASAN_FLAGS TCR_TBI1
> > >  #else
> > >  #define TCR_KASAN_FLAGS 0
> >
> > I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> > user series, just do this in __cpu_setup.
> 
> Started working on this, but realized that I don't understand what
> exactly is suggested here. TCR_KASAN_FLAGS are used in __cpu_setup(),
> so this already happens in __cpu_setup().
> 
> Do you mean that TBI1 should be enabled when CONFIG_ARM64_MTE is
> enabled, but CONFIG_KASAN_HW_TAGS is disabled?

What I meant is that we should turn TBI1 only when the MTE is present in
hardware (and the ARM64_MTE option is on). But I probably missed the way
MTE is used with KASAN.

So what happens if CONFIG_KASAN_HW_TAGS and CONFIG_ARM64_MTE are both on
but the hardware does not support MTE? Does KASAN still generate tagged
pointers? If yes, then the current patch is fine, we should always set
TBI1.

-- 
Catalin
