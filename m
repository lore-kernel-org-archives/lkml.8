Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E720C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD3A206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ov/ZXMw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbgIHQka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbgIHQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71910C06125E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:18:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so3873946pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vIgYTSyDPV3iR6+cw+LdVUS1ZrYeuTmFBotSM5CblM=;
        b=ov/ZXMw/AKOs8jo09rA2hYZSxInsT3OMFVq89whQo7cYYu2SCkDSKDxy0gcKVbVn7t
         hFYOgCbfDVCtB1NDLGjAf471ThUkNGJM9gXwPedc1dFFgCJ+KLGWLjhlmFiCTwlIJbic
         wc9pyM7t6SceOLnil91wfK2poKJPGBRPN3XmiaGTw7yGS8phORQ95GUv2UtX4oEXZMPc
         nHgtFAQlkf5qKrRYD4x75Qn3bMbrk0QI0czVR1MYPLmaKef/ZY+yhb1u2qQk4nAFniiY
         qAaMXOv8TQY4xmSAcOzvdKoT2YVDknIApH8CKySjRjGDfQmhwfxU+gvw2bwl+D6+dMED
         igpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vIgYTSyDPV3iR6+cw+LdVUS1ZrYeuTmFBotSM5CblM=;
        b=BhGJ6hs7a7+gW/2yBeVN33FzxviEaHSeBOnDtVHAxgNbbbPMlrtRUwBBOL2RVL5i8Z
         A8ArQcQFbIoa6yU9T66L5R8ydzAnPK8JUYv9y1IJRMDgMDvTc6JzMdkNrs8NTKQ/VLti
         jmfOqDbmvrhj+A9krjJBXqddCyt/l0o1pUVbBk9Jg/AXPYSaSvMQ3yF/f39veZAQdR5l
         OKKAdDLCQFENGte22X8deSE8uz7Rc9bdhklQnC9pdsUUgtvzeVQOA1uE4kMbCJNNuFEe
         rfhnPOqYps0q99i1ObL7MG/WamDM/GOx5FcpgrA69NFYK289brvA2waPLoIWIvvaEpfy
         E6HA==
X-Gm-Message-State: AOAM531W7huFEqKyitGX0Apw5QBIABZzVjxKof+sTn8ZTBIbLdvUPcwq
        hgy4aY/zae4/NxVByblXtFGRdMY1IxqKA/5Du54xgw==
X-Google-Smtp-Source: ABdhPJzxi6yQj0Q2YVkwR7BwzG5jGX9Kv30i0fI1k3zMgffaPeCcvt33Dkc1PTDpk7PvaFohhQSk8DzIdn8G1e0e6HU=
X-Received: by 2002:a17:902:988f:: with SMTP id s15mr23932254plp.26.1599571095681;
 Tue, 08 Sep 2020 06:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia>
In-Reply-To: <20200827104033.GF29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 15:18:04 +0200
Message-ID: <CAAeHK+x_B+R3VcXndaQ=rwOExyQeFZEKZX-33oStiDFu1qePyg@mail.gmail.com>
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

On Thu, Aug 27, 2020 at 12:40 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 152d74f2cc9c..6880ddaa5144 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -38,7 +38,7 @@
> >  /* PTWs cacheable, inner/outer WBWA */
> >  #define TCR_CACHE_FLAGS      TCR_IRGN_WBWA | TCR_ORGN_WBWA
> >
> > -#ifdef CONFIG_KASAN_SW_TAGS
> > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >  #define TCR_KASAN_FLAGS TCR_TBI1
> >  #else
> >  #define TCR_KASAN_FLAGS 0
>
> I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> user series, just do this in __cpu_setup.

Started working on this, but realized that I don't understand what
exactly is suggested here. TCR_KASAN_FLAGS are used in __cpu_setup(),
so this already happens in __cpu_setup().

Do you mean that TBI1 should be enabled when CONFIG_ARM64_MTE is
enabled, but CONFIG_KASAN_HW_TAGS is disabled?
