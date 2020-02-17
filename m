Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8CC3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534042072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581934599;
	bh=4cLlQS6dh3TII+e63aZc4SI9thiBfzKMd7Iu5QCGWjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BNkVzhxLmKq1lRjnZpvR5+uCDXjBUIUsBHo604ykPV3+xJzzo9yV05mxglVYvgonP
	 4oZeOyFfHWXhBlmI8wzEhLt6G9yRB7kStgpZBloEIZzzR2ufcs1GR9OqREVeZHAxE/
	 G2j6cdykKMlHEjNWV0HZc5jTLTqnP2g4loTVKpEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgBQKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgBQKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:16:37 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE50824655
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581934597;
        bh=4cLlQS6dh3TII+e63aZc4SI9thiBfzKMd7Iu5QCGWjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eq5UfpApFfSqgahMtWpRHuyClv3jPdyyd6PVRbQT2PcAXEEpHt8JYkGsEBXaLUR3v
         yxJfKOj8zQKAAWslqWAgPnGkbIgTkaVY05SWCFX3Pd+3Z/SEFcQhj2cEaKl35qQJv3
         QGWBAbZxg7TlwdUTdJuvsq13UzOI6Ya/rYQgLfwE=
Received: by mail-wm1-f49.google.com with SMTP id m10so7015985wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:16:36 -0800 (PST)
X-Gm-Message-State: APjAAAWDg/l9F5AcF3EuwKrMf6rI/KhNF4soPgGo+9rKm8/QBmVqBz33
        dwY1ZOQMbIqLhREOv33wsxNWwOaiu05YjsKcafHVkg==
X-Google-Smtp-Source: APXvYqzqZNxl118rnsQ1j1OXjhkx9vVcOI+aj/V8YvXdxCexJjSRKnmYAijbWYByC/Tq0yzU4F9Fp8tfyDdGHA9vZD0=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr22636081wmf.133.1581934595070;
 Mon, 17 Feb 2020 02:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20191218162402.45610-1-steven.price@arm.com> <20191218162402.45610-22-steven.price@arm.com>
 <CAKv+Gu8Hed9jGiqdgaqJ93JhErJA5OfGRpiarU=YKXb6vQUyMQ@mail.gmail.com> <ee4f53ec-601b-3698-1479-f7aeaada38ad@arm.com>
In-Reply-To: <ee4f53ec-601b-3698-1479-f7aeaada38ad@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Feb 2020 11:16:23 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-iLwjZvavQud9o+5nTB0ORAAn32qKMScxYHJ64k7HExA@mail.gmail.com>
Message-ID: <CAKv+Gu-iLwjZvavQud9o+5nTB0ORAAn32qKMScxYHJ64k7HExA@mail.gmail.com>
Subject: Re: [PATCH v17 21/23] arm64: mm: Convert mm/dump.c to use walk_page_range()
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <James.Morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 at 11:01, Steven Price <steven.price@arm.com> wrote:
>
> On 16/02/2020 16:25, Ard Biesheuvel wrote:
> > On Wed, 18 Dec 2019 at 17:25, Steven Price <steven.price@arm.com> wrote:
> >>
> >> Now walk_page_range() can walk kernel page tables, we can switch the
> >> arm64 ptdump code over to using it, simplifying the code.
> >>
> >> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >
> > I did not realize this at the time, but this patch removes the ability
> > to dump the EFI page tables on 32-bit ARM. Was that intentional?
>
> No that wasn't intentional, but I can't instantly see how this change
> affects 32-bit ARM.
>
> <snip (files in arch/arm64)>
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 899b803842bb..9dda2602c862 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -27,7 +27,7 @@
> >>
> >>  extern u64 efi_system_table;
> >>
> >> -#ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
> >> +#if defined(CONFIG_PTDUMP_DEBUGFS) && defined(CONFIG_ARM64)
>
> The previous define was *ARM64* so should never have been true when
> building for arm. The new condition should be equivalent (arm64 &&
> ptdump enabled).
>
> Am I missing something?
>

Not at all, I just got confused.

IIRC we did have support for dumping the EFI pages tables on 32-bit
ARM at *some* point, but it obviously wasn't your patch that removed
it.

Apologies for the noise.
