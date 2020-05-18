Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29AE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgERTJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:09:21 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:43052 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgERTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:09:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 566B7100E7B45;
        Mon, 18 May 2020 19:09:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grape47_8b57717f1c942
X-Filterd-Recvd-Size: 2379
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 May 2020 19:09:17 +0000 (UTC)
Message-ID: <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 18 May 2020 12:09:16 -0700
In-Reply-To: <20200518190114.GA7757@embeddedor>
References: <20200518190114.GA7757@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 14:01 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
[]
> This issue has been out there since 2009.
> This issue was found with the help of Coccinelle and fixed _manually_.
[]
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index 7af31b245636..993a8ae6fdfb 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
>  	struct {
>  		int	lcpu;		/* systemwide logical cpu number */
>  		u64	expires;	/* next timer expiration for this cpu */
> -	} cpu[1];
> +	} cpu[];
>  };
>  
>  /*
> @@ -156,9 +156,8 @@ static __init int uv_rtc_allocate_timers(void)
>  		struct uv_rtc_timer_head *head = blade_info[bid];
>  
>  		if (!head) {
> -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> -				(uv_blade_nr_possible_cpus(bid) *
> -					2 * sizeof(u64)),
> +			head = kmalloc_node(struct_size(head, cpu,
> +				uv_blade_nr_possible_cpus(bid)),

It's probably safer to use kzalloc_node here as well.

>  				GFP_KERNEL, nid);
>  			if (!head) {
>  				uv_rtc_deallocate_timers();

