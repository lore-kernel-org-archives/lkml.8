Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2BC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CB02467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jA55lcjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBTKhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:37:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42440 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:37:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so2482448qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+L7+FQcGBr8q70euhVbn25PNyS+UmjbMnhO14ByiE0w=;
        b=jA55lcjyKchTjKedLP1Wj0EVdUaYmPyaSRofNRJZYIMyBkdwfDu2zKEAG3/YWxQ99w
         nz3cOyoo4/3epPmSFOF4VQt4TFbLGxzPtbksWAAKpx2+tKkZn+qCN0jkwVZSCMlQFAkG
         Uf6s1v909+xdLurZ3YSirXD4CT+ejRhw86LaavcvgITFXkpNAm0PXUcRYdbAzkshbO7f
         vxp5jtRfNxvUG7955zn+hTm9K/Zcz1YjuERzRmHGqKIlsetT2Z0T3r6j2rp0R2L1zBBO
         bMtwudyrb62KTOXC2FOHR2wlZz/N0dJnFmaWy+1fkxqQcn0fKNb2+tjPgvtlV+GTo7lv
         Z0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+L7+FQcGBr8q70euhVbn25PNyS+UmjbMnhO14ByiE0w=;
        b=n87Fro+1kLYg4esD5ArWWbHCiIrE55ThbVQ5yzQHum/cGr18j4x+jp39mu0QE5YJch
         ZP3Blyw83SxgTnUOdrYgs1WUU5rKf1scZ36AMi2PXWFjCAkS2uzUSzocFOqQJx8fe5cO
         mKq69GRdSNxZTcKXT34VkFK0RBkLpxEJN+RT+Ink3pTXRaRsp6G3ibUQswIRc/kbJ5jb
         GU37yH4Ke0hCFbl2AelQsXWSce21KiXwJ9ogU61CSqrbPRY0u0P0qCrHsKPfWao+zzVk
         GuDXvOYGrJY3gVA2g/1kfPX66Mrai3lqSTvXbNw22j52cNSwclxbmD0IdaaekCiM7Q0b
         JCYw==
X-Gm-Message-State: APjAAAXlwYfQBS+gEVio1myXwiMemdun+zlILd2PncQdSrTSpPMu2gOr
        LoewEn+cS8M4yRKbXWthzUROpHvrTor3oeSLMUuBnw==
X-Google-Smtp-Source: APXvYqyfb7yOWKobd/t82hIUD1+XI++wuCcNV55LY8LnxBBwkaX0UMRW6CI35HdCB5KAi21LZP1we98OnRawhnsYxc4=
X-Received: by 2002:ac8:340c:: with SMTP id u12mr25564787qtb.257.1582195063751;
 Thu, 20 Feb 2020 02:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net> <20200219172014.GI14946@hirez.programming.kicks-ass.net>
In-Reply-To: <20200219172014.GI14946@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Feb 2020 11:37:32 +0100
Message-ID: <CACT4Y+ZfxqMuiL_UF+rCku628hirJwp3t3vW5WGM8DWG6OaCeg@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is not sanitized
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 6:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:
>
> > By inlining everything in poke_int3_handler() (except bsearch :/) we can
> > mark the whole function off limits to everything and call it a day. That
> > simplicity has been the guiding principle so far.
> >
> > Alternatively we can provide an __always_inline variant of bsearch().
>
> This reduces the __no_sanitize usage to just the exception entry
> (do_int3) and the critical function: poke_int3_handler().
>
> Is this more acceptible?

Let's say it's more acceptable.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

I guess there is no ideal solution here.

Just a straw man proposal: expected number of elements is large enough
to make bsearch profitable, right? I see 1 is a common case, but the
other case has multiple entries.

> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
>         return _stext + tp->rel_addr;
>  }
>
> -static int notrace __no_sanitize patch_cmp(const void *key, const void *elt)
> +static __always_inline int patch_cmp(const void *key, const void *elt)
>  {
>         struct text_poke_loc *tp = (struct text_poke_loc *) elt;
>
> @@ -989,7 +989,6 @@ static int notrace __no_sanitize patch_c
>                 return 1;
>         return 0;
>  }
> -NOKPROBE_SYMBOL(patch_cmp);
>
>  int notrace __no_sanitize poke_int3_handler(struct pt_regs *regs)
>  {
> @@ -1024,9 +1023,9 @@ int notrace __no_sanitize poke_int3_hand
>          * Skip the binary search if there is a single member in the vector.
>          */
>         if (unlikely(desc->nr_entries > 1)) {
> -               tp = bsearch(ip, desc->vec, desc->nr_entries,
> -                            sizeof(struct text_poke_loc),
> -                            patch_cmp);
> +               tp = __bsearch(ip, desc->vec, desc->nr_entries,
> +                              sizeof(struct text_poke_loc),
> +                              patch_cmp);
>                 if (!tp)
>                         goto out_put;
>         } else {
> --- a/include/linux/bsearch.h
> +++ b/include/linux/bsearch.h
> @@ -4,7 +4,29 @@
>
>  #include <linux/types.h>
>
> -void *bsearch(const void *key, const void *base, size_t num, size_t size,
> -             cmp_func_t cmp);
> +static __always_inline
> +void *__bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
> +{
> +       const char *pivot;
> +       int result;
> +
> +       while (num > 0) {
> +               pivot = base + (num >> 1) * size;
> +               result = cmp(key, pivot);
> +
> +               if (result == 0)
> +                       return (void *)pivot;
> +
> +               if (result > 0) {
> +                       base = pivot + size;
> +                       num--;
> +               }
> +               num >>= 1;
> +       }
> +
> +       return NULL;
> +}
> +
> +extern void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp);
>
>  #endif /* _LINUX_BSEARCH_H */
> --- a/lib/bsearch.c
> +++ b/lib/bsearch.c
> @@ -28,27 +28,9 @@
>   * the key and elements in the array are of the same type, you can use
>   * the same comparison function for both sort() and bsearch().
>   */
> -void __no_sanitize *bsearch(const void *key, const void *base, size_t num, size_t size,
> -             cmp_func_t cmp)
> +void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
>  {
> -       const char *pivot;
> -       int result;
> -
> -       while (num > 0) {
> -               pivot = base + (num >> 1) * size;
> -               result = cmp(key, pivot);
> -
> -               if (result == 0)
> -                       return (void *)pivot;
> -
> -               if (result > 0) {
> -                       base = pivot + size;
> -                       num--;
> -               }
> -               num >>= 1;
> -       }
> -
> -       return NULL;
> +       __bsearch(key, base, num, size, cmp);
>  }
>  EXPORT_SYMBOL(bsearch);
>  NOKPROBE_SYMBOL(bsearch);
