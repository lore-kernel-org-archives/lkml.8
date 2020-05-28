Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A54AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5021532
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fv6Rb/bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405009AbgE1QSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:18:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404997AbgE1QSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=htjljCPzd1c4kmormW0XrtycmMbB50z3R0kch7eOlKE=; b=Fv6Rb/bQHB9l3LlI4jwJZGNRwt
        dEs9f7NJAyK83DaeQ7V1GTzKHgB6IkHiIioGU/Pz7oUK+T4Kk7WPFc5qKIcANwP4plOuts6rymW5g
        IENc9JY/Tx1d/XserZp1yNyoSw0Uvqrdb07uWILrYTC0vTmGcKeC8ue4doDNKFistGf1vMg85/c5O
        Qplex2ZVceaIw5NjwHB2q1pbL2V6df91IswtVMJWyUcrAf9sja8bDfo+g7JIiUMtlWFV/zn/nraIt
        sngDxnqI1E0dU9afoTDavZzJ9fPb5Iq0T0eHTZK5sMwPrfu+kJX+FkLG+2GQw3WtUuOXjE5C4dvrE
        ScNBBx5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeLCl-0005W6-KN; Thu, 28 May 2020 16:16:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AE229836F8; Thu, 28 May 2020 18:16:16 +0200 (CEST)
Date:   Thu, 28 May 2020 18:16:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 5/5] x86/idt: Consolidate idt functionality
Message-ID: <20200528161616.GK2483@worktop.programming.kicks-ass.net>
References: <20200528145315.727724091@linutronix.de>
 <20200528145523.084915381@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528145523.084915381@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:53:20PM +0200, Thomas Gleixner wrote:

> -#ifdef CONFIG_X86_64
> -DECLARE_PER_CPU(u32, debug_idt_ctr);
> -static __always_inline bool is_debug_idt_enabled(void)
> -{
> -	if (this_cpu_read(debug_idt_ctr))
> -		return true;
> -
> -	return false;
> -}
> -
> -static __always_inline void load_debug_idt(void)
> -{
> -	load_idt((const struct desc_ptr *)&debug_idt_descr);
> -}
> -#else
> -static inline bool is_debug_idt_enabled(void)
> -{
> -	return false;
> -}
> -
> -static inline void load_debug_idt(void)
> -{
> -}
> -#endif

I have a patch that does this too; except it doesn't put it back. I like
that one better :-)
