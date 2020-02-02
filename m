Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6474C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7371120679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBsX9Hpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgBBSCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 13:02:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52198 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBBSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 13:02:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so13440017wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmKWAHIRS574byfrrAo7husLV2hZAgH8s/ZJVLQJI3g=;
        b=aBsX9Hpef1ms4ozqNDTFAQ2tNBdDwTakNV/lcZvRVy1CEWOUikE8PTfJdCCHOXThBy
         K/uRER0R1Lt9H33e4VLfa/061i21BcHAA/i1SHMT+bzgKNLhJzJnIeEqiMv4ohyEeSdB
         KU/ZxEKvrF34CjEu8x1Ei+Onktl9sth+4xVk10IeiQ9h6l9NfJxV5toDvXqJozfLwbjl
         XXfb+0e4ERSlTlDxraoSv8pyQ+ReVlXsBx6Lanult13oOuEWjsJVi/LIQKCJkvGTZWxK
         aeTcxo3ANAmtAo/zzDopyTAjlxD1rgSYAlyZiiPcu4IWJEK6Hc4m4TkhuR6YdHH8vaLC
         HSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmKWAHIRS574byfrrAo7husLV2hZAgH8s/ZJVLQJI3g=;
        b=oxuo8R+SPdjKuDhis7C2PqO0nYS82xATiPJ7nTebNeKoaqYEMOCee56JBD4hYBr2ML
         pZ95wQudYUxCyDD1Cm7Izm5vbcn5DyFyCg/idLgNiEBeEZ/ElMg9O715xAJSj9vtDfTp
         4uPq4qzyTVP36LAf8lSOphVneO4tjrfxbsubRdoxir1rdqbbA55VOA13m+meBhvyxa4J
         zUdM4/ZTRbCZPOtv6PakjHkCU1Vdu3zA3X5C5/oCEApSbng6hVMmiM4PI9vf8+xnmfxj
         ZQXiNcWdrf5IielCEAH/lRI+ESltbCdMDkqVZH343nvUul9P0wuARcD+peieg22+ww4G
         R8ZA==
X-Gm-Message-State: APjAAAU01nXNYbqknEhFYQy6fu3ItVQa5DKf0el/M2bnCS0dmsiBKpFd
        WZ9o1egxiQNnyBtOQY/6yox3XyrzqJ63RuOfo2xeqA==
X-Google-Smtp-Source: APXvYqyp+LfNjYLyx7jF8VwNkgNpyXLXKBIKNlb+Sx5rURpHGzkTO0rTl3kUdkDD9b9d+3r5Ig7GL7iu2lydhzMHUQ4=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr23729628wma.62.1580666525652;
 Sun, 02 Feb 2020 10:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20200130200440.1796058-1-nivedita@alum.mit.edu> <20200202171353.3736319-1-nivedita@alum.mit.edu>
In-Reply-To: <20200202171353.3736319-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 2 Feb 2020 19:01:27 +0100
Message-ID: <CAKv+Gu_pXg3hFophgQZ2nMHMWZwUuiE2s+Z6bRzby8_3vXzcNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] x86/efi,boot: GDT handling cleanup/fixes
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020 at 18:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series fixes a potential bug in EFI mixed-mode and leaves GDT
> handling to startup_{32,64} instead of efi_main.
>
> The first patch removes KEEP_SEGMENTS support in loadflags, this is
> unused now (details in patch 1 commit msg), to slightly simplify
> subsequent changes.
>
> The second patch fixes a potential bug in EFI mixed-mode, where we are
> currently relying on the firmware GDT having a particular layout: a
> CODE32 segment as descriptor 2 and a DATA segment as descriptor 3.
>
> The third patch adds some safety during kernel decompression by updating
> the GDTR to point to the copied GDT, rather than the old one which may
> have been overwritten.
>
> The fourth patch adds cld/cli to startup_64, and the fifth patch removes
> all the GDT setup from efi_main and adds it to the 32-bit kernel's
> startup_32. The 64-bit kernel already does GDT setup. This should be
> safer as this code can keep track of where the .data section is moving
> and ensure that GDTR is pointing to a clean copy of the GDT.
>
> The last two patches are to fix an off-by-one in the GDT limit and do a
> micro-optimization to the GDT loading instructions.
>

Thanks Arvind.

This looks good to me,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

but I'm a bit out of my depth here when it comes to x86'ology so it's
really up to the x86 maintainers.


> Changes from v1:
> - added removal of KEEP_SEGMENTS
> - added the mixed-mode fix
> - completely removed GDT setup from efi_main, including for the 32-bit
>   kernel
> - dropped documentation patches for now
>
> Arvind Sankar (7):
>   x86/boot: Remove KEEP_SEGMENTS support
>   efi/x86: Don't depend on firmware GDT layout
>   x86/boot: Reload GDTR after copying to the end of the buffer
>   x86/boot: Clear direction and interrupt flags in startup_64
>   efi/x86: Remove GDT setup from efi_main
>   x86/boot: GDT limit value should be size - 1
>   x86/boot: Micro-optimize GDT loading instructions
>
>  Documentation/x86/boot.rst              |   8 +-
>  arch/x86/boot/compressed/eboot.c        | 103 ------------------------
>  arch/x86/boot/compressed/efi_thunk_64.S |  29 +++++--
>  arch/x86/boot/compressed/head_32.S      |  48 +++++++----
>  arch/x86/boot/compressed/head_64.S      |  66 ++++++++-------
>  arch/x86/kernel/head_32.S               |   6 --
>  6 files changed, 99 insertions(+), 161 deletions(-)
>
> --
> 2.24.1
>
