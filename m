Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB38206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594586727;
	bh=GK/EmAdbjbJj+B/3NkTX+j2YI+rSBcFd2aFHE1JN3yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iBxFEiib0IPdrKbwXL8korKiPmDDDd4TwTHSPDTIcLj3nt2W5ZCk+L12uUMFKiG4p
	 eB9B0y4mLtPETg0pkXzdhzcllRugN+Xq9u3ohx9arOu/h4VYxke5slANFsiuzK5kNQ
	 f7NB0C0HKFtQMWnnlFX/ElRBHXO/dhCUEecG5x6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgGLUpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgGLUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 16:45:13 -0400
X-Greylist: delayed 29583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jul 2020 13:45:13 PDT
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [IPv6:2001:4ca0:200:3:200:5efe:8d54:4505])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:45:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4B4f0v3T5Cz29;
        Sun, 12 Jul 2020 22:45:03 +0200 (CEST)
Date:   Sun, 12 Jul 2020 23:45:01 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, alex.gaynor@gmail.com,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200712204501.GC25970@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost>
 <20200712193944.GA81641@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200712193944.GA81641@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 12:39:44PM -0700, Josh Triplett wrote:
> On Sun, Jul 12, 2020 at 03:31:51PM +0300, Adrian Bunk wrote:
> > On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> > >...
> > > but also a larger question of "should we do
> > > this?" or "how might we place limits on where this can be used?"
> > >...
> > 
> > I won't attend, but I do have a topic that should be covered:
> > 
> > Firefox always depends on recent Rust, which forces distributions to 
> > update Rust in stable releases.
> > 
> > As an example:
> > Ubuntu LTS releases upgrade to a new Rust version every 1-2 months.
> > Ubuntu 16.04 started with Rust 1.7.0 and is now at Rust 1.41.0.
> > 
> > It would not sound good to me if security updates of distribution
> > kernels might additionally end up using a different version of the
> > Rust compiler - the toolchain for the kernel should be stable.
> > 
> > Would Rust usage in the kernel require distributions to ship
> > a "Rust for Firefox" and a "Rust for the kernel"?
> 
> Rust has hard stability guarantees when upgrading from one stable
> version to the next. If code compiles with a given stable version of
> Rust, it'll compile with a newer stable version of Rust. Given that, a
> stable distribution will just need a single sufficiently up-to-date Rust
> that meets the minimum version requirements of both Firefox and Linux.
>...

API stability avoids problems that are visible early as build errors.

Rust cannot offer a hard stability guarantee that there will never be 
a code generation regression on any platform.

Rust gets updated frequently.
Sometimes this also changes the LLVM version used by Rust.
Debian stable supports targets like ARMv5 and 32bit MIPS.
Distribution kernel updates are often automatically installed
on user hardware.

cu
Adrian
