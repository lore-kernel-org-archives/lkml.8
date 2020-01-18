Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF4CC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47CD24687
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vG/c8xAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgARIAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:00:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgARIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:00:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so24730082wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 00:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFOEOXqnCDTTcDQn4El+71G/5ufyH8CwcIjRAHLYoAg=;
        b=vG/c8xAMLKnw35yMwUcyERh82mgpWduiosJkl6ePJZx//bVHz6K/t81pdkparT0iXQ
         UqRivSuHguBripc8g2qmPENm7gWkXLsYSBGSWtqOINGdVHlVui62Dz1xLoKvU4LEXRAw
         +ONISHBcLa/DtBEWffemkC/VGWnm7AqBratbxOL2qerng8irHqsFLKyHWo0rUVepd1Et
         QVFmp4MVkmO+AE6gu0qswMtkByStwcQnyWA73tOnrEKr67BABarPpUVFlLIE5ubwnicX
         ZHUDe+nSnjQAHdsqkcIibgc0oXD5FltiBNKRvhUGxNtPyPs6bhcRH3gNA8K/FFBGF899
         BdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFOEOXqnCDTTcDQn4El+71G/5ufyH8CwcIjRAHLYoAg=;
        b=m8y+LsJEoVxQik0ClCIyQWDQ6fUIz16F6RR1u05PMcQwynDf9St3XayPbvgRbvlGHk
         yBMcfyP33/dsBnUNpS5HpskSSiNlAxoAtYzcwB66APW+KUhOIlpStqU2awQFy3+Wrl/W
         u6IgM37bKTZZnQVonvKExu1+H4KUuX2LxPGpH95AFLVgiBCEK+4uo3Af4xykJKK+fmmu
         DBH7Kxaa1cps3I2s+grluRj7g4xE7jnI77V77p31vCYsm1P8VowJLVatnASnovzN0gaF
         0Fc6bt2k7Y9yiwiFIsFNGMH39f1QywCEHTrfYSzlMVCU+4THjOTOCMstdGmeXbP5KB6n
         WVEw==
X-Gm-Message-State: APjAAAW6dKLAADoetBwKlY2dq0LcB4SpfEF8E25tcyEasEANNCpjwcnT
        fR+niJrCwkJ1XV0xZW8ptEpwU+tiXG83RD1EtQ6kAg==
X-Google-Smtp-Source: APXvYqxAnrbSBO9XoqExZSQU6rzKOVMX5hrWLQTmZJfR0JgUPSpTLbnaLmkmSiraht3cZ64g2pxjZYjbInNmVVkHL6U=
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr7276173wrm.151.1579334411045;
 Sat, 18 Jan 2020 00:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20200118063022.21743-1-cai@lca.pw>
In-Reply-To: <20200118063022.21743-1-cai@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 09:00:04 +0100
Message-ID: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 at 07:30, Qian Cai <cai@lca.pw> wrote:
>
> The commit 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers
> into 32 and 64 bit versions") introduced a KASAN error during boot,
>
>  BUG: KASAN: user-memory-access in efi_set_virtual_address_map+0x4d3/0x574
>  Read of size 8 at addr 00000000788fee50 by task swapper/0/0
>
>  Hardware name: HP ProLiant XL450 Gen9 Server/ProLiant XL450 Gen9
>  Server, BIOS U21 05/05/2016
>  Call Trace:
>   dump_stack+0xa0/0xea
>   __kasan_report.cold.8+0xb0/0xc0
>   kasan_report+0x12/0x20
>   __asan_load8+0x71/0xa0
>   efi_set_virtual_address_map+0x4d3/0x574
>   efi_enter_virtual_mode+0x5f3/0x64e
>   start_kernel+0x53a/0x5dc
>   x86_64_start_reservations+0x24/0x26
>   x86_64_start_kernel+0xf4/0xfb
>   secondary_startup_64+0xb6/0xc0
>
> It points to this line,
>
> status = efi_call(efi.systab->runtime->set_virtual_address_map,
>
> efi.systab->runtime's address is 00000000788fee18 which is an address in
> EFI runtime service and does not have a KASAN shadow page. Fix it by
> doing a copy_from_user() first instead.
>

Can't we just use READ_ONCE_NOCHECK() instead?

> Fixes: 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers into 32 and 64 bit versions")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/platform/efi/efi_64.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 515eab388b56..d6712c9cb9d8 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -1023,6 +1023,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
>                                                 u32 descriptor_version,
>                                                 efi_memory_desc_t *virtual_map)
>  {
> +       efi_runtime_services_t runtime;
>         efi_status_t status;
>         unsigned long flags;
>         pgd_t *save_pgd = NULL;
> @@ -1041,13 +1042,15 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
>                 efi_switch_mm(&efi_mm);
>         }
>
> +       if (copy_from_user(&runtime, efi.systab->runtime, sizeof(runtime)))
> +               return EFI_ABORTED;
> +
>         kernel_fpu_begin();
>
>         /* Disable interrupts around EFI calls: */
>         local_irq_save(flags);
> -       status = efi_call(efi.systab->runtime->set_virtual_address_map,
> -                         memory_map_size, descriptor_size,
> -                         descriptor_version, virtual_map);
> +       status = efi_call(runtime.set_virtual_address_map, memory_map_size,
> +                         descriptor_size, descriptor_version, virtual_map);
>         local_irq_restore(flags);
>
>         kernel_fpu_end();
> --
> 2.21.0 (Apple Git-122.2)
>
