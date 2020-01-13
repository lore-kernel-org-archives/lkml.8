Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1343222D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgAMB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgAMB66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:58:58 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFCD21744;
        Mon, 13 Jan 2020 01:58:56 +0000 (UTC)
Subject: Re: [PATCH] m68k: Switch to asm-generic/hardirq.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200112174854.2726-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <55c34fc6-cac0-0c53-37d7-d46658a327fc@linux-m68k.org>
Date:   Mon, 13 Jan 2020 11:58:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112174854.2726-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/1/20 3:48 am, Geert Uytterhoeven wrote:
> Classic m68k with MMU was converted to generic hardirqs a long time ago,
> and there are no longer include dependency issues preventing the direct
> use of asm-generic/hardirq.h.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
>   arch/m68k/include/asm/Kbuild    |  1 +
>   arch/m68k/include/asm/hardirq.h | 29 -----------------------------
>   2 files changed, 1 insertion(+), 29 deletions(-)
>   delete mode 100644 arch/m68k/include/asm/hardirq.h
> 
> diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
> index 591d53b763b71b27..63f12afc48749c96 100644
> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -8,6 +8,7 @@ generic-y += emergency-restart.h
>   generic-y += exec.h
>   generic-y += extable.h
>   generic-y += futex.h
> +generic-y += hardirq.h
>   generic-y += hw_irq.h
>   generic-y += irq_regs.h
>   generic-y += irq_work.h
> diff --git a/arch/m68k/include/asm/hardirq.h b/arch/m68k/include/asm/hardirq.h
> deleted file mode 100644
> index 11793165445df45a..0000000000000000
> --- a/arch/m68k/include/asm/hardirq.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __M68K_HARDIRQ_H
> -#define __M68K_HARDIRQ_H
> -
> -#include <linux/threads.h>
> -#include <linux/cache.h>
> -#include <asm/irq.h>
> -
> -#ifdef CONFIG_MMU
> -
> -static inline void ack_bad_irq(unsigned int irq)
> -{
> -	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
> -}
> -
> -/* entry.S is sensitive to the offsets of these fields */
> -typedef struct {
> -	unsigned int __softirq_pending;
> -} ____cacheline_aligned irq_cpustat_t;
> -
> -#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
> -
> -#else
> -
> -#include <asm-generic/hardirq.h>
> -
> -#endif /* !CONFIG_MMU */
> -
> -#endif
> 
