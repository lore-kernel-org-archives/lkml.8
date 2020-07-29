Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79311206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgG2Gea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:34:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59943 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgG2Gea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:34:30 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E3C58240003;
        Wed, 29 Jul 2020 06:34:20 +0000 (UTC)
Date:   Tue, 28 Jul 2020 23:34:17 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200729063417.GD286933@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <20200710225934.GA16881@localhost>
 <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
 <20200711210317.GA60425@localhost>
 <20200728204037.GC1012@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728204037.GC1012@bug>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:40:38PM +0200, Pavel Machek wrote:
> > We just need to make sure that any kernel CI infrastructure tests that
> > right away, then, so that failures don't get introduced by a patch from
> > someone without a Rust toolchain and not noticed until someone with a
> > Rust toolchain tests it.
> 
> So... I'm fan of Rust, but while trying to use it one thing was obvious: it
> takes _significantly_ longer than C to compile and needs gigabyte a lot of RAM.
> 
> Kernel is quite big project, can CI infrastructure handle additional load?
> 
> Will developers see significantly longer compile times when Rust is widespread?

I wouldn't expect the addition of Rust to the kernel to substantially
impact overall build time; on balance, I'd expect the major bottleneck
in kernel builds to continue to be linking and other serialized steps,
not compiling and other highly parallel steps.

There are also *many* things that can be done to improve Rust build time
in a project. And I don't expect that in-kernel Rust will have many
dependencies on third-party crates (since they'd need to be checked into
the tree).
