Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C60C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56ED22067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHCJ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:58:04 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:45096 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHCJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:58:03 -0400
Received: by mail-oo1-f68.google.com with SMTP id a9so7140773oof.12;
        Mon, 03 Aug 2020 02:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdwftEG62tf67WwZTXwWotQmRllGZsxvggFDPPsmbhs=;
        b=DE6QPBYurMz2BcHy1c31mU23UvOlWqdMa3apNDWxEbW+QvX9gm2zaZNNzA/FNfyeCf
         Y5c8TlWiA1zvok6RuWhoeVI8bz/bHgfG21VhkWdEikcVeU3VPdguf76in/SSMSu5tI+w
         2zn9eereHipLwijodTiaXhqScbXuxMiElvceYdVPwcNJbhwyDzvs14lkrvCuVI985MMu
         sifuavi4uoXk+6HveltUgeHRS7Tm6T2Fkg+QKodZVtuNLX9ElHhQP2C7TG4D0PKzloLD
         vadBpSJdxCoSbWIaI43GE7uwGLNwsojyozBRhAgI2XjBRFNUS9zWiLxsfjZblyGMKZ3R
         zUBQ==
X-Gm-Message-State: AOAM532SVu3D/DY+wadAcAtyvNZIykkT4OmtcV6/IfojYoOLT/OUzvEq
        MyCjAeR7uuu/0wzR/9LpeJZDlmimO/PBYQhNIHVYb1um
X-Google-Smtp-Source: ABdhPJyp942dhOYiRWw/Ts3ez6GHKnKxf4Kyj0csAXGvzraMsVztqRa5+R5NqTxvQCTBztJz+f8Cju+TIrThf0vMgqc=
X-Received: by 2002:a4a:275e:: with SMTP id w30mr13404242oow.40.1596448682394;
 Mon, 03 Aug 2020 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200803095048.20102-1-geert@linux-m68k.org>
In-Reply-To: <20200803095048.20102-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Aug 2020 11:57:51 +0200
Message-ID: <CAMuHMdW=tzsK=bsQHQmFAUF041XZ8-msfgNZPpKQurxq1dsjGg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 11:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8[1] to v5.8-rc7[3], the summaries are:
>   - build errors: +2/-3

  + /kisskb/src/arch/powerpc/include/asm/mmu.h: error: unknown type
name 'next_tlbcam_idx':  => 139:22

v5.8/powerpc-gcc4.9/corenet64_smp_defconfig
v5.8/powerpc-gcc4.9/ppc64_book3e_allmodconfig
v5.8/powerpc-gcc4.9/ppc64e_defconfig
v5.8/powerpc-gcc9/ppc64_book3e_allmodconfig
(fix available)

  + /kisskb/src/arch/sparc/include/asm/trap_block.h: error: 'NR_CPUS'
undeclared here (not in a function):  => 54:39

v5.8/sparc64/sparc64-allmodconfig
v5.8/sparc64/sparc64-defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (192 out of 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/92ed301919932f777713b9172e525674157e983d/ (192 out of 194 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
