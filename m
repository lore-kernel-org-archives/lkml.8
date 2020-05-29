Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BCFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6722077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8wq3Vs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgE2QTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:19:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgE2QTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ybXgUUvnJ5OVqyLh6pi2nJ1zfYcPDr1hIJqrcDCVeg=; b=R8wq3Vs4NI9Ph2F1lL/a0yf/14
        TLpGeOnf1U57OJaHcy8N0dd7Z7/vWRUJUaU0tk+caNsacKB6MeFNxs1bFkhE5czosiT6QRlsMe0EK
        7ldOcnOi8GrwfCy+0cG7XcWMdpbhrDwr9YQ3pihnujed8XLkBYQv0/ChqNKK7bOhHsdTV2oaBLNpL
        Lj+d0AZJI6vJ7L/IA8qYOh5c3PwBvAC1vlf0RLt6BHsxqIB/xPZe4I1wntF1K+ol6DT6WMdOUfaGW
        dr0QWrATOLhAt2ZKWE1nWJjJHEVlG+kjN4mhQoQDnH1FeChyVBGXkcbFpret13qP1cf7rIGqbBJqX
        /cZCq5VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jehge-0000wX-U3; Fri, 29 May 2020 16:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD32D3012C3;
        Fri, 29 May 2020 18:16:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABF8E2BB457CD; Fri, 29 May 2020 18:16:47 +0200 (CEST)
Date:   Fri, 29 May 2020 18:16:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH v2 3/6] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200529161647.GE706460@hirez.programming.kicks-ass.net>
References: <20200528140535.206916549@infradead.org>
 <20200528140946.831087909@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528140946.831087909@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:05:38PM +0200, Peter Zijlstra wrote:
> +#include <asm/percpu.h>
> +#include <asm/percpu.h>

If we change those to <linux/percpu-defs.h>, in direct conflict with
what the header says about itself, all builds seem to be good again.

s390, sparc64, power64 all build again.
