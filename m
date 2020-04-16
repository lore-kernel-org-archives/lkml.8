Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5789C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B099720771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587021035;
	bh=ryc6wxWPw9o1JBywIVfmLfQfPLw/yNBffMQNg8SEEvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w5vTu1P+4Tzm5di3HHv85R1Pl6gUqWZjFBLmt03nebyPWlAcwu52IqAMhMHeA51p/
	 R/PEgXWL1jYB8qjFsP8B9lB61mtC7ijGzbdbQtwBxqVo+9XyVPX/K2/gXyXep3S94K
	 0b3mNZfzoZOo4L9AX4eJkXPwdgxD5hTCNnjTaHxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438533AbgDPHKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437186AbgDPHK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:10:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257FB20771;
        Thu, 16 Apr 2020 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587021029;
        bh=ryc6wxWPw9o1JBywIVfmLfQfPLw/yNBffMQNg8SEEvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dt7W3di72wz2z2ARB0niotEho/ZirUa6JoEZ7XeG02dWm9SXiDH05NrrrxyPbQUjx
         WFG4WMY/l+XMZwptWODKf3D6CfxcAz3LWkDk9W30P/Iz6CVAu4FlTaoDD3lttWLDKC
         jhV6CPm++eT0Xm3S4MG6sU04fMvY24BAx6CCJsjE=
Date:   Thu, 16 Apr 2020 08:10:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Perf: support to unwind userspace application stacks
 generated with thumb.
Message-ID: <20200416071023.GB29742@willie-the-truck>
References: <20200416053829.130395-1-jiping.ma2@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416053829.130395-1-jiping.ma2@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:38:29PM +0800, Jiping Ma wrote:
> Only push sp and lr in the stack for thumb mode. it will go
> through the stack find sp and lr.
> 
> Change this to the more detailed description of the patch
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  arch/arm64/kernel/perf_callchain.c | 36 +++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
> index bcafd7dcfe8b..97dde271c121 100644
> --- a/arch/arm64/kernel/perf_callchain.c
> +++ b/arch/arm64/kernel/perf_callchain.c
> @@ -104,6 +104,30 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
>  
>  	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
>  }
> +
> +void
> +user_backtrace_thumb(struct perf_callchain_entry_ctx *entry,
> +		     struct pt_regs *regs)
> +{
> +	u32 sp;
> +	u32 *sp_t;
> +	/*
> +	 * Only push sp, lr to stack.
> +	 */
> +	for (sp = regs->compat_sp; (sp < current->mm->start_stack) &&
> +		(entry->nr < entry->max_stack); sp += 4) {
> +		sp_t = (u32 *)(unsigned long)sp;
> +		if ((*sp_t > regs->compat_sp) &&
> +			(*sp_t < current->mm->start_stack)) {
> +			if (*(sp_t + 1) < current->mm->end_code &&
> +				*(sp_t + 1) > current->mm->start_code) {
> +				perf_callchain_store(entry,  *(sp_t + 1)-1);
> +				sp += 4;
> +			}
> +		}
> +	}
> +}

This looks like a pile of fragile heuristics to me. Why don't you just use
libunwind in userspace, the same way you'd have to if you compiled without
framepointers?

Will
