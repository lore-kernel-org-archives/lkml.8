Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54272C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341E1207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CyE6hWK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgEKJgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:36:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YNHgbChJZQ7ZhkULZQtUTSd3NIM4J1mM9pYKXez7Uro=; b=CyE6hWK4nJDqzRWnqxpzFEAcIV
        vv4ZpLl4Vr13+F4Dv14/vr2KLGFXZ1vtSAmAtSkomqWXP3H1z1pE/5C8QNZO9vahTSpx/eBdoyNcK
        6PbULwPtKEPM2Zw+Hd2eIWT934E/DMjoErfi+0DegFA/HXiqWp3Hg1CFCqv0BUjP9PyFYxarpVkJb
        mH4pMJEq4Qv3hPMQMbpTzMmE1DGMNtI6QHUghceMPJ8HLIrcrMlubCLnt1np+wjqbqJN24RUiYDbj
        oSVZxTiMFDbpEXtQktDP2mJwgVjCAkKBoQ/sSCjRSdk1ohclP31oyZkz6mdJj77Mm1hXp0N4q5KaN
        nnVbhG0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY4rB-0008Np-JS; Mon, 11 May 2020 09:36:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9958E301A80;
        Mon, 11 May 2020 11:36:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74269200FC689; Mon, 11 May 2020 11:36:15 +0200 (CEST)
Date:   Mon, 11 May 2020 11:36:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Radoslaw Biernacki <biernacki@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        linux@endlessm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsc: Use hard-coded crystal clock for Skylake mobile
Message-ID: <20200511093615.GG2957@hirez.programming.kicks-ass.net>
References: <20200509113717.9084-1-pmenzel@molgen.mpg.de>
 <87eerr3ppb.fsf@nanos.tec.linutronix.de>
 <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:38:34AM +0200, Paul Menzel wrote:

> Sorry about that. From `MAINTAINERS` I thought x86@kernel.org is wanted.
> Other subsystems list LKML explicitly there.

Not sure what you're reading but:

X86 ARCHITECTURE (32-BIT AND 64-BIT)
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Ingo Molnar <mingo@redhat.com>
M:      Borislav Petkov <bp@alien8.de>
M:      x86@kernel.org
R:      "H. Peter Anvin" <hpa@zytor.com>
L:      linux-kernel@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
F:      Documentation/devicetree/bindings/x86/
F:      Documentation/x86/
F:      arch/x86/

Explicitly lists LKML, also note how x86@kernel.org is M not L. It is in
fact a mail alias for just a few people, it is _NOT_ a list.
