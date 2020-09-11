Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C2B221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6I1g9C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgIKHFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgIKHFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:05:08 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCEC061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b13so4715293qvl.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qYTA7a/mDb0x7v76SumPW6fQ7bLMrnrWY5ltUv9JNU=;
        b=l6I1g9C1SvoJBjGEU0JNeOK0OUWWHuh+ALTBHG8Q61JGEqU4KeeE5IlLbk4bq+biRP
         GLthBBCFLV74aP/hQaHI2M0uCtoZz+JpOo4lFoxKTjE1iW7bCuJswGKKAlv+zaA9qnkp
         TlS1NPVdFNmHAqjPSNR659dB1WOgl7sIIp5R9vb7NnibPcG7TDweMFV/AUK/qXe6Nlww
         O3k9zPK1DfyWXuhengm0F807rZ57VgNbELKS6QRJ5VAQEYFRAIBEj+paw0bj8u/keVzB
         +KusOeic/b8Aqz8saD0zP8EvoIS5TolTvFwZtAgF/VFApLsHX/JUnGw3O8psBt3RKhyr
         ibtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qYTA7a/mDb0x7v76SumPW6fQ7bLMrnrWY5ltUv9JNU=;
        b=BBLq4hNaTSJCwbEPefYNA/7kFs1hKjX6prex0TGkClfufn3e1ZSyVxAmHOMIVtaqvI
         13PBBW6UEBpGc0Am0WWsHpdGSx2fCqsNge+UfNomqfdDvR9V7+tk7pbc0im0Cu800cVF
         cC/8DrNpNnLk69gAjbFqi8CHFl6iht5xqS/nIUVDT3KnaIyw286KYpNcbJ8QrDNMUXkl
         oVe2a1gRwoSZ6H8osNWNzzSgHBN+qOZiXe7l3NBalu2Y+wW5fLPhGgK9CWMEmH60mPsV
         zMRnEPyhGd6HiRsHq5mx6INe9Ni+YbMhUaXXt3cVZmguo2I2na/RJsb7qgjrs/Y+oK9M
         Yc7g==
X-Gm-Message-State: AOAM5321qX9cJjRyIuoiCB7xMXg1rySOYENBO6xieoAX1NWvvZ0cN5iQ
        yo/ESiwLGrqe0u2RHrGNZqP+g/dgxRumxq5e/Cueow==
X-Google-Smtp-Source: ABdhPJwPLAUEsAzaSMCLt+v28C4/YXeXs4UpRMTYz0l4idhp0Mt0npwu+vanlcme90OTrVPya2wrVj/k/dc78p5FmYU=
X-Received: by 2002:a0c:c24a:: with SMTP id w10mr609462qvh.99.1599807905731;
 Fri, 11 Sep 2020 00:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-7-elver@google.com>
In-Reply-To: <20200907134055.2878499-7-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 11 Sep 2020 09:04:54 +0200
Message-ID: <CACT4Y+b=Ph-fD_K5F_TNMp_dTNjD7GXGT=OXogrKc_HwH+HHwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] kfence, kasan: make KFENCE compatible with KASAN
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
>
> We make KFENCE compatible with KASAN for testing KFENCE itself. In
> particular, KASAN helps to catch any potential corruptions to KFENCE
> state, or other corruptions that may be a result of freepointer
> corruptions in the main allocators.
>
> To indicate that the combination of the two is generally discouraged,
> CONFIG_EXPERT=y should be set. It also gives us the nice property that
> KFENCE will be build-tested by allyesconfig builds.
>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/Kconfig.kfence | 2 +-
>  mm/kasan/common.c  | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> index 7ac91162edb0..b080e49e15d4 100644
> --- a/lib/Kconfig.kfence
> +++ b/lib/Kconfig.kfence
> @@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
>
>  menuconfig KFENCE
>         bool "KFENCE: low-overhead sampling-based memory safety error detector"
> -       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> +       depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
>         depends on JUMP_LABEL # To ensure performance, require jump labels
>         select STACKTRACE
>         help
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 950fd372a07e..f5c49f0fdeff 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> +#include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/linkage.h>
>  #include <linux/memblock.h>
> @@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         tagged_object = object;
>         object = reset_tag(object);
>
> +       if (is_kfence_address(object))
> +               return false;

Is this needed?
At least in the slab patch I see that we do :

if (kfence_free(objp)) {
  kmemleak_free_recursive(objp, cachep->flags);
  return;
}

before:

/* Put the object into the quarantine, don't touch it for now. */ /*
Put the object into the quarantine, don't touch it for now. */
if (kasan_slab_free(cachep, objp, _RET_IP_)) if
(kasan_slab_free(cachep, objp, _RET_IP_))
  return; return;


If it's not supposed to be triggered, it can make sense to replace
with BUG/WARN.


>         if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
>             object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
> @@ -444,6 +448,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         if (unlikely(object == NULL))
>                 return NULL;
>
> +       if (is_kfence_address(object))
> +               return (void *)object;
> +
>         redzone_start = round_up((unsigned long)(object + size),
>                                 KASAN_SHADOW_SCALE_SIZE);
>         redzone_end = round_up((unsigned long)object + cache->object_size,
> --
> 2.28.0.526.ge36021eeef-goog
>
