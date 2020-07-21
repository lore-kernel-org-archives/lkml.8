Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A93C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD720792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgGULTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:19:46 -0400
Received: from atcsqr.andestech.com ([60.248.187.195]:33779 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGULTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:19:45 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 06LAxsIa080540
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:59:54 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 06LAxfUT080504;
        Tue, 21 Jul 2020 18:59:41 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcfdc88 (10.0.15.132) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.123.3; Tue, 21 Jul 2020 19:08:33 +0800
Date:   Tue, 21 Jul 2020 19:08:34 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nds32: remove dump_instr
Message-ID: <20200721110834.GB19721@atcfdc88>
References: <20200720114448.205876-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200720114448.205876-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.132]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 06LAxfUT080504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:44:47PM +0200, Christoph Hellwig wrote:
> dump_inst has a return before actually doing anything, so just drop the
> whole thing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/kernel/traps.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
> 
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index 6a9772ba739276..b66f889bc6df9b 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -62,40 +62,6 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
>  
>  EXPORT_SYMBOL(dump_mem);
>  
> -static void dump_instr(struct pt_regs *regs)
> -{
> -	unsigned long addr = instruction_pointer(regs);
> -	mm_segment_t fs;
> -	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
> -	int i;
> -
> -	return;
> -	/*
> -	 * We need to switch to kernel mode so that we can use __get_user
> -	 * to safely read from kernel space.  Note that we now dump the
> -	 * code first, just in case the backtrace kills us.
> -	 */
> -	fs = get_fs();
> -	set_fs(KERNEL_DS);
> -
> -	pr_emerg("Code: ");
> -	for (i = -4; i < 1; i++) {
> -		unsigned int val, bad;
> -
> -		bad = __get_user(val, &((u32 *) addr)[i]);
> -
> -		if (!bad) {
> -			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
> -		} else {
> -			p += sprintf(p, "bad PC value");
> -			break;
> -		}
> -	}
> -	pr_emerg("Code: %s\n", str);
> -
> -	set_fs(fs);
> -}
> -
>  #define LOOP_TIMES (100)
>  static void __dump(struct task_struct *tsk, unsigned long *base_reg,
>  		   const char *loglvl)
> @@ -179,7 +145,6 @@ void die(const char *str, struct pt_regs *regs, int err)
>  
>  	if (!user_mode(regs) || in_interrupt()) {
>  		dump_mem("Stack: ", regs->sp, (regs->sp + PAGE_SIZE) & PAGE_MASK);
> -		dump_instr(regs);
>  		dump_stack();
>  	}
>  
> -- 
> 2.27.0
>

Acked-by: Nick Hu <nickhu@andestech.com> 
