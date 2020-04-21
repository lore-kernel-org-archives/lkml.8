Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81804C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5020E2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1fbcTDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDUNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgDUNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:01:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D40C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:01:45 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p13so6430195qvt.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bxpXR7bk9lriyagOO2UqkV9Fm2IwK+BGPfkmvwlllg=;
        b=Y1fbcTDdB4pAfXbWuu0qCG+GiUYb96vpjnmGAFccY+9j1v13cfYYYRjb73MRcZXYkp
         U6EUTapHN9b9XenIOE4lK9D0skhRRaKRbgIi6UH10YgxB4FSdYbtrmmyy2mFX7rQ+8R/
         kGn6S3t1uPAksnkCI4N/P4q0xaxZzwS+9Yp5d8ADm/pq1cwx0wJSHVhSFnoBFkZKOH+E
         yDdrM2omM7plYRSKEiPH9ZORCCGp7mEKBEyRIXDcFjWKwc7f5WS6l8QkW9Ak/SJoA07r
         kCGwk+SL2V5/2244fqoqANhTIqFEGclIW9TN9d2rthe3JBNWnOtS58O/PtfRNthm8+61
         T37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bxpXR7bk9lriyagOO2UqkV9Fm2IwK+BGPfkmvwlllg=;
        b=HCOR6mllnzH3s9jMs/+NSgY0HgQemIsmRocK5Ug0E84AQpB9jcRVSzdmJgdnIzCocI
         UDFSQRF2VNPx4Eah+9eytKSor7X94WL1OUGObO/IQ9nHk+xtaTwxCky9DieEf07ou9Pr
         MW7SPc8o+GNvYhOIfqSoEUlsMS1DKkKyBjozT6XJHeITpxAggB7E31p5Qtv1XKKBJ1iw
         m/r6j4LGoPvtBWCvvAm836qYMJmLooIf44G/NvobqoqBnJPO8tr3EygVcvWyiyOzBo1O
         zvBXbAw3pBfacjpChlDcPkLQ/IXkzQnDIuH2S44P5oW4L+Qx6ggENUGY7ay8fLswExio
         QycQ==
X-Gm-Message-State: AGi0PuYflrviKFl77aRuEnm/H2FDd5mSR8OVJqq+7ydDgl7o95WFqdEu
        4nti8MqzrFrzCQJRolW8sZrXkth5tnl1lTDXOA/gsg==
X-Google-Smtp-Source: APiQypLBt/g9IVIcofjvmBFH/qVYPkFDIZThvQ9tJkf8X2mWe5oPzgaUwrZkerf+z9oIHEEkmTmVpUTSEno7/Es3070=
X-Received: by 2002:a0c:b2d2:: with SMTP id d18mr2496270qvf.80.1587474103980;
 Tue, 21 Apr 2020 06:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200421014007.6012-1-walter-zh.wu@mediatek.com>
 <CACT4Y+af5fegnN9XOUSkf_B62J5sf2ZZbUwYk=GxtSmAhF3ryQ@mail.gmail.com> <1587472005.5870.7.camel@mtksdccf07>
In-Reply-To: <1587472005.5870.7.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Apr 2020 15:01:31 +0200
Message-ID: <CACT4Y+avYV1xoqB6V5XrQSs-p2s3mKKu+LZQc4EzPaW-jV+KaA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix KASAN unit tests for tag-based KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 2:26 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Hi Dmitry,
>
> On Tue, 2020-04-21 at 13:56 +0200, Dmitry Vyukov wrote:
> > On Tue, Apr 21, 2020 at 3:40 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
> > > When we use tag-based KASAN, then KASAN unit tests don't detect
> > > out-of-bounds memory access. Because with tag-based KASAN the state
> > > of each 16 aligned bytes of memory is encoded in one shadow byte
> > > and the shadow value is tag of pointer, so we need to read next
> > > shadow byte, the shadow value is not equal to tag of pointer,
> > > then tag-based KASAN will detect out-of-bounds memory access.
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Andrey Konovalov <andreyknvl@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  lib/test_kasan.c | 62 ++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 55 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index e3087d90e00d..a164f6b47fe5 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -40,7 +40,12 @@ static noinline void __init kmalloc_oob_right(void)
> > >                 return;
> > >         }
> >
> > Hi Walter,
> >
> > This would be great to have!
> > But I am concerned about these series that port KASAN tests to KUNIT:
> > https://lkml.org/lkml/2020/4/17/1144
> > I suspect it will be one large merge conflict. Not sure what is the
> > proper way to resovle this. I've added authors to CC.
> >
> Yes, it should have conflicts. Thanks for your reminder.
> >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         ptr[size] = 'x';
> > > +#else
> > > +       ptr[size + 5] = 'x';
> > > +#endif
> > > +
> >
> > For this particular snippet I think we can reduce amount of idef'ery
> > and amount of non-compiled code in each configuration with something
> > like:
> >
> >   ptr[size + 5] = 'x';
> >   if (ENABLED(CONFIG_KASAN_GENERIC))
> >       ptr[size] = 'x';
> >
> > One check runs always (it should pass in both configs, right?). The
>
> There is a problem, With generic KASAN it may trigger two KASAN reports.

