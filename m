Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B989C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C292087D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1LaOXVpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390944AbgEYORm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390872AbgEYORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:17:42 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kr9buj3Bzk9juOwV9KAH42CouIIua7TPJ6CsB4FDIvo=; b=1LaOXVpxbh4kKq0WRwK771k5k+
        IFL66RFj2QvC04aQnG2UgDS6g2q4/9jSBXN9vYRSH9Lvv+WIGEtu9XIF6sbUnlGLoB+1Ex4Btc1ha
        KDeEetD7C/tNJJWw/yY6CfkHu22dmwWwUG12Sf4sl3e372SyF7Z9Xq9PZW596ONN1EBZPgBF8nyOF
        jPdH7j7JcyxfjEiqCllRK4JPte946n6+tBD6nRh1X35GPD8vEEe7iRMFByyGqEB+3CoTYVgHt1JE7
        TvUZSQTwMVSg8EVEt9ffMKMFrwRL3vnU04Tr2Tylxs4S7KaTSGkFbGcQSdmAUXaHtWEI5XGpQF+tv
        3GDKOqzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdDuk-0000Ae-0B; Mon, 25 May 2020 14:17:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94E6B300478;
        Mon, 25 May 2020 16:17:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 800832389FE09; Mon, 25 May 2020 16:17:11 +0200 (CEST)
Date:   Mon, 25 May 2020 16:17:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200525141711.GI325303@hirez.programming.kicks-ass.net>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
 <20200521093938.GG325280@hirez.programming.kicks-ass.net>
 <20200521104937.GB325303@hirez.programming.kicks-ass.net>
 <20200521110027.GC325303@hirez.programming.kicks-ass.net>
 <20200521124113.GC15455@lenoir>
 <20200525132105.GW325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525132105.GW325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:21:05PM +0200, Peter Zijlstra wrote:
> -	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> -	if (!(flags & NOHZ_KICK_MASK))
> +	if (idle != CPU_IDLE)
>  		return false;
>  
>  	_nohz_idle_balance(this_rq, flags, idle);

Bah, I think I broke something there. Lemme go mend.
