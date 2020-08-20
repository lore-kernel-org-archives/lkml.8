Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD12A22B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgHTLiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgHTLa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:30:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA164AC98;
        Thu, 20 Aug 2020 11:31:24 +0000 (UTC)
Date:   Thu, 20 Aug 2020 13:30:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Balamuruhan S <bala24@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, Jisheng.Zhang@synaptics.com, rdna@fb.com,
        viro@zeniv.linux.org.uk, gpiccoli@canonical.com,
        naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        sandipan@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kernel/watchdog: fix warning -Wunused-variable for
 watchdog_allowed_mask in ppc64
Message-ID: <20200820113056.GG4353@alley>
References: <20200814133330.210093-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200814133330.210093-1-bala24@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-08-14 19:03:30, Balamuruhan S wrote:
> In ppc64 config if `CONFIG_SOFTLOCKUP_DETECTOR` is not set then it
> warns for unused declaration of `watchdog_allowed_mask` while building,
> move the declaration inside ifdef later in the code.
> 
> ```
> kernel/watchdog.c:47:23: warning: ‘watchdog_allowed_mask’ defined but not used [-Wunused-variable]
>  static struct cpumask watchdog_allowed_mask __read_mostly;
> ```
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  kernel/watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 5abb5b22ad13..33c9b8a3d51b 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -44,7 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
>  int __read_mostly watchdog_thresh = 10;
>  static int __read_mostly nmi_watchdog_available;
>  
> -static struct cpumask watchdog_allowed_mask __read_mostly;
>  
>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> @@ -166,6 +165,7 @@ int __read_mostly sysctl_softlockup_all_cpu_backtrace;
>  unsigned int __read_mostly softlockup_panic =
>  			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
>  
> +static struct cpumask watchdog_allowed_mask __read_mostly;

I could confirm that the variable is used only in code that is built
when CONFIG_SOFTLOCKUP_DETECTOR is enabled.

Note that the problem can't be seen on x86. There the softlockup
detector is enforced together with hardloclup detector via
via HARDLOCKUP_DETECTOR_PERF.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
