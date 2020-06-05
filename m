Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DE2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgFENZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:25:44 -0400
Received: from verein.lst.de ([213.95.11.211]:58491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgFENZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:25:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB3AC6736F; Fri,  5 Jun 2020 15:25:41 +0200 (CEST)
Date:   Fri, 5 Jun 2020 15:25:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: kprobes string reading broken on s390
Message-ID: <20200605132541.GB31829@lst.de>
References: <20200605110533.GA57038@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605110533.GA57038@tuxmaker.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this looks correct.  You probably want to write a small changelog
and add a Fixes tag, though.

On Fri, Jun 05, 2020 at 01:05:34PM +0200, Sven Schnelle wrote:
> Hi Christoph,
> 
> with the latest linux-next i noticed that some tests in the
> ftrace test suites are failing on s390, namely:
> 
> [FAIL] Kprobe event symbol argument
> [FAIL] Kprobe event with comm arguments
> 
> The following doesn't work anymore:
> 
> cd /sys/kernel/tracing
> echo 'p:testprobe _do_fork comm=$comm ' >kprobe_events
> echo 1 >/sys/kernel/tracing/events/kprobes/testprobe/enable
> cat /sys/kernel/tracing/trace
> 
> it will just show
> 
> test.sh-519   [012] ....    18.580625: testprobe: (_do_fork+0x0/0x3c8) comm=(fault)
> 
> Looking at d411a9c4e95a ("tracing/kprobes: handle mixed kernel/userspace probes
> better") i see that there are two helpers for reading strings:
> 
> fetch_store_string_user() -> read string from user space
> fetch_store_string() -> read string from kernel space(?)
> 
> but in the end both are using strncpy_from_user_nofault(), but i would
> think that fetch_store_string() should use strncpy_from_kernel_nofault().
> However, i'm not sure about the exact semantics of fetch_store_string(),
> as there where a lot of wrong assumptions in the past, especially since
> on x86 you usually don't fail if you use the same function for accessing kernel
> and userspace although it's technically wrong.
> 
> Regards,
> Sven
> 
> commit 81408eab8fcc79dc0871a95462b13176d3446f5e
> Author: Sven Schnelle <svens@linux.ibm.com>
> Date:   Fri Jun 5 13:01:24 2020 +0200
> 
>     kprobes: use strncpy_from_kernel_nofault() in fetch_store_string()
> 
>     Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index b1f21d558e45..ea8d0b094f1b 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1278,7 +1278,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  	 * Try to get string again, since the string can be changed while
>  	 * probing.
>  	 */
> -	ret = strncpy_from_user_nofault(__dest, (void *)addr, maxlen);
> +	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
>  	if (ret >= 0)
>  		*(u32 *)dest = make_data_loc(ret, __dest - base);
>  
---end quoted text---
