Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA20C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE49520733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585550614;
	bh=wqUgt38gg5HIIrdOfYhQnYLsZkcBfgRXxZOQ5Vaw7Ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FJmpGrPwiUL3yPmEgh5owUlW7N2QUmwKdxWoeMYeurYT2eXtVDtAQ6TnxmJUCH/cJ
	 LfhvjtkFvodgz6FNW1gUv+9XcFo/0vdEzBuaVNCGVIYFMWBQgpnXByOXH8b7qir7ym
	 uLI6KP5uIb43I7TNFkcaGe0wl/0UrU/t5Lif8eOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgC3Gnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:43:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61095 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3Gnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:43:33 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02U6hMeB020321
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:43:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02U6hMeB020321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585550603;
        bh=fe5stnF90OOGGE2G27nsV+KSX6+hF2P4th86HquOIOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pd1AmFvXiB8K7/u4rqX+CK7xZMIuBJQwsP05SgIoFokundBYKupb9RGS96T4winI2
         YnrZ2vqkrA+u/2muft0V12ElfL8pOeoF5+Z/rrn1jRrVDoYOVf1h6F3IM/m0I8xRfx
         bnUR6QE1P1XbQQ9vaz2cdHSaJ4xCEhLEElquyjo5Bh7ieoZ28VflcNAj4zmY0S8oTb
         S7bNBcJBLbpqOvoAYCvGjtsibPDR1lHCZ34nR2ZqfcAsX8Zk1g6G4jFRTgLsdpb38L
         KXRQ90EvJ08DDnDqWxzL/JsGmcdZ07SGYs6c0vl1ZAEGecZH/5DH1X1kgFEP338cZD
         e/ZkoTFLheDcg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id y138so10310947vsy.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 23:43:23 -0700 (PDT)
X-Gm-Message-State: AGi0Pub2JCWrD2mWuSkWsHDh50Bd/HdQU8diYKGkfyBj5FT/e0mklAW3
        tCLAA2o94siTg2IesMf9tsJ9Hb1NbLACqNBoFpU=
X-Google-Smtp-Source: APiQypKULmtvRpyh2fbQtHY9lBpL/FB1uBtWrlg/BI7wTbjTHci8OIk7fTx1FbRj/OaQ4dAHjbYzFtJgewIXXwBca+Y=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr7151865vsz.155.1585550602488;
 Sun, 29 Mar 2020 23:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200215063241.7437-1-masahiroy@kernel.org>
In-Reply-To: <20200215063241.7437-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 Mar 2020 15:42:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5Lt6X98+B4iADYpyG7YcJoTHZkKQ1==5B0UkAuO4uCg@mail.gmail.com>
Message-ID: <CAK7LNAQ5Lt6X98+B4iADYpyG7YcJoTHZkKQ1==5B0UkAuO4uCg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/build: add cpustr.h to targets and remove clean-files
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ross Burton <ross.burton@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 3:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Files in $(targets) are always cleaned up.
>
> Move the 'targets' assignment out of the ifdef and remove 'clean-files'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


This is not a big deal, but let me ping just in case
you missed it.





> ---
>
>  arch/x86/boot/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 012b82fc8617..050164ba3def 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -57,11 +57,10 @@ $(obj)/cpu.o: $(obj)/cpustr.h
>
>  quiet_cmd_cpustr = CPUSTR  $@
>        cmd_cpustr = $(obj)/mkcpustr > $@
> -targets += cpustr.h
>  $(obj)/cpustr.h: $(obj)/mkcpustr FORCE
>         $(call if_changed,cpustr)
>  endif
> -clean-files += cpustr.h
> +targets += cpustr.h
>
>  # ---------------------------------------------------------------------------
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
