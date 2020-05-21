Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E01AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6815B208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590103168;
	bh=8cafiJEelzf4WJ/LLk0FHorXkrqE7sdt4U/xN6JWAE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rfo442osZ3ShW7ZU2MtZsGXVC5U7IZGqO7sr3xsT8CdyRoSFBlqJNmXdekHWxEX3n
	 MQoYj1AomNSp1BwE7K2tyV3CvGdxgWn3J3OPHE0zvmuBi1PGtT5TwiWtA1HKMi9PJu
	 TYX8iYccrMDdAgIn33kIXso2pFS24uzzb6nyuWtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgEUXT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUXT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:19:27 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17D3208A9;
        Thu, 21 May 2020 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590103166;
        bh=8cafiJEelzf4WJ/LLk0FHorXkrqE7sdt4U/xN6JWAE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np9y+T6CLI9Bi7doQBEdQUG+Eu1B+S0zCtdpsFDG4hpwD/ODRrRFAjYVN6qnZp1LH
         AHSRMX2eWht08NR/9CXC8W3ET9qDHd1mXXOH8COU/+pFdyknau1szmQebQea3m1moY
         3Ly3szd1iwyJKmH2gxbJ95FZLmodOXgaEtvIw9dQ=
Date:   Thu, 21 May 2020 18:24:15 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
Message-ID: <20200521232415.GD29907@embeddedor>
References: <20200518190114.GA7757@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518190114.GA7757@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+CC John Stultz <john.stultz@linaro.org> and +Kees' Reviewed-by tag]

Reviewed-by: Kees Cook <keescook@chromium.org>

On Mon, May 18, 2020 at 02:01:14PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
> 
> Also, make use of the new struct_size() helper to properly calculate the
> total size needed to allocate dynamic memory for struct uv_rtc_timer_head.
> Notice that, due to the use of a one-element array, space for an extra
> struct cpu:
> 
> struct {
> 	int     lcpu;           /* systemwide logical cpu number */
> 	u64     expires;        /* next timer expiration for this cpu */
> } cpu[1]
> 
> was being allocated at the moment of applying the sizeof operator to
> struct uv_rtc_timer_head in the call to kmalloc_node() at line 159:
> 
> 159		head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> 160			(uv_blade_nr_possible_cpus(bid) *
> 161				2 * sizeof(u64)),
> 162			GFP_KERNEL, nid);
> 
> but that extra cpu[] was never actually being accessed due to the
> following piece of code at line 168:
> 
> 168		head->ncpus = uv_blade_nr_possible_cpus(bid);
> 
> and the piece of code at line 187:
> 
> 187		for (c = 0; c < head->ncpus; c++) {
> 188			u64 exp = head->cpu[c].expires;
> 189			if (exp < lowest) {
> 190				bcpu = c;
> 191				lowest = exp;
> 192			}
> 193		}
> 
> so heap space was being wasted.
> 
> Another thing important to notice is that through the use of the
> struct_size() helper, code at line 161:
> 
> 161		2 * sizeof(u64)),
> 
> is changed to now be the actual size of struct cpu; see
> sizeof(*(p)->member) at include/linux/overflow.h:314:
> 
> 314 #define struct_size(p, member, n)                                       \
> 315         __ab_c_size(n,                                                  \
> 316                     sizeof(*(p)->member) + __must_be_array((p)->member),\
> 317                     sizeof(*(p)))
> 
> As a side note, the original developer could have implemented code at line
> 161: 2 * sizeof(64) as follows:
> 
> sizeof(*head->cpu)
> 
> This issue has been out there since 2009.
> 
> This issue was found with the help of Coccinelle and fixed _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/x86/platform/uv/uv_time.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
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
>  				GFP_KERNEL, nid);
>  			if (!head) {
>  				uv_rtc_deallocate_timers();
> -- 
> 2.26.2
> 
