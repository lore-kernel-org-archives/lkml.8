Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C72E20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592891954;
	bh=3dxpZGLI2V6Q6CK7y9l4OGb8tt6RpGJtQyEDXKundcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MsSAcS4pYmqCPAAmCD81TU7wlOMBbQh4XVMRRYarVJoZQzYfVE3Nigqfq36zVwE54
	 RDVwK3cNBqig6W04eAZ4N0CULDmGABJwRSJM8qvj74uq/rtO9SgihicXrjZwM2r7gM
	 +ROYnmMpkoyRLfNs7UqMv/aSYOYEzDrqfjXt9a3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgFWF7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:59:12 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57576 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbgFWF7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:59:12 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 05N5woOv020265
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:58:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 05N5woOv020265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592891931;
        bh=LA4ny58y0i74llSePJcU8nuoH07ULbozGJ0bUmLWE40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nfX6QL33WKznkuWjn9JPy62OyjuN4GLKzbLmtV2VE4puMiNuE7fM1BWGpNCms/kQU
         eVEpZ/NilSB7136KQfBP7xGFuhdxa5lEldl46LAIzC51ptvssRy3JaJuSoMFCyjqL+
         2IS3Vp3B4dbZQBlUBWe33qFkxtwpkAPuafABBnPXOkanUcU9vSOBvLVPd2tUVy+bJ1
         Y+iwsshwRyMAqiNtNAp2sVCQm9vmx6TnZbyFva2zGoci2kk+8cMLib9jcStM+ovh+s
         eJ9VM1r5doZ83JjDSiz0mcjIvpLoj4Qiu7mPK5zeZx/Orko8mvdg/070Oq0qCNLd/I
         wtWZq7wyeS5xg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id r11so11022339vsj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:58:51 -0700 (PDT)
X-Gm-Message-State: AOAM5314gYdhVJ3eYfNSNl5sqnH7VzFgwvKe3mvHXLpHNYJbu/PJwKBQ
        JkH4wickwcjPF7II36LeOCPwi56s5d5vC5NPrMs=
X-Google-Smtp-Source: ABdhPJxIl9TBqYxECGihhhrT4EIIDg9mJe5kwB1bEDy64w6rrMl0ElPLV+X+EPFjQEjmBhQkuKczqGQLzcq+GjbRv1o=
X-Received: by 2002:a67:2d42:: with SMTP id t63mr17469610vst.181.1592891930200;
 Mon, 22 Jun 2020 22:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200622154512.82758-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200622154512.82758-1-luc.vanoostenryck@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Jun 2020 14:58:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATu_vCFr1n7KRpxv0Q3RQ6hGRrNzTyD437GiSm57tRUWQ@mail.gmail.com>
Message-ID: <CAK7LNATu_vCFr1n7KRpxv0Q3RQ6hGRrNzTyD437GiSm57tRUWQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: run the checker after the compiler
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:47 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Since the pre-git time the checker is run first, before the compiler.
> But if the source file contains some syntax error, the warnings from
> the compiler are more useful than those from sparse (and other
> checker most probably too).
>
> So move the 'check' command to run after the compiler.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Applied to linux-kbuild.
Thanks.

> ---
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2e8810b7e5ed..7ba6a752d5bd 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -252,9 +252,9 @@ cmd_gen_ksymdeps = \
>  endif
>
>  define rule_cc_o_c
> -       $(call cmd,checksrc)
>         $(call cmd_and_fixdep,cc_o_c)
>         $(call cmd,gen_ksymdeps)
> +       $(call cmd,checksrc)
>         $(call cmd,checkdoc)
>         $(call cmd,objtool)
>         $(call cmd,modversions_c)
> @@ -277,8 +277,8 @@ endif
>
>  # Built-in and composite module parts
>  $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
> -       $(call cmd,force_checksrc)
>         $(call if_changed_rule,cc_o_c)
> +       $(call cmd,force_checksrc)
>
>  cmd_mod = { \
>         echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
>
> base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
