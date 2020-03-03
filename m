Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97EEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7A20717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZO61Sxyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCCEcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:32:54 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35050 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCCEcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:32:54 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so760060pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PAeuIw+hEri4xfaGtdCge6RjFwR9k/M6VeehKKOz2Zg=;
        b=ZO61SxyiPLNPpW1EXlXI4x/HWOeu8rffpoS2+/Bt7b2ua54SalZEEkqudi6diZIkXh
         cHuWJrfIFBFUMQECEu4k0LXTwfeayiwHTSI1Fd//oRS+ft8IegW8BxZ6m+yG/+KLbXEF
         rCmTGOMC5dQjrfF/eviJrA/wJr34l+fzh5k2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PAeuIw+hEri4xfaGtdCge6RjFwR9k/M6VeehKKOz2Zg=;
        b=uFFwGYO9LIAZ5vhL5Xz3Wk6XHK0KttTMVmgMGM81BWKdCL4k1deQ4Fku4Hv7ZuwKEW
         XFByKqbtIK9/mOECbuwZWPZYvWhRoUElh6Dunh9cch+seaU3AC0FhtGL87NPom3bVuvW
         Wlx39KIUFQ+tzd59WQNBadJg79EiD6Ise0HjCurELSARw6Ca9n2vWuT30gHuW2gMIpqZ
         vCPMAyYuBDrLTb6aCV3obzHxDPhqhv309VVhtf66iFkHxeTOfi1zTxTQC48dipwTwUHA
         MxyFuwFpl3IorVT3eaXHXDxu5i/9LveWIKOenGmDp/el0HxV7joo34F4GDXI4CGnl+mE
         uCfw==
X-Gm-Message-State: ANhLgQ1GEJDG15YQaUgRgpmKnleB4bF9qb6ELMHq5n54sNdkYzv9MUjd
        NAy2Ajxru8dJcpz9ummgNF07+A==
X-Google-Smtp-Source: ADFU+vuu87r1SlcNGnctFE2kHHSUxB6qWqCEisCd/TiEgwd8JkcqMCC9rIaYFVZCii+GL+ZBtK9QSw==
X-Received: by 2002:a17:90a:be04:: with SMTP id a4mr2011764pjs.73.1583209973125;
        Mon, 02 Mar 2020 20:32:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f127sm23298618pfa.112.2020.03.02.20.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:32:52 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:32:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Enable orphan section warning
Message-ID: <202003022029.B549AA3@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <CA+icZUVRnjOWKZynAGDniXD_H9KRccONmeKHs25DPPU1c8ZcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVRnjOWKZynAGDniXD_H9KRccONmeKHs25DPPU1c8ZcGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:51:21AM +0100, Sedat Dilek wrote:
> On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > landed), and has a minor conflict[4] with the ARM tree (related to
> > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > linker script, and makes changes to kbuild, I think the cleanest place
> > for this series to land would also be through -tip. Once again (like
> > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > this can go all together with the least disruption. Splitting it up by
> > architecture seems needlessly difficult.
> 
> Hi Kees,
> 
> is this an updated version of what you have in your
> kees/linux.git#linker/orphans/x86-arm Git branch?

Hi; yes indeed.

> Especially, I saw a difference in [2] and "[PATCH 4/9] x86/boot: Warn
> on orphan section placement"
> 
> [ arch/x86/boot/compressed/Makefile ]
> 
> +KBUILD_LDFLAGS += --no-ld-generated-unwind-info
> 
> Can you comment on why this KBUILD_LDFLAGS was added/needed?

It looks like the linker decided to add .eh_frame sections even when all
the .o files lacked it. Adding this flag solved it (which I prefer over
adding it to DISCARD).

> I like when people offer their work in a Git branch.
> Do you plan to do that?

Since it was based on a -tip sub-branch I didn't push a
copy, but since you asked here it is:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=orphans/tip/x86/boot

And this email can serve as a "ping" to the arch maintainers too...
does this all look okay to you? I think it'd be a nice improvement. :)

Thanks!

-Kees

> Thanks.
> 
> Regards,
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=linker/orphans/x86-arm&id=e43aa77956c40b9b6db0b37b3780423aa2e661ad
> 
> 
> 
> > H.J. Lu (1):
> >   Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> >
> > Kees Cook (8):
> >   scripts/link-vmlinux.sh: Delay orphan handling warnings until final
> >     link
> >   vmlinux.lds.h: Add .gnu.version* to DISCARDS
> >   x86/build: Warn on orphan section placement
> >   x86/boot: Warn on orphan section placement
> >   arm64/build: Use common DISCARDS in linker script
> >   arm64/build: Warn on orphan section placement
> >   arm/build: Warn on orphan section placement
> >   arm/boot: Warn on orphan section placement
> >
> >  arch/arm/Makefile                             |  4 ++++
> >  arch/arm/boot/compressed/Makefile             |  2 ++
> >  arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
> >  .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
> >  arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
> >  arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
> >  arch/arm64/Makefile                           |  4 ++++
> >  arch/arm64/kernel/vmlinux.lds.S               | 13 +++++------
> >  arch/x86/Makefile                             |  4 ++++
> >  arch/x86/boot/compressed/Makefile             |  3 ++-
> >  arch/x86/boot/compressed/vmlinux.lds.S        | 13 +++++++++++
> >  arch/x86/kernel/vmlinux.lds.S                 |  7 ++++++
> >  include/asm-generic/vmlinux.lds.h             | 11 ++++++++--
> >  scripts/link-vmlinux.sh                       |  6 +++++
> >  14 files changed, 85 insertions(+), 31 deletions(-)
> >  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

-- 
Kees Cook
