Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A99BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C55C2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584149590;
	bh=hvlO78c2V/JX/kWnlF1FKeekfMwSsbRadTsBU6fgMAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i+9kGCfiqrAYcvMMVPHtO3Mp186Z/Rxhc2b0zSv82bQ30X9ihjyhfMR125tlG3dxZ
	 It9LIAi/O7ezuhDizW6lojPKIy6Lq1gOTiBGy9Q1Y7pUIVBdKzbWeUC3ZXMlrZlY1e
	 XRue5nxIzCmrmlUzhi0E2NC3a+UvOLouHdd5eJ28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCNBdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:33:09 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59928 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNBdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:33:09 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 02E1Wspc029135;
        Sat, 14 Mar 2020 10:32:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 02E1Wspc029135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584149575;
        bh=aecj5qoz+QO3oCVXQl613LJGjLAsLDhInCVgRky/Qn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e8UJRae1OkDD8N1p4kaFVrZD8m2Rhoj46ZtgkpNKOr8m3DsOtRM40jgTFcXBwJVlN
         rpsHbLd0sr6mWBPexB0/dUnKvmD+nrT1x0ydtRDqShK5cZoJXnrK+Z2SlUEQ91F9A4
         Y7Ur5f9nACLtjq5uZqsdV0Yt3aaKEsat2iBuIoZrj4mDld89undcenDhAetZT55nM6
         i2Z3EHgSomTgbheZFEn3ktQ/AXxdu9mfKgNfsH69ybXMkeXBlYu5HEeAvLyoarv1KH
         I9gHPZeWnAw2AD2hLHI/GcKTXRqOU0FCkT5YU0MKn/fhgWvXccQwIe7Xd1a5knOZS3
         tsO2DmDTsXQXQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id o16so4373273uap.6;
        Fri, 13 Mar 2020 18:32:54 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0bmionYd3wGZ5L0uHb0Wsd1fMShCnvTv+IEzQjtsdKyzVdJoja
        rNvuEicScyULXL4XQVo4ibk6gduxk3RkQVlZ99U=
X-Google-Smtp-Source: ADFU+vuhkX/B0QFmFUHk6fw4un08xfDVdxVGrjON9vYm2FvfthDPaom+E25E07SlC8TXdF936i2sfALZjqc6u7Yxj2Q=
X-Received: by 2002:ab0:25c8:: with SMTP id y8mr10653606uan.95.1584149573443;
 Fri, 13 Mar 2020 18:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200308073400.23398-1-natechancellor@gmail.com> <20200311194121.38047-1-natechancellor@gmail.com>
In-Reply-To: <20200311194121.38047-1-natechancellor@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Mar 2020 10:32:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdzfR6iewpZY8z4Ln8tN8GxNxgnzk2tPsOBn2v4ZJvwg@mail.gmail.com>
Message-ID: <CAK7LNASdzfR6iewpZY8z4Ln8tN8GxNxgnzk2tPsOBn2v4ZJvwg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Disable -Wpointer-to-enum-cast
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 4:41 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang's -Wpointer-to-int-cast deviates from GCC in that it warns when
> casting to enums. The kernel does this in certain places, such as device
> tree matches to set the version of the device being used, which allows
> the kernel to avoid using a gigantic union.
>
> https://elixir.bootlin.com/linux/v5.5.8/source/drivers/ata/ahci_brcm.c#L428
> https://elixir.bootlin.com/linux/v5.5.8/source/drivers/ata/ahci_brcm.c#L402
> https://elixir.bootlin.com/linux/v5.5.8/source/include/linux/mod_devicetable.h#L264
>
> To avoid a ton of false positive warnings, disable this particular part
> of the warning, which has been split off into a separate diagnostic so
> that the entire warning does not need to be turned off for clang. It
> will be visible under W=1 in case people want to go about fixing these
> easily and enabling the warning treewide.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/887
> Link: https://github.com/llvm/llvm-project/commit/2a41b31fcdfcb67ab7038fc2ffb606fd50b83a84
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---


Applied to linux-kbuild.
Thanks.


>
> v1 -> v2:
>
> * Move under scripts/Makefile.extrawarn, as requested by Masahiro
>
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index ecddf83ac142..ca08f2fe7c34 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -48,6 +48,7 @@ KBUILD_CFLAGS += -Wno-initializer-overrides
>  KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
> +KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
>  endif
>
>  endif
> --
> 2.26.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200311194121.38047-1-natechancellor%40gmail.com.



-- 
Best Regards
Masahiro Yamada
