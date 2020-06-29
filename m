Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C80B2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDLsjzTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgF2Snl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgF2Snj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:43:39 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BAC031C40
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:43:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so8115106qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=20l025BZSmljDHaRdAwUJU/sS1IgTLaKPGtOtjxywLI=;
        b=EDLsjzTsEWau+DTUx00QeWGrmY63SYxKcs+gb1NA5d7R97Cm8ah5dWrQZQDrWCkyRL
         JUxyP4uNFo1+Q0sSMHBZ9X4OHKcXOVmxbsYiE2GTJYNW/YxoFFnnajvguRf/YfhfE7Rl
         2dlsAiQsBWzZ7HpicS4TCKGfObU8F3S5OmF3hnrx1UdIKP6ajL/gvx5t+p6w2xM3Muuj
         FjpQ8ubaPjXiOzdRdZ+oMmgOgv/45CqOPMco6y/DVwAEW7TU45x1UQkzwkPdUz/rb6aR
         NBfE2PSvtvIc5MVsP6VVkbWt4Xu6e7LuIVsmCD3FFFLZHUn5pqL9AlVhaPq4VVzNRbFE
         bwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=20l025BZSmljDHaRdAwUJU/sS1IgTLaKPGtOtjxywLI=;
        b=EkGQVxA2f0CwH4QzIYCvt9fk6CrfzI07eIadgjukyM9+xaGRtZihcZdA4XPxjx1+wl
         karyGBjGIeCvXQHG8uQMdWH7ZXv9uLC60Iob7etXqaw3pT1auCG0r6JKCFfmPdMV2w2f
         LNm8RNjIvh5ErJNGU9MwITyfBvTqW6qYXRGmiovvLsrPSioC0yTffJ19pO/6XkSjb9E8
         i+PYBWD3zfxEFlAHcq8lM5yP2I50yQeSR9EjI9mPGCg4altIRRPRzimAxKP6lf0y809H
         9sM+HnmFW6u+mU4KBXUXSn7YVgT7FvOkVJ9jHIYwLLP2Q+Oe0Ivjvc9WyA0FuFORbBrf
         zvYg==
X-Gm-Message-State: AOAM533Jk8b9lceID9BvFIA/KzYRyeUSZ3Ga9k5zJe4RXdaNG5zAl3K3
        I3KJ7JXR3+h4o0M+q/ZeEOY=
X-Google-Smtp-Source: ABdhPJyv48cnmze6ap1z6r/F1pbCtC2KwFqlodfQ72ywXHjT25cbajzYc/ZEl65kkVJ7l/E8dcV/ag==
X-Received: by 2002:a0c:8e04:: with SMTP id v4mr16625133qvb.213.1593456218301;
        Mon, 29 Jun 2020 11:43:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u27sm578425qkm.121.2020.06.29.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:43:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 14:43:35 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200629184335.GA1102734@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006290919.93C759C62@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:20:31AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 06:11:59PM +0200, Ard Biesheuvel wrote:
> > On Mon, 29 Jun 2020 at 18:09, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Should these be marked (INFO) as well?
> > >
> > 
> > Given that sections marked as (INFO) will still be emitted into the
> > ELF image, it does not really make a difference to do this for zero
> > sized sections.
> 
> Oh, I misunderstood -- I though they were _not_ emitted; I see now what
> you said was not allocated. So, disk space used for the .got.plt case,
> but not memory space used. Sorry for the confusion!
> 
> -Kees
> 

To confuse the issue a bit more, there are subtleties around "disk space
used" :) The section will be present in the ELF format file, but at
least on x86, that file is then converted into binary format via
objcopy. At this point a non-allocated section at the end of the file
will be stripped off. So on 32-bit x86, moving .got.plt to the end and
marking it INFO will shave 16 bytes off the bzImage kernel.
