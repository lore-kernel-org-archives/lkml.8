Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F083C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2032065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595592983;
	bh=WdKBttJSrUprqS6V7PDxTgYqLUaZfmvXP2DkIOtu0so=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZAuGWXgR1OpBB/vygaK7hXyXu6HFytprPvExHBWjHGEOu6l6Wt747ECZ7jhjy8j/b
	 sq0w6O55vwOVO+OMSH8mNR0EuE+pLd3HF+o9iD0neZPwONPxVcP3DPMYdqj+hrJxiS
	 0h1BIAfydZBZRjbxiTFRI6HsRNrBi1pFIqGO+9/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGXMQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgGXMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:16:21 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF162073E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595592980;
        bh=WdKBttJSrUprqS6V7PDxTgYqLUaZfmvXP2DkIOtu0so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VFB+q4ntLqL2Ctbo5MgHkPItgam47VQK06Pl1wqcpJGLX3T+w3386RUBz+2EpNySK
         6e+zBJSOnsYMp+UAN8UaF6g9qY7oaCIMxUPAPcg3G3O6RdbTlfmDVvbbL0CzNrghCh
         kl33diwLiJ14k+lGLNFeolqDXVRL54593INbIlKQ=
Received: by mail-oi1-f182.google.com with SMTP id e4so7851082oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:16:20 -0700 (PDT)
X-Gm-Message-State: AOAM532s6+DSrNQ2ye3hOjowe3nnzQ/Es564+Xf5aebmyi3DY+bER7qz
        COQJjm/1KK2+UH98m8ng7xpQWGV+eX9xYW9vZ/4=
X-Google-Smtp-Source: ABdhPJzazvz+YVH4yMcXQ4eOnvDzE85XNeiZD+dIinUZRfsQnYXvvBcJr9fd1mpDed/CD8C2NxVD5gOjumZYvAaYlKs=
X-Received: by 2002:aca:5516:: with SMTP id j22mr7411445oib.47.1595592979858;
 Fri, 24 Jul 2020 05:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com> <20200724092746.GD517988@gmail.com>
In-Reply-To: <20200724092746.GD517988@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jul 2020 15:16:08 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHeSVn7W-Awq2Z57w4OevaLLLX7QrPgnzceiaQ2PooQXg@mail.gmail.com>
Message-ID: <CAMj1kXHeSVn7W-Awq2Z57w4OevaLLLX7QrPgnzceiaQ2PooQXg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 12:27, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>
> > Use text_alloc() and text_free() instead of module_alloc() and
> > module_memfree() when an arch provides them.
> >
> > Cc: linux-mm@kvack.org
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  kernel/kprobes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 4e46d96d4e16..611fcda9f6bf 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/errno.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/vmalloc.h>
> >
> >  #define KPROBE_HASH_BITS 6
> >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +     return text_alloc(PAGE_SIZE);
> > +#else
> >       return module_alloc(PAGE_SIZE);
> > +#endif
> >  }
> >
> >  void __weak free_insn_page(void *page)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +     text_free(page);
> > +#else
> >       module_memfree(page);
> > +#endif
> >  }
>
> I've read the observations in the other threads, but this #ifdef
> jungle is silly, it's a de-facto open coded text_alloc() with a
> module_alloc() fallback...
>

Also, as I attempted to explain before, there is no reason to allocate
kasan shadow for any of these use cases, so cloning module_alloc() to
implement text_alloc() is not the correct approach even on x86.

I suppose module_alloc() could be reimplemented in terms of
text_alloc() in this case, but simply relabelling it like this seems
inappropriate on all architectures.
