Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03A920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eaKMvZWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgFPRAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgFPRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:00:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:00:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id y6so9559692edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPeuMd1WEvJ1ma7aQCw6zXV4QVdt7ZfI0Cfl/8xUDIM=;
        b=eaKMvZWei9R2XyacgUoysVdJc068IXP0NNd/XrABL5Fs96V0/mUo0avQdjYOlpxSFd
         e9b1R8aS7VarUTJHJSzN3qb1YGADscXGqARaOV3vmLZwRq0OzpklWLOuWFTgnhGSi2mE
         XGQyPt2OX112Xs45OsWmyUUmnceiRdwaIqNB53Q4Z/fz+eP5lTK3V6j6ScJRiC0VUz5P
         3iCL506atUQ329qDSBG5dw0RHxyv6QZauGlfgpNqu9IGSf3hm5/rqM462W+Yapt1TEud
         tAzCYJ+D5SrOkPgEgljnTmTikMdu2EKN1cYTbm/V02lyTZwYevLgbpejj2xgMRj0BvOd
         tYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPeuMd1WEvJ1ma7aQCw6zXV4QVdt7ZfI0Cfl/8xUDIM=;
        b=M10EoK23fGyIkJIKJNgdpgl48AAgD1bJaWb9/Anf9DR6WJhZI1E4vWOpftqhk3naAs
         7aLieeb7E+moOASJvdO3uHigPe/kljBFUHp2U/Yym6XnyX7uxrW8vvTte33FxiaMERp7
         oTztQJpB4evMk1MOMpL1EMVFmkke/CK3UGfForGlfDYviyJsKrEJV5BOEMVjn7KRSd1u
         uFcD428JsA43p46NMXAqUwNGjPC7P7VtF3DAccbkjUrWX+zeN3GK6oKE+DcgliVmYO8f
         x8KBHZMjgrzXe0RyREJMaHjAm72ThzxHd2GSdXqKur7VSrfUnvczeEcZ813eN7y1yluk
         EBJA==
X-Gm-Message-State: AOAM532ozZ5+xKHEpNjXlJwWvDm8nSuINiT0LlVxDlLRfAgkGlf7U5i5
        WypHpgtMSEcZjZHtxbe79uqZ6XJW+tBD27eR/3r3Iw==
X-Google-Smtp-Source: ABdhPJyfIkb+AkO/SqC7bmIMe89rUqNRgupadojlXmAms/5ZoR75qQ7LiyI9oncPtq8Ui1V9UYIwxYqtwmFDhUUuWek=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr1572935edw.383.1592326850286;
 Tue, 16 Jun 2020 10:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200616115213.13109-1-david@redhat.com> <20200616115213.13109-3-david@redhat.com>
 <20200616125051.GH9499@dhcp22.suse.cz>
In-Reply-To: <20200616125051.GH9499@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jun 2020 10:00:39 -0700
Message-ID: <CAPcyv4hjxyyxVyZbAYoXX2TM3mHF6e4VneVVcmVU+_Q4n9CxzQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone
 when onlining memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 5:51 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 16-06-20 13:52:12, David Hildenbrand wrote:
> > Commit e900a918b098 ("mm: shuffle initial free memory to improve
> > memory-side-cache utilization") introduced shuffling of free pages
> > during system boot and whenever we online memory blocks.
> >
> > However, whenever we online memory blocks, all pages that will be
> > exposed to the buddy end up getting freed via __free_one_page(). In the
> > general case, we free these pages in MAX_ORDER - 1 chunks, which
> > corresponds to the shuffle order.
> >
> > Inside __free_one_page(), we will already shuffle the newly onlined pages
> > using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
> > memory hotplug.
> >
> > Note: When hotplugging a DIMM, each memory block (e.g., 128MB .. 2G on
> > x86-64) will get onlined individually, resulting in a shuffle_zone() for
> > every memory block getting onlined.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Nacked-by: Dan Williams <dan.j.williams@intel.com>

As explained in another thread this is in active use.
