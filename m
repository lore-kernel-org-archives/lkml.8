Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E991C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F122053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgHOV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:21 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:46386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgHOV6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:58:15 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 77CD218018769
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:18:38 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3B2BF1801874F;
        Sat, 15 Aug 2020 04:18:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: unit59_4e1053f27002
X-Filterd-Recvd-Size: 3572
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 04:18:36 +0000 (UTC)
Message-ID: <2364837d5dcf80f3bdece75d8bfc2f9747467571.camel@perches.com>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>
Date:   Fri, 14 Aug 2020 21:18:35 -0700
In-Reply-To: <20200815035228.GC582@jagdpanzerIV.localdomain>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
         <20200815035228.GC582@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-15 at 12:52 +0900, Sergey Senozhatsky wrote:
> Cc-ing John
> 
> On (20/08/14 10:53), Joe Perches wrote:
> [..]
> 
> In general, the idea looks nice.
> 
> > +static noinline_for_stack
> > +char *vma_addr(char *buf, char *end, void *ip,
> > +	       struct printf_spec spec, const char *fmt)
> > +{
> > +#ifdef CONFIG_MMU
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +
> > +	/*
> > +	 * we might be running from an atomic context so we cannot sleep
> > +	 */
> > +	if (!mmap_read_trylock(mm))
> > +		return buf;
> > +
> > +	vma = find_vma(mm, (unsigned long)ip);
> > +	if (vma && vma->vm_file) {
> > +		char *p;
> > +		struct file *f = vma->vm_file;
> > +		char *page = (char *)__get_free_page(GFP_NOWAIT);
> 
> Hmm, this is huge. For the time being this is going to introduce lock
> inversion chains:
> 
> 	PRINTK -> printk_locks -> MM -> mm_locks
> 
> vs
> 	MM -> mm_locks -> PRINTK -> printk_locks
> 
> Another thing to mention is
> 
> 	PRINTK -> printk_locks -> MM (WANR_ON/etc) -> PRINTK
> 
> we are in printk_safe, currently, but that's going to change.
> 
> We might not be ready to take this as of now, but things can change
> once we drop printk_locks.
> 
> > +		if (page) {
> > +			p = file_path(f, page, PAGE_SIZE);
> > +			if (IS_ERR(p))
> > +				p = "?";
> > +			buf = string(buf, end, kbasename(p), default_str_spec);
> > +			buf = string_nocheck(buf, end, "[", default_str_spec);
> > +			buf = pointer_string(buf, end,
> > +					     (void *)vma->vm_start,
> > +					     default_hex_spec);
> > +			buf = string_nocheck(buf, end, "+", default_str_spec);
> > +			buf = pointer_string(buf, end,
> > +					     (void *)(vma->vm_end - vma->vm_start),
> > +					     default_hex_spec);
> > +			buf = string_nocheck(buf, end, "]", default_str_spec);
> > +			free_page((unsigned long)page);
> > +		}
> > +	}
> > +	mmap_read_unlock(mm);
> > +#else
> > +	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);
> 
> Hmm, we don't usually do that CONFIG_FOO=n thing, I think we just need
> to skip %pv and print nothing.

I don't.

Right now, include/linux/mm.h has

#ifdef CONFIG_MMU
void print_vma_addr(char *prefix, unsigned long rip);
#else
static inline void print_vma_addr(char *prefix, unsigned long rip)
{
}
#endif

and the 'v' can't be #ifdef'd in vsprintf/pointer()
otherwise %pv would fallthrough to

	return ptr_to_id(buf, end, ptr, spec);


