Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2E020658
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DAsgmM1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGHJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:12:53 -0400
Received: from casper.infradead.org ([90.155.50.34]:58324 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgGHJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNfnia1zIEwFXAVe3ArSMXxA9lLI4nhBIytQMA82G40=; b=DAsgmM1CZbQ2E6pa/16EJ1asf2
        5cVZwcve5zkPSOmP/IVITPHDDsGVjNaY0iSvGrBw5K46ET3EDuaJpDAo0zZVMWt8LumpvDN+aNLeN
        u3AnWWNkAvj3i4525tx1cnB38jXZE00CEEL8N2IKBpCe3b1TT6iaFarsZSoVHciR3MdFDLdccOviX
        H72VbRq7NCuDMWBQ4znqzkA2hhMfuinVDA1NQpukg3y51wJmZ4rExdGS1/Vks/U55BTk49R1a9l/Z
        RggdrElfcx8prsKrzF/EU3XVREpZRoqEtPFBZo8kT6aZOqoIJkj+dwFoJUUMtwcDfkoheI9ag4oyx
        igTLy5Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt67X-0001G0-KW; Wed, 08 Jul 2020 09:12:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D27B7300739;
        Wed,  8 Jul 2020 11:12:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5876212325C9; Wed,  8 Jul 2020 11:12:01 +0200 (CEST)
Date:   Wed, 8 Jul 2020 11:12:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708091201.GP117543@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707143726.GO117543@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:37:26PM +0200, Peter Zijlstra wrote:
> + * Use the ``_irqsave`` and ``_bh`` variants instead if the read side
> + * ``_bh`` variant of write_seqlock(). Use only if the read side section
> + * ``_irq`` variant of write_sequnlock(). The write side section of
> + * ``_irqsave`` variant of write_seqlock(). Use if the read section of
> + * ``_irqrestore`` variant of write_sequnlock(). The write section of
> + * ``_bh`` variant of read_seqlock_excl(). Use this variant if the
> + * ``_bh`` variant of read_sequnlock_excl(). The closed section must've
> + * ``_irq`` variant of read_seqlock_excl(). Use this only if the
> + * ``_irq`` variant of read_sequnlock_excl(). The closed section must've
> + * ``_irqsave`` variant of read_seqlock_excl(). Use this only if the
> + * ``_irqrestore`` variant of read_sequnlock_excl(). The closed section
> + * This is the ``_irqsave`` variant of read_seqbegin_or_lock(). Use if
> + * This is the ``_irqrestore`` variant of done_seqretry(). The read

Can we also get rid of that '' nonsense, the gods of ASCII gifted us "
for this.
