Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F3C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D7021741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QExvbQY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgBHHTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:19:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42794 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBHHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 02:19:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so673614plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jgwctlv4oTdrR8f92pQb4YhHDZt1lVlF6B/6oa0E6k=;
        b=QExvbQY9zENmzwf2XNQkmYOe6FOAm9tFA7X4oOsxdX0bmSApRMn0H2KxNgDk+0y6Gw
         sTZcLV9XR1ldJoctRe45yrlpbGAIaLyQXt8KLesGsYv6tGe3d4V54XHGaKYpAe9uRzvN
         OhD6M+w4AOceUKtAL5aBbuxvQ2As2tEyJp0b5Jfm8yVWX0Zf9O2Qo5Im1VTUpeg4wAYc
         hYF1gDrCPDXCQTmCilHoZBN4hcsZCTTy3FUz3468GmMAfnW9WU6bmU2SXVWn95XIBe2Z
         3U2tIqjDpqqK/6eOEs7HnpD7YcuUrvF49oNxrDATQHiB8AFpzvQr6WUdwmONXd/VN1Q3
         dsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jgwctlv4oTdrR8f92pQb4YhHDZt1lVlF6B/6oa0E6k=;
        b=KTAcz/49yHN07NBo8a16Y+voxYwVohQ0ec4Dc7AgTCs0RGcI0ifucCLh0ZZDLvqkGy
         6jh6IoskBoXk7JXHOkQvukPSQaeMyO2QbmGBGqHbdffuVdDcabZI/BvQzYBUpNaioJmb
         qJ766x2hZQRAEB6F9hqx/URe2ACHfzBat4XOwHyOZTMmpsir0/HsyDWh4FK4hkT+AoK1
         IHQGckOXsWcr6MmRgI4mHtQT5bat1WaQTPkm/PyY0QhnR3KmRVLPNUY7B4L8y1Dc/0Sc
         aDDLO+8ahxyv0zHNAIFgqkHZYn05v4far2PODznQVTlw4OMCF7SI8VXXsXseNYwdVdHT
         F11w==
X-Gm-Message-State: APjAAAWc7kjrtq+9tl23Lv9muhvT3ObZM9IZE8WqiXEnsYd2AZ/jxl9e
        sZICt8h7B0NepRCV2KzzjW+wc+KKL7ROL2N9Z108AQ==
X-Google-Smtp-Source: APXvYqw8xG46GGBEEWPCcwaJ/KgKqjRQuzCI+4Pk80gb8Y71tuBBhYaz6Ik2oWvedA26GyTWf5unwOzNF3ycmpGtFiQ=
X-Received: by 2002:a17:90a:3745:: with SMTP id u63mr8411017pjb.123.1581146339108;
 Fri, 07 Feb 2020 23:18:59 -0800 (PST)
MIME-Version: 1.0
References: <202002071754.F5F073F1D@keescook>
In-Reply-To: <202002071754.F5F073F1D@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 8 Feb 2020 07:18:47 +0000
Message-ID: <CAKwvOdnRhx=SgtcUCyX2ZOGATM8OzG6hSOY9wGQZcwtp+P5WBQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: rename missed uaccess .fixup section
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 3:02 AM Kees Cook <keescook@chromium.org> wrote:

Looks like we were both up late debugging this! Great job finding a fix!

>
> When the uaccess .fixup section was renamed to .text.fixup, one case was
> missed. Under ld.bfd, the orphaned section was moved close to .text
> (since they share the "ax" bits), so things would work normally on
> uaccess faults. Under ld.lld, the orphaned section was placed outside
> the .text section, making it unreachable. Rename the missed section.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/282
> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
> Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
> Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")

I was curious if the "mix" of `.fixup` and `.text.fixup` in a few
places under arch/arm/ was intentional or not. I should have
investigated that more.

> Cc: stable@vger.kernel.org
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Manoj Gupta <manojgupta@google.com>
> Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Before this patch:
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang LD=ld.lld -j71
$ readelf -S arch/arm/lib/copy_from_user.o
...
   [ 9] .fixup            PROGBITS        00000000 0004e8 00001c 00
AX  0   0  4
...
$ readelf -S vmlinux
...
  [ 2] .fixup            PROGBITS        c020826c 00126c 00001c 00  AX  0   0  4
  [ 3] .text             PROGBITS        c0300000 002000 d71964 00 WAX
 0   0 4096
....
(Which is bad since .fixup resides before _stext!)
$ readelf -s vmlinux | grep _stext
203324: c0300000     0 NOTYPE  GLOBAL DEFAULT    3 _stext

After this patch is applied:
$ readelf -S arch/arm/lib/copy_from_user.o
...
  [ 9] .text.fixup       PROGBITS        00000000 0004e8 00001c 00  AX  0   0  4
...
$ readelf -S vmlinux
...
  [ 2] .text             PROGBITS        c0300000 002000 d71964 00 WAX
 0   0 4096
...
(So there's no orphaned .fixup section).  I forget if I was just
discussing it w/ Ard or Arnd a few days ago but I think we should
really enable warning on orphan sections during link (lest we continue
to run into issues like this).

$ grep -r \\.fixup arch/arm

turns up another hit in:
arch/arm/boot/compressed/vmlinux.lds.S:    *(.fixup)

Which I think should be fixed, too, maybe in a V2 so I'll hold my
reviewed-by tag for now. (Modifying that locally, I'm able to boot
qemu, and I also don't see any object files with such a section, ie.

$ readelf -S arch/arm/boot/compressed/*.o | grep fixup

comes up empty. So it could be renamed or even removed).

We should also cc stable, since c4a84ae39b4a5 first landed in v4.1-rc1.

Thanks for the patch!

> ---
> I completely missed this the first several times I looked at this
> problem. Thank you Nicolas for pushing back on the earlier patch!
> Manoj or Nathan, can you test this?
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 95b2e1ce559c..f8016e3db65d 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
>
>  ENDPROC(arm_copy_from_user)
>
> -       .pushsection .fixup,"ax"
> +       .pushsection .text.fixup,"ax"
>         .align 0
>         copy_abort_preamble
>         ldmfd   sp!, {r1, r2, r3}
> --
> 2.20.1
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
