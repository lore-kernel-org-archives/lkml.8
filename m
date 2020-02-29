Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9573C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6AC24672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MJlh0jh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgB2WdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:33:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38991 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgB2WdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:33:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id r16so6621586oie.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 14:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+qFmqhcgb7jhEPbeVLEVdCHOr+If3XHxdqQ1tb+5pc=;
        b=MJlh0jh6fKGmlMf8QKHfSMGKxkzGHEeUxIKuMK576jnOzp5ajBbWFd723+Nwz5sX5o
         kd5kFB1Qa4nMK4C2Quz1EtosMFhbFGty2TrTrSeM0926YL1M9TjPuncmtlZef3BqKcKO
         0QMDkTU7/GfTsJIR/w5n5LoqIVS0h8Ha+vMH2bvx31vmcGio+VmcVwwkaawh8iuK3FDK
         B8oJ2LCRKfwY4UJPa+Ufg0yoRxTMpdzcD2JzNOx//OiTA4E21r9KhphDTjUvXXJpa4mN
         qph+2qengVBm0C0Rc0eQp7M69RV9q8SQixDZKId1V2L1G6rpoNj9Qc0++zW1EeGd/ZTO
         X0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+qFmqhcgb7jhEPbeVLEVdCHOr+If3XHxdqQ1tb+5pc=;
        b=sdlqW5phjzxF66vGDi/16y4nb8s1p5WKp2ofO4LQ+KyybVpAlCk1cCHmhseofm2I3V
         etPEzUQdXV36b6k6oPW+e5ZRC/3ip7E08AJLMgt4w23RiDHt2Ex//lcY4m47jjdEENr9
         wJxbKXJOniz71skht3GDgJmDu1r62g5l4CcSXcZpI+e5OrGND3Ffp6qOAW8ag4VnHHsV
         BIeqXHL5hh9y+s8E/zVszr0+wOjWtPjw9rHbHouFXnO8J8BmprlnVBNHGLTIkc/XOVL9
         0slvlmRYdJopriEsH5ECGeBxwDGu4IFL2+WRMxKXual1TghCpCB/7bUluUtKBANsK6WM
         N7lw==
X-Gm-Message-State: APjAAAV0/9F75FssVVfh60/o1aY9vLWtpz/NyGts4UOzsCZ3Av/DL4bF
        UcvNaZ+yZOdONUcTeEpc/keIIum3HRzS4mmi3jcWBg==
X-Google-Smtp-Source: APXvYqyGoDfozeCQcvGtfIbG5zusEz6FXIH1C19GvJgWOw0G4+LzaZgF0KV8DfFmkR6MhUJ7WBGfGAzVDBqWpHKu+yI=
X-Received: by 2002:a54:4791:: with SMTP id o17mr6946593oic.70.1583015599612;
 Sat, 29 Feb 2020 14:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200221182503.28317-5-logang@deltatee.com>
In-Reply-To: <20200221182503.28317-5-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 29 Feb 2020 14:33:08 -0800
Message-ID: <CAPcyv4j=bZ5KBPp6PbViERdDe+HZpV_W6qbSJupTNAzyfiK6xg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] x86/mm: Introduce _set_memory_prot()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:25 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> For use in the 32bit arch_add_memory() to set the pgprot type of the
> memory to add.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  arch/x86/include/asm/set_memory.h | 1 +
>  arch/x86/mm/pat/set_memory.c      | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
> index 64c3dce374e5..0aca959cf9a4 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -34,6 +34,7 @@
>   * The caller is required to take care of these.
>   */
>
> +int _set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);

I wonder if this should be separated from the naming convention of the
other routines because this is only an internal helper for code paths
where the prot was established by an upper layer. For example, I
expect that the kernel does not want new usages to make the mistake of
calling:

   _set_memory_prot(..., pgprot_writecombine(pgprot))

...instead of

    _set_memory_wc()

I'm thinking just a double underscore rename (__set_memory_prot) and a
kerneldoc comment for that  pointing people to use the direct
_set_memory_<cachemode> helpers.

With that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
