Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE59C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D8E2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBSMDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:03:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgBSMDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:03:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6E62BB18;
        Wed, 19 Feb 2020 12:02:58 +0000 (UTC)
Subject: Re: [PATCH] xen: Enable interrupts when calling _cond_resched()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <87tv3mq1rm.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8808612b-11c2-f7b8-f027-7ff92e992c50@suse.com>
Date:   Wed, 19 Feb 2020 13:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3mq1rm.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.20 12:01, Thomas Gleixner wrote:
> xen_maybe_preempt_hcall() is called from the exception entry point
> xen_do_hypervisor_callback with interrupts disabled.
> 
> _cond_resched() evades the might_sleep() check in cond_resched() which
> would have caught that and schedule_debug() unfortunately lacks a check
> for irqs_disabled().
> 
> Enable interrupts around the call and use cond_resched() to catch future
> issues.
> 
> Fixes: fdfd811ddde3 ("x86/xen: allow privcmd hypercalls to be preempted")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/xen/preempt.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/drivers/xen/preempt.c
> +++ b/drivers/xen/preempt.c
> @@ -33,8 +33,10 @@ asmlinkage __visible void xen_maybe_pree
>   		 * cpu.
>   		 */
>   		__this_cpu_write(xen_in_preemptible_hcall, false);
> -		_cond_resched();
> +		local_irq_enable();
> +		cond_resched();
>   		__this_cpu_write(xen_in_preemptible_hcall, true);
> +		local_irq_disable();

Could you please put the call of local_irq_disable() directly after the
cond_resched() call to make the result symmetric regarding writing of
xen_in_preemptible_hcall and irq enable/disable?


Juergen
