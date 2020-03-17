Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2278C5ACD7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 23:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58FD206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 23:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUMPbzAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCQXLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 19:11:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37107 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgCQXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 19:11:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id 3so4943275pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=655SZyZ4kTa0wHYVMzoiHvAnRif4SDxsc5wkKB6CdU4=;
        b=eUMPbzAqzrqQXlybEnzx167u/1i1iSQsa7u7QfhXmBEvhSkw8D+L0/TR8sOAEwOfIg
         XuAaujrRbieGgO0/qr+EvIWua1i6z8ZvoplH1M5dXL6LAPgDXaFFCLzr41m0i1ZHiWWz
         H8U8U9DHtdBdgdQ/u2EWN1hOn5e0xjJuGohPBJKgDSKjH7w95GZBs/sOWTTDXco39T2t
         cTP631HOxnCKgBY+Cv74mEaRxLg85+5Wv62YbfVHxZKll7CsMkCz3CTTEsteQhDOee23
         v474oNfv+rwexWppcw+5NzUx5z7W9BU+O4T233jnqRISbv9YLBcCTH2ByBQyKawclyel
         MMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=655SZyZ4kTa0wHYVMzoiHvAnRif4SDxsc5wkKB6CdU4=;
        b=s0AWCkfWrm0QWvp0prgjN6vOW8pj0CUJfEgyK8vnudsIdesa6KZdF43vmGGmA1hVGG
         b+HBM8o4BOsOP6PRRx8d/bX51Nl7x7s1u7+SnNesE99+wOd3ZjQ68UmaQfPd2hNbEA0R
         7L85gd7Oh+2S5JahJW0Df4CNrRrEfTop5xVyagzBFsLIKi7LnvP6LIYqs8KVTD4S9VAj
         7lVA/cy4JbzfOdS6eXYlcCqfX2LAaGgp7uBPIfMU7ym5j/8wFi5qClYsqoDIwzowrVUP
         kDMALWSxSJS7qVWOqqqzJAtqwZ4OkIE+hH9kEbUi4lLB8proyY3BXo1MPXUZupIOT3/V
         amGg==
X-Gm-Message-State: ANhLgQ361v+7ANMq2zY3P95uUVJtu4EU0JLtiQBfE+Ypbyly/7wvCxhT
        BdfCehAHEnS6tVZqMuIFymWogYzxYcmCM+RGezZCCQ==
X-Google-Smtp-Source: ADFU+vvE1FXbmVfwZP+3e+8/+pgDo9ls3qIGPgKOg4hXyHLB8+yMmGdmETbmaY842qrOS5HGBT3syYeBGVngysMxZJM=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr1155834pfd.39.1584486664473;
 Tue, 17 Mar 2020 16:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200228002244.15240-1-keescook@chromium.org> <20200228002244.15240-8-keescook@chromium.org>
 <20200317215614.GB20788@willie-the-truck> <202003171558.7E1D46AED6@keescook>
In-Reply-To: <202003171558.7E1D46AED6@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Mar 2020 16:10:53 -0700
Message-ID: <CAKwvOd=9JHM4yhfCWEa-8OhZ70v_pChjgKj=TSGZgxZrhS5a_g@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Borislav Petkov <bp@suse.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 4:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Mar 17, 2020 at 09:56:14PM +0000, Will Deacon wrote:
> > On Thu, Feb 27, 2020 at 04:22:42PM -0800, Kees Cook wrote:
> > > We don't want to depend on the linker's orphan section placement
> > > heuristics as these can vary between linkers, and may change between
> > > versions. All sections need to be explicitly named in the linker
> > > script.
> > >
> > > Explicitly include debug sections when they're present. Add .eh_frame*
> > > to discard as it seems that these are still generated even though
> > > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > > to the image as it does appear to be mapped near .data. Finally enable
> > > orphan section warnings.
> >
> > Hmm, I don't understand what .got.plt is doing here. Please can you
> > elaborate?
>
> I didn't track it down, but it seems to have been present (and merged
> into the kernel .data) for a while now. I can try to track this down if
> you want?

Yes, the presence of a procedure linkage table makes sense for symbol
interposition and lazy binding in userspace executables with runtime
shared object loading support, but not so much the kernel, I would
think.  (Though someone did just recently ask me if loadable kernel
modules could interpose weakly defined symbols in the kernel, and if
so what happens on unload.  I have no idea and suspect kernel modules
cannot do that, but I have looked into the kernel's runtime relocation
support.)
-- 
Thanks,
~Nick Desaulniers
