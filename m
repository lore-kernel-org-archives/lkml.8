Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D6A20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgGULTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:19:43 -0400
Received: from exmail.andestech.com ([60.248.187.195]:44066 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGULTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:19:42 -0400
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 07:19:41 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 06LAwicE080338
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:58:44 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 06LAwPXe080275;
        Tue, 21 Jul 2020 18:58:25 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcfdc88 (10.0.15.132) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.123.3; Tue, 21 Jul 2020 19:07:15 +0800
Date:   Tue, 21 Jul 2020 19:07:17 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Message-ID: <20200721110717.GA19721@atcfdc88>
References: <20200720114448.205876-1-hch@lst.de>
 <20200720114448.205876-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200720114448.205876-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.132]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 06LAwPXe080275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:44:48PM +0200, Christoph Hellwig wrote:
> Use the proper get_kernel_nofault helper to access an unsafe kernel
> pointer without faulting instead of playing with set_fs and get_user.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/kernel/traps.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index b66f889bc6df9b..ee0d9ae192a504 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -25,17 +25,8 @@ extern void show_pte(struct mm_struct *mm, unsigned long addr);
>  void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
>  {
>  	unsigned long first;
> -	mm_segment_t fs;
>  	int i;
>  
> -	/*
> -	 * We need to switch to kernel mode so that we can use __get_user
> -	 * to safely read from kernel space.  Note that we now dump the
> -	 * code first, just in case the backtrace kills us.
> -	 */
> -	fs = get_fs();
> -	set_fs(KERNEL_DS);
> -
>  	pr_emerg("%s(0x%08lx to 0x%08lx)\n", lvl, bottom, top);
>  
>  	for (first = bottom & ~31; first < top; first += 32) {
> @@ -48,7 +39,9 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
>  		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
>  			if (p >= bottom && p < top) {
>  				unsigned long val;
> -				if (__get_user(val, (unsigned long *)p) == 0)
> +
> +				if (get_kernel_nofault(val,
> +						(unsigned long *)p) == 0)
>  					sprintf(str + i * 9, " %08lx", val);
>  				else
>  					sprintf(str + i * 9, " ????????");
> @@ -56,8 +49,6 @@ void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
>  		}
>  		pr_emerg("%s%04lx:%s\n", lvl, first & 0xffff, str);
>  	}
> -
> -	set_fs(fs);
>  }
>  
>  EXPORT_SYMBOL(dump_mem);
> -- 
> 2.27.0
>
Hi Christoph,

Thank you!
Acked-by: Nick Hu <nickhu@andestech.com>
