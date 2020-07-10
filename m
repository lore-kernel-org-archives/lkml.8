Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01D52078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594401319;
	bh=L7/tSb+Pse5aLWVxH/CLIrVK11DXAitXfSjGWiPzMUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fpTHP/U+tnhn6IXwAeMISHGWhSrRrSFKV85wJc8VVCX8/e22brj2JEakDmGAp5Mu6
	 aT2MzLayCnJM4NkkIrUx58qgSNlr6x38glei1kZfEURSQfwOeE0pOF05XDKuUd191L
	 HSSB0bhXPaOFUOHwRUCHyCtiYWk1sJ2WPg0J/kfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:15:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19C020674;
        Fri, 10 Jul 2020 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594401316;
        bh=L7/tSb+Pse5aLWVxH/CLIrVK11DXAitXfSjGWiPzMUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODn+wBX8HVqj1KZ2HGIGv/MORKu3ZZn1aHWKKfff8Ba+oqIUoNxRgomJHmFYKPNHS
         P1MuJ6OVVATCam7HY3GwWvnyCmD9TLL59R8ZtNw8xhnMxMpwg3QAynx9yvsiNN5Ud7
         r7lMVIb3kVpC3xRWR0p0fhp6Z1rXKg0F4ZE4sIz8=
Date:   Fri, 10 Jul 2020 18:15:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v3 06/19] asm/rwonce: Don't pull <asm/barrier.h> into
 'asm-generic/rwonce.h'
Message-ID: <20200710171508.GA31366@willie-the-truck>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-7-will@kernel.org>
 <CAKwvOd=HJye0iHr=9=7EMytO8ycFNJEsHHe1m64uT8s0jOQw0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=HJye0iHr=9=7EMytO8ycFNJEsHHe1m64uT8s0jOQw0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:06:12AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 10, 2020 at 9:52 AM Will Deacon <will@kernel.org> wrote:
> > diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> > index 0c5ef54fd416..c1e79f72cd89 100644
> > --- a/include/linux/nospec.h
> > +++ b/include/linux/nospec.h
> > @@ -5,6 +5,8 @@
> >
> >  #ifndef _LINUX_NOSPEC_H
> >  #define _LINUX_NOSPEC_H
> > +
> > +#include <linux/compiler.h>
> 
> The other hunks LGTM, but this one is a little more curious to me. Can
> you walk me through this addition?

Sure. Without it, the build breaks on riscv because it includes this header
without first including <linux/compiler.h>, and this header relies on
OPTIMIZER_HIDE_VAR() being to defined as it is used in static inline
functions.

Perhaps I should squash this hunk into "compiler.h: Split {READ,WRITE}_ONCE
definitions out into rwonce.h" instead, as that is where I remove the
include of <linux/compiler.h> from 'asm-generic/barrier.h'. I'll check
the bisection on riscv...

Will
