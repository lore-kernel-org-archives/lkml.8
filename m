Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E99C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F04820768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="s/CTb7+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgIGKq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:46:57 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:47419 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgIGKqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:46:49 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4c9a9bfa
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Sep 2020 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=YRWb63lJVe5k63YRgdeGYsmd2Bk=; b=s/CTb7
        +I8bahKDFZBpLm+nJqsHR9ej/3MHQ+HgCyYk/NygA/vnXOKRoS9Jn5iRFWZUr4rK
        kNVf0Ec8bPrVfub6H/YJhdFWLaoEiThbHxH5y6Mgp+fbFg+uuv0KgdeAlbrJINlO
        ZcX17dnhwVAgnpt5XI/VDbTS5tUNHpST/B8rkx6Sf+C4d+kOtXfQM13UZEko/RvB
        bIbiOtF+pGIcWH1l64LtvZlBgvSF6uWwuiKebSVeL3F66t5Nlo9z7fcI0gjS+vAU
        hICw9obsbSKq+R9JGmoVTZ6HIQZt7jD9PRpX2Lnw5T0dBeLHBqDCEDTiO2XWdbE/
        Va0ZqF6tkf/UBbPA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d0ac0383 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Sep 2020 10:18:02 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id h4so13538102ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:46:46 -0700 (PDT)
X-Gm-Message-State: AOAM533jg5R9ArKxTL/G54BptJ2IXuZjNC6+/OZs9G+4LZTnhITWItqc
        FFHa5moOygB2fg+m3ImeFs/ZiX+zEGRg4tWfYXY=
X-Google-Smtp-Source: ABdhPJzMpaY4lmNeXEQUbkmxDHjkjYiWcE6cIYClsNoFqMPtUkyBE3a9p9czyEOQ6qaXTT5yfb63qWzpc8dZ9KwqG10=
X-Received: by 2002:a02:8802:: with SMTP id r2mr19505406jai.75.1599475605957;
 Mon, 07 Sep 2020 03:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
In-Reply-To: <20200907100647.GB10657@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Sep 2020 12:46:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com>
Message-ID: <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Borislav Petkov <bp@suse.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,


On Mon, Sep 7, 2020 at 12:06 PM Borislav Petkov <bp@suse.de> wrote:
>
> + Srinivas.
> + kitsunyan.
>
> On Mon, Sep 07, 2020 at 11:48:43AM +0200, Jason A. Donenfeld wrote:
> > Popular tools, like intel-undervolt, use MSR 0x150 to control the CPU
> > voltage offset. In fact, evidently the intel_turbo_max_3 driver in-tree
> > also uses this MSR. So, teach the kernel's MSR list about this, so that
> > intel-undervolt and other such tools don't spew warnings to dmesg, while
> > unifying the constant used throughout the kernel.
> >
> > Fixes: a7e1f67ed29f ("x86/msr: Filter MSR writes")
> > Cc: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/x86/include/asm/msr-index.h         | 2 ++
> >  arch/x86/kernel/msr.c                    | 5 ++++-
> >  drivers/platform/x86/intel_turbo_max_3.c | 6 +++---
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > -     if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> > +     switch (reg) {
> > +     case MSR_IA32_ENERGY_PERF_BIAS:
> > +     case MSR_IA32_OC_MAILBOX:
> >               return 0;
> > +     }
> Actually, we added the filtering to catch exactly such misuses and,

Are you sure that intel-undervolt using OC_MAILBOX from userspace is
actually a "misuse"? Should the kernel or kernel drivers actually be
involved with the task of underclocking? This seems pretty squarely in
the realm of "hobbyists poking and prodding at their CPUs" rather than
something made for a kernel driver, right? Also, what was the
justification for whitelisting MSR_IA32_ENERGY_PERF_BIAS?

Jason
