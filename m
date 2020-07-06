Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2EBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A8720772
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kb5GyZA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGFGTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgGFGTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:19:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8FC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 23:19:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so33839670qkc.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8GSicWISxuLf8SI+byIF+xMxTNvfdYQixlttIglDVo=;
        b=Kb5GyZA+RJu/iVN8HUtF7SZb/AesZh0MC1s2Up/L6gZO8CAX69QBX/18QLSEWJcaQm
         bV7234iQyfobwViOUP11+RW17wTqDvAX9lQ/LE2y9YLRWlcKoAPKQW+h3hPzjnGF9F9L
         VGT8cnzbQIlczAjUu/gpZE6GJbtQ1c9wnxnnXylraSfK67Kz3CRTdLE/6cWI1PJBO2m3
         0dnqBtOtUuC0f6DT2TRVMuZKkS2IdppDH3Okra7WpEYhKJYB3HuNs0o4Y3Mftwob2M/D
         T4pZRiMkxbGZ8tMKR9UxafTx4d/K3TR2NsxGH67l2E09lNBJ2FgKwvW0py2Uii2yttD7
         Uxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8GSicWISxuLf8SI+byIF+xMxTNvfdYQixlttIglDVo=;
        b=qjmXrfMVXM5W243byH6INUkckoiiAxcVwy+MJBiWpjwdbXBneBiqWA5xKY0Jfsk6Pd
         1+oRYHX2B0MMpkWvwEzWetNVss5shirHTnjG7heqI0GCWEOMOFvXNKUMpg+qB3XFnKBd
         KVlfJs8aoEcz7SWgRIrnCZP9DmsTExhSBmr+6/0fbsXPTUfi8scORMVrwLV0rRSzQqOs
         sfKzPMgzX+BBAF51h8bBhxe2wJs2c6UeKXcWFVu73oGHNQZvg78T5GBSf1xZvLuQ1PPV
         syTTuxT8Y8P7F2TAAirjRJwGftw5TF59ZCvjFnQUFXXlcX5SroymQACZqvWFlMhX9Pla
         owFg==
X-Gm-Message-State: AOAM530Iq1SKsk2FCdI/6X2fnnDyS9bM2sll76QQdVGjUxsLgR+lPKFL
        213yiUXUxCPPKr/j7OacBQxA1/zYhUPlxArks51yJw==
X-Google-Smtp-Source: ABdhPJxlC97uRvdNje6Yxi/b5Fq8p0PnY4Y6DnkuEjMt/sh0vf2nWbgdvCADjv0hclufOA80J/fDvD6J6xJwxhe0Nqo=
X-Received: by 2002:a37:67d4:: with SMTP id b203mr19900712qkc.407.1594016385214;
 Sun, 05 Jul 2020 23:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200706022150.20848-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200706022150.20848-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Jul 2020 08:19:33 +0200
Message-ID: <CACT4Y+akZ5iu2ohQhRqiUd8zkew-NmrUPrA=xYtS1xxHWZ60Og@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix KASAN unit tests for tag-based KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 4:21 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
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
> - KUnit-KASAN Integration patchset are not merged yet. My patch should
>   have conflict with it, if needed, we can continue to wait it.
>
> ---
>
>  lib/test_kasan.c | 81 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 17 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index e3087d90e00d..660664439d52 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -40,7 +40,11 @@ static noinline void __init kmalloc_oob_right(void)
>                 return;
>         }
>
> -       ptr[size] = 'x';
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               ptr[size] = 'x';
> +       else
> +               ptr[size + 5] = 'x';
> +

Hi Walter,

Would if be possible to introduce something like:

#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : 8)

and then add it throughout as

        ptr[size + OOB_TAG_OFF] = 'x';

?
The current version results in quite some amount of additional code
that needs to be read, extended  and maintained in the future. So I am
thinking if it's possible to minimize it somehow...

