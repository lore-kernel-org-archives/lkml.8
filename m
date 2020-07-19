Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8806420B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595183147;
	bh=kn11+YCuZbBTZ/qf9bPPn2pJixaeM7Qk+ftWPjEqfSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ULCAFda4SuV8fWpzGe723KzxzBANPhF3Iw8db0zAYS12z4tj8KpaQrVaSG7RS4Poh
	 8jtsquKEN8/kxFQ7piKd3CvMgx6SKr1RGnaWtQe1e3B7YgCnUCQhuopktN9mpKe8J+
	 7URILjWpOaKHo04S0NeZOSOqMHh+8abIcx6e4aP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGSSZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:25:46 -0400
Received: from mail.stusta.mhn.de ([141.84.69.5]:53070 "EHLO
        mail.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:25:45 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2020 14:25:44 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4B8tRZ0r2bz3H;
        Sun, 19 Jul 2020 20:19:21 +0200 (CEST)
Date:   Sun, 19 Jul 2020 21:19:19 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200719181919.GA4179@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost>
 <20200712193944.GA81641@localhost>
 <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:06:01PM +0200, Arnd Bergmann wrote:
> 
> I would expect we'd want a fairly tight coupling between kernel
> releases and minimum rust releases at first. Whatever is the latest
> stable rust version during the kernel's merge window might be
> assumed to be the minimum version for the life of that kernel, but
> an LTS release would not suddenly start relying on features
> from a newer compiler (thought it might warn about known bugs).
> 
> This might mean that linux-next requires a beta version of rust, if
> the release is expected before the merge window and it contains
> an important change.

I would expect this is absolutely not wanted,
it would make testing recent kernels very hard.

If you want to keep a tool that tightly to the kernel,
please bundle it with the kernel and build it as part
of the kernel build.

I would suggest to start with a proper design/specification what the 
kernel wants to use, so that you are confident that a compiler 
implementing this will be sufficient for the next 5 years.

As a secondary benefit, starting with a proper design often brings
a better result than adding permanent features piece by piece.

As a tertiary benefit, it would avoid tying the kernel to one specific 
compiler implementation. A compiler like mrustc or a hypothetical Rust 
frontend for gcc could then implement a superset of what the kernel 
needs.

> Staying with fairly recent versions of clang
> certainly helped in getting clang and the kernel to co-evolve and
> get to the point we are now in using it as an alternative to gcc.

The main difference is between an alternative to an existing tool,
and a mandatory new tool.

> While Linux used to build with 12 year old compilers (4.1 until
> 2018), we now require a 6 year old gcc (4.9) or 1 year old
> clang/llvm. I don't know whether these will fully converge over
> time but it seems sensible that the minimum rust frontend version
> we require for a new kernel release would eventually also fall
> in that range, requiring a compiler that is no more than a few
> years old, but not requiring the latest stable release.

The correct range for a mandatory tool are the 6 to 12 years for gcc.

Debian stable and Ubuntu LTS are providing (different) mechanisms
for installing the kernel from the next stable/LTS release 2 years
later[1] for supporting new hardware.
If kernel 5.12 LTS cannot be compiled on Ubuntu 20.04 LTS with
the 2019 gcc 9 there would be pain downstream.

In the embedded world spreads far wider than these 3 years are common.
I would currently have a real-life usecase for compiling a recent
kernel with a gcc 4.0 (sic) toolchain.
Properly supporting 15 year old toolchains would be painful upstream,
supporting 6 year old toolchains is a reasonable compromise between
not being too painful upstream while rarely causing pain downstream.

What applies to gcc does also apply to other external tools used
during the kernel build.

>       Arnd

cu
Adrian

[1] following a new upstream kernel stable branch every 6 months (Ubuntu)
    or the latest upstream stable kernels (Debian) until this is reached
