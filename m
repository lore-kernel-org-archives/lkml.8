Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884832081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAqAoTvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgFJFzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgFJFzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:55:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AAFC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:55:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so865391qtr.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXeXhMtb00GflCcome0aHfH/SxNK2VTYdZLVXM019as=;
        b=iAqAoTvA46Z2sblYgfZOL7pzb3QK0mqL/ZnAwC0797L01rt261OwAPmuXMNgXLg05w
         V29um2KxKaOmr+04jdeOpytlIkVk7HpK5mjAj4DOZCLtQr2Ii+jWPr6VMXKxSGNJKFFQ
         w23WDEFR+SSzKXnujerpUeyBkCKiSkPjVxYSOJ4UX7/VlcgGT7qd6srNpuYABMS70h1O
         ndXS0zQeBWxThlRJXk6plgxXE9I+uZ4UXeOFhSUPmpJanush8yygVryxPxsQccIAC5kt
         uiwGMqYSmtN1uwc7bUWGS1Vs9qSTh/Fc23PUZCFs1cmqrERiPw4oEd+na+B+sbKU/g33
         T5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXeXhMtb00GflCcome0aHfH/SxNK2VTYdZLVXM019as=;
        b=Xp6PINCpZLVuSpolI8Fpo/VjE0pnWnahXgKCHb62Fwb2bnHIhI1IlkTStLu0jQjUAA
         8wV9SaZe7gLn0j0ctfaItFLr0t+i2Mvc41C9FSuQQrgKWDBibxOB+IySHWECsmJQrgKX
         kZe2WmfOdo/o6cXbYV9/MYe2pK9jFgtoqnCbduD1s4Do0tuI7T6XBj2E6W5V06N0YT+h
         O5W/NtS8z7Xg9ssUvIYLLWNIYx5iqgqWV8C9MbUn/ROwfNGsLCsP0/RBvbJKhCZ1HJ3O
         oUL6eo7dr66MwMMYa7o2xxkWU0QqtvgZdWfP8PGTXOpUzVvQncilYa2D0rlQegD2C3KV
         Tf+w==
X-Gm-Message-State: AOAM533/PXxJkvLjX2lUaneu5uGm40EV4Y4o6gnQtgvdp0TV7evwzb3j
        PlcwmlU6ASfbZOMLKZ55ftT+7JkibPY3QMWakcaPpb+xy0Q=
X-Google-Smtp-Source: ABdhPJw3koTqDtRzMIIGbRP7i54AjEis4nXKiEC8e6TgERflXOQglSBjO+mkIcvGtrWrte9076PRZ3XzqXKFqCZK5Iw=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr1541245qtu.380.1591768501932;
 Tue, 09 Jun 2020 22:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200610052154.5180-1-cai@lca.pw>
In-Reply-To: <20200610052154.5180-1-cai@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Jun 2020 07:54:50 +0200
Message-ID: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
>
> kernel_init_free_pages() will use memset() on s390 to clear all pages
> from kmalloc_order() which will override KASAN redzones because a
> redzone was setup from the end of the allocation size to the end of the
> last page. Silence it by not reporting it there. An example of the
> report is,

Interesting. The reason why we did not hit it on x86_64 is because
clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
thus is not instrumented. Arm64 probably does the same. However, on
s390 clear_page is defined to memset.
clear_[high]page are pretty extensively used in the kernel.
We can either do this, or make clear_page non instrumented on s390 as
well to match the existing implicit assumption. The benefit of the
current approach is that we can find some real use-after-free's and
maybe out-of-bounds on clear_page. The downside is that we may need
more of these annotations. Thoughts?

>  BUG: KASAN: slab-out-of-bounds in __free_pages_ok
>  Write of size 4096 at addr 000000014beaa000
>  Call Trace:
>  show_stack+0x152/0x210
>  dump_stack+0x1f8/0x248
>  print_address_description.isra.13+0x5e/0x4d0
>  kasan_report+0x130/0x178
>  check_memory_region+0x190/0x218
>  memset+0x34/0x60
>  __free_pages_ok+0x894/0x12f0
>  kfree+0x4f2/0x5e0
>  unpack_to_rootfs+0x60e/0x650
>  populate_rootfs+0x56/0x358
>  do_one_initcall+0x1f4/0xa20
>  kernel_init_freeable+0x758/0x7e8
>  kernel_init+0x1c/0x170
>  ret_from_fork+0x24/0x28
>  Memory state around the buggy address:
>  000000014bea9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  000000014bea9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >000000014beaa000: 03 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                     ^
>  000000014beaa080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  000000014beaa100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>
> Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 727751219003..9954973f89a3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1164,8 +1164,11 @@ static void kernel_init_free_pages(struct page *page, int numpages)
>  {
>         int i;
>
> +       /* s390's use of memset() could override KASAN redzones. */
> +       kasan_disable_current();
>         for (i = 0; i < numpages; i++)
>                 clear_highpage(page + i);
> +       kasan_enable_current();
>  }
>
>  static __always_inline bool free_pages_prepare(struct page *page,
> --
> 2.21.0 (Apple Git-122.2)
>
