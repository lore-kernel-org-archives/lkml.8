Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827972075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxvICSWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgFDUwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgFDUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:52:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F63C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PiE7DNxO3pqAGslsM8EXoQp6h0xtdTMR2V3mK8r5hpk=; b=rxvICSWikzzfJtOczSxakO0/h8
        jqa+P/c9wy9vxdQn073hpbAYoNZhqEoEVk5l+2zd/eWIMJ2fFuW5CWy0BhZSTyewwmu//2yBsPHKp
        fdAMw9QWB6yu8S+gU9A+2Ge+eTIDlKaeyvboH2JDV25i/ZpoJLpTJaA0KDs13QoM+QrUwxPt9zABd
        y1W4+HTVDLbkHRF9cVTaF79dPg2DGuiXjDCovx+KuFpv6RLaxzVYQCLtbxKHVggDQV+CbLkoNfY0L
        uar6HeIJL18rSdPMRGjf1Rc4E4qxVNkJIG9iIGM559qfNlXL4Y5cJd54YNBT/xT9XOxX/MwnrAq6W
        /Fe1POiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgwqb-0002DS-T9; Thu, 04 Jun 2020 20:52:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65A5A9838B9; Thu,  4 Jun 2020 22:52:19 +0200 (CEST)
Date:   Thu, 4 Jun 2020 22:52:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
Message-ID: <20200604205219.GZ2483@worktop.programming.kicks-ass.net>
References: <20200604095057.259452-1-elver@google.com>
 <20200604110918.GA2750@hirez.programming.kicks-ass.net>
 <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
 <CANpmjNML7hBNpYGL81M1-=rrYn5PAJPTxFc_Jn0DVhUgwJV8Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNML7hBNpYGL81M1-=rrYn5PAJPTxFc_Jn0DVhUgwJV8Hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:23:38PM +0200, Marco Elver wrote:
> Sadly no. 'noinstr' implies 'notrace', but also places the function in
> the .noinstr.text section for the purpose of objtool checking.

Not only the compile time checking, but also for purpose of runtime
exclusion for things like kprobes and hw-breakpoints.
