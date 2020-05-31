Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C58C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341CD207D0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdoyKIUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgEaND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 09:03:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ECC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:03:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so8178856wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqhV+NqZNeQJy9937H6t2fNsaGUaVeO+uIzbSmUO5Ek=;
        b=ZdoyKIUQ6bcXIf1i6U4D+OAZlSfSrJNiPoMSOihkOAV7j3NcygRhNyaVSJezcTOo3D
         f+qVVkKojLorSAUDNc8ULzuj13GZmrmEJVssVqarWQscJCnQBX96HcqBCj6xnfvMieiV
         4t/DoVi5ez44ie2MCnraH6uHCJykNeEt+McehD0k6A2qrcpsVT84w0sN3vP8sMeAfcXf
         /Qk3wAT3OJGX6VLKSJSQ3uzQKrHHJfWpd+uq7gKJutLrk3vzV8XyElv5zMVpuUQSXgVR
         AgpTSrUw0tCR53bDMF8jtQwTvWZPmLAKGSavyrgy1k1P9N2qAFpCHIgKV0wCjaotPlpO
         sI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqhV+NqZNeQJy9937H6t2fNsaGUaVeO+uIzbSmUO5Ek=;
        b=O4xQJisrS8zzu7tW/XwJYTaIu4caZJJX/qsD3/GKq756EoqBuun0wVYMgQvGyUBXiS
         nCNJUElRh+v0ElbwE3uj0FmW8eEF8QaCVeyaGa2AauKxYBTceSPeVS3t2IUpliJEq5wf
         NZDD39pdkeBQT2iOHdjk8d/TyKCYWY8Z9iJFly16jmOylkLnTH/XgAJcqrxgO/KkNRVo
         6LXok/mC4LlmKODeVr4M8I0oM6xndlofVLfmVzX89vS8+WkEccquhVZpQlIrn+FS/2Aj
         YDVz8IZPuI6GA3vmgvbRl/PgNn9mSA+tHcuhZ8BxnOj9tox4WUHb/bZaYicVxWh45hXi
         9NdQ==
X-Gm-Message-State: AOAM530oXbDlaFI9EPM/tGCE+40niztm6294PVYBJ5mOycytYcq57S38
        wuhESqbIo0l+fiisD0XYQ8hKguHKXYMo3n/Doa0=
X-Google-Smtp-Source: ABdhPJyNmQucopa1ZwtxV6TDL6Cfs17/jBM8pu98SVjDcwNIJ5V7kCklaKZ2TDvVGxS9N9qym5HI6MNxnmUufw9zy9g=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr18302534wmh.105.1590930204261;
 Sun, 31 May 2020 06:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200527223243.884385-1-jhubbard@nvidia.com> <20200527223243.884385-2-jhubbard@nvidia.com>
In-Reply-To: <20200527223243.884385-2-jhubbard@nvidia.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 31 May 2020 15:03:13 +0200
Message-ID: <CAM9Jb+j2J3PJT6Pn_YXuEjRAm7nGCLiXKof3TvrrVgrUzsKvWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

On Thu, 28 May 2020 at 00:32, John Hubbard <jhubbard@nvidia.com> wrote:
>
> Introduce pin_user_pages_locked(), which is nearly identical to
> get_user_pages_locked() except that it sets FOLL_PIN and rejects
> FOLL_GET.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/gup.c           | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 98be7289d7e9..d16951087c93 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1700,6 +1700,8 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>                     struct vm_area_struct **vmas);
>  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>                     unsigned int gup_flags, struct page **pages, int *locked);
> +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +                   unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>                     struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index 2f0a0b497c23..17418a949067 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2992,3 +2992,33 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>         return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
> +
> +/*
> + * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
> + * Behavior is the same, except that this one sets FOLL_PIN and rejects
> + * FOLL_GET.
> + */
> +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +                          unsigned int gup_flags, struct page **pages,
> +                          int *locked)
> +{
> +       /*
> +        * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> +        * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> +        * vmas.  As there are no users of this flag in this call we simply
> +        * disallow this option for now.
> +        */
> +       if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> +               return -EINVAL;
> +
> +       /* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +       if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> +               return -EINVAL;
> +
> +       gup_flags |= FOLL_PIN;
> +       return __get_user_pages_locked(current, current->mm, start, nr_pages,
> +                                      pages, NULL, locked,
> +                                      gup_flags | FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL(pin_user_pages_locked);
> +
> --
> 2.26.2
>
>
