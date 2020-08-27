Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BE020825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgH0AOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgH0AOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:14:45 -0400
Received: from [192.168.0.106] (193-116-198-1.tpgi.com.au [193.116.198.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8582B20791;
        Thu, 27 Aug 2020 00:14:44 +0000 (UTC)
Subject: Re: [PATCH] m68k: Revive _TIF_* masks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200826122923.22821-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <aae200e7-2618-b17a-3e88-ee349a75c74d@linux-m68k.org>
Date:   Thu, 27 Aug 2020 10:14:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826122923.22821-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26/8/20 10:29 pm, Geert Uytterhoeven wrote:
> While the core m68k code does not use the _TIF_* masks anymore, there
> exists generic code that relies on their presence.  Fortunately none of
> that code is used on m68k, currently.
> 
> Re-add the various _TIF_* masks, which were removed in commit
> cddafa3500fde4a0 ("m68k/m68knommu: merge MMU and non-MMU
> thread_info.h"), to avoid future nasty surprises.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


>   arch/m68k/include/asm/thread_info.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
> index 015f1ca383053a39..3689c6718c883d23 100644
> --- a/arch/m68k/include/asm/thread_info.h
> +++ b/arch/m68k/include/asm/thread_info.h
> @@ -68,4 +68,12 @@ static inline struct thread_info *current_thread_info(void)
>   #define TIF_MEMDIE		16	/* is terminating due to OOM killer */
>   #define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal */
>   
> +#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> +#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> +#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_DELAYED_TRACE	(1 << TIF_DELAYED_TRACE)
> +#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> +#define _TIF_MEMDIE		(1 << TIF_MEMDIE)
> +#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
> +
>   #endif	/* _ASM_M68K_THREAD_INFO_H */
> 
