Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B1EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFCA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iUyquCbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGOTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGOTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:36:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA8C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:36:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so3459235pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvkmBERge76OD9EroFR1ab0FIW+Z4wHO+7dviVws/gQ=;
        b=iUyquCbsUx2U5Bmvi53VPRZwo0kqbDq+f/tALn5Dx3qumSe0apG8eUSZnfhBqmq7gR
         WgOR/I9kPn/cCyvtSlqnHr5I0+qr4C8QpxOP/MNMmRKOQKnB6tCeS82Mt7+jJEI+bitT
         JJA5d+5WCEh7eWfpSQXvRJ759zt6PEjjnE7Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvkmBERge76OD9EroFR1ab0FIW+Z4wHO+7dviVws/gQ=;
        b=nSXMmAIxZ/CElRcNQL5nAWzKpJFsOO3fxw05bRExhUbs0wd+VtgQ/Aue/xA5Hfzhmo
         oqmAKFqVkYbsB18iKTz3bKpVLbCouUR8GhpWEnOE7dCBh97YEaeWT/GzXN5bOZ6l7qxu
         Mur3i3N2ctzv1O3Jc1++UZZHur15IsiRf2RHUNL7glaNBYbzYzbwVzPI/7yYrZA2VF8I
         4mA9GSG0n8CiVzuHojXAvS8J4LnOT7dIDR7323SkyfDqOpRtlPg0UqJOCzyyAq84WV4Q
         jjfbA6tPHTvpDaaEClv4U1pnWmsoMpZWa4TmiKs4QdAPymjlatcZPfmTxwUYcpCWoCJV
         778w==
X-Gm-Message-State: AOAM532rKlZH+qc0IuP7QttdZZNw5ysYx56vIV4jqIextDgdWdPZexfR
        o9ehE7r3fEttiELgThcg1mVLpQ==
X-Google-Smtp-Source: ABdhPJyM5sz6byeyGclhslNZM7/7kp3ou4WZ3VtGjTgoQQiaAG3JFPwGoRQe8zQM+Zio/ppSwVqo9g==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr742714plp.229.1594841764231;
        Wed, 15 Jul 2020 12:36:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n62sm3025449pjb.28.2020.07.15.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:36:03 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:36:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-ID: <202007151232.0DA220B2@keescook>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:32:27AM +0300, Jarkko Sakkinen wrote:
> Introduce new API for allocating space for code generaed at run-time
> leveraging from module_alloc() and module_memfree() code. Use this to
> perform memory allocations in the kprobes code in order to loose the
> bound between kprobes and modules subsystem.
> 
> Initially, use this API only with arch/x86 and define a new config
> flag CONFIG_ARCH_HAS_TEXT_ALLOC to promote the availability of the
> new API.
> [...]
> diff --git a/include/linux/text.h b/include/linux/text.h
> new file mode 100644
> index 000000000000..a27d4a42ecda
> --- /dev/null
> +++ b/include/linux/text.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _LINUX_TEXT_H
> +#define _LINUX_TEXT_H
> +
> +/*
> + * An allocator used for allocating modules, core sections and init sections.
> + * Returns NULL on failure.
> + */
> +void *text_alloc(unsigned long size);
> +
> +/*
> + * Free memory returned from text_alloc().
> + */
> +void text_free(void *region);
> +
> +#endif /* _LINUX_TEXT_H */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2e97febeef77..fa7687eb0c0e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -35,6 +35,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/cpu.h>
>  #include <linux/jump_label.h>
> +#include <linux/text.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -111,12 +112,20 @@ enum kprobe_slot_state {
>  
>  void __weak *alloc_insn_page(void)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	return text_alloc(PAGE_SIZE);
> +#else
>  	return module_alloc(PAGE_SIZE);
> +#endif

This seems like it shouldn't be needed. I think text_alloc() should
always be visible. In the ARCH_HAS... case it will call the arch
implementation, and without it should just call module_alloc():

For example:
void *text_alloc(unsigned long size)
{
#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
	return arch_text_alloc(size);
#else
	return module_alloc(size);
#endif
}

-- 
Kees Cook
