Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45BC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31DB20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgLHd9z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBXVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:17:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40034 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:17:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so298210pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n81gtXjw+2ieZ/bEPe6r6jWFZXVIieracfuZrlD29fQ=;
        b=CgLHd9z6q/Tw2VVqGIzOmXdtrGyMfkzCVFkTje/+lwlipv7xNGkMEobT1OkO+hBkdz
         BD1aLja4Fz+Q/QGduWjDes6hjM9u0Tyq/HidcqF55LwA1I6nwwQfb3a53vZFI1yk/3S/
         UBWQKkm3eUUDRwi6duYuNlA3omDHYAUk4ghfRUHCoQWHDBFQfoiM/8IyWOFdfF2EpOTb
         l2dQE7K+L5eQqoGEqBV+jJs8oCbNRTIpxov5ocIx1tMvwMfWeDLick6SNk7nqGruK36y
         vnYfAj7XhTHOelT/rY5/fZ7WbL9h43G+XyTzLUfnNm8Loege901tsitxia4BCNsDILPi
         2Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n81gtXjw+2ieZ/bEPe6r6jWFZXVIieracfuZrlD29fQ=;
        b=NgR4APn8tvI7SzJCAPbU6TD7x7Q+K7O6SPwfVwPE9h06eNpJgE1APKd4f2nXzSWnuV
         nwNI2+B04BNUG+NuYiU55G6uEDdACTStV6MM88jMiOWP6IObfWtI/RDagCbmS1twM9Jt
         rRGRywAdOdeJW8zMaw7Pc0JAKNBgxavRTitVIe7PdAPo567E6b6sRyS/KmwB1HZfAgbo
         tZUqNz6+xz/smj0WT6bENNsjVudHzfuSCBh759NjfKuzKGLQmWHOWApqo3H36dhZsGxV
         DrSE9uj5akkFwufjTyhj+cnPeEb3PHzxf0MMWCw+GplfkWL5mw373JGqsgc2FXiji2oK
         aiIg==
X-Gm-Message-State: APjAAAWS9EBi5YkKAyz2Fmyo7s8U0NgEJ5Jv/smWpk2rWm/8BbLCTvOX
        onsxQd/C+V7RIKEutfFv4MSgMFhXcZzyX+m8WH6PNA==
X-Google-Smtp-Source: APXvYqxzji5ltSVF1Fo1ff9m3UiqfbktF3Qiwd2fLorP8+GGZ64znuXUDXqul8W35+58uHKjJtQACHza1+uzdEeOC1E=
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr1149344pjs.73.1582579041319;
 Mon, 24 Feb 2020 13:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-2-nivedita@alum.mit.edu>
 <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
 <20200224210522.GA409112@rani.riverdale.lan> <20200224211209.3snqf7atf5h4ywcr@google.com>
In-Reply-To: <20200224211209.3snqf7atf5h4ywcr@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 13:17:10 -0800
Message-ID: <CAKwvOd=4YAj1yzncXeyDvw4ghuPCHNYU0NMGnYEDwKNozcm-uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:12 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2020-02-24, Arvind Sankar wrote:
> >On Mon, Feb 24, 2020 at 12:33:49PM -0800, Nick Desaulniers wrote:
> >> On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >> >
> >> > While discussing a patch to discard .eh_frame from the compressed
> >> > vmlinux using the linker script, Fangrui Song pointed out [1] that these
> >> > sections shouldn't exist in the first place because arch/x86/Makefile
> >> > uses -fno-asynchronous-unwind-tables.
> >>
> >> Another benefit is that -fno-asynchronous-unwind-tables may help
> >> reduce the size of .text!
> >> https://stackoverflow.com/a/26302715/1027966
> >
> >Hm I don't see any change in .text size.
> >> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> >> > index 98a81576213d..a1140c4ee478 100644
> >> > --- a/drivers/firmware/efi/libstub/Makefile
> >> > +++ b/drivers/firmware/efi/libstub/Makefile
> >> > @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
> >> >                                    -mno-mmx -mno-sse -fshort-wchar \
> >> >                                    -Wno-pointer-sign \
> >> >                                    $(call cc-disable-warning, address-of-packed-member) \
> >> > -                                  $(call cc-disable-warning, gnu)
> >> > +                                  $(call cc-disable-warning, gnu) \
> >> > +                                  -fno-asynchronous-unwind-tables
> >>
> >> I think we want to add this flag a little lower, line 27 has:
> >>
> >> KBUILD_CFLAGS     := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> >>
> >> so the `cflags-y` variable you modify in this hunk will only set
> >> -fno-asynchronous-unwind-tables for CONFIG_X86, which I don't think is
> >> intentional.  Though when I run
> >
> >It is intentional -- the other case is that we're building for ARM,
> >which only filters out the regular KBUILD_CFLAGS, so adding the flag for
> >it should not be necessary. The cflags for ARM are constructed by
> >manipulating KBUILD_CFLAGS. Besides it may or may not want unwind
> >tables. 32-bit ARM appears to have an option to enable -funwind-tables.

Ah, right the `subst` from `KBUILD_CFLAGS`.
Are there other architectures that care about EFI beyond x86 and ARM? IA64?

>
> clang (as of today) has not implemented the
> -funwind-tables/-fasynchronous-unwind-tables distinction as GCC does..
> (probably because not many people care..)

Ah, thanks for the clarification.

>
> >>
> >> $ llvm-readelf -S drivers/firmware/efi/libstub/lib.a | grep eh_frame
> >>
> >> after doing an x86_64 defconfig, I don't get any hits. Do you observe
> >> .eh_frame sections on any of these objects in this dir? (I'm fine
> >> adding it to be safe, but I'm curious why I'm not seeing any
> >> .eh_frame)
> >>
> >
> >You mean before this patch, right? I see hits on every .o file in there
> >(compiling with gcc 9.2.0).
> >
> >> >
> >> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >> >  # disable the stackleak plugin
> >> > --
> >> > 2.24.1
> >> >



-- 
Thanks,
~Nick Desaulniers
