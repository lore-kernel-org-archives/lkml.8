Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A811C352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D802080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581391177;
	bh=0ZZlJcK8McjXh01uz81yZISTYzV8JaT6PQSW2nSfIRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MRGFO4Zbk63ywwtNFavT6MW+O44AfdTMSunMnyhmeU8rSuJez+MzqCALtuNRTFxGq
	 oas7V2oJSORWsR2MAxE9P7XfXn8434RCzZMDZAstXa2VEzjY49xvBnQ5227wuZh510
	 V7cjrURYiyUiRag6WRJHkfxlydc59TounCY/qqX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBKDTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgBKDTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:19:35 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5D020714;
        Tue, 11 Feb 2020 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581391173;
        bh=0ZZlJcK8McjXh01uz81yZISTYzV8JaT6PQSW2nSfIRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0yjulO0gpAn3JrqNTcILV2aa0BdwPiiPtg13Gwk+GZjqSbP7Lg4hZfcfz4H1pfZF
         lo1tBdrp5GQ3T0pnkstQjBlHj0M4IVd4x7Eg3F5R3NExW89k3ywsnOwTpM48x81tdX
         PmQeMDqOY+TfvSN9IrWwiSC9g3F7jo44up3zmNBY=
Date:   Mon, 10 Feb 2020 19:19:33 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Xia <jing.xia.mail@gmail.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, rppt@linux.ibm.com,
        allison@lohutok.net, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuming.han@unisoc.com,
        chunyang.zhang@unisoc.com, Jing Xia <jing.xia@unisoc.com>
Subject: Re: [RFC] lib/show_mem.c: extend show_mem() to support showing
 drivers' memory consumption
Message-ID: <20200211031933.GA1835339@kroah.com>
References: <1579249445-27429-1-git-send-email-jing.xia.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579249445-27429-1-git-send-email-jing.xia.mail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:24:05PM +0800, Jing Xia wrote:
> From: Jing Xia <jing.xia@unisoc.com>
> 
> In low memory situations, sometimes we need to check how much memory
> a driver using.This patch add a notifer chain to show_mem.So a driver
> can show their memory usage when show_mem_extend() is called.
> 
> Co-developed-by: Yuming Han <yuming.han@unisoc.com>
> Signed-off-by: Yuming Han <yuming.han@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> ---
>  include/linux/mm.h |  9 +++++++++
>  lib/show_mem.c     | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cfaa8fe..a37274a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2201,6 +2201,15 @@ extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
>  #ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
>  extern unsigned long arch_reserved_kernel_pages(void);
>  #endif
> +enum show_mem_extend_type {
> +	SHOW_MEM_EXTEND_BASIC,
> +	SHOW_MEM_EXTEND_CLASSIC,
> +	SHOW_MEM_EXTEND_ALL
> +};
> +extern int register_show_mem_notifier(struct notifier_block *nb);
> +extern int unregister_show_mem_notifier(struct notifier_block *nb);
> +extern void show_mem_extend(unsigned int flags, nodemask_t *nodemask,
> +			    enum show_mem_extend_type type);
>  
>  extern __printf(3, 4)
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
> diff --git a/lib/show_mem.c b/lib/show_mem.c
> index 1c26c14..6b013cb 100644
> --- a/lib/show_mem.c
> +++ b/lib/show_mem.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/mm.h>
>  #include <linux/cma.h>
> +#include <linux/notifier.h>
> +#include <linux/swap.h>
>  
>  void show_mem(unsigned int filter, nodemask_t *nodemask)
>  {
> @@ -42,3 +44,37 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
>  }
> +
> +static BLOCKING_NOTIFIER_HEAD(show_mem_notify_list);
> +
> +int register_show_mem_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&show_mem_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_show_mem_notifier);
> +
> +int unregister_show_mem_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&show_mem_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_show_mem_notifier);

You are exporting functions that are never used at all.  We can't do
that.


> +
> +void show_mem_extend(unsigned int filter, nodemask_t *nodemask,
> +		     enum show_mem_extend_type type)
> +{
> +	unsigned long used = 0;
> +	struct sysinfo si;
> +
> +	pr_info("Mem-Info-Extend:\n");
> +	show_mem(filter, NULL);
> +	si_meminfo(&si);
> +	pr_info("MemTotal:	%8lu KB\n"
> +		"Buffers:	%8lu KB\n"
> +		"SwapCached:	%8lu KB\n",
> +		(si.totalram) << (PAGE_SHIFT - 10),
> +		(si.bufferram) << (PAGE_SHIFT - 10),
> +		total_swapcache_pages() << (PAGE_SHIFT - 10));
> +
> +	blocking_notifier_call_chain(&show_mem_notify_list,
> +				     (unsigned long)type, &used);
> +}

Who calls this function?

As a stand-alone patch, this makes no sense as it doesn't seem to do
anything, so there's no way it can be accepted.

Please submit this as a patch series, with actual users of these
functions, if you wish to have it properly considered.

thanks,

greg k-h
