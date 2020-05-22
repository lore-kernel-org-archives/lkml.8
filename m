Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B09820723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fctbeo2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgEVLkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgEVLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:40:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD40C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:40:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so6299768lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj2fTCjbxOKsyZP7M3oTIyRA9mJ2Bc+fUg1m8uH2yYk=;
        b=Fctbeo2rUCXQwGpTpFGVse8+WCb+g1DgkimSxd0aywjWQzd7bhxHHSHfy1FP+QqJ5E
         HQGcAIndvBPaVq+mvvXrYxa60iZ270cp/hL7v335T389bW5HYMkEi/Mut44zha6NDaG4
         UCrNm9pJDDi2UNXl+PlD6bv/w4smxNEG9g8AyCyft6tAOApW/apnSn16+WYKI0WwO/LX
         QygL+8MKePZCy7xTU8Q+o6DXxVRskTBMwRQQsFJ+VR7QHRA9Pic1hmOdE0dfFierlTBM
         XmumN0HJD7IHx+R0ZAzFlmPROpUU2YmKdDsZd/Q7eTLT58JceLPdRakROdwY5S4uTJxp
         Cehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj2fTCjbxOKsyZP7M3oTIyRA9mJ2Bc+fUg1m8uH2yYk=;
        b=ikks4OUmV7o9J6aw0q4UQuKSvYm8ITAsqpFx7/hveNfHqGGNfYNvX0yS4+RUPOvvgT
         9NttISV+1d4JFWlkAgf7khGgY89fpoYWl62TtEc5V6LBnOA63Uob/Ni7/c5ArCHdV/5D
         IvOJPt01b0qi1OlhD1a5OMZhFInjCMWR/hOhpeSPOY0kHHggz7dyBMRp4P5ZCWTJLChm
         Zq4NAbEDoAM2wBvKbv6UC12M3Tbngn5TzuXTD90n85DmtBrMOIdVqlhNfEE4juY7N1iO
         DKvu2bjKi4zPcOxBIi0H8DDM2B0fiCRxyTv6zIdGmmI/buqyd2lMM3BhE1oTCqeF2m5t
         A0qA==
X-Gm-Message-State: AOAM532m4vO1yn2BBhh1ckAvAbxywmZA3cbM+jBZgYW10Si5Q1hmCNGl
        lRHhXkvEt2EuA3FTU0TrRSv7mXxzkpOTwdCH3zddtI1z
X-Google-Smtp-Source: ABdhPJyCH6J7CaJtTe9PzunF+afSux/PTZRtv8MDXaAqacG2ZKbC4Y+MdKt3boWpmeIuz1KBImEFTAKzX+qejKOKM8k=
X-Received: by 2002:ac2:53a2:: with SMTP id j2mr7071822lfh.139.1590147643673;
 Fri, 22 May 2020 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
In-Reply-To: <20200519002124.2025955-1-jhubbard@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 22 May 2020 17:10:32 +0530
Message-ID: <CAFqt6zZTZrB=LiGQpcOtZfnr7-CL4tkLHz8eXFvxwCTcfKy4sQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm/gup, drm/i915: refactor gup_fast, convert to pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


On Tue, May 19, 2020 at 5:51 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> This needs to go through Andrew's -mm tree, due to adding a new gup.c
> routine. However, I would really love to have some testing from the
> drm/i915 folks, because I haven't been able to run-time test that part
> of it.
>
> Otherwise, though, the series has passed my basic run time testing:
> some LTP tests, some xfs and etx4 non-destructive xfstests, and an
> assortment of other smaller ones: vm selftests, io_uring_register, a
> few more. But that's only on one particular machine. Also, cross-compile
> tests for half a dozen arches all pass.
>
> Details:
>
> In order to convert the drm/i915 driver from get_user_pages() to
> pin_user_pages(), a FOLL_PIN equivalent of __get_user_pages_fast() was
> required. That led to refactoring __get_user_pages_fast(), with the
> following goals:
>
> 1) As above: provide a pin_user_pages*() routine for drm/i915 to call,
>    in place of __get_user_pages_fast(),
>
> 2) Get rid of the gup.c duplicate code for walking page tables with
>    interrupts disabled. This duplicate code is a minor maintenance
>    problem anyway.
>
> 3) Make it easy for an upcoming patch from Souptick, which aims to
>    convert __get_user_pages_fast() to use a gup_flags argument, instead
>    of a bool writeable arg.  Also, if this series looks good, we can
>    ask Souptick to change the name as well, to whatever the consensus
>    is. My initial recommendation is: get_user_pages_fast_only(), to
>    match the new pin_user_pages_only().

Shall I hold my changes till 5.8-rc1 , when this series will appear upstream ?
>
> John Hubbard (4):
>   mm/gup: move __get_user_pages_fast() down a few lines in gup.c
>   mm/gup: refactor and de-duplicate gup_fast() code
>   mm/gup: introduce pin_user_pages_fast_only()
>   drm/i915: convert get_user_pages() --> pin_user_pages()
>
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  22 +--
>  include/linux/mm.h                          |   3 +
>  mm/gup.c                                    | 150 ++++++++++++--------
>  3 files changed, 107 insertions(+), 68 deletions(-)
>
>
> base-commit: 642b151f45dd54809ea00ecd3976a56c1ec9b53d
> --
> 2.26.2
>
