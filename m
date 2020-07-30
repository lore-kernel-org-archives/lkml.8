Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5868C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8693520842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgG3M12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgG3M11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:27:27 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDE42074B;
        Thu, 30 Jul 2020 12:27:25 +0000 (UTC)
Date:   Thu, 30 Jul 2020 13:27:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        james.morse@arm.com, peterx@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] arm64: mm: add message to die() in die_kernel_fault()
Message-ID: <20200730122723.GN25149@gaia>
References: <20200730114757.13592-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730114757.13592-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:47:57PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Just to identify the kernel fault more clearly.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8afb238..3a753c7 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -289,7 +289,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  	mem_abort_decode(esr);
>  
>  	show_pte(addr);
> -	die("Oops", regs, esr);
> +	die("Oops - Page fault", regs, esr);
>  	bust_spinlocks(0);
>  	do_exit(SIGKILL);
>  }

Don't we already print enough information prior to die()?

-- 
Catalin
