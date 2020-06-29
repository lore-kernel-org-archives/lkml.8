Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39036C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BE22063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+9UP96B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbgF2VoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgF2Shr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C8C0307BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:10:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x3so2568698pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLeKruvw8xS/1C0BGsgxQCKuNobKaryrVDfkNcFoTKw=;
        b=i+9UP96BeuDUndvXAn5oRwVUqCxKPUqo5jb9FpFAkevibF4fOIyewm6LBAtkZLrBzP
         /7U3H02kF4xz1/F9l3P0SJ2jj2PFznh1x5HDxhs16XUY+e7OWMJgLhbNHwJYVT8KWpee
         TodpFVlf7IKIfvaTS8QPjZFYeI1/hHcL3q4bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLeKruvw8xS/1C0BGsgxQCKuNobKaryrVDfkNcFoTKw=;
        b=Q440k/y6E7c3jBG0LIB6b9Gr0mSHBjQw3bzPBiLt4T9k9ESmvAG/HdqayEVJjUwuGc
         fh4d4U1LEZJOb5nvecMBDGUWMdr4GGiWQ1RHftgtu7QatRcilGbDOxAdnzArhCJj7aIB
         x7xhCflg66T0F+3pJC71HBg1faVZE5MTsGM5lNWwpc2GDuYt42K1DB/2eio24LYfDxjH
         iyBCxWYGuPlQjVgGE/jSzMJGX9m7TRFbfs6q7XisClhpzeo0B2u5CkaHYokz5qfkHk9H
         BK3673eJa1oeQ/hnLeTglh6ddlCYHGNonmONPBg6JBeCEwzyp4ZB7yYMI29PyiCYFmTu
         VCOQ==
X-Gm-Message-State: AOAM530SFj0+XxykKDZxSy3GpNztGZWFBjnXOVGg6UbsqqyBl94ep3Qm
        a9ABZ2JjZXlAqy9cI0HDfew19w==
X-Google-Smtp-Source: ABdhPJxiXdS02g2kg/C3e7NIZ+hRQZoFSkyCVmAnS41BhXLKFEBoQYo+oIuHHOwfsIe186IoCXJYwg==
X-Received: by 2002:a65:5649:: with SMTP id m9mr10671287pgs.279.1593447006373;
        Mon, 29 Jun 2020 09:10:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j21sm176656pfa.133.2020.06.29.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:10:05 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:10:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
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
Subject: Re: [PATCH v3 1/7] x86/boot/compressed: Move .got.plt entries out of
 the .got section
Message-ID: <202006290909.F79ED275C@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-2-nivedita@alum.mit.edu>
 <202006290846.5A5C76A4D7@keescook>
 <20200629155011.GA900899@rani.riverdale.lan>
 <CAMj1kXH1Fx3c4fZRVgNPeXnPFbHWVhgywU0Jvu65=wBaR_5yjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH1Fx3c4fZRVgNPeXnPFbHWVhgywU0Jvu65=wBaR_5yjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:51:00PM +0200, Ard Biesheuvel wrote:
> On Mon, 29 Jun 2020 at 17:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, Jun 29, 2020 at 08:48:05AM -0700, Kees Cook wrote:
> > > On Mon, Jun 29, 2020 at 10:09:22AM -0400, Arvind Sankar wrote:
> > >
> > > This is also being done on arm64, and the section was specified slightly
> > > differently (with INFO) which maybe should be done here too?
> >
> > I was actually just about to email you to ask what that INFO is for :)
> > What does it do?
> >
> 
> It makes the section non-allocatable, so it is dropped from the final image

i.e. takes no disk space, but the ASSERT can still be done.

-- 
Kees Cook
