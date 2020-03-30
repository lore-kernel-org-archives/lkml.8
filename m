Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D42120733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585550495;
	bh=Zu9yp62WptmgXEhQMPQmYRvVsIZKsk9X8lV11qCG+KM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QpkV/mjZvELYYEazGhmovQvXhu0ZRF5snnVUaVw1B+N+qKC+na2PybsX5XhOs9Qci
	 HR8prXJIwLwZLUXIJtVdtgNv5cyQlstZ2Is3hwcIuZBOlCF/mGIDXRfi0G+nLDpoE9
	 DX6eigzLNKDq1/xE3QFmNljc5dxgbfBDIzHxlNfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgC3Gle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:41:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57424 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgC3Gld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:41:33 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02U6fTkP018916
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:41:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02U6fTkP018916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585550490;
        bh=MnXwOK+aGKqmNuthI8wpTUrpEqT5c0OsIW156GHkhlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NyTNfxwPiX8CeF2Boo+Z588OUQU0AeuYSMVtpDFx08E5uNfvJ5rrfOP1S0PXrddrw
         5Jxm9lnAZiI1+Fz69BpRWpyqgVmxeVZZA0PwW1T4Y5PveuH6KBrcM6pRKmoBzeH3T7
         mba6bmCc72L7SRGsD8Iv8cOI/BBdTI5iOhp0NbL2wWc+6ju5QWIdgo8RITeQrYM86F
         /qVhzuppNEHU/YVutMwn1XMdHejdFVZSX9JJgFdlJQr6UgdYIPUaa5zXrTfoi5LXXO
         0ijuX6i4ioqQ3xHEVUx13Tw8lCBjHUKwOYooVRXKjaBUqzfD7FEdMtDwl0PCQ1BlcL
         bqhBP0M6cYl0g==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id b5so10345965vsb.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 23:41:30 -0700 (PDT)
X-Gm-Message-State: AGi0PubGF121VYWao+A4oYsVBvYITHFNNizT0A9eDLXJcme4a0doSvDB
        Qq4cuN3ovDNQv7jELyeYXuDwHRy8rtCtyPts99U=
X-Google-Smtp-Source: APiQypJUFcPYVriKtO2g1PujBWTTu55R1FYI7eYQeKAoVGy3JEmKY4PO4STxent8ZR3Iz7DwCMakJNEP+djedCPuLSE=
X-Received: by 2002:a05:6102:21c7:: with SMTP id r7mr153018vsg.181.1585550489071;
 Sun, 29 Mar 2020 23:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200215063852.8298-1-masahiroy@kernel.org>
In-Reply-To: <20200215063852.8298-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 Mar 2020 15:40:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRxmQnXHSbaW4DG_WOe+yXwU7sm0PGSpoPeZxtiaNckw@mail.gmail.com>
Message-ID: <CAK7LNAQRxmQnXHSbaW4DG_WOe+yXwU7sm0PGSpoPeZxtiaNckw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/build: make 'make bzlilo' not depend on
 vmlinux or $(obj)/bzImage
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Feb 15, 2020 at 3:39 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> bzlilo is an installation target because it copies files to
> $(INSTALL_PATH)/, then runs 'lilo'.
>
> However, arch/x86/Makefile and arch/x86/boot/Makefile have it depend on
> vmlinux, $(obj)/bzImage, respectively.
>
> 'make bzlilo' may update some build artifacts in the source tree.
>
> As commit 19514fc665ff ("arm, kbuild: make "make install" not depend
> on vmlinux") explained, it should not happen.
>
> Make 'bzlilo' not depend on any build artifact.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Ping.
Can you pick up this series?

Thanks.


> ---
>
>  arch/x86/Makefile      | 6 +++---
>  arch/x86/boot/Makefile | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 94df0868804b..a034d7787b7e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -267,7 +267,7 @@ drivers-$(CONFIG_FB) += arch/x86/video/
>
>  boot := arch/x86/boot
>
> -BOOT_TARGETS = bzlilo bzdisk fdimage fdimage144 fdimage288 isoimage
> +BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 isoimage
>
>  PHONY += bzImage $(BOOT_TARGETS)
>
> @@ -288,8 +288,8 @@ endif
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $@
>
> -PHONY += install
> -install:
> +PHONY += install bzlilo
> +install bzlilo:
>         $(Q)$(MAKE) $(build)=$(boot) $@
>
>  PHONY += vdso_install
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 050164ba3def..1b37746aab82 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -144,7 +144,7 @@ isoimage: $(obj)/bzImage
>         $(call cmd,genimage,isoimage,$(obj)/image.iso)
>         @$(kecho) 'Kernel: $(obj)/image.iso is ready'
>
> -bzlilo: $(obj)/bzImage
> +bzlilo:
>         if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
>         if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
>         cat $(obj)/bzImage > $(INSTALL_PATH)/vmlinuz
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
