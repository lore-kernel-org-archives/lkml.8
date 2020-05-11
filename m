Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC53C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01199206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589212699;
	bh=ZUL/euW9ZqyW+8lzBy3LfGieslVZmcH38lLT670jFJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nhh3D8aWh4mjkAHc9T+D5uh5N2y6smRMZ0LTlT/BG77xJBkIKLT2QYrPWzy87WvlZ
	 qtkkK51j7YHVvuiMbbMou/YmwH5259cdedlfAqYjiRi+/apGjkf734IOlq26PguKtY
	 3aOhTLz6NIyBTiuVCS3LEbxwZM1zCVck+v4D59x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgEKP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKP6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:58:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5549B206D7;
        Mon, 11 May 2020 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589212697;
        bh=ZUL/euW9ZqyW+8lzBy3LfGieslVZmcH38lLT670jFJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZGe/zNmXwFu8Fs0Em2kMBqlIJCgYH17jf32/NXfxBq98NMTNw10pZWEOJ4YKQ6/C
         d3LrpYXeGvc0Km4SG8Bf9CSrGrRRU1PpCpgN531mHjopoo8glvrTR9js2GI3V3Nu3X
         g7ze/2XM+ukbhw8VWsdEWSx4LMDCFEKzZ+MiINls=
Date:   Mon, 11 May 2020 16:58:13 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511155812.GB22270@willie-the-truck>
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
 <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
 <20200509213654.GO2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509213654.GO2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 02:36:54PM -0700, Paul E. McKenney wrote:
> On Sat, May 09, 2020 at 12:53:38PM -0400, Qian Cai wrote:
> > 
> > 
> > > On May 9, 2020, at 12:12 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > Ah, and I forgot to ask.  Why "if (data_race(prev->next == node)" instead
> > > of "if (data_race(prev->next) == node"?
> > 
> > I think the one you suggested is slightly better to point out the exact race. Do you want me to resend or you could squash it instead?
> 
> The patch was still at the top of my stack, so I just amended it.  Here
> is the updated version.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 13e69ca01ce1621ce74248bda86cfad47fa5a0fa
> Author: Qian Cai <cai@lca.pw>
> Date:   Tue Feb 11 08:54:15 2020 -0500
> 
>     locking/osq_lock: Annotate a data race in osq_lock
>     
>     The prev->next pointer can be accessed concurrently as noticed by KCSAN:
>     
>      write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
>       osq_lock+0x25f/0x350
>       osq_wait_next at kernel/locking/osq_lock.c:79
>       (inlined by) osq_lock at kernel/locking/osq_lock.c:185
>       rwsem_optimistic_spin
>       <snip>
>     
>      read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
>       osq_lock+0x196/0x350
>       osq_lock at kernel/locking/osq_lock.c:157
>       rwsem_optimistic_spin
>       <snip>
>     
>     Since the write only stores NULL to prev->next and the read tests if
>     prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
>     shattered, the code is still working correctly. Thus, mark it as an
>     intentional data race using the data_race() macro.
>     
>     Signed-off-by: Qian Cai <cai@lca.pw>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 1f77349..1de006e 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>  	 */
>  
>  	for (;;) {
> -		if (prev->next == node &&
> +		/*
> +		 * cpu_relax() below implies a compiler barrier which would
> +		 * prevent this comparison being optimized away.
> +		 */
> +		if (data_race(prev->next) == node &&
>  		    cmpxchg(&prev->next, node, NULL) == node)
>  			break;

I'm fine with the data_race() placement, but I don't find the comment
very helpful. We assign the result of a READ_ONCE() to 'prev' in the
loop, so I don't think that the cpu_relax() is really relevant.

The reason we don't need READ_ONCE() here is because if we race with
the writer then either we'll go round the loop again after accidentally
thinking prev->next != node, or we'll erroneously attempt the cmpxchg()
because we thought they were equal and that will fail.

Make sense?

Will