Why is this a problem? If there are 2, fine. KUNIT can check that if
we expect 2, there are indeed 2.

> if we change it like:
>
> if (ENABLED(CONFIG_KASAN_GENERIC))
>     ptr[size] = 'x';
> else
>     ptr[size + 5] = 'x';
>
> > only only in GENERIC, but it's C-level if rather than preprocessor.
> > KUNIT should make 2 bugs per test easily expressable (and testable).
> >
>
> >
> >
> >
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -92,7 +97,12 @@ static noinline void __init kmalloc_pagealloc_oob_right(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         ptr[size] = 0;
> > > +#else
> > > +       ptr[size + 6] = 0;
> > > +#endif
> > > +
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -162,7 +172,11 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         ptr2[size2] = 'x';
> > > +#else
> > > +       ptr2[size2 + 13] = 'x';
> > > +#endif
> > >         kfree(ptr2);
> > >  }
> > >
> > > @@ -180,7 +194,12 @@ static noinline void __init kmalloc_oob_krealloc_less(void)
> > >                 kfree(ptr1);
> > >                 return;
> > >         }
> > > +
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         ptr2[size2] = 'x';
> > > +#else
> > > +       ptr2[size2 + 2] = 'x';
> > > +#endif
> > >         kfree(ptr2);
> > >  }
> > >
> > > @@ -216,7 +235,11 @@ static noinline void __init kmalloc_oob_memset_2(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         memset(ptr+7, 0, 2);
> > > +#else
> > > +       memset(ptr+15, 0, 2);
> > > +#endif
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -232,7 +255,11 @@ static noinline void __init kmalloc_oob_memset_4(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         memset(ptr+5, 0, 4);
> > > +#else
> > > +       memset(ptr+15, 0, 4);
> > > +#endif
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -249,7 +276,11 @@ static noinline void __init kmalloc_oob_memset_8(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         memset(ptr+1, 0, 8);
> > > +#else
> > > +       memset(ptr+15, 0, 8);
> > > +#endif
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -265,7 +296,11 @@ static noinline void __init kmalloc_oob_memset_16(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         memset(ptr+1, 0, 16);
> > > +#else
> > > +       memset(ptr+15, 0, 16);
> > > +#endif
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -281,7 +316,11 @@ static noinline void __init kmalloc_oob_in_memset(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         memset(ptr, 0, size+5);
> > > +#else
> > > +       memset(ptr, 0, size+7);
> > > +#endif
> > >         kfree(ptr);
> > >  }
> > >
> > > @@ -415,7 +454,11 @@ static noinline void __init kmem_cache_oob(void)
> > >                 return;
> > >         }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > >         *p = p[size];
> > > +#else
> > > +       *p = p[size + 8];
> > > +#endif
> > >         kmem_cache_free(cache, p);
> > >         kmem_cache_destroy(cache);
> > >  }
> > > @@ -497,6 +540,11 @@ static noinline void __init copy_user_test(void)
> > >         char __user *usermem;
> > >         size_t size = 10;
> > >         int unused;
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +       size_t oob_size = 1;
> > > +#else
> > > +       size_t oob_size = 7;
> > > +#endif
> > >
> > >         kmem = kmalloc(size, GFP_KERNEL);
> > >         if (!kmem)
> > > @@ -512,25 +560,25 @@ static noinline void __init copy_user_test(void)
> > >         }
> > >
> > >         pr_info("out-of-bounds in copy_from_user()\n");
> > > -       unused = copy_from_user(kmem, usermem, size + 1);
> > > +       unused = copy_from_user(kmem, usermem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in copy_to_user()\n");
> > > -       unused = copy_to_user(usermem, kmem, size + 1);
> > > +       unused = copy_to_user(usermem, kmem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in __copy_from_user()\n");
> > > -       unused = __copy_from_user(kmem, usermem, size + 1);
> > > +       unused = __copy_from_user(kmem, usermem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in __copy_to_user()\n");
> > > -       unused = __copy_to_user(usermem, kmem, size + 1);
> > > +       unused = __copy_to_user(usermem, kmem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> > > -       unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
> > > +       unused = __copy_from_user_inatomic(kmem, usermem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> > > -       unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
> > > +       unused = __copy_to_user_inatomic(usermem, kmem, size + oob_size);
> > >
> > >         pr_info("out-of-bounds in strncpy_from_user()\n");
> > > -       unused = strncpy_from_user(kmem, usermem, size + 1);
> > > +       unused = strncpy_from_user(kmem, usermem, size + oob_size);
> > >
> > >         vm_munmap((unsigned long)usermem, PAGE_SIZE);
> > >         kfree(kmem);
> > > --
> > > 2.18.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200421014007.6012-1-walter-zh.wu%40mediatek.com.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1587472005.5870.7.camel%40mtksdccf07.
