Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADAC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A920692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeuT1AV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgDMSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728022AbgDMSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:20:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCACC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:20:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w11so4795406pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOnXvBD+1tH8qvIGf2uSojwZ4oLg81q4MCieLQpC63U=;
        b=oeuT1AV0ime5Fh4Rm1OT+N4p5ZprfDIRamr/sJ4vSfypoagGnjNeHMoAvTBInH8kl6
         w+vZ6BSLnN1/4u8FEXKAtpk/emslIy0rFdStcDetjHj4xedGp8HdCntv+FZxm5eKhtvs
         efuKf2pCVQOGr2QoXZ/JRNmPe0dmSoCYbdaUYZa1sAxCz/K0pXeTwoKlHl/bkeaXSLsp
         jF8vaZ1AAn+9GrlceQrjN0fnUYq7TGvgMAfgYK1mdp5VH5Vo4/MkvJmFMCv/3aoFm6CN
         1+EWzvfMTkgAJiYLzm8Wgff7B+O6d4czS2URiYRa/5KGgT+13iULt6+UB8A+845DKYdw
         LqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOnXvBD+1tH8qvIGf2uSojwZ4oLg81q4MCieLQpC63U=;
        b=FdR6FWNIxAXiNmmlF+ehweIlebKl/rrslVKtOZXNl2CsWtwMbEydx2SwW0lt/mqPiQ
         8AhvgwJRNCtW3HSahiRRt7/KMaDsxO2CIdOtz3SQmMOsqilZzd9DS7cH8M2AeBN26J68
         0oILUHpUtvzCLakkPa07Xvvz0m+Jxl7t6ngaHfBFibPWa56FIRK6+JFvYiI4ReTFh0uE
         oO8cI8GazHsOS4oibYCL+czaQsYuR4wytakUuDwZTTOzWzWtrGulUprh9UqHEyipQopy
         /jw+gcmDc8T861lOlosQpaTXjQWlMTKfDFCohFoopX2KUZeR6RseB1XhfeH0Fx7j7K9V
         /6yw==
X-Gm-Message-State: AGi0PuY1fZ0xT8dAOPXcjrLqKrFXHdufw5PXjLBiA3ACA/0+U62jE1pT
        euYoZZMjXOEvWTOTqIrNrDrJYHcs8kkhYlPHY643xg==
X-Google-Smtp-Source: APiQypJwUNJu1vlLEjikzzfaLZvsRT9M+9FSian5AttKj5c01LY2XFIqQOuHAme5EAkTGljALMbupJwwZf5FUfYE8Fw=
X-Received: by 2002:a65:6704:: with SMTP id u4mr18738485pgf.263.1586802013753;
 Mon, 13 Apr 2020 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200413020538.31322-1-masahiroy@kernel.org>
In-Reply-To: <20200413020538.31322-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 11:20:02 -0700
Message-ID: <CAKwvOdk3-o2-Zom-Ejt0HP3vn+QWBYkJo+kPNzamofc-eH-FjA@mail.gmail.com>
Subject: Re: [PATCH] arc: remove #ifndef CONFIG_AS_CFI_SIGNAL_FRAME
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 7:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_CFI_SIGNAL_FRAME is never defined for ARC.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch.  I worry there may be many preprocessor checks
in the kernel that are always true/false.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


> ---
>
>  arch/arc/kernel/unwind.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 27ea64b1fa33..f87758a6851b 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -1178,11 +1178,9 @@ int arc_unwind(struct unwind_frame_info *frame)
>  #endif
>
>         /* update frame */
> -#ifndef CONFIG_AS_CFI_SIGNAL_FRAME
>         if (frame->call_frame
>             && !UNW_DEFAULT_RA(state.regs[retAddrReg], state.dataAlign))
>                 frame->call_frame = 0;
> -#endif
>         cfa = FRAME_REG(state.cfa.reg, unsigned long) + state.cfa.offs;
>         startLoc = min_t(unsigned long, UNW_SP(frame), cfa);
>         endLoc = max_t(unsigned long, UNW_SP(frame), cfa);
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
