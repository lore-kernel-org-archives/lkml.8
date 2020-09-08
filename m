Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F262080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv+LslJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgIHQ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbgIHQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:22:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941BC08EAD4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:39:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so5763669pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6IZBEYdJUicGrUE54qThuMWVgXq8hL/oKiMR3tNmWw=;
        b=cv+LslJ4V6jfBHxvBBCk7QV/70j9a6RdII0YFlSLFtzmyWQa8pV+VXOTMXbYoLw3gJ
         7DIJkOIRBeK9eyC075KhNoNS5tWP+NhRGWamXmd9VcbEgexsPRuHqUxTUvwMVVwGIrQF
         jwja0RSSmK4sJz0xpuPKd0pIbeb4yMAcw3vrt3c8itGysNVbPAyttMGQV8BzfMCWY7yw
         10eknqk7kUIcYYTpqo6phYE6GX1SOCg8dLd0QXO77rBoW3FuzgGfCkkGE3/GOXACuBrL
         ygzDP55kRb9Cjp7f8QCSbAxJ5uTK/SVSXSDPlNwqOZyT/AGeeGHpjt+Z2NExWvZqpMZX
         PPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6IZBEYdJUicGrUE54qThuMWVgXq8hL/oKiMR3tNmWw=;
        b=Tyk8+9lJb/4BY03UaA2p2MImv88LanBHkjCBk4SczXp0bSrkupmzWzPfkQDdVOinfo
         jLWqH4SCt3coM5RjjMpbSa8v0vl9hQN4iXft+zArwo8bI33Lbwj23cu4zXsdSGnqQai7
         BmJs4ToB7EI6sJ46o0XXtdU/KXnfjf3F8X9+FF56suKugq1glSC2tBgNUYgvplbT07Fi
         87+9DBHA/kkrbSfUb9CTE1PvBmoeIrNH5+J8bYD2xm3FcGahP9dBV5XRC2URafbS/Tyu
         4cwUMKt5Vg6G91Bs9+NagcgzwffikCettVa0F+5RCxjj4+tLgHoTeHWcDznb37IX7x0i
         bAKg==
X-Gm-Message-State: AOAM5305HEn6gLkMon+tpxvLzRcwVTMevbJV4RC1L7Ke96prTJ+jr/Ig
        AayN5E+BCYeOejUGKGrqnl7CbZTq/x7ZuhVZPqcLlw==
X-Google-Smtp-Source: ABdhPJws7YHVVJhG8H6UoWmd1N6htiZqw6o05TjLx9l7lnPD7Lq3S75jkqpmEFtYhNZsF2F4rx0yGYcdoIIg1vb7fUk=
X-Received: by 2002:a17:90b:140c:: with SMTP id jo12mr4229667pjb.41.1599575986171;
 Tue, 08 Sep 2020 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
In-Reply-To: <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 16:39:35 +0200
Message-ID: <CAAeHK+y-gJ5JKcGZYfZutKtb=BoM3qfkOyoTi7CtW6apHUcCAw@mail.gmail.com>
Subject: Re: [PATCH 22/35] arm64: mte: Enable in-kernel MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> The Tag Checking operation causes a synchronous data abort as
> a consequence of a tag check fault when MTE is configured in
> synchronous mode.
>
> Enable MTE in Synchronous mode in EL1 to provide a more immediate
> way of tag check failure detection in the kernel.
>
> As part of this change enable match-all tag for EL1 to allow the
> kernel to access user pages without faulting. This is required because
> the kernel does not have knowledge of the tags set by the user in a
> page.
>
> Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
> similar way as TCF0 affects EL0.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4d3abb51f7d4..4d94af19d8f6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1670,6 +1670,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>         write_sysreg_s(0, SYS_TFSR_EL1);
>         write_sysreg_s(0, SYS_TFSRE0_EL1);
>
> +       /* Enable Match-All at EL1 */
> +       sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
> +
>         /*
>          * CnP must be enabled only after the MAIR_EL1 register has been set
>          * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
> @@ -1687,6 +1690,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>         mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
>         mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
>         write_sysreg_s(mair, SYS_MAIR_EL1);
> +
> +       /* Enable MTE Sync Mode for EL1 */
> +       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>         isb();
>
>         local_flush_tlb_all();
> --
> 2.28.0.220.ged08abb693-goog
>

Should we change this commit to enable in-kernel MTE only if
KASAN_HW_TAGS is enabled?
