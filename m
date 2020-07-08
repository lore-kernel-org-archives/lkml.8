Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B87C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3739206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUVoyvYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgGHMiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgGHMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:38:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8218AC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:38:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so9655454pfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kee2YtmMHgv7A7dyVw1lKxR+tADNMGpw4FHY05ErWKs=;
        b=BUVoyvYmTz8ZDtfycOlc63OWOr6QOq3OdXVIpgIkP+lyMsbeJX2hVgXFqFU9Wl5VBL
         m0WSTsLYb2NG4ZWkjdfb6HfdcgqQlX2dzr8v1H8Yd/Qqc0uUYY2M92OoEtQg3WlJ+ACF
         9NyCwxG1S6ozatSQD7Xh0QCwedEpb1CJgNG8WBPReVBIme9WBVscmmELcGThcaAQQTq5
         CI/SSMcM7QRqukR86O++70R0g4b5EDcdaEMfnBYT4RbP8KctYPJDkLrHDLAdfSeK0ppr
         xZBR5VQengbMd0Nb1ekdY/vlWEDbbhEF/ZfG8SiFiWDQ+Ar5ktIro3/F+LiDC32dtukA
         9BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kee2YtmMHgv7A7dyVw1lKxR+tADNMGpw4FHY05ErWKs=;
        b=MjNo3cgsQ34UB+NfjaacpERpHporO4EG2oBsb/e4fX5iiRQLqQ6LeZTlno85T/OfUJ
         iSnptNQONxlyDlmqaC6p8OZwzX72F5omGgpeoh+dEL88tP2Ubvh5satrPb7QYsTpG/yc
         KBkM/Es4vhj4QMgIWntb0Jv84kl3g0wfN0M0U1WpOeUSIvStbC/Mr8adZc8JDZC1ptwI
         RdAvXPTwJ3kgMFwFn7UbNJCjjd3LJeDqLmIZJciIGDzknxJ6CleLZuBZ0IAD6cC7bS/1
         kEBxBLIVcVz5infcH0fRsaLQGC6k/2Mntmxwcm7ilkyUUYiJkV7G3E0sTKsgABBq9vKi
         6WtA==
X-Gm-Message-State: AOAM531Q3VLhK4LsWl6BQTjkTH6K3GdAogNVPl/9Azxz/wNIjAv3693c
        oCSJmQ8Yj7OAVV2OtmTa7X1YU9DR6dnA0CZkK3r3ag==
X-Google-Smtp-Source: ABdhPJyuLR6QeVaXP6OjKnIrKrqfE0bWlnsaLu7hVpXkSQ6tvUnLVglr7za275US/hzu1ZOvqBp0jWwLbfx/vTSY8U8=
X-Received: by 2002:a62:52cd:: with SMTP id g196mr53579108pfb.178.1594211880888;
 Wed, 08 Jul 2020 05:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200706115039.16750-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200706115039.16750-1-walter-zh.wu@mediatek.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 8 Jul 2020 14:37:49 +0200
Message-ID: <CAAeHK+zQDeo5K8D9QTQvdkp4H36s_wPPcGDizJ-ZDD0YAtLeRw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: fix KASAN unit tests for tag-based KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 1:50 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> We use tag-based KASAN, then KASAN unit tests don't detect out-of-bounds
> memory access. They need to be fixed.
>
> With tag-based KASAN, the state of each 16 aligned bytes of memory is
> encoded in one shadow byte and the shadow value is tag of pointer, so
> we need to read next shadow byte, the shadow value is not equal to tag
> value of pointer, so that tag-based KASAN will detect out-of-bounds
> memory access.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> changes since v1:
> - Reduce amount of non-compiled code.
> - KUnit-KASAN Integration patchset is not merged yet. My patch should
>   have conflict with it, if needed, we can continue to wait it.
>
> changes since v2:
> - Add one marco to make unit tests more readability.
>
> ---
>  lib/test_kasan.c | 47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index e3087d90e00d..b5049a807e25 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,6 +23,8 @@
>
>  #include <asm/page.h>
>
> +#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : 13)

Let's use KASAN_SHADOW_SCALE_SIZE instead of 13 to make sure the
access always lands in the next memory granule.

With that:

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> +
>  /*
>   * Note: test functions are marked noinline so that their names appear in
>   * reports.
> @@ -40,7 +42,8 @@ static noinline void __init kmalloc_oob_right(void)
>                 return;
>         }
>
> -       ptr[size] = 'x';
> +       ptr[size + OOB_TAG_OFF] = 'x';
> +
>         kfree(ptr);
>  }
>
> @@ -92,7 +95,8 @@ static noinline void __init kmalloc_pagealloc_oob_right(void)
>                 return;
>         }
>
> -       ptr[size] = 0;
> +       ptr[size + OOB_TAG_OFF] = 0;
> +
>         kfree(ptr);
>  }
>
> @@ -162,7 +166,8 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
>                 return;
>         }
>
> -       ptr2[size2] = 'x';
> +       ptr2[size2 + OOB_TAG_OFF] = 'x';
> +
>         kfree(ptr2);
>  }
>
> @@ -180,7 +185,9 @@ static noinline void __init kmalloc_oob_krealloc_less(void)
>                 kfree(ptr1);
>                 return;
>         }
> -       ptr2[size2] = 'x';
> +
> +       ptr2[size2 + OOB_TAG_OFF] = 'x';
> +
>         kfree(ptr2);
>  }
>
> @@ -216,7 +223,8 @@ static noinline void __init kmalloc_oob_memset_2(void)
>                 return;
>         }
>
> -       memset(ptr+7, 0, 2);
> +       memset(ptr + 7 + OOB_TAG_OFF, 0, 2);
> +
>         kfree(ptr);
>  }
>
> @@ -232,7 +240,8 @@ static noinline void __init kmalloc_oob_memset_4(void)
>                 return;
>         }
>
> -       memset(ptr+5, 0, 4);
> +       memset(ptr + 5 + OOB_TAG_OFF, 0, 4);
> +
>         kfree(ptr);
>  }
>
> @@ -249,7 +258,8 @@ static noinline void __init kmalloc_oob_memset_8(void)
>                 return;
>         }
>
> -       memset(ptr+1, 0, 8);
> +       memset(ptr + 1 + OOB_TAG_OFF, 0, 8);
> +
>         kfree(ptr);
>  }
>
> @@ -265,7 +275,8 @@ static noinline void __init kmalloc_oob_memset_16(void)
>                 return;
>         }
>
> -       memset(ptr+1, 0, 16);
> +       memset(ptr + 1 + OOB_TAG_OFF, 0, 16);
> +
>         kfree(ptr);
>  }
>
> @@ -281,7 +292,8 @@ static noinline void __init kmalloc_oob_in_memset(void)
>                 return;
>         }
>
> -       memset(ptr, 0, size+5);
> +       memset(ptr, 0, size + 5 + OOB_TAG_OFF);
> +
>         kfree(ptr);
>  }
>
> @@ -415,7 +427,8 @@ static noinline void __init kmem_cache_oob(void)
>                 return;
>         }
>
> -       *p = p[size];
> +       *p = p[size + OOB_TAG_OFF];
> +
>         kmem_cache_free(cache, p);
>         kmem_cache_destroy(cache);
>  }
> @@ -512,25 +525,25 @@ static noinline void __init copy_user_test(void)
>         }
>
>         pr_info("out-of-bounds in copy_from_user()\n");
> -       unused = copy_from_user(kmem, usermem, size + 1);
> +       unused = copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in copy_to_user()\n");
> -       unused = copy_to_user(usermem, kmem, size + 1);
> +       unused = copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in __copy_from_user()\n");
> -       unused = __copy_from_user(kmem, usermem, size + 1);
> +       unused = __copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in __copy_to_user()\n");
> -       unused = __copy_to_user(usermem, kmem, size + 1);
> +       unused = __copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> -       unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
> +       unused = __copy_from_user_inatomic(kmem, usermem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> -       unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
> +       unused = __copy_to_user_inatomic(usermem, kmem, size + 1 + OOB_TAG_OFF);
>
>         pr_info("out-of-bounds in strncpy_from_user()\n");
> -       unused = strncpy_from_user(kmem, usermem, size + 1);
> +       unused = strncpy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
>
>         vm_munmap((unsigned long)usermem, PAGE_SIZE);
>         kfree(kmem);
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200706115039.16750-1-walter-zh.wu%40mediatek.com.
