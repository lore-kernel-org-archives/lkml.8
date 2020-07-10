Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1954C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879B7207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xf9Dd9sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgGJIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:53:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761EFC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vpuh/UyJCwIooEffOYqRs5sxFTS9oyEwixxCjgqxAA4=; b=xf9Dd9sh8eexx3l9KAeK/ORwsk
        n4t8Mi80UqPBVV9JSsCoXJLrNUNWqVUolu/+xGlhhJcWsHPkYM5kOyZtaiZ/LPYxlunL5QqOuY6HH
        hoXQ84I/JxHwA+yV1RB7ux89quepCwI9sBgpaMKvt99b9TDw8mAE6Y0Ojq0pGan0bsXqjgaI7ic1g
        SNbH7yMPpl+5X09zRWqMJGmmwXbtNNkUb//1EjeZ/TCR+mmzNy2ip6qHXXBDnGuzMNlDNOaGpDgaB
        EDKKlUzAgKt2THNOrNfK6OPnt2P3dULPaS35tFGJnAJvLlWIiPOPRXPUCFg5SE05DhSxAP6aApEJD
        /6VJtfJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtomh-0006xk-HE; Fri, 10 Jul 2020 08:53:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31C4C304E03;
        Fri, 10 Jul 2020 10:53:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A0E214ECE40; Fri, 10 Jul 2020 10:53:27 +0200 (CEST)
Date:   Fri, 10 Jul 2020 10:53:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/10] x86/percpu: Clean up percpu_to_op()
Message-ID: <20200710085327.GW4800@hirez.programming.kicks-ass.net>
References: <20200530221127.459704-1-brgerst@gmail.com>
 <20200530221127.459704-3-brgerst@gmail.com>
 <20200709103024.GO597537@hirez.programming.kicks-ass.net>
 <CAMzpN2i3TPxpf5ktaQgb5EmB9wd84V+J5U6=_MuihtXx1-cp+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2i3TPxpf5ktaQgb5EmB9wd84V+J5U6=_MuihtXx1-cp+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:38:23AM -0400, Brian Gerst wrote:
> On Thu, Jul 9, 2020 at 6:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, May 30, 2020 at 06:11:19PM -0400, Brian Gerst wrote:
> > > +     if (0) {                                                        \
> > > +             typeof(_var) pto_tmp__;                                 \
> > > +             pto_tmp__ = (_val);                                     \
> > > +             (void)pto_tmp__;                                        \
> > > +     }                                                               \
> >
> > This is repeated at least once more; and it looks very similar to
> > __typecheck() and typecheck() but is yet another variant afaict.
> 
> The problem with typecheck() is that it will complain about a mismatch
> between unsigned long and u64 (defined as unsigned long long) even
> though both are 64-bits wide on x86-64.  Cleaning that mess up is
> beyond the scope of this series, so I kept the existing checks.

Fair enough; thanks for explaining.
