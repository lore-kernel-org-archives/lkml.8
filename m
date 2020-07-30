Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3837820809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqeC961W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgG3XLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG3XL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:11:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:11:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so4980610pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6t51k6uSisSjBlEUy+Di3TVdJhxEYeHUBTv0q9IOTFI=;
        b=uqeC961W2dYdHubhyaW7T4dKd9uxNBe1lhPt5U3EsINvDx4it+Cu3Iea6tTpnrwyS/
         ZdRcekgTxtobE2OEf2fpfFai2VTWD3vPo1oi7g/8BagUpImM9lF8Y/5swNjtjWnsoSJK
         n1NNQdxWNyxc4cJz2CztbBCWCMrmDoMBc7g6dUUDdnaZX1rSaR6Jd7ACeLFsMd0Wf4Q7
         yMQYxbUN1dlH1zoTKPwbUlBv+xI/+Ssp+dWB3tldxxNrCClcTxjT9lVnqI9T5wwYDf7B
         odvfVTDGxA1eG/X1/0+DlZWyH+8ypkOTD9uhp7/k57Pcq6h80BPp66sn/PcghWmj+9dT
         jQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6t51k6uSisSjBlEUy+Di3TVdJhxEYeHUBTv0q9IOTFI=;
        b=rFl2E0F1vztduvEJf4CSMjeZdqbyNKpviA81EdKPPFYAG/6s4VN+Gkb/nqES+NsVbd
         Y98rsUSa1iIPDXFj3i2qBIexuTCcVzLwNvO3wLA7R1Mfa/T5ezLjsWP2yIJRLt5UosZY
         jHxm7muXUlvW6euDyIYY9RKDve6aRk+oMeyWSTLXg69zLodvkO/A6bYa0y+BuY1w/Exa
         3/tBOod4TzVkH52NNcI8Xp0ocwtG2KrcOJJ81SvbudOyeow6/EZ2ZNBp6vqf5NmQzKiX
         IDhTe21/omGavfInKuQzxPVRhXN/DqOVckEF5XuQyVCVMq37ExTVPlzLpCJKFijr5a0y
         zTlQ==
X-Gm-Message-State: AOAM530xwfR9Qij+JNVRRwCkiKSg35c0GRvoQrrnRsAp7+5OEm5z+UYz
        2hK5An85W7oRGfKsBRqNDfRMBvZsEqMR1TVKN377Mg==
X-Google-Smtp-Source: ABdhPJxOXUHEhdJmgD2vJNKg2CqnnTND2jUDZdgdMHH/tX+1QJi6yXHLd798pxNr7ouI5IIeLVTjMTkKFk3cVZE07Pc=
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr1390615pjb.32.1596150688580;
 Thu, 30 Jul 2020 16:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1596097609-14118-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1596097609-14118-1-git-send-email-kernelfans@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jul 2020 16:11:17 -0700
Message-ID: <CAKwvOdnThb=Sv2v1K3w0DAJBZFiEp2Z0Y=NbQ9kEuK1nsQqJBw@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: strip debug info
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Steve Wahl <steve.wahl@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 1:27 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> It is useless to keep debug info in purgatory. And discarding them saves
> about 200K space.
>
> Original:
>   259080  kexec-purgatory.o
> Stripped:
>    29152  kexec-purgatory.o
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: linux-kernel@vger.kernel.org
> To: x86@kernel.org

I don't see any code in
arch/x86/purgatory/
arch/x86/include/asm/purgatory.h
include/linux/purgatory.h
include/uapi/linux/kexec.h
kernel/kexec*
include/linux/kexec.h
include/linux/crash_dump.h
kernel/crash_dump.c
arch/x86/kernel/crash*
https://github.com/horms/kexec-tools/tree/master/kexec/arch/x86_64
that mentions any kind of debug info section.  I'm not sure what you'd
do with the debug info anyway for this binary.  So I suspect this
information should ok to discard.

This works, but it might be faster to build to not generate the
compile info in the first place via compile flag `-g0`, which could be
added `ifdef CONFIG_DEBUG_INFO` or even just unconditionally.  That
way we're not doing additional work to generate debug info, then
additional work to throw it away.

> ---
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 088bd76..4340ae6 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> -PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
> +PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib -S
>  LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
>  LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
>  targets += purgatory.ro purgatory.chk
> --
> 2.7.5
>


-- 
Thanks,
~Nick Desaulniers
