Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED5AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGVYMQdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgE0Rj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:39:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0Rj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5GDconUS+H3K1ww0DFY/n5/LgHvK82xPWYPy4Flo1Y=; b=jGVYMQdT4x67xlPFbhHlvpGZ5k
        8WQX87mcGowLUv584ELtR331KxeMWHSYHJUN5Y1XrNML4/yk7fgNhrx4jWSH4RXpaLzlUyR/j5396
        RIkoMA1ZnnpuoaZS9NMapkBF2VyCBdc8HX1EHb0MwLZw+qO+Pl7gGueLfi52B69YJ9EMaXxg6p0dR
        tUD/dfQ8F4bB3uOb5vgtD75qNTw0l67YBhhPA5/FVslBGG6gLcutU260z1rdReFy9EhfQirmg5/Fu
        TpxwtUorI3V79vS4IbOilmBXd7Bc6deTfMiKnZrgcmttAlJISwyHyp9TRrx+litPzLGQd0vhUfoX2
        xxykKVcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je01Q-0004Up-Ho; Wed, 27 May 2020 17:39:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08AA8307770;
        Wed, 27 May 2020 19:39:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6DBF2024926D; Wed, 27 May 2020 19:39:18 +0200 (CEST)
Date:   Wed, 27 May 2020 19:39:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH 2/6] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200527173918.GD706495@hirez.programming.kicks-ass.net>
References: <20200527154527.233385756@infradead.org>
 <20200527155003.202732880@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527155003.202732880@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:45:29PM +0200, Peter Zijlstra wrote:
> -do {						\
> -	if (!current->hardirq_context++)	\
> -		current->hardirq_threaded = 0;	\
> +# define lockdep_hardirq_enter()			\
> +do {							\
> +	if (!this_cpu_inc_return(hardirq_context))	\

	this_cpu_inc_return(hardirq_context) == 1

or this_cpu_fetch_inc(), which we don't have.

> +		current->hardirq_threaded = 0;		\
