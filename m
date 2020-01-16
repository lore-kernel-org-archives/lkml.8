Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8EDC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA588207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTR/LPR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgAPJJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:09:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40649 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAPJJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:09:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so18422327qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tonFvUx7UkLvzdq6Qt10/rB0wyKCjPpdmSM6EzK1Zgc=;
        b=GTR/LPR5CJCmIb4lPK4juOg3rimqFzGsYxB7ANak6Osq2oyUQOcw0nGc0oI8Pe6JMz
         TaOpHEAk7VKCnvkyuQ3c+ZzbS+saEGPkqVUJ+Uv2oC6AoY6fnsyqAVTS/qSzgTEK9wVQ
         vzUN35lj8aufrykCUGaF6kC7gx2pKkxHKTAIzZaoJ8AZ4j6bJE/VRwIaA8LvUrg8xtBq
         iR0uTxn0JC8oteDlQe+iwlJBdT4TcEz+BgUMF6TDvg+tsN0iWwl7qPZlNZ7XDSP5qLn0
         CR+LNDN0l6r5xtR3T8/ukhoHwdVf0mWjFbPtJP4syd0oYM+XRWlrGnj23nI3PjXOrEDQ
         uf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tonFvUx7UkLvzdq6Qt10/rB0wyKCjPpdmSM6EzK1Zgc=;
        b=ChViVhjkF1FTCsOEV6w1DesbHubWhtrOdjVGSiL9nS+/aX4W9Vs468L/CO3SUtTiGq
         PrJ+5HUZSjPm5ucVA+SGqMQh7BBWR4oJLKTQcIkkezqdI1kL4YxqiELUXOJm0vQ19cwb
         bQqCztqRv13+QqIyPnHESkuC2V6wDGXsiacpb8OcaNt2N5fKEIURHeyJEarkE3dudopm
         7me4KSLZ7KxaGyr+x4FXRKlHJ2CcqXfJtUfml9Cc9WXtI0s6aCKpYjpN8ItvvWDXUzr+
         4z18xa0w11IA2dPKN/jPX+k8XxK6OO6wkByAZ/ahUQHeQoL0g/WOCIAI546dZPqTY0MB
         Z+Ew==
X-Gm-Message-State: APjAAAVvxMht7DnJ+mbzpatGW/ZDq/4MknQKgL8HFp6/wWWSG6YqKhq4
        K9mBKCnH0Xej8zB+aKAm9RDz2UKF7GtV/ZtO52CJMQ==
X-Google-Smtp-Source: APXvYqzt2RtQHB+l1Uls8Nh2pJ1jFacFAdBfZtc7vtXiftJc+uLnJiv7M1aeYBEmn3cMvbnA/W1IcAGc0YnWe7raj3s=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr32318196qkk.8.1579165769218;
 Thu, 16 Jan 2020 01:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 10:09:17 +0100
Message-ID: <CACT4Y+ahnhTXQPfxcJPEFOA1saAr4xOGY583am8buW7kMJiq8w@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> new file mode 100644
> index 000000000000..ca4c43a35d41
> --- /dev/null
> +++ b/arch/um/include/asm/kasan.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_KASAN_H
> +#define __ASM_UM_KASAN_H
> +
> +#include <linux/init.h>
> +#include <linux/const.h>
> +
> +#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +#ifdef CONFIG_X86_64
> +#define KASAN_SHADOW_SIZE 0x100000000000UL

How was this number computed? Can we replace this with some formula?
I suspect this may be an order of magnitude off. Isn't 0x10000000000 enough?

> +#else
> +#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
> +#endif
> +
> +// used in kasan_mem_to_shadow to divide by 8
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
> +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +void kasan_map_shadow(void);
> +#else
> +static inline void kasan_early_init(void) { }
> +static inline void kasan_init(void) { }
> +#endif /* CONFIG_KASAN */
> +
> +void kasan_map_memory(void *start, unsigned long len);

This better be moved under #ifdef CONFIG_KASAN, it's not defined
otherwise, right?

> +void kasan_unpoison_shadow(const void *address, size_t size);

This is defined by <linux/kasan.h>. It's better to include that file
where you need this function. Or there are some issues with that?

> +
> +#endif /* __ASM_UM_KASAN_H */



> diff --git a/arch/um/kernel/kasan_init_um.c b/arch/um/kernel/kasan_init_um.c
> new file mode 100644
> index 000000000000..2e9a85216fb5
> --- /dev/null
> +++ b/arch/um/kernel/kasan_init_um.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/kasan.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <asm/dma.h>
> +#include <as-layout.h>
> +
> +void kasan_init(void)
> +{
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +
> +       // unpoison the kernel text which is form uml_physmem -> uml_reserved

Why do we need to unpoison _text_? Who is accessing shadow for it? Do
you mean data/bss?
But on a more general point, we just allocated it with mmap, mmap
always gives zeroed memory and asan shadow is specifically arranged so
that 0's mean "good". So I don't think we need to unpoison anything
separately.

What may be more useful is to poison (or better mprotect, unmap, not
mmap) regions that kernel is not supposed to ever touch. One such
region is shadow self-mapping (shadow for shadow), in user-space we
mprotect that region. For KASAN we don't map shadow for user-space
part of VM, but I don't know if UML has such separation. We could also
protect other UML-specific regions if there are any, e.g does anybody
read/write text?


> +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> +
> +       // unpoison the vmalloc region, which is start_vm -> end_vm
> +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> +
> +       init_task.kasan_depth = 0;
> +       pr_info("KernelAddressSanitizer initialized\n");
> +}