>         kfree(ptr);
>  }
>
> @@ -92,7 +96,11 @@ static noinline void __init kmalloc_pagealloc_oob_right(void)
>                 return;
>         }
>
> -       ptr[size] = 0;
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               ptr[size] = 0;
> +       else
> +               ptr[size + 6] = 0;
> +
>         kfree(ptr);
>  }
>
> @@ -162,7 +170,11 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
>                 return;
>         }
>
> -       ptr2[size2] = 'x';
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               ptr2[size2] = 'x';
> +       else
> +               ptr2[size2 + 13] = 'x';
> +
>         kfree(ptr2);
>  }
>
> @@ -180,7 +192,12 @@ static noinline void __init kmalloc_oob_krealloc_less(void)
>                 kfree(ptr1);
>                 return;
>         }
> -       ptr2[size2] = 'x';
> +
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               ptr2[size2] = 'x';
> +       else
> +               ptr2[size2 + 2] = 'x';
> +
>         kfree(ptr2);
>  }
>
> @@ -216,7 +233,11 @@ static noinline void __init kmalloc_oob_memset_2(void)
>                 return;
>         }
>
> -       memset(ptr+7, 0, 2);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               memset(ptr+7, 0, 2);
> +       else
> +               memset(ptr+15, 0, 2);
> +
>         kfree(ptr);
>  }
>
> @@ -232,7 +253,11 @@ static noinline void __init kmalloc_oob_memset_4(void)
>                 return;
>         }
>
> -       memset(ptr+5, 0, 4);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               memset(ptr+5, 0, 4);
> +       else
> +               memset(ptr+15, 0, 4);
> +
>         kfree(ptr);
>  }
>
> @@ -249,7 +274,11 @@ static noinline void __init kmalloc_oob_memset_8(void)
>                 return;
>         }
>
> -       memset(ptr+1, 0, 8);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               memset(ptr+1, 0, 8);
> +       else
> +               memset(ptr+15, 0, 8);
> +
>         kfree(ptr);
>  }
>
> @@ -265,7 +294,11 @@ static noinline void __init kmalloc_oob_memset_16(void)
>                 return;
>         }
>
> -       memset(ptr+1, 0, 16);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               memset(ptr+1, 0, 16);
> +       else
> +               memset(ptr+15, 0, 16);
> +
>         kfree(ptr);
>  }
>
> @@ -281,7 +314,11 @@ static noinline void __init kmalloc_oob_in_memset(void)
>                 return;
>         }
>
> -       memset(ptr, 0, size+5);
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               memset(ptr, 0, size+5);
> +       else
> +               memset(ptr, 0, size+7);
> +
>         kfree(ptr);
>  }
>
> @@ -415,7 +452,11 @@ static noinline void __init kmem_cache_oob(void)
>                 return;
>         }
>
> -       *p = p[size];
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               *p = p[size];
> +       else
> +               *p = p[size + 8];
> +
>         kmem_cache_free(cache, p);
>         kmem_cache_destroy(cache);
>  }
> @@ -497,6 +538,7 @@ static noinline void __init copy_user_test(void)
>         char __user *usermem;
>         size_t size = 10;
>         int unused;
> +       size_t oob_size;
>
>         kmem = kmalloc(size, GFP_KERNEL);
>         if (!kmem)
> @@ -511,26 +553,31 @@ static noinline void __init copy_user_test(void)
>                 return;
>         }
>
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               oob_size = 1;
> +       else
> +               oob_size = 7;
> +
>         pr_info("out-of-bounds in copy_from_user()\n");
> -       unused = copy_from_user(kmem, usermem, size + 1);
> +       unused = copy_from_user(kmem, usermem, size + oob_size);
>
>         pr_info("out-of-bounds in copy_to_user()\n");
> -       unused = copy_to_user(usermem, kmem, size + 1);
> +       unused = copy_to_user(usermem, kmem, size + oob_size);
>
>         pr_info("out-of-bounds in __copy_from_user()\n");
> -       unused = __copy_from_user(kmem, usermem, size + 1);
> +       unused = __copy_from_user(kmem, usermem, size + oob_size);
>
>         pr_info("out-of-bounds in __copy_to_user()\n");
> -       unused = __copy_to_user(usermem, kmem, size + 1);
> +       unused = __copy_to_user(usermem, kmem, size + oob_size);
>
>         pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> -       unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
> +       unused = __copy_from_user_inatomic(kmem, usermem, size + oob_size);
>
>         pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> -       unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
> +       unused = __copy_to_user_inatomic(usermem, kmem, size + oob_size);
>
>         pr_info("out-of-bounds in strncpy_from_user()\n");
> -       unused = strncpy_from_user(kmem, usermem, size + 1);
> +       unused = strncpy_from_user(kmem, usermem, size + oob_size);
>
>         vm_munmap((unsigned long)usermem, PAGE_SIZE);
>         kfree(kmem);
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200706022150.20848-1-walter-zh.wu%40mediatek.com.
