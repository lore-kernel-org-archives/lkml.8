Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A72C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD4F206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hr7MeltL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCWVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:12:10 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43439 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgCWVMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:12:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e9d878be
        for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=FEPb9kRX8V6WY9RqWMzOGd2OZM8=; b=hr7Mel
        tL5+US9VRxqSQXFA17+epv/BPj4mgzZPKLG6AH0uDZ98veTGzZTcOhlJUxjCTmPq
        rx2YvZBSNFt7zhIpxbjzVqCcNUCm+mUg1huUvWtEtdFPjCJgkNzzm5Wrz/eFhWoz
        1aY5kBSO20/4HNMtAx+lYfMaH7YTCrHGTSqQn/EGB2jhdimpR2tZpNyctqOBM5th
        Ycu0Smj9UfgOzRbd2n0+M0Th+VdJMYqF0fZV2T3XTtaNC+pp/2TkuCFQP+jIhtzG
        zH/xP47MWy7ejpuZNv/0Uo+rnJBmEsYPbVNaEnQZb45pZNwDX3JgiArt7nRswzkt
        8u31IQw4g/ahAl6A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b18c583 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 21:05:04 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id r5so10051334ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:12:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1Vq97xRAheaBrWYjouRE/oOAk73mdMKEQK36ZbEomz6BtUW5Pa
        4LRKQxbLlQmeje2i2dOgy4C2hvkxZPbMAQL35Ng=
X-Google-Smtp-Source: ADFU+vtXSOy47FOYVIpjgGIZNSXirEFFAh/pmLveforkptYs+ujn9CPwZ+BJ54Wvhd37vkIqAAlxKMo7ipwUs9VCZ8w=
X-Received: by 2002:a92:cd4e:: with SMTP id v14mr24004973ilq.231.1584997926074;
 Mon, 23 Mar 2020 14:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com> <202003231350.7D35351@keescook>
In-Reply-To: <202003231350.7D35351@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 23 Mar 2020 15:11:55 -0600
X-Gmail-Original-Message-ID: <CAHmME9o3Vef022V6fb1b3JOFOmjKXBBroiYU83kOewKHJ3MyQA@mail.gmail.com>
Message-ID: <CAHmME9o3Vef022V6fb1b3JOFOmjKXBBroiYU83kOewKHJ3MyQA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> > On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > > Long overdue patch, see below.
> > >
> > > Plan is to queue it after 5.7-rc1.
> > >
> > > ---
> > > From: Borislav Petkov <bp@suse.de>
> > > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > >
> > > The currently minimum-supported binutils version 2.21 has the problem of
> > > promoting symbols which are defined outside of a section into absolute.
> > > According to Arvind:
> > >
> > >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > >           Invalid absolute R_X86_64_32S relocation: _etext
> > >   and after fixing that one, with
> > >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > >
> > > Those two versions of binutils have a bug when it comes to handling
> > > symbols defined outside of a section and binutils 2.23 has the proper
> > > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> > >
> > > Therefore, up to the fixed version directly, skipping the broken ones.
> > >
> > > Currently shipping distros already have the fixed binutils version so
> > > there should be no breakage resulting from this.
> > >
> > > For more details about the whole thing, see the thread in Link.
> >
> > That sounds very good to me. Then we'll be able to use ADX instructions
> > without ifdefs.
> >
> > Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Can you send these now and we can land in 5.7 with the doc change?

By the way, while we're in the process of updating dependencies, what
if we ratched the minimum binutils on x86 up to 2.25 (which is still
quite old)? In this case, we could get rid of *all* of the CONFIG_AS_*
ifdefs throughout.

Jason
