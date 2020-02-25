Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E162C4BA00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBA82176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMkbvLLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBYWCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:02:52 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37702 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgBYWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:02:52 -0500
Received: by mail-pj1-f43.google.com with SMTP id m13so342004pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bvro5bqgLoB7Q+QOnUukmSXnFk4BT1NY/ZAFMUfpRmI=;
        b=QMkbvLLyqttt8K0Za0EOq8KWcm6weijM62KcldL6NQ2fIoAXY026AK/Dgog7qX2hbG
         S3i2NIWMVWvBd2LzrF/4EBNAgxk2GuDRyHGFUyDGtsfJ3er50UMq46NMGX0gLE2GRn7a
         ZcKtvDacIkE97cApgIrf38ItG6/pao5IHz4cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bvro5bqgLoB7Q+QOnUukmSXnFk4BT1NY/ZAFMUfpRmI=;
        b=Ld80AB6epJuSGyp1hlBFp0afSF6gvmojvQ4DniUDhQNFG/hBV1JoYOVy/7K6ZAxA5L
         Yj36Nwqa3gvhB6/PlyzbH1QYADUdly+zJJcZ+PSiN3snaSUNCkzDwTvhaHLojwVASliN
         JGHgnAmGs3wDqKVFYRe0o6gpFloBdP9rMc4lMACpZcY/34YOb7b4pCmn4lXvljLVpeIE
         fVp61vkUS7W2RKgVfK7RcazeLB0p01C+b/xfxkMRYYRzpC06qSLdPPxEzvIq3x15xL4c
         Ftf7n22HkrwuXZZ8T63aF+9ZuSUYB+BqY5pw/X0LFBR3pY3F+PIffT2+rIvXnsp4UgmT
         7Q1Q==
X-Gm-Message-State: APjAAAW+yk22FRHF6q3hPXPhB/RuKxuedQeVSKlDjX1w6blYibb0BjIq
        XGC0Jt0QMRpbcgfmfjTJ5i4+Fw==
X-Google-Smtp-Source: APXvYqyi/IdFHOhdoTujGGepz1gv+utlp506jhon2zXTaTyUOqxNnQ3SSyYbl/1S710zwjPG+xsLSA==
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr1268428pju.65.1582668171246;
        Tue, 25 Feb 2020 14:02:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a19sm94740pju.11.2020.02.25.14.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 14:02:49 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:02:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: --orphan-handling=warn
Message-ID: <202002251358.EDA50C11F@keescook>
References: <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
 <20200225182951.GA1179890@rani.riverdale.lan>
 <202002251140.4F28F0A4F@keescook>
 <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:37:26PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 25, 2020 at 11:43 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Feb 25, 2020 at 01:29:51PM -0500, Arvind Sankar wrote:
> > > On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
> > > > Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> > > > entry linker script ... made ld.lld take about 15 minutes to do the
> > > > final link. :(
> > >
> > > Out of curiosity, how long does ld.bfd take on that linker script :)
> >
> > A single CPU at 100% for 15 minutes. :)
> 
> I can see the implementers of linker script handling thinking "surely
> no one would ever have >10k entries." Then we invented things like
> -ffunction-sections, -fdata-sections, (per basic block equivalents:
> https://reviews.llvm.org/D68049) and then finally FGKASLR. "640k ought
> to be enough for anybody" and such.

Heh, yeah. I had no expectation that it would work _well_; I just
wanted to test if it _could_ work. And it did: FGKASLR up and running
on Clang+LLD. I stopped there before attempting the next step:
FGKASLR+LTO+CFI, which I assume would be hilariously slow linking.

-- 
Kees Cook
