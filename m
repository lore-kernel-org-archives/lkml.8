Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF62C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628282051A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5RdwMNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCJPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:21:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36387 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:21:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id u25so13081935qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cxfOub78XytTahn0ib89laSCRrqzn9vDFVf61uClLI=;
        b=Y5RdwMNJMJblBzN647Yke7Zce6IteaahmzUHifdeaplxhqjXETgJG0XKvMZx9ZM9Ue
         1L5v+OTE7ivPVOS4gYetnOoyeMnq7MNeijXQjOxrWvAmI2YrIkLatNF6Q6mnLfgjsdgz
         U8V37gP9VoPzE86ci5Jf/Flx2XppySzeDKuE/zpC968Sep1Df2TLmJNA+BSH62rcvt5/
         o3ooJ/1g00plN6q0rQwCf7WFBaVJWiVOn2TNwlDda7GLExDXelyRlZmCG6Wxm9SezrBU
         izN1vEygT07SJt8DdpS9CsEahM404zWuyjNn8VuZd2ZJxgKKlKIiGDrRMtXePESPtKBG
         yqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cxfOub78XytTahn0ib89laSCRrqzn9vDFVf61uClLI=;
        b=mRubwAHHKhLwPhAKjutCOC0NGl8Vn3WP0likiEVmLWFNXf8lhK/REwCMwg1d4Ux08d
         uCtnBu2NUq1OSROHcKMbwHk+MhJEQ1WuPI+YRwJCoI+ZfnGIjiMe11pb1S+TTJr372AT
         RaQDNGZCo+g0v9031lvpZd1Vgyxw3GbKz0Vrf04oY28AQPg71cca5t2FKE2WAZfL81C8
         nE3UaVC99PrVZJ6RH9RqgTPoj2SuI5D2Zq5jGGh72Nrg77y6W+7kVWFp5RL4IJTkadOM
         Q4SryVYXKWXd63MYDlSeFT3GYwGkAaDz9yty94RSnFk6OSKZsu3REB+rcssE8KeuYqKm
         XNCQ==
X-Gm-Message-State: ANhLgQ2AD1/PXSkhR8PDBu0uhCQtrru7nTc7jhbDuendHDlRbARZyQQM
        PwgDTi5oI4BbVPLj7Rbf2ZiVWNKf00RNViHlzzunMQ==
X-Google-Smtp-Source: ADFU+vs4ODfadGzkx9DreWNEkZk62mKgItLMH3weq/WOR7/tvNypN8+locOzkNBD5F8Cz4KEQWjwL8YKDoNTYx5Jqvs=
X-Received: by 2002:a37:7c47:: with SMTP id x68mr20526910qkc.8.1583853661912;
 Tue, 10 Mar 2020 08:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <1583847469-4354-1-git-send-email-cai@lca.pw>
In-Reply-To: <1583847469-4354-1-git-send-email-cai@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Mar 2020 16:20:50 +0100
Message-ID: <CACT4Y+aV9BrvEHdaadL7FXsjMi4iPDJUnK8eyJj=HuZFa4fxuw@mail.gmail.com>
Subject: Re: [PATCH -next] lib/test_kasan: silence a -Warray-bounds warning
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 2:38 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit "kasan: add test for invalid size in memmove" introduced a
> compilation warning where it used a negative size on purpose. Silence it
> by disabling "array-bounds" checking for this file only for testing
> purpose.
>
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:22,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/uaccess.h:6,
>                  from ./arch/x86/include/asm/fpu/xstate.h:5,
>                  from ./arch/x86/include/asm/pgtable.h:26,
>                  from ./include/linux/kasan.h:15,
>                  from lib/test_kasan.c:12:
> In function 'memmove',
>     inlined from 'kmalloc_memmove_invalid_size' at
> lib/test_kasan.c:301:2:
> ./include/linux/string.h:441:9: warning: '__builtin_memmove' pointer
> overflow between offset 0 and size [-2, 9223372036854775807]
> [-Warray-bounds]
>   return __builtin_memmove(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  lib/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index ab68a8674360..24d519a0741d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -297,6 +297,8 @@ UBSAN_SANITIZE_ubsan.o := n
>  KASAN_SANITIZE_ubsan.o := n
>  KCSAN_SANITIZE_ubsan.o := n
>  CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
> +# kmalloc_memmove_invalid_size() does this on purpose.
> +CFLAGS_test_kasan.o += $(call cc-disable-warning, array-bounds)
>
>  obj-$(CONFIG_SBITMAP) += sbitmap.o
>
> --
> 1.8.3.1
>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks
