Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42168C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138DA2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588859541;
	bh=IwsXYXmDs9aNaYPa4+QMKqQ65GYmJMLHHgZOQO0ito0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLZPLbqJRriiHsR2OeAnohqPmTFZKivUIZ5/NIQLgMRUFAir5q4fdJgh7MFaVrIT8
	 K59UoKVwYAP6c+z/U7vc5gbAoLVX+Vvz3OS+Tj1JBNtPfiRBDASFVmYfPrToy4Y1nE
	 WqOM1FpCbwzwn8fVTuvjXx86zfKOg2ZSNQfYs/EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEGNwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgEGNwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:52:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681E52073A;
        Thu,  7 May 2020 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588859539;
        bh=IwsXYXmDs9aNaYPa4+QMKqQ65GYmJMLHHgZOQO0ito0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnd4bYDWYAIZ4zCHfaiJgGW7gq/naBS9fqditzfIOrsnv40Et2ZRgwpNfZocNknka
         Axg7s2N1KjHSV9RE7TilOJ7BeJnjKctTrwdNmwvVRrJhDfMgNkonFMoZ7eABSB+qyC
         PuuBS2r0GmqVqCNKkbKQu7tNa+Iw0qnZXMIV3cCs=
Date:   Thu, 7 May 2020 14:52:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, Dave.Martin@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, 0x7f454c46@gmail.com, tglx@linutronix.de,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hushiyuan@huawei.com,
        hewenliang4@huawei.com
Subject: Re: [PATCH] arm64: stacktrace: Factor out some common code info
 on_stack()
Message-ID: <20200507135213.GA32706@willie-the-truck>
References: <10b188af-a03b-3acc-8a06-cf31a46f735a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b188af-a03b-3acc-8a06-cf31a46f735a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:28:19PM +0800, Yunfeng Ye wrote:
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index fdb913cc0bcb..b92bef2fb6cd 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -69,27 +69,40 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
> 
>  DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
> 
> -static inline bool on_irq_stack(unsigned long sp,
> +static inline bool on_stack(unsigned long sp, unsigned long low,
> +				unsigned long high, enum stack_type type,
>  				struct stack_info *info)
>  {
> -	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
> -	unsigned long high = low + IRQ_STACK_SIZE;
> -
> -	if (!low)
> -		return false;
> -
>  	if (sp < low || sp >= high)
>  		return false;
> 
>  	if (info) {
>  		info->low = low;
>  		info->high = high;
> -		info->type = STACK_TYPE_IRQ;
> +		info->type = type;
>  	}
> -
>  	return true;
>  }
> 
> +static inline bool on_valid_stack(unsigned long sp, unsigned long low,
> +				unsigned long high, enum stack_type type,
> +				struct stack_info *info)
> +{
> +	if (!low)
> +		return false;
> +
> +	return on_stack(sp, low, high, type, info);
> +}

Do we need this as distinct from on_stack()? Afaict, 'low' is never
going to be NULL for the on_stack() callers, so I suggest just having
on_stack() check 'low' and getting everybody to call that instead.

Make sense?

Will
