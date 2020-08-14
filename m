Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5862E2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgHNSiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgHNSiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:38:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BB920774;
        Fri, 14 Aug 2020 18:38:18 +0000 (UTC)
Date:   Fri, 14 Aug 2020 14:38:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
Message-ID: <20200814143816.33325a49@oasis.local.home>
In-Reply-To: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 10:53:03 -0700
Joe Perches <joe@perches.com> wrote:

> There is a print_vma_addr function used several places
> that requires KERN_CONT use.
> 
> Add a %pv mechanism to avoid the need for KERN_CONT.
> 
> An example conversion is arch/x86/kernel/signal.c
> 
> from:
> 	if (show_unhandled_signals && printk_ratelimit()) {
> 		printk("%s"
> 		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx",
> 		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
> 		       me->comm, me->pid, where, frame,
> 		       regs->ip, regs->sp, regs->orig_ax);
> 		print_vma_addr(KERN_CONT " in ", regs->ip);
> 		pr_cont("\n");
> to:
> 		printk("%s"
> 		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx in %pv\n",
> 		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
> 		       me->comm, me->pid, where, frame,
> 		       regs->ip, regs->sp, regs->orig_ax, (void *)regs->ip);
> ---
>  lib/vsprintf.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index c155769559ab..654402c43f8d 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -995,6 +995,12 @@ static const struct printf_spec default_dec_spec = {
>  	.precision = -1,
>  };
>  
> +static const struct printf_spec default_hex_spec = {
> +	.base = 16,
> +	.precision = -1,
> +	.flags = SMALL,
> +};
> +
>  static const struct printf_spec default_dec02_spec = {
>  	.base = 10,
>  	.field_width = 2,
> @@ -2089,6 +2095,50 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +static noinline_for_stack
> +char *vma_addr(char *buf, char *end, void *ip,
> +	       struct printf_spec spec, const char *fmt)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * we might be running from an atomic context so we cannot sleep
> +	 */
> +	if (!mmap_read_trylock(mm))
> +		return buf;
> +
> +	vma = find_vma(mm, (unsigned long)ip);
> +	if (vma && vma->vm_file) {
> +		char *p;
> +		struct file *f = vma->vm_file;
> +		char *page = (char *)__get_free_page(GFP_NOWAIT);
> +
> +		if (page) {
> +			p = file_path(f, page, PAGE_SIZE);
> +			if (IS_ERR(p))
> +				p = "?";
> +			buf = string(buf, end, kbasename(p), default_str_spec);
> +			buf = string_nocheck(buf, end, "[", default_str_spec);
> +			buf = pointer_string(buf, end,
> +					     (void *)vma->vm_start,
> +					     default_hex_spec);
> +			buf = string_nocheck(buf, end, "+", default_str_spec);
> +			buf = pointer_string(buf, end,
> +					     (void *)(vma->vm_end - vma->vm_start),
> +					     default_hex_spec);
> +			buf = string_nocheck(buf, end, "]", default_str_spec);
> +			free_page((unsigned long)page);
> +		}
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);
> +#endif

I'm fine with all his, but I feel more comfortable if this patch
created a single copy of the code. Perhaps add:

diff --git a/mm/memory.c b/mm/memory.c
index 87ec87cdc1ff..795a4db4d83d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4771,32 +4771,7 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  */
 void print_vma_addr(char *prefix, unsigned long ip)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	/*
-	 * we might be running from an atomic context so we cannot sleep
-	 */
-	if (!mmap_read_trylock(mm))
-		return;
-
-	vma = find_vma(mm, ip);
-	if (vma && vma->vm_file) {
-		struct file *f = vma->vm_file;
-		char *buf = (char *)__get_free_page(GFP_NOWAIT);
-		if (buf) {
-			char *p;
-
-			p = file_path(f, buf, PAGE_SIZE);
-			if (IS_ERR(p))
-				p = "?";
-			printk("%s%s[%lx+%lx]", prefix, kbasename(p),
-					vma->vm_start,
-					vma->vm_end - vma->vm_start);
-			free_page((unsigned long)buf);
-		}
-	}
-	mmap_read_unlock(mm);
+	printk("%s%pv", prefix, ip);
 }
 
 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)


And of course this would need for documentation.

-- Steve



> +	return buf;
> +}
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2254,6 +2304,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return uuid_string(buf, end, ptr, spec, fmt);
>  	case 'V':
>  		return va_format(buf, end, ptr, spec, fmt);
> +	case 'v':
> +		return vma_addr(buf, end, ptr, spec, fmt);
>  	case 'K':
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':
> 

