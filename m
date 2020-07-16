Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32532076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGPXMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:12:37 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58101 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:12:36 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D26B420003;
        Thu, 16 Jul 2020 23:12:22 +0000 (UTC)
Date:   Thu, 16 Jul 2020 16:12:17 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Bunk <bunk@kernel.org>,
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
Message-ID: <20200716231217.GA378765@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost>
 <20200712193944.GA81641@localhost>
 <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:06:01PM +0200, Arnd Bergmann wrote:
> On Sun, Jul 12, 2020 at 9:39 PM Josh Triplett <josh@joshtriplett.org> wrote:
> > On Sun, Jul 12, 2020 at 03:31:51PM +0300, Adrian Bunk wrote:
> > >
> > > As an example:
> > > Ubuntu LTS releases upgrade to a new Rust version every 1-2 months.
> > > Ubuntu 16.04 started with Rust 1.7.0 and is now at Rust 1.41.0.
> > >
> > > It would not sound good to me if security updates of distribution
> > > kernels might additionally end up using a different version of the
> > > Rust compiler - the toolchain for the kernel should be stable.
> > >
> > > Would Rust usage in the kernel require distributions to ship
> > > a "Rust for Firefox" and a "Rust for the kernel"?
> >
> > Rust has hard stability guarantees when upgrading from one stable
> > version to the next. If code compiles with a given stable version of
> > Rust, it'll compile with a newer stable version of Rust. Given that, a
> > stable distribution will just need a single sufficiently up-to-date Rust
> > that meets the minimum version requirements of both Firefox and Linux.
> >
> > (That would not apply if the kernel used nightly Rust, since
> > nightly-only features are allowed to change before becoming stable;
> > that's one reason why we should use stable Rust, and try to get Firefox
> > to stick to stable Rust.)
> 
> I would expect we'd want a fairly tight coupling between kernel
> releases and minimum rust releases at first. Whatever is the latest
> stable rust version during the kernel's merge window might be
> assumed to be the minimum version for the life of that kernel, but
> an LTS release would not suddenly start relying on features
> from a newer compiler (thought it might warn about known bugs).

Agreed; we should be careful that any backported fix to an LTS kernel
does not increase the required Rust toolchain.

> While Linux used to build with 12 year old compilers (4.1 until
> 2018), we now require a 6 year old gcc (4.9) or 1 year old
> clang/llvm. I don't know whether these will fully converge over
> time but it seems sensible that the minimum rust frontend version
> we require for a new kernel release would eventually also fall
> in that range, requiring a compiler that is no more than a few
> years old, but not requiring the latest stable release.

I expect in the short term that we will likely have a need for features
from recent stable releases, especially when those features were added
specifically to support the kernel or similar, but the rate at which we
need new features will slow over time, and eventually we'll go from
"latest stable" to "within a year or so".
