Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0320C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795102087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5T69mNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgH0OnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgH0Ogb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:36:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BAEC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:36:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so3651633pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESqQJ3ododn8j9sB4yCnSFUyTmI5ABpQzOrhit8Rb1k=;
        b=g5T69mNObCL2Grw6KpM8c7kJaXhDw6FnnWEnoUt2a2mXj7lmMnmDXfB0QgIi1Y2TxE
         ef2UhYnFSwkLTsWcaKGppKGv8SScFSWrN3gGiqB8FvSyYai9icB647Fjlocg9ADLoBpL
         2R7jUYSXz5TotwCsvpSyZJsDOzb+me7pVDlGO/FZrFEVMOqzLFqGav9vW4IGmYNBMZZ7
         tQKQeiMngbDbp6F8Ui4ywO5g48dojUg1e76DBPdtiyi6MgDh8BwLDMgKMpBTUS17hh0o
         jjl1XNzTRtP5LINd5Qrp3BIEMMdl3xKkofP7NDNFT1ZH9Zg45xxaSTSqoy/XivcEp1n7
         AsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESqQJ3ododn8j9sB4yCnSFUyTmI5ABpQzOrhit8Rb1k=;
        b=gwrpjLfK3Zj13YCqtWMIQgZjNwQPxjKdv8IQWp5wxuedWKivwp+FG+y0ja4K/CNa0+
         I1Rkjiku+OM7FetO4L+FT8/6XvUzXcNC+OUKiIAx1b7oc5VDmUb3A6r4igHwnyrqfM1D
         BK/zUOSEd2DFKl70pI+YvWuT635DEiguXS5syu9EJpVfkQdxRQPKW7vCgTYAPDrXY0yc
         tDANbTbA8YRLdb3nw08WJ7/7+Z7I7IZDnjaLsCjbmhU5nWcEKbMQAJ3JwLSGQpCHE+5E
         hwAlf2n+4jKsGHv58wGo3TOhX6LzRfwabn/q0ELW6DH5V9+nSseeVthx/6tkkPcDNso5
         x2XA==
X-Gm-Message-State: AOAM533WrV9XiRMFuerzUwnqO6IJAwU+YyGS92r+9Fbz3yYc9el885gf
        j+voobKpHP0gA7PMeLIco1pvBofTit2dBUvSjWkPhA==
X-Google-Smtp-Source: ABdhPJyOXXy6+yLSZX6CJbiVi7n4/xo7pJcVNWBmzm5+yLYznjEK7CI3vCIpoZLRNoCeI9h3o87WVSkoOug5TbvYApw=
X-Received: by 2002:a62:2bcc:: with SMTP id r195mr8138438pfr.123.1598538990077;
 Thu, 27 Aug 2020 07:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia> <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
 <20200827111344.GK29264@gaia> <d6695105-0484-2013-1012-fa977644e8ad@arm.com>
 <CAAeHK+wGKjYX6eLztiwQA2iObjibHPKt3A4oU0zpXPKk-4qdOw@mail.gmail.com> <30b90e66-2ac0-82b3-b590-5a2b35fad446@arm.com>
In-Reply-To: <30b90e66-2ac0-82b3-b590-5a2b35fad446@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 16:36:19 +0200
Message-ID: <CAAeHK+ws8H=Ba7Q2J-UiaweK1KuKYMQA17RD3U3CO7b5FvMx2g@mail.gmail.com>
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

On Thu, Aug 27, 2020 at 3:42 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 8/27/20 1:43 PM, Andrey Konovalov wrote:
> > On Thu, Aug 27, 2020 at 1:15 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >>
> >>
> >> On 8/27/20 12:13 PM, Catalin Marinas wrote:
> >>> On Thu, Aug 27, 2020 at 12:05:55PM +0100, Vincenzo Frascino wrote:
> >>>> On 8/27/20 11:40 AM, Catalin Marinas wrote:
> >>>>> On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
> >>>>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >>>>>> index 152d74f2cc9c..6880ddaa5144 100644
> >>>>>> --- a/arch/arm64/mm/proc.S
> >>>>>> +++ b/arch/arm64/mm/proc.S
> >>>>>> @@ -38,7 +38,7 @@
> >>>>>>  /* PTWs cacheable, inner/outer WBWA */
> >>>>>>  #define TCR_CACHE_FLAGS   TCR_IRGN_WBWA | TCR_ORGN_WBWA
> >>>>>>
> >>>>>> -#ifdef CONFIG_KASAN_SW_TAGS
> >>>>>> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >>>>>>  #define TCR_KASAN_FLAGS TCR_TBI1
> >>>>>>  #else
> >>>>>>  #define TCR_KASAN_FLAGS 0
> >>>>>
> >>>>> I prefer to turn TBI1 on only if MTE is present. So on top of the v8
> >>>>> user series, just do this in __cpu_setup.
> >>>>
> >>>> Not sure I understand... Enabling TBI1 only if MTE is present would break
> >>>> KASAN_SW_TAGS which is based on TBI1 but not on MTE.
> >>>
> >>> You keep the KASAN_SW_TAGS as above but for HW_TAGS, only set TBI1 later
> >>> in __cpu_setup().
> >>>
> >>
> >> Ok, sounds good.
> >
> > Sounds good to me too.
> >
> > Vincenzo, could you take care of Catalin's comments on your (arm64)
> > patches, do the rebase onto user mte v8, and share it with me? I'll
> > work on KASAN changes in the meantime, and then integrate everything
> > together for v2.
> >
>
> I am happy to do that. I will be on holiday though from this Saturday till the
> September, 9. After that I will start the rebasing.

Ah, OK. I'll see if I can do the rebase and fix some of Catalin's
comments myself then. I'll let you know the current status once you're
back.

>
> > Perhaps the best way to test only the arm64 part is writing a simple
> > module that causes an MTE fault. (At least that's what I did when I
> > was testing core in-kernel MTE patches separately.) Or reuse this
> > series, all KASAN patches should rebase cleanly on top of the latest
> > mainline.
> >
>
> I can reuse the patches as they are, unless they require changes when I start
> rebasing. In such a case to not duplicate the work I will scale back to use a
> simple module.
>
> --
> Regards,
> Vincenzo
