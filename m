Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3009C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851FC2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofwmEIfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBZJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:23:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46342 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GKIB9rmTQ2B9i7Ks2Xba/rmqH7IIJo9VHXRLvcBLAVQ=; b=ofwmEIfmOGPvRiPdrm5xsuK2ok
        3eht0oX9e7HME3bDKdcXxFpagw9pzcZQR76l1DPOtK7RZ0YG7/xoXEsN+HiqaON8z0vYmYRk8o+2d
        Ao082MtuqhlDaEiRksAK2Bf6/yOX6dMhEVCL2WTU1XgnxF58p6TFR2MtJjFgc5sK7lvQAtVD/aBQ4
        q7zVHpRLjRChXScEfLExVUK2akC0iy9z0abTrk3uMnboBDht6DGNIH0FGuXN91c0oRM2JkmDnyLOD
        uqf2vxHLXkB+AiHZQ3uT313MJItJZbOK/uqXuB5q+FcuD3yv4oBeGFeL+Xt6CKAznKo1c07rpD2Hb
        UcPa/zpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6suo-0000Hw-Jv; Wed, 26 Feb 2020 09:23:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F52D300478;
        Wed, 26 Feb 2020 10:21:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB4282013DAEE; Wed, 26 Feb 2020 10:23:35 +0100 (CET)
Date:   Wed, 26 Feb 2020 10:23:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 16/16] x86/entry: Disable interrupts in IDTENTRY
Message-ID: <20200226092335.GS18400@hirez.programming.kicks-ass.net>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.764810350@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225224145.764810350@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:33:37PM +0100, Thomas Gleixner wrote:
> Not all exceptions guarantee to return with interrupts disabled. Disable
> them in idtentry_exit() which is invoked on all regular (non IST) exception
> entry points. Preparatory patch for further consolidation of the return
> code.

ISTR a patch that undoes cond_local_irq_enable() in the various trap
handlers. Did that get lost or is that still on the TODO list somewhere?

Once we do that, this can turn into an assertion that IRQs are in fact
disabled.
