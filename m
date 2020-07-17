Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78E820737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7blFMyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGQR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:26:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726232AbgGQR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595006796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHG39auNHRE1WZtPTrj7HBCLgjL3HfRMERmH4ZoBnBw=;
        b=W7blFMyO/81VaPmCdFVCHuytUzbnAqP34nr7DEzzPpDeyQHEZlWwn6wsDOp2x0s9VwfCeb
        OsGbU+wC7qjSPG1wNkXGoibQOpNB4Au83gpb45QKjaP9JC6ATT8rLfYgI1Cct2S06NklDa
        qYg6+pyXwPfI4Akjvuw9uzLzqpDV9kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-rN1OUrIHMpWAgGDMvhUJZw-1; Fri, 17 Jul 2020 13:26:32 -0400
X-MC-Unique: rN1OUrIHMpWAgGDMvhUJZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A417107ACCA;
        Fri, 17 Jul 2020 17:26:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id A934319724;
        Fri, 17 Jul 2020 17:26:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Jul 2020 19:26:31 +0200 (CEST)
Date:   Fri, 17 Jul 2020 19:26:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Message-ID: <20200717172627.GC6067@redhat.com>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.734067877@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202044.734067877@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks correct to me, but I forgot everything about posix-timers.c

this obviously means that the expired timer won't fire until the
task returns to user-mode but probably we don't care.

One cosmetic nit below,

On 07/16, Thomas Gleixner wrote:
>
> +#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
> +void posix_cpu_timers_work(struct callback_head *work);
> +
> +static inline void posix_cputimer_init_work(struct posix_cputimers *pct)
> +{
> +	pct->task_work.func = posix_cpu_timers_work;

init_task_work() ?

> +}
> +#else
> +static inline void posix_cputimer_init_work(struct posix_cputimers *pct) { }
> +#endif
> +
>  static inline void posix_cputimers_init(struct posix_cputimers *pct)
>  {
>  	memset(pct, 0, sizeof(*pct));
>  	pct->bases[0].nextevt = U64_MAX;
>  	pct->bases[1].nextevt = U64_MAX;
>  	pct->bases[2].nextevt = U64_MAX;
> +	posix_cputimer_init_work(pct);
>  }

And I can't resist. I know this is a common practice, please ignore, but to me

	static inline void posix_cputimers_init(struct posix_cputimers *pct)
	{
		memset(pct, 0, sizeof(*pct));
		pct->bases[0].nextevt = U64_MAX;
		pct->bases[1].nextevt = U64_MAX;
		pct->bases[2].nextevt = U64_MAX;
	#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
		init_task_work(&pct->task_work, posix_cpu_timers_work);
	#endif
	}

looks better than 2 posix_cputimer_init_work() definitions above.

Note also that signal_struct->posix_cputimers.task_work is never used, perhaps
it would be better to move this task_work into task_struct? This way we do not
even need to change posix_cputimers_init(), we call simply initialize
init_task.posix_task_work.

Oleg.

