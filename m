Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DD22CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHlALGet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgH0MtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgH0Mnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:43:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A2C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:43:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so3406066pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpzREOcIrukXANPEmvrI6Q05nccQGVBf08+JNfkt4Jw=;
        b=UHlALGethP+XF8Xx15Bkd4rjqcoCWixU2Kg9zK1Ai8YR26cFQnGAAfZFhCzGD5exxl
         6DUgXAxpJx0VzhgnLZ8veoDW4D2VtOSwi1WssJvi+C5TYGg6zi8NI4Xx0TfZqWjybswN
         krFsTBIjs/qGYPkYoEJNzjH8DRa716+rz3GW9MehNX+lOGE5gAHWCjuh/5lW4SAhceUK
         HEmoCmPRKpZ7AvrLMz7QZRECy09ZoOGSoLkjZnOxrvwevweft/o9soFkVMDNBErYheU/
         9UpwsJUd4LVDpWNX5ew7wyXbZHrKg23EZg+XwyPbO6hXuJecShqgfjPIGSmdM0iHK3G1
         SvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpzREOcIrukXANPEmvrI6Q05nccQGVBf08+JNfkt4Jw=;
        b=pOjAqBuRGP1sQ2o269evdQTeybeehR6v6IShDcoa78oLPKRREyGbqcBnLzIdXYcwb4
         DqehRkI5mNwkfwEIh5Sxmc6eAn5byVJjQ+dBdF5aCLzxBMdt9ljIk7w7vxY8NQRUa2Mp
         JITXrAfZFzW784EaS4kPun8ktt0F4W5cr8HJ2fb6i2eZWxQq2vR27Uw42Awrf0LyY+9P
         k52H12CeQ5MVpzKJwVUDDxTXTXxVIWtTKPsZxk6V/XRQehlD9U/ep2q3U9LiCndn0fzJ
         rwFs2YAWqzbzjiCMqxbTU3GZpXOgTFbpPBanx6TXiwvhWasdAU/HVMrBGCW2ORMnu3A9
         PNzA==
X-Gm-Message-State: AOAM532Zqc3Mq3Fk7K3Ef9XjtyPKn1mCXFc4tX0d7rWCmg5WrzGPsyOG
        JmMTb95xlZv5uAKMWdHiiU5qfseDqMaqkZQeTg+bNA==
X-Google-Smtp-Source: ABdhPJxuj6rYCJJdWgpgaTNs6Y6dBbQY8aITvclQRebjC3+PxK6h72/GRkpCuz/1FNoHMmojX+ZiKylGPmUJot58C80=
X-Received: by 2002:a63:4c:: with SMTP id 73mr14624887pga.286.1598532216123;
 Thu, 27 Aug 2020 05:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia> <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
 <20200827111344.GK29264@gaia> <d6695105-0484-2013-1012-fa977644e8ad@arm.com>
In-Reply-To: <d6695105-0484-2013-1012-fa977644e8ad@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:43:25 +0200
Message-ID: <CAAeHK+wGKjYX6eLztiwQA2iObjibHPKt3A4oU0zpXPKk-4qdOw@mail.gmail.com>
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
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

On Thu, Aug 27, 2020 at 1:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 8/27/20 12:13 PM, Catalin Marinas wrote:
> > On Thu, Aug 27, 2020 at 12:05:55PM +0100, Vincenzo Frascino wrote:
> >> On 8/27/20 11:40 AM, Catalin Marinas wrote:
> >>> On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> >>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >>>> index 152d74f2cc9c..6880ddaa5144 100644
> >>>> --- a/arch/arm64/mm/proc.S
> >>>> +++ b/arch/arm64/mm/proc.S
> >>>> @@ -38,7 +38,7 @@
> >>>>  /* PTWs cacheable, inner/outer WBWA */
> >>>>  #define TCR_CACHE_FLAGS   TCR_IRGN_WBWA | TCR_ORGN_WBWA
> >>>>
> >>>> -#ifdef CONFIG_KASAN_SW_TAGS
> >>>> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >>>>  #define TCR_KASAN_FLAGS TCR_TBI1
> >>>>  #else
> >>>>  #define TCR_KASAN_FLAGS 0
> >>>
> >>> I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> >>> user series, just do this in __cpu_setup.
> >>
> >> Not sure I understand... Enabling TBI1 only if MTE is present would break
> >> KASAN_SW_TAGS which is based on TBI1 but not on MTE.
> >
> > You keep the KASAN_SW_TAGS as above but for HW_TAGS, only set TBI1 later
> > in __cpu_setup().
> >
>
> Ok, sounds good.

Sounds good to me too.

Vincenzo, could you take care of Catalin's comments on your (arm64)
patches, do the rebase onto user mte v8, and share it with me? I'll
work on KASAN changes in the meantime, and then integrate everything
together for v2.

Perhaps the best way to test only the arm64 part is writing a simple
module that causes an MTE fault. (At least that's what I did when I
was testing core in-kernel MTE patches separately.) Or reuse this
series, all KASAN patches should rebase cleanly on top of the latest
mainline.
