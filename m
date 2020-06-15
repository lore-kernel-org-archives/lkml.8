Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725FB20679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4FF/1Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgFOPzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:55:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0375C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Xkq9S9SwcNKk+N4luSOtQt3D5uwFKdvMxktzgQmU5I=; b=m4FF/1Ke402iooXR6InOkwH6c5
        tdE84iaiKdTdKlax6aqg2lBpDPJ2+yiu9hEavcA1uoFc2NMD1fQcIicLCnrNTpFsQfuqlm1fNiD+7
        Y3ch5eiZBW28lHzAFu1ZyOrSrQ0MijTpwWlZyJJmEpwcEoMsakJNVkhSDxq5gevK4vRgD11zJwTOE
        Pxk3OEbaltbpB/FqD8hWQAMHjzKQ5WevBdQUEipEFpwJQT/X58xd85LuzdsciB5qkxCl3YFSxCXfC
        u8bx7Zvyba3DqQbZ4rceeV4vZo2/XFfhGnaFZSs/3CnezfyhxfBpunC/m/D3OnwLpovN9FiiTPxPW
        CtO4tLdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkrS7-0003jl-HO; Mon, 15 Jun 2020 15:55:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D09DD30081A;
        Mon, 15 Jun 2020 17:55:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAE9620E05A91; Mon, 15 Jun 2020 17:55:13 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:55:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615155513.GG2554@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:49:05PM +0200, Peter Zijlstra wrote:
> @@ -983,13 +993,17 @@ noinstr void rcu_nmi_enter(void)
>  		if (!in_nmi())
>  			rcu_cleanup_after_idle();
>  
> +		instrumentation_begin();
> +		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> +		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> +		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
> +		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> +
>  		incby = 1;
>  	} else if (!in_nmi()) {
>  		instrumentation_begin();
>  		rcu_irq_enter_check_tick();
> -		instrumentation_end();
>  	}
> -	instrumentation_begin();
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  rdp->dynticks_nmi_nesting,
>  			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));

Oh, that's lost a possible instrumentation_begin() :/ But weirdly
objtool didn't complain about that... Let me poke at that.

