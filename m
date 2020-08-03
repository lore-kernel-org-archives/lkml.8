Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50A722CAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFGpIjGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgHCRM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHCRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:12:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF133C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:12:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so21069802ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdcsAD52151YFyK9GV+0dTJh1rWdO1ZkWpKqDyiylxA=;
        b=PFGpIjGn1339koZitvzVbBMuGGtmca3kJSr1WQrEN+phD/GnE9e0iYibDk906j3c3m
         O59emUPBY55iyJ/cbZJ4Za0UuDvLGr0ObmEgp3KRW3HHQWBu1oeu9hWmgsWVtVBfA6ct
         kMeGFen2EDnaZY2cPVQJXhM3RzqdF+22zmrJbhQuzbZwmUtsB9QCnVRAVwvWHZtRKafS
         I0P3VVu2OzGC2fQ8qIu7Fdu3NBKdztPegrTtcydKXmVp9mQB+TBFNiruBufTlzMCNwbC
         PeelPejcygyXnSYWML3bQjP/9dFtK4j7ljNSDe8q8J49DRBILha4+C1ShQwxFFFuCFz5
         9Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdcsAD52151YFyK9GV+0dTJh1rWdO1ZkWpKqDyiylxA=;
        b=VWU9W+NfM292zO9rFDEbUZQeUbQ1/nuG9W7dGIS6HudAvbt6MOKQAjN8eXi3RAU0md
         CX2Ih/AaZS3ike+/fNbMpNMasq8wf2vgJF+E2Gi5PpkNdqs2Jh+rvkvhKI0nJWboMNz+
         Ebs4x1tqjuI8HOT8jOxJRNEO0dbSKJFnYbyJLdXEGWRaqbbfnOIOY4zIVLu7aadTGY8A
         3gcuxP8Bzdsv0Mv6mc+PulNjjdycf45aHqTmZ1hUoyHSLl4bvz5w+vViYpS8Cei682mC
         WKncVXsjej37KSeFLD7/pJq+CSrqCD5Dut5vZ3g5Kr5Dd3iF7cf++a9l61yWmY8o6maj
         mZxw==
X-Gm-Message-State: AOAM530a+aEz7aUHgcp1tbR1V9IbgqIjEfrWQWILl/tY7kZmYisObuDV
        +FBiRdrSquy495zfVA4MwVeSyqqz3T3HsHgq5DPT6Q==
X-Google-Smtp-Source: ABdhPJw5TW7FReeEX1APXOX/ZQatH6ra4I//9QKhkV6V5458j1Hlort4tnWu/gKD9ytnrbCaJ0lx59WW3QFNYO9VQQU=
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr333409pjb.32.1596474747635;
 Mon, 03 Aug 2020 10:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Aug 2020 10:12:16 -0700
Message-ID: <CAKwvOd=o0fjh3VzdHSon+JYECjyDXO552ppGk1xk5VjsvjNtvg@mail.gmail.com>
Subject: Re: [PATCHv2] x86/purgatory: don't generate debug info for purgatory.ro
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Steve Wahl <steve.wahl@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 10:50 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Purgatory.ro is a standalone binary that is not linked against the rest of
> the kernel.  Its image is copied into an array that is linked to the
> kernel, and from there kexec relocates it wherever it desires.
>
> Unlike the debug info for vmlinux, which can be used for analyzing crash
> such info is useless in purgatory.ro. And discarding them can save about
> 200K space.
>
> Original:
>   259080  kexec-purgatory.o
> Stripped debug info:
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
> Cc: kexec@lists.infradead.org
> To: x86@kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---

Thanks for the patch! One thing that can be handy for reviewers (but
isn't strictly necessary) is to put a comment about what changed since
the previous version below the above^ `---` line.  By putting comments
"below the fold" you can pass along information to the reviewers that
won't wind up in `git log` when committed.  Not strictly necessary,
and less so for smaller patches, but hope this helps.  (No need for a
v3 over that).

>  arch/x86/purgatory/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 088bd76..d24b43a 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
>  # make up the standalone purgatory.ro
>
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
>
> @@ -64,6 +64,9 @@ CFLAGS_sha256.o                       += $(PURGATORY_CFLAGS)
>  CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
>
> +AFLAGS_REMOVE_setup-x86_$(BITS).o      += -Wa,-gdwarf-2
> +AFLAGS_REMOVE_entry64.o                        += -Wa,-gdwarf-2
> +
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
>
> --
> 2.7.5
>


-- 
Thanks,
~Nick Desaulniers
