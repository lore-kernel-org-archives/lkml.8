Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82114C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEFE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYx1azbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbgE1PBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403869AbgE1PBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:01:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E20C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:01:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so3224717pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4gasz7E8Vka0VphamQPgsMwOl6rPaC5hW405KW6cAI=;
        b=OYx1azbF4P0dfQ10iSb9La9p4gAK2jIv1Jyus2X+j/g6v3DL392OEZJCMm6Gubuxt8
         9B93plARWlCI4yChxjLUa6wtP8iFtPYo3Fob5WH+3DD/hZZ9IN4v13ZXa8Njy19M3w90
         5xh6LsJfF8CqhmZueR/sIIgcudTwgCdX8SmdLF3zNwLUL58j2SX4AwlRAC+RzF7Wn5V4
         /RdBd83tXL/sKKUzTvL1MHStduUDIOEFxz8tqTe0GX2paOOzPf/ekGvWJgzgtTyuIRvc
         1DQfX6vwtJnkDRl39I7N9HAa5GqPluQfoDlQ9rb1nS71Jv+Rbt8U6F79BeEuYlzV+ubl
         wYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4gasz7E8Vka0VphamQPgsMwOl6rPaC5hW405KW6cAI=;
        b=pWPWYXELb+hlJAeCUicKim3zxXFXKJBR1Dw6G7vTBEKj841t/deM9UwRIKGoasTeJf
         9zxX6hStbr0g53AdLucANYht3RZU6n/wULPIfE2VKF9dZHhdz+l679/94jazZoEmwKv3
         yZ0Q15e4Dxe25rRmbvn6NA9eJ54Wnialhak/s6lCFQAk2AxbrocH9OK3J8KRknUCcD3n
         bGAOFZgcpyz6OmCiCK0M/6gOIwMjZQsm71kFFENj7tPdAFgq/bNuvkEP2iseX3gBGfZ/
         sxm65k7h9GimC8R2rk2Hqfe0rWxJycSOEq4f1HRtRbvIzoyjW8i48jZfDmCTPOlTUEw8
         J/WA==
X-Gm-Message-State: AOAM533gNAWiXkJcxkJQiItE0C/ZB3SAy80PDPrJQ1gBkugdwB99GBPq
        U67hOryxEPyazJ7pxGFtI58wp4yv8xFifCW9CeYduv8MB50=
X-Google-Smtp-Source: ABdhPJyyVAv6fiUo0j3cap9zCp8UlZcYGzN4ZXwcx0fZ4+b4Gd56xyiNHKoTi+8a/20TZ9ed9h9YvvDZRqDlC/LfwtA=
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr4202521pjd.136.1590678065375;
 Thu, 28 May 2020 08:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
 <20200528134913.GA1810@lca.pw>
In-Reply-To: <20200528134913.GA1810@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 28 May 2020 17:00:54 +0200
Message-ID: <CAAeHK+zELpKm7QA7PCxRtvRDTCXpjef9wOcOuRwjc-RcT2HSiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 3:49 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > The kasan_report() functions belongs to report.c, as it's a common
> > functions that does error reporting.
> >
> > Reported-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Today's linux-next produced this with Clang 11.
>
> mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled
>
> kasan_report at mm/kasan/report.c:536

Hm, the first patch in the series ("kasan: consistently disable
debugging features") disables stack protector for kasan files. Is that
patch in linux-next?

>
> > ---
> >  mm/kasan/common.c | 19 -------------------
> >  mm/kasan/report.c | 22 ++++++++++++++++++++--
> >  2 files changed, 20 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 2906358e42f0..757d4074fe28 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -33,7 +33,6 @@
> >  #include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/bug.h>
> > -#include <linux/uaccess.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> > @@ -613,24 +612,6 @@ void kasan_free_shadow(const struct vm_struct *vm)
> >  }
> >  #endif
> >
> > -extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
> > -extern bool report_enabled(void);
> > -
> > -bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > -{
> > -     unsigned long flags = user_access_save();
> > -     bool ret = false;
> > -
> > -     if (likely(report_enabled())) {
> > -             __kasan_report(addr, size, is_write, ip);
> > -             ret = true;
> > -     }
> > -
> > -     user_access_restore(flags);
> > -
> > -     return ret;
> > -}
> > -
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  static bool shadow_mapped(unsigned long addr)
> >  {
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 80f23c9da6b0..51ec45407a0b 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/kasan.h>
> >  #include <linux/module.h>
> >  #include <linux/sched/task_stack.h>
> > +#include <linux/uaccess.h>
> >
> >  #include <asm/sections.h>
> >
> > @@ -454,7 +455,7 @@ static void print_shadow_for_address(const void *addr)
> >       }
> >  }
> >
> > -bool report_enabled(void)
> > +static bool report_enabled(void)
> >  {
> >       if (current->kasan_depth)
> >               return false;
> > @@ -479,7 +480,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
> >       end_report(&flags);
> >  }
> >
> > -void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > +static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> > +                             unsigned long ip)
> >  {
> >       struct kasan_access_info info;
> >       void *tagged_addr;
> > @@ -518,6 +520,22 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
> >       end_report(&flags);
> >  }
> >
> > +bool kasan_report(unsigned long addr, size_t size, bool is_write,
> > +                     unsigned long ip)
> > +{
> > +     unsigned long flags = user_access_save();
> > +     bool ret = false;
> > +
> > +     if (likely(report_enabled())) {
> > +             __kasan_report(addr, size, is_write, ip);
> > +             ret = true;
> > +     }
> > +
> > +     user_access_restore(flags);
> > +
> > +     return ret;
> > +}
> > +
> >  #ifdef CONFIG_KASAN_INLINE
> >  /*
> >   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> > --
> > 2.26.2.645.ge9eca65c58-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl%40google.com.
