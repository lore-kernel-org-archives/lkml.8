Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECBC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35E720656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubxAfdRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXEPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:15:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47083 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgBXEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:15:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so7703085oid.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 20:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtOOndOWZSDXybYasUpcnffIRI9DWgK6w/MiME7iIyA=;
        b=ubxAfdRSx4t292O11yEtyiS45hr76kV1ZivVX31imh2sVv75jLafbyUz7Sk1vhKyxp
         U13Q/QyCrb1aj+hIbtw0GbB38ZxZTf8ujH/gF/AoxXfgmJIQZRUmNB+wz9ovq7qGobWp
         G44SlHNyrlhH9etlitz8Coe5/JG8nsbDkfJCXZEdB2d57vC+27jxfoP7pvkjpGMwE2tv
         UKWS3Qba+HfkFV3b9bj1Lw+a0LCULnCBDhQAcmEbJZatno/M2G5bGIAYZAF+xe3JMZSb
         MpBmk1MgsDydiP+3bWDi+e8VGZtDdj2UKTO7P8FWNWodW+Olv4cSOHD49ywVJrYVUDsr
         1ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtOOndOWZSDXybYasUpcnffIRI9DWgK6w/MiME7iIyA=;
        b=Fgb0QQb6Ak7phZ9iF1Ap2MbPUnik/uBW7+qgY8558YjtblooxzZBn16aTvyGYzfO+p
         ufuzWmaRKG4l6GICczxaQUWWuxPGiL3eBQMXnuDNf7OaQ2GMJERTuzbZsTHfD5Ccaljp
         Q/q06w/Crno/gQRhtN9uC3zuk3tmVInpL7zUyECq58+HtuMT4zgZX5R0EHuyOXVYUhwc
         9Yjj1gyvfyKGjaptMxaZezjuVaj7+bZaZjC4XkotfOqbUDFUL8V33CvL4BAU0O9PK4/W
         YhJ4p1d9vsYLO/KiIVXusj9zvXea0RC2MWzrFdgCkbfX6mq6jGlvlGszFqcxwzyMXAFj
         SEtQ==
X-Gm-Message-State: APjAAAXq3TVJ4AQiB9uNbF1bLOD9nTgGwY9anLhC0tK02sHhrKX2MbhW
        y+5Zqvw1e6m7ih6qhZNzGW0=
X-Google-Smtp-Source: APXvYqzq2PcrTKVvsY8h4Bm2ZVrzilS6ewqvNS0QEaJ85ba/Rqs8yck9S9qvBi4qg2zbS1IE0l8juQ==
X-Received: by 2002:aca:5f87:: with SMTP id t129mr11397800oib.36.1582517744531;
        Sun, 23 Feb 2020 20:15:44 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j13sm3701944oii.14.2020.02.23.20.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 20:15:43 -0800 (PST)
Date:   Sun, 23 Feb 2020 21:15:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] Stop generating .eh_frame sections
Message-ID: <20200224041542.GA55909@ubuntu-m2-xlarge-x86>
References: <20200222235709.GA3786197@rani.riverdale.lan>
 <20200223193715.83729-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223193715.83729-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 02:37:13PM -0500, Arvind Sankar wrote:
> In three places in the x86 kernel we are currently generating .eh_frame
> sections only to discard them later via linker script. This is in the
> boot code (setup.elf), the realmode trampoline (realmode.elf) and the
> compressed kernel.
> 
> Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
> adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
> sections in the first place, rather than discarding it in the linker
> script.
> 
> Arvind Sankar (2):
>   arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
>   arch/x86: Drop unneeded linker script discard of .eh_frame
> 
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/boot/setup.ld                | 1 -
>  arch/x86/kernel/vmlinux.lds.S         | 3 ---
>  arch/x86/realmode/rm/Makefile         | 1 +
>  arch/x86/realmode/rm/realmode.lds.S   | 1 -
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  7 files changed, 5 insertions(+), 6 deletions(-)
> 
> -- 
> 2.24.1
> 

With both of these patches applied on top of next-20200221 and a revert
of commit e11831d0ada3 ("x86/boot/compressed: Remove unnecessary
sections from bzImage"), I do not see any .eh_frame sections in the
following files:

$ readelf -S arch/x86/boot/setup.elf \
arch/x86/realmode/rm/realmode.elf \
arch/x86/boot/compressed/vmlinux \
vmlinux |& grep eh_frame

Additionally, I can see -fno-asynchronous-unwind-tables get added to
files that didn't previously have it.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
