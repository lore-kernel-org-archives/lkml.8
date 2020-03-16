Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F56C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2CA206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgCPIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:38:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgCPIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:38:51 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDlGo-0002u8-JF; Mon, 16 Mar 2020 09:38:46 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 06B1D100F5A; Mon, 16 Mar 2020 09:38:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prasad Sodagudi <psodagud@codeaurora.org>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        tsoni@codeaurora.org, tj@kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH 2/2] sched: Add a check for cpu unbound deferrable timers
In-Reply-To: <1584326350-30275-3-git-send-email-psodagud@codeaurora.org>
References: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org> <1584326350-30275-3-git-send-email-psodagud@codeaurora.org>
Date:   Mon, 16 Mar 2020 09:38:45 +0100
Message-ID: <874kuoelt6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prasad Sodagudi <psodagud@codeaurora.org> writes:
> @@ -948,6 +949,11 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
>  	ktime_t expires;
>  	int cpu = smp_processor_id();
>  
> +#ifdef CONFIG_SMP
> +	if (check_pending_deferrable_timers(cpu))
> +		raise_softirq_irqoff(TIMER_SOFTIRQ);
> +#endif

So if that raises the soft interrupt then the warning in 

can_stop_idle_tick()

	if (unlikely(local_softirq_pending())) {
		....
                pr_warn()

will trigger. Try again.

Thanks,

        tglx
