Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87BC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A032176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582652722;
	bh=3Poz7jxq/qrWijhX+h0LsAxU+LowS2xjr5QXZRUEM/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ATjCW9tyvzjlQqNYnklk/13n39KVlYChkVRNE6Q85u+Uj9Vmm2KvMSm/1gCRyMwSd
	 iIJ4v+bquPaYZzIqk24tTbOhKtha4iwih628DIe8+gJo6UT/pdJVDWB5y9egWi5mDt
	 e/N8/8v6QO2j8H/0j7zznpTc7nOoNVht/krtjG24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgBYRpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgBYRpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:45:20 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E1D22464
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582652720;
        bh=3Poz7jxq/qrWijhX+h0LsAxU+LowS2xjr5QXZRUEM/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qVWyRsciCPkSKXc5vXMsH44IvYNi1Ru2klseSGmoInTcEJ7iupPoCumWQvacsEgDP
         Dkaf799PKHDMNJ1k54tRReZpvSlxbq4izq3YNkqHGvYWL6Y4K6QLk+RrMMCe+Pzhuc
         ZWsKGd7NaoAkvLu39t+5FdorfzPSqo69GLF0dSgQ=
Received: by mail-wm1-f54.google.com with SMTP id z12so59889wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:45:19 -0800 (PST)
X-Gm-Message-State: APjAAAWITPV+gc9/tW+Ch9xFS0VAJwjxbvVNKXCCMubXmU/JY39kvuc8
        +B3ubvFxtQlcgaY6pP5rl5s8jHlbn79zinKLBdmC2g==
X-Google-Smtp-Source: APXvYqyZRwLTc1nkXaComsaLWbhJtUqWzzkDg2dRKUkmo7/fXBOi/XyjC/Y/6v14bvpDRDK/fkAw2IXpcmtzTQP/G/k=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr363473wmj.1.1582652718055;
 Tue, 25 Feb 2020 09:45:18 -0800 (PST)
MIME-Version: 1.0
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
In-Reply-To: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 18:45:06 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
Message-ID: <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> When booting with SME active, EFI tables must be mapped unencrypted since
> they were built by UEFI in unencrypted memory. Update the list of tables
> to be checked during early_memremap() processing to account for new EFI
> tables.
>
> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> it lives in memory that has been marked as usable rather than reserved.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>
> ---
> Changes since v1:
> - Re-spun against EFI tree

Which one? Surely not the one in the link I included?

> ---
>  arch/x86/platform/efi/efi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 43b24e149312..c6ca959e2366 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -88,6 +88,9 @@ static const unsigned long * const efi_tables[] = {
>  #ifdef CONFIG_EFI_RCI2_TABLE
>         &rci2_table_phys,
>  #endif
> +       &efi.rng_seed,
> +       &efi.tpm_log,
> +       &efi.tpm_final_log,
>  };
>
>  u64 efi_setup;         /* efi setup_data physical address */
> --
> 2.17.1
>
