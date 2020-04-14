Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42000C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C4B2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8Ir9IZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503392AbgDNSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503383AbgDNSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:05:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KweB4QuPPovogJ/b7HJZC7qbwDcSIuXed6bpI29U9Gg=; b=V8Ir9IZ4xyRcKjAO825c4ArGPl
        Bkn9m1PaOuwrsYwsQmBviMIK0S/5Y+ByLuBPc0tKPdkmeHOcOaCekZ7z0rGXpv7XiY0r5SLzYJlmT
        W5fsut/h+/TrkjJqH2UVyRYzrAEymceyj5F3redJFFQ76ZHUbfBO1TvROBndrFgFsf5vvDQkwHYHj
        zSoxWDd4kpT7jZkDL3JK7ZnD4JF4xR5DI6dg/GYw9H/eJmk4TNFUGs1cNo+gzIGxNTHzEK5KKd1Oe
        ZK1NlFrlj4lWN19V1DB7yWqdsP199uRjqbszjkdTJ+1+r9rHOTC84vG6xzt0F6NwiMuqxlSbc8bYQ
        6ipGItIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOPwS-0000CG-Ow; Tue, 14 Apr 2020 18:05:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08C8B981086; Tue, 14 Apr 2020 20:05:46 +0200 (CEST)
Date:   Tue, 14 Apr 2020 20:05:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Park, Kyung Min" <kyung.min.park@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
Message-ID: <20200414180545.GE2483@worktop.programming.kicks-ass.net>
References: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
 <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
 <20200414103106.GK20713@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F5E3E80@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5E3E80@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 06:00:21PM +0000, Luck, Tony wrote:
> >> +static inline void __tpause(u32 ecx, u32 edx, u32 eax)
> >> +{
> >> +	/* "tpause %ecx, %edx, %eax;" */
> >> +	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
> >> +		     :
> >> +		     : "c"(ecx), "d"(edx), "a"(eax));
> >> +}
> >
> > Can we please get a comment stating from what binutils version this
> > opcode has a mnemonic? That way, when we raise the minimum binutils
> > version we can easily grep and find such things.
> 
> Or maybe use arch/x86/Kconfig.assembler to set up a CONFIG_AS_TPAUSE?
> 
> Then the code can read something like (syntax may need fixing)
> 
> #ifdef CONFIG_AS_TPAUSE
> 		asm volatile("tpause %ecx\n", : : "c"(ecx), "d"(edx), "a"(eax));
> #else
> 		asm volatile(".byte hex gibberish ...
> #endif

Then we still need a comment to know when we can kill that...
