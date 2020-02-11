Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E3CC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2C20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581460179;
	bh=KbBBWvLVK/nodTeKKBzWdDxesPO9rH86mdssi2OYvmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dbk3DrFcCoA6Iqe53CptNdHGBatWqb/dOxsQoJj+fk1h1LP3Fqw2eEH71s7OGrgMl
	 5wOibAorVGoL1sIb7gRXf7uo4jvW+lby5Dd1h22BjhjxoXiVNkTsWqs3ApRGvVYb4M
	 BFDp4cNY8drnR4tUceibD4izmzf3DUXYJBMSfxbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBKW3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgBKW3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:29:38 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAFF220708
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581460178;
        bh=KbBBWvLVK/nodTeKKBzWdDxesPO9rH86mdssi2OYvmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DEpqbkvuTZXMkr63GM08gp5bKr12sFU+qQi9r5Zj4HWdj7aslzu8jgZSigrAe2eQU
         RP6IiPQqnLnmgJBtQ8Sp0A5ySeD+z0EsIWHL/OXdxBcq/7M90Bi/UlGbpzm/2hPm0y
         UnqVtWL9dY39uCU4ZBjxv6N+E6hI3lWhITd4TEe8=
Received: by mail-wm1-f51.google.com with SMTP id s144so3254827wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:29:37 -0800 (PST)
X-Gm-Message-State: APjAAAV/qP0wXGlXtZpbCGVbDMjAS+HOgtQm17JSwk1FWeiJI4WOolKn
        NLREegpRRNXz8l0ZURqaUbv7A64RzWRCLhso9aFiSg==
X-Google-Smtp-Source: APXvYqxAXjknmXNrLHvDElSilQoVMSXHJMtigVdOl5IHhqhN4u1qCSPsaq5HYAeGjLH+qh9AEhijdGGotRqPNvYIFyc=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr8217365wml.138.1581460176281;
 Tue, 11 Feb 2020 14:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-26-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-26-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:29:24 -0800
X-Gmail-Original-Message-ID: <CALCETrWryvrGoPD5zOVxVs3pk+WFfb287NV46Zw7Gz7FtNAHag@mail.gmail.com>
Message-ID: <CALCETrWryvrGoPD5zOVxVs3pk+WFfb287NV46Zw7Gz7FtNAHag@mail.gmail.com>
Subject: Re: [PATCH 25/62] x86/head/64: Install boot GDT
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Handling exceptions during boot requires a working GDT. The kernel GDT
> is not yet ready for use, so install a temporary boot GDT.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/head_64.S | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 4bbc770af632..5a3cde971cb7 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -72,6 +72,20 @@ SYM_CODE_START_NOALIGN(startup_64)
>         /* Set up the stack for verify_cpu(), similar to initial_stack below */
>         leaq    (__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
>
> +       /* Setup boot GDT descriptor and load boot GDT */
> +       leaq    boot_gdt(%rip), %rax
> +       movq    %rax, boot_gdt_base(%rip)
> +       lgdt    boot_gdt_descr(%rip)
> +
> +       /* GDT loaded - switch to __KERNEL_CS so IRET works reliably */
> +       pushq   $__KERNEL_CS
> +       leaq    .Lon_kernel_cs(%rip), %rax
> +       pushq   %rax
> +       lretq
> +
> +.Lon_kernel_cs:
> +       UNWIND_HINT_EMPTY

I would suggest fixing at least SS as well.
