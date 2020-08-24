Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7584C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24C42074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598292910;
	bh=S4JVlPgfHuMmBXtrcQ9GAG3QkqAnOokvBVoiTEifj0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZfykxILz8C7qi7pLr7BrWJrTmddRlXhmUgyS4es8RLPKY8FHiekhnl1PDJ3l3MyxU
	 KgXlZMsAmJXFEMa/9P+h+Y3VLu08caa/n+rl0hD0D0+B/ksaGMZq0/hMslxvlUvMaD
	 AnG9JEQz+RFuvJbyNfVy+UoAjsCTu2+qbsN4+tYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHXSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgHXSPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:15:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC31320702;
        Mon, 24 Aug 2020 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598292907;
        bh=S4JVlPgfHuMmBXtrcQ9GAG3QkqAnOokvBVoiTEifj0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ySjPI4oojhsWZ4NwQz0/3hu2T6AcFmAvSQlwl+QQEMSSrMaw+sDUDDqouLviwUAVc
         Txnnf1e3Q6G1JHXQfEmfHHIWnH+VnhAP1chNeu++i4iT8IFPbhT+WhVEM9kfTBQtKl
         vgstHdB3QDp9L3I6gqC5byVJGX6h0b7HqlLxYAUg=
Date:   Tue, 25 Aug 2020 03:15:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825031503.57d08355bf44900af7d70536@kernel.org>
In-Reply-To: <20200824141429.GA3982@worktop.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200824141429.GA3982@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 24 Aug 2020 16:14:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 24, 2020 at 12:02:58PM +0000, Eddy_Wu@trendmicro.com wrote:
> > After bisecting, I found this behavior seems to introduce by this
> > commit: (5.8-rc1) 0d00449c7a28a1514595630735df383dec606812 x86:
> > Replace ist_enter() with nmi_enter() This make kprobe_int3_handler()
> > effectively running as NMI context, which pre_handler_kretprobe()
> > explicitly checked to prevent recursion.
> > 
> > (in_nmi() check appears from v3.17)
> > f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit
> > in NMI context to avoid deadlock
> > 
> > To make kretprobe work again with int3 breakpoint, I think we can
> > replace the in_nmi() check with in_nmi() == (1 << NMI_SHIFT) at
> > kprobe_int3_handler() and skip kretprobe if nested NMI.  Did a quick
> > test on 5.9-rc2 and it seems to be working.  I'm not sure if it is the
> > best way to do since it may also require change to other architecture
> > as well, any thought?
> 
> Masami, would it be possible to have a kretprobe specific recursion
> count here?

Hmm, good point. As I commented in f96f56780ca5 ("kprobes: Skip kretprobe
hit in NMI context to avoid deadlock"), this check is for avoiding the
deadlock with kretprobe_table_lock which is used in pre_handler *and*
kretprobe trampoline handler.

> 
> I did the below, but i'm not at all sure that isn't horrible broken. I
> can't really find many rp->lock sites and this might break things by
> limiting contention.

This is not enough. For checking the recursion of kretprobes, we might
need kretprobe_table_trylock() or kretprobe_table_busy() (but both
can be false positive)

Note that rp->lock shouldn't matter unless we will support recursive
kprobe itself. (even though, we can use raw_spin_trylock_irqsave())

Thank you,

> 
> ---
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 9be1bff4f586..0bff314cc800 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -153,6 +153,7 @@ struct kretprobe {
>  	size_t data_size;
>  	struct hlist_head free_instances;
>  	raw_spinlock_t lock;
> +	atomic_t recursion;
>  };
>  
>  struct kretprobe_instance {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..27fd096bcb9a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1934,22 +1934,17 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
> -	unsigned long hash, flags = 0;
>  	struct kretprobe_instance *ri;
> -
> -	/*
> -	 * To avoid deadlocks, prohibit return probing in NMI contexts,
> -	 * just skip the probe and increase the (inexact) 'nmissed'
> -	 * statistical counter, so that the user is informed that
> -	 * something happened:
> -	 */
> -	if (unlikely(in_nmi())) {
> -		rp->nmissed++;
> -		return 0;
> -	}
> +	unsigned long hash, flags;
> +	int rec;
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
> +	rec = atomic_fetch_inc_acquire(&rp->recursion);
> +	if (rec) {
> +		rp->nmissed++;
> +		goto out;
> +	}
>  	raw_spin_lock_irqsave(&rp->lock, flags);
>  	if (!hlist_empty(&rp->free_instances)) {
>  		ri = hlist_entry(rp->free_instances.first,
> @@ -1964,7 +1959,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  			raw_spin_lock_irqsave(&rp->lock, flags);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
>  			raw_spin_unlock_irqrestore(&rp->lock, flags);
> -			return 0;
> +			goto out;
>  		}
>  
>  		arch_prepare_kretprobe(ri, regs);
> @@ -1978,6 +1973,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		rp->nmissed++;
>  		raw_spin_unlock_irqrestore(&rp->lock, flags);
>  	}
> +out:
> +	atomic_dec(&rp->recursion);
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
