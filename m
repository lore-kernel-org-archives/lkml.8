Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD93C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07F320773
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Z5spa72D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgF1SGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:06:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2AC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:06:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so14821613iow.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIK/OChRVmVoJTuyMGQzpm0rHctDDsuMCJJxWBYwBQw=;
        b=Z5spa72DQofI/63ezBPQRBvc9INvJoQrJx3TJ7cCJVHRdE6jTt6XL+CQMDA3sD7X+c
         H5FLFB0PKxE8pB+MiYaktHq+45yDY+pWAHv0KdIbSy2O++BN8YL4WuZ7QFdkLppkf210
         0rw4HlX/ra/DX/ihuODI8HeR1xObpVOIsDDd6sPtilN5DyPkL2cSLnCAIlHFRKI5jVQD
         RBIgRyAco8LhCCFzlIhSBYKwBqzfJNPJ8RrweASaNzbHN57ib1juU7l27OfH6ko3mOAF
         xlWRN6DCgRs/UcS9GwvLAyrfcW3JrtJjGDzE1FFoeBwiDKdTJ0ebHed50dKgxH0pt+XF
         KGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIK/OChRVmVoJTuyMGQzpm0rHctDDsuMCJJxWBYwBQw=;
        b=JI0oPUgHcqVT8Mqg+yDNqzRvfsbLs1bZpEWDYsLzBWdfu1GTtFJiAEv1PmN6uUtzKc
         doxtXum1EZuP+ZymETaZq6pjeujNCjPIcqAZEffSOle/bNNf/56To1isZRWHIObIsghU
         dBfLqXp3snNCHpKOlf1GWGznigV+fZX1wuhJ3DVqMCIahQqlx6iXcU11XPcXBkFhqOFA
         nwHDzfPvWsL6fSpNxY4VrychBQWN4N86qK9XGG0kAHbIJ48DntxOYE8AGYZPy6o4IWG4
         dR+7GQA6+vOZfKMqHY7AM6Mj8pvY0cW8/gNWdlAZXCtqMNhpnzvSAEUybcdLeerg3Hni
         JcUQ==
X-Gm-Message-State: AOAM531/ye+pzcWlRpLIZn6N6MImyRGY3wFhUdGUByiYpGCXt7PNykEU
        EaoVIcXXW+sacSCcHJUgUmCJXYdeEMvzb6CD6q2Gjw==
X-Google-Smtp-Source: ABdhPJwHfxfeQq9oRM50K88Jkv/stvFurGcubVZVPC9CzZbSlGrKrvviOyAkv/WKNTgHlNEwyx4Ng8mmHR4AqnxjjsA=
X-Received: by 2002:a02:30c4:: with SMTP id q187mr13641062jaq.102.1593367579793;
 Sun, 28 Jun 2020 11:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200628152500.17916-1-brgl@bgdev.pl> <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
In-Reply-To: <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 28 Jun 2020 20:06:09 +0200
Message-ID: <CAMRc=MciqbwHBPJf1w2m3xa6ZxbX7=Ca9ucEeyVaKa+FWPzu7A@mail.gmail.com>
Subject: Re: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 7:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-06-28 at 17:25 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Memory allocated with kstrdup_const() must not be passed to regular
> > krealloc() as it is not aware of the possibility of the chunk residing
> > in .rodata. Since there are no potential users of krealloc_const()
> > at the moment, let's just update the doc to make it explicit.
>
> Another option would be to return NULL if it's
> used from krealloc with a pointer into rodata
> ---
>  mm/slab_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 37d48a56431d..f8b49656171b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1683,6 +1683,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
>   * @new_size: how many bytes of memory are required.
>   * @flags: the type of memory to allocate.
>   *
> + * If the object pointed to is in rodata (likely from kstrdup_const)
> + * %NULL is returned.
> + *
>   * The contents of the object pointed to are preserved up to the
>   * lesser of the new and old sizes.  If @p is %NULL, krealloc()
>   * behaves exactly like kmalloc().  If @new_size is 0 and @p is not a
> @@ -1694,6 +1697,9 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>  {
>         void *ret;
>
> +       if (unlikely(is_kernel_rodata((unsigned long)p)))
> +               return NULL;
> +
>         if (unlikely(!new_size)) {
>                 kfree(p);
>                 return ZERO_SIZE_PTR;
>
>
>

In that case we should probably add a WARN_ON() - otherwise the user
will be baffled by krealloc() failing.

Bartosz
