Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE06C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D2222D00
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWaKBXCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgH0M0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgH0MFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:05:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF13C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:05:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so3323114pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQWdT8WbkjggL+VwPZ1ejJL4JOhIunI/RdMzpXfnZIU=;
        b=BWaKBXCNmEVXA2JWbxY9DmiZBysI37rmIsvDDCfuwrfdPQHvFGNEvbK9FuNxLP5aJ6
         hfKiqRqly/VGxw3TZPGRRv2dA7r8TAnrjSjQaXsjJbL5CzdVQ+D7f17CjTSfiVE59+YE
         ESTuI0sOn8bYUUjps3RHi13LgWRRQOvplLxYZAmfK1Klh3eFUUnRZkgzEogRtFoOIMoa
         5HxY+z4IDMpvteZDqYYSzAk5ZHvkNHWTypJyxye5yEC+/zZqR/DW4ZT0LduguVg0JeRV
         WD89MaNyvouyNjVN+AF7hnm+K4MVleSuRe9uAkebAYtpIGreRpPYr6oSuSwJPsNU1HL3
         ESBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQWdT8WbkjggL+VwPZ1ejJL4JOhIunI/RdMzpXfnZIU=;
        b=R9ecPDfcTVPzE+llGE5FgJ/N5q6m3vF/VFqZFL2HwK1ULMgTShANgW6Jt8j2eqRkfg
         R5F9OEAzkl1Yxl6G/Lueh2cJ85kB18Mw5ppSbliELBuE01p4T5haFc+u30YA2qbGFXcl
         84naknG4SJih66D9dNsopG0wA+JKK9Vgs0673dTXeerwVxIVYuk4wo2MfpLGFUlSE3+w
         8nXxWEXz3/z5fmOuwytgu59QPMyJoyY0Sc5vO4zNfGu5MzsJ3cy3y+2bMMbi6A4S5ZCY
         AxytlJTZySjkRVZ4zJa2GLXLWh1z5lwYHbgc9ShDAFokXbF1msrEj562TMqRat3JJqzj
         WiMQ==
X-Gm-Message-State: AOAM530fa8dtUfmk193lAi0l/F6VFWT3ZVW61/vjGHHwBiM7UEbY8ZPI
        WVx6YlvYhW3qIH/BwDm9cZYFoEO948OouVtYdXvmpA==
X-Google-Smtp-Source: ABdhPJxBixhsyk7YFbVXwQoa9Dy/RTNiXLkApjohxbkjb0jNodf4ci0xjdKa/q7Wu2qZq4T77yF1RITctr4g9vGoC54=
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr4462254pfd.135.1598529940106;
 Thu, 27 Aug 2020 05:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <07455abaab13824579c1b8e50cc038cf8a0f3369.1597425745.git.andreyknvl@google.com>
 <20200827104147.GG29264@gaia> <c0319233-8985-8cc7-ea72-910b42b2b5d0@arm.com>
In-Reply-To: <c0319233-8985-8cc7-ea72-910b42b2b5d0@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:05:29 +0200
Message-ID: <CAAeHK+wLVK_YG2gWVLk0YsoKozfZhht6zVzz=7N_yz0S=JgHEg@mail.gmail.com>
Subject: Re: [PATCH 28/35] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Aug 27, 2020 at 1:05 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 8/27/20 11:41 AM, Catalin Marinas wrote:
> > On Fri, Aug 14, 2020 at 07:27:10PM +0200, Andrey Konovalov wrote:
> >> Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
> >> KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.
> >>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >> ---
> >>  mm/kasan/kasan.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> >> index 1d3c7c6ce771..4d8e229f8e01 100644
> >> --- a/mm/kasan/kasan.h
> >> +++ b/mm/kasan/kasan.h
> >> @@ -5,7 +5,13 @@
> >>  #include <linux/kasan.h>
> >>  #include <linux/stackdepot.h>
> >>
> >> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >>  #define KASAN_GRANULE_SIZE  (1UL << KASAN_SHADOW_SCALE_SHIFT)
> >> +#else
> >> +#include <asm/mte.h>
> >
> > You could only include the new asm/mte-def.h file (currently mte_asm.h).
> >
>
> Agreed, we should only include asm/mte-def.h here since after the suggested
> modification will be sufficient for the purpose.

Will do in v2.

>
> >> +#define KASAN_GRANULE_SIZE  (MTE_GRANULE_SIZE)
> >> +#endif
> >> +
> >>  #define KASAN_GRANULE_MASK  (KASAN_GRANULE_SIZE - 1)
> >>
> >>  #define KASAN_TAG_KERNEL    0xFF /* native kernel pointers tag */
> >> --
> >> 2.28.0.220.ged08abb693-goog
> >>
> >
>
> --
> Regards,
> Vincenzo
