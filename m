Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D9C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35A720857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581874397;
	bh=iPN4GRSxftClYdW2bpJCs06VBDIRWUdhu33LTOPvy1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O4yStBjwIzu1Uvd4UaGiwNivcPM2tjgTNup7aKxi356PEaqPjISkr0JNIIg2gRd6C
	 d/q7ZBa/HHNmYsr/fN2RlzYxKVvYWfxKvj12epizq+3ZPnH9D5Vwehl1c13Ip90ZXT
	 8xQzSgPrfLezfiPITwo+L69y9yeuaLwE1uhULUnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgBPRdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgBPRdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:33:16 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7784A20857
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581874395;
        bh=iPN4GRSxftClYdW2bpJCs06VBDIRWUdhu33LTOPvy1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZGp3vKGqx04ZGJrBDPDq0J03AaC5AmXX6vckOQmSKI6OnFXxFQ4zDkj0x/lcMxTd5
         d3LAu/7ooPAGLOZA5ObrWmaArrgKv37HkzZcM2Kyn84Ej6A3TlI6Ux+2ERb1RWP05O
         OuvQ+x3hyfKs/fHCHNuElz4dGKWZGSFeNwFdQRIo=
Received: by mail-wr1-f52.google.com with SMTP id w12so16871275wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 09:33:15 -0800 (PST)
X-Gm-Message-State: APjAAAVzXWs3onU9Ptrgh5apnMYYaRlyddLq5wNWcfNbzR6t5WgCFsk6
        dP9vHCvPE5h0XbtU7gPhGcpu3Vriua+AHj/sU6HXYA==
X-Google-Smtp-Source: APXvYqzC09ky72ZcgkuwLRBsvoAJlw1G1Sf2p3pvdKBd8s4iPftZIwbDcMky5AWdTt8T8hmXVaRSSfXvtc3SLleoicA=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr16532123wrw.262.1581874393852;
 Sun, 16 Feb 2020 09:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20200216171340.6070-1-xypron.glpk@gmx.de>
In-Reply-To: <20200216171340.6070-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 16 Feb 2020 18:33:03 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8JEkFPN3V1mAJtCBAM2=gDhqMMaVxX7Zep-73s6CeARw@mail.gmail.com>
Message-ID: <CAKv+Gu8JEkFPN3V1mAJtCBAM2=gDhqMMaVxX7Zep-73s6CeARw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: function description efi_allocate_pages()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020 at 18:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Provide a Sphinx style function description for efi_allocate_pages().
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich. I will put this on the pile.

> ---
>  drivers/firmware/efi/libstub/mem.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 5808c8764e64..c6a784ed640f 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -65,8 +65,20 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
>         return status;
>  }
>
> -/*
> - * Allocate at the highest possible address that is not above 'max'.
> +/**
> + * efi_allocate_pages() - Allocate memory pages
> + * @size:      minimum number of bytes to allocate
> + * @addr:      On return the address of the first allocated page. The first
> + *             allocated page has alignment EFI_ALLOC_ALIGN which is an
> + *             architecture dependent multiple of the page size.
> + * @max:       the address that the last allocated memory page shall not
> + *             exceed
> + *
> + * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
> + * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the address
> + * given by 'max'.
> + *
> + * Return:     status code
>   */
>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>                                 unsigned long max)
> --
> 2.25.0
>
