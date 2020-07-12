Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27929C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0745220702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 19:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgGLTjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 15:39:54 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46027 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgGLTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 15:39:54 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E2F421BF205;
        Sun, 12 Jul 2020 19:39:46 +0000 (UTC)
Date:   Sun, 12 Jul 2020 12:39:44 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Adrian Bunk <bunk@kernel.org>
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
Message-ID: <20200712193944.GA81641@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712123151.GB25970@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 03:31:51PM +0300, Adrian Bunk wrote:
> On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> >...
> > but also a larger question of "should we do
> > this?" or "how might we place limits on where this can be used?"
> >...
> 
> I won't attend, but I do have a topic that should be covered:
> 
> Firefox always depends on recent Rust, which forces distributions to 
> update Rust in stable releases.
> 
> As an example:
> Ubuntu LTS releases upgrade to a new Rust version every 1-2 months.
> Ubuntu 16.04 started with Rust 1.7.0 and is now at Rust 1.41.0.
> 
> It would not sound good to me if security updates of distribution
> kernels might additionally end up using a different version of the
> Rust compiler - the toolchain for the kernel should be stable.
> 
> Would Rust usage in the kernel require distributions to ship
> a "Rust for Firefox" and a "Rust for the kernel"?

Rust has hard stability guarantees when upgrading from one stable
version to the next. If code compiles with a given stable version of
Rust, it'll compile with a newer stable version of Rust. Given that, a
stable distribution will just need a single sufficiently up-to-date Rust
that meets the minimum version requirements of both Firefox and Linux.

(That would not apply if the kernel used nightly Rust, since
nightly-only features are allowed to change before becoming stable;
that's one reason why we should use stable Rust, and try to get Firefox
to stick to stable Rust.)
