Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E14C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166C2206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A//evzdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgDGRWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:22:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:22:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so1098104pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WtbWNWaVQeVcZQhFvV6urZvQa34yJxf2HAD/pRyZ2g=;
        b=A//evzdq82feuNT1S0w8k6MnJEEgUVxfRf/ZPEKgZFogbwDEvZLLPyDFNw0npeOZE5
         aRr9ZB2Ag7cqmATU1j0bo3Wsr9iuVhfezrnQhiBXKR5Qn3cayuIJw4byB9yoMTOHeK9m
         xmG1Lm1Str+uHFCOq12fN/67aoXI6Zue8Qz8W4KcZUHv34DKYKYFue+/y+eFMX4/QnpY
         VH3napxV2cFMjS4+29S9lFxw3fYj3Mqn+9ZltSjfk93fVTAIPfDgl0YX3Ig0I0pfOUcj
         ge/euJffA/n7846Mso1XK6t30DA3z/YmMYCscvFdHLmRYcxL8lWrHs92/hQ1YPhyw1HC
         OCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WtbWNWaVQeVcZQhFvV6urZvQa34yJxf2HAD/pRyZ2g=;
        b=astr3DqI8HtKTbq3DgiGwRG8bp0GgNdY/wMUweD8UTwZhNWiwWwBhn0I48S9KL/zRv
         BEM1/MfHdY5aOr7r9LraT2rgFU9xcfDnr2x9NXJ8aUctXIly0u6islh8P7WtlitDssh8
         1Gaq+LsrSKiMMzl+CAD7ZyYFNjGUyaWryc9xP4JFI2sOklBj21XQ7C3E2bdzI3kF4GLr
         3nJ5doM1nxRE3TcYTPydYV9MM8GL1OULLj08RQ+/ezZ6vZQkoHQ4lLpRlvkc/dtPpUlD
         yl/Uhgs8/6guOF7u6GbTGSZmy9VtPp9i5Wd4aTOYc5H+lD1acCKBauSgbHU/zNWW2UNG
         IIOA==
X-Gm-Message-State: AGi0PuayJYu04z9yMLcyTfKG0p+FCaTKFJriyvJDSUm2TOtthfS40Kd+
        W3bVX7LAlmmTOLv8YZIHXo2pUEJvBSfHPaASKU4zrA==
X-Google-Smtp-Source: APiQypLXNlv4R/y81mJvIDWONLy09l47bJvWAJxTsJ2LurRhrn59gKhDUZpgjh+oTtE6x5UfRKdwrsuFsD2nb78XCSQ=
X-Received: by 2002:a63:6604:: with SMTP id a4mr1741195pgc.381.1586280128643;
 Tue, 07 Apr 2020 10:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200405082451.694910-1-jiaxun.yang@flygoat.com> <20200407080611.859256-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200407080611.859256-1-jiaxun.yang@flygoat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Apr 2020 10:21:56 -0700
Message-ID: <CAKwvOd=Upj_OcrhBnqf1=woCRm-g2wqjv882R0HQeMJu12Uq9w@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Truncate load-y into 32bit for 32bit kernel
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:07 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> LLD failed to link vmlinux with 64bit load address for 32bit ELF
> while bfd will strip 64bit address into 32bit silently.
> To fix LLD build, we should truncate load address provided by platform
> into 32bit for 32bit kernel.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
> --
> V2: Take MaskRay's shell magic.

V2 is way too clever, V1 was much more readable.

Can this tag be added to the commit to help us track when and where it lands?
Link: https://github.com/ClangBuiltLinux/linux/issues/786

> ---
>  arch/mips/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e1c44aed8156..f8fd3c39fb55 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -286,6 +286,9 @@ ifdef CONFIG_64BIT
>        $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)
>      endif
>    endif
> +else
> +       # Truncate address into 32-bit
> +       load-y := 0x$(shell echo "$(load-y)" | rev | head -c 8 | rev)
>  endif
>
>  KBUILD_AFLAGS  += $(cflags-y)
> --

-- 
Thanks,
~Nick Desaulniers
