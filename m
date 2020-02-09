Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE8C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8CC207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581275315;
	bh=EB/J+jflRD2yCj40XdloUpfqi1I8JNK9YWOGFiZ6l8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+yaCxXjVc3kDkqzvt201S90TYEucvu7jg77WqQUqNYXRaZalgAUt+JvwfQR5udQb
	 TDPjfVt15TArbSeS3McBiWr2JHPDpbLMylgEPHR+Cvz2IGjd2LOdgPInr5ZRNiq0P3
	 qqTv4YI3Uu1O/v9BUldHL5spQYFou59ptGlhk3K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBITIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 14:08:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51203 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbgBITId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 14:08:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so7565362wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/7uHyQ5OmDbIcy4Y4TOiSGFczvwv7nupJbM+jMqS2fU=;
        b=bdDQ2IAwGKvA9OrGWMMCR4QoTdr+W5ksf3ScpXcrWfJlWKNTFnJY+p8KE/toYj5q2i
         XS1lwa69ElHkNjGkkNXOeCwSSrKbffKV8aIg3cBXhXCE6Esr3p7VbQ9osjGMfruPxKvQ
         6GoYkErbmJehxb5MgCerDpId0h3o7toHIenJLfIl65Nuto/CQZ0eFarIAjPiGKdXwdpj
         Zt8kVKx0Zc9Hsvq/y4AbUdXta6M+FZFtb/ky2f/y3vbjDMl63vlwiCv6tL7jRPc+f2OT
         Fs84sn2XxW4xr1K92IhxYY7JAVXv9VDlxVD77IvVzQxhLqfdoeH9+YTB/BK9B/4eSH70
         DJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7uHyQ5OmDbIcy4Y4TOiSGFczvwv7nupJbM+jMqS2fU=;
        b=LoG34D9mwfgxb9YDsFC2sT6MKpX+8nuzaP+O0HiBBIg06td+UfIXL1F6k3k2cVZh6c
         xCeLt9Fd05mrAnOiUIPb15QlTQRkSbi1MPj9scH0jvkzirkpPNdbrPXyKKdM7qe3N0hI
         ytHboPBlPrBwqQuYEji9WmojsUJZ5JPUQrlSVJSQMSq50A5Ur6ik7J6lHn9aJUffwqlj
         LoV+u8ICjaW0x7gZwqMCd46XNDGBBTc754yV3NQ236F2mW6KZK/nTc3pAyhiMqtQp3PL
         t5fajiqWkEVm3ooKzm7UGbqTk3jT18FfPAepDbYWAgLsQJ07oKUisbI5r68HLWPw3+rd
         ONAg==
X-Gm-Message-State: APjAAAUZFN89/T2thWRdeZAVgmA7f8RQkndd/vJMAEMzINQhTG0m1e0p
        Kq8V+zOJWU062SmEm3YY7is=
X-Google-Smtp-Source: APXvYqw+zyviJrU6dUBvUadVfJGjlY/yK/pcr0rd5RV0xTRfSgtFj6SnIw3b7C0x32bRqv3vJBaf2g==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr11025936wml.50.1581275310480;
        Sun, 09 Feb 2020 11:08:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e6sm12048397wme.3.2020.02.09.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 11:08:29 -0800 (PST)
Date:   Sun, 9 Feb 2020 20:08:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: sched: Provide migrate_disable/enable() inlines
Message-ID: <20200209190827.GA100648@gmail.com>
References: <878slclv1u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878slclv1u.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Code which solely needs to prevent migration of a task uses
> preempt_disable()/enable() pairs. This is the only reliable way to do so
> as setting the task affinity to a single CPU can be undone by a
> setaffinity operation from a different task/process.
> 
> RT provides a seperate migrate_disable/enable() mechanism which does not
> disable preemption to achieve the semantic requirements of a (almost) fully
> preemptible kernel.
> 
> As it is unclear from looking at a given code path whether the intention is
> to disable preemption or migration, introduce migrate_disable/enable()
> inline functions which can be used to annotate code which merely needs to
> disable migration. Map them to preempt_disable/enable() for now. The RT
> substitution will be provided later.
> 
> Code which is annotated that way documents that it has no requirement to
> protect against reentrancy of a preempting task. Either this is not
> required at all or the call sites are already serialized by other means.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> ---
>  include/linux/preempt.h |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -322,4 +322,34 @@ static inline void preempt_notifier_init
>  
>  #endif
>  
> +/**
> + * migrate_disable - Prevent migration of the current task
> + *
> + * Maps to preempt_disable() which also disables preemption. Use
> + * migrate_disable() to annotate that the intent is to prevent migration
> + * but not necessarily preemption.
> + *
> + * Can be invoked nested like preempt_disable() and needs the corresponding
> + * number of migrate_enable() invocations.
> + */
> +static __always_inline void migrate_disable(void)
> +{
> +	preempt_disable();
> +}
> +
> +/**
> + * migrate_enable - Allow migration of the current task
> + *
> + * Counterpart to migrate_disable().
> + *
> + * As migrate_disable() can be invoked nested only the uttermost invocation
> + * reenables migration.
> + *
> + * Currently mapped to preempt_enable().
> + */
> +static __always_inline void migrate_enable(void)
> +{
> +	preempt_enable();
> +}

I've applied this with s/uttermost/outermost, which I suspect was the 
intention?

Thanks,

	Ingo
