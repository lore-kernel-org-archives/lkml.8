Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B77A2072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9NwDt3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbgDMXhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727839AbgDMXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:37:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A1EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:37:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so5196825pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMPIRjn0PE7jnqkkSuf3FQb+qv7klZT/6x17CMWdL34=;
        b=d9NwDt3IHShJ2ZFMU0WdEcCis4G+93NeL33oosLAJ0QBuuU2m6PWo3KMjSfpLJlU4I
         t06sp32EumYZEhSVDRcWGyPkyeetQP8+MvbdwRXYykzoH3+AITWvVP64YO93bwnOJxLF
         D5KfnhButbLosSN8/qU629tHEf6ViakscnvvxpZ3hhQXplpdLVNheOPeHCaq8xhmjbzn
         s6Z9ObCL9VQ4ioIaVHFzpurAEI0OZDQEdMmeCPFrIo58ZFT/7Xe0wdFRaU5Vdi3dQhlc
         rYQcrSsUKZOdKvzTe+NmJgyRZz7G74rogHaSGx7C4MrN6k8npbyfw+gF6whUx0hQek9X
         eQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMPIRjn0PE7jnqkkSuf3FQb+qv7klZT/6x17CMWdL34=;
        b=BaTPtu9NG5Fg2c7j4bJGj1CUziAn70yLYBnY9lpfqydrd3VjcB9qPaBr4HxUQwVJJx
         TlJ0+WOp6o3u+AbqmQ9uIVDu7FmPDw7A/Jk+VqryykgLYtnSQPpySH4KuCwEFRQKWqX+
         aUYQ0I2WCb+1LYZH1bcEA+C0C5LTikmNuRHPzCz1Wz+/CKU53eBSZM6eSQjh4nfa7ycM
         tHKnXgk6NfUE2KN2lEMH57KX6qPzSuucYa5bRQZob4mEi0AjAXLRvnj0Pf/4xpOl7IRh
         D3S1ziPTuKEmZtRM2TKs7BZWrgG6NsEz0JWVrLk0lc4ccLEHex43V3OeOnbXa+kAG35u
         mD/Q==
X-Gm-Message-State: AGi0PuYkZqZm+ExTefMK2qOtWGb+2bZdYdIL8C6j6/+8ZZeepJDSuVsF
        aIB2nRZAxhg5wO4s5ga4+ZpH7Q8w3c+G/C/EXodCBtXTfnw=
X-Google-Smtp-Source: APiQypIIArEcMtBa+6lU3ecAVeDtyJ9+R/7AtvwXV6mkhFTgICAF71cY/Q7KBQ2W2N1aHsHsV6yeVXwI/BROaWewvSM=
X-Received: by 2002:a63:6604:: with SMTP id a4mr18265124pgc.381.1586821042616;
 Mon, 13 Apr 2020 16:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200413231016.250737-1-maskray@google.com>
In-Reply-To: <20200413231016.250737-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 16:37:10 -0700
Message-ID: <CAKwvOdn35v5LkvhWugfLmK_FjVsd0RdPtBCRSqVaM9EP_1KU7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: kvm: Delete duplicated label: in invalid_vector
To:     Fangrui Song <maskray@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 4:10 PM Fangrui Song <maskray@google.com> wrote:
>
> SYM_CODE_START defines \label , so it is redundant to define \label again.
> A redefinition at the same place is accepted by GNU as
> (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=159fbb6088f17a341bcaaac960623cab881b4981)
> but rejected by the clang integrated assembler.
>
> Fixes: 617a2f392c92 ("arm64: kvm: Annotate assembly using modern annoations")

Thanks for the patch!  I think a more accurate Fixes tag would be:
Fixes: 2b28162cf65a ("arm64: KVM: HYP mode entry points")

With this patch applied, and your other arm64 integrated assembler
patch (https://lore.kernel.org/linux-arm-kernel/20200413033811.75074-1-maskray@google.com/T/#u),
I can now assemble arch/arm64/kvm/.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> Link: https://github.com/ClangBuiltLinux/linux/issues/988
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/arm64/kvm/hyp/hyp-entry.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> index c2a13ab3c471..9c5cfb04170e 100644
> --- a/arch/arm64/kvm/hyp/hyp-entry.S
> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> @@ -198,7 +198,6 @@ SYM_CODE_END(__hyp_panic)
>  .macro invalid_vector  label, target = __hyp_panic
>         .align  2
>  SYM_CODE_START(\label)
> -\label:
>         b \target
>  SYM_CODE_END(\label)
>  .endm
> --
> 2.26.0.110.g2183baf09c-goog
>


-- 
Thanks,
~Nick Desaulniers
