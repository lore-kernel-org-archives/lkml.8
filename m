Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55958C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D39F207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589998742;
	bh=trnJEEy7OwEzJwuvyGL2l3v8wDg+b4PNHsrrpzNkbOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=utS1qvvFQX+En0Uz7IV6djRS/kwon9CrEku3LQvXTr9V+s09iyY3XHH9UZlXRXEhY
	 9RHdm+5Oep3Z3+Peh0hXEeCGWbZPmY9j9+YAP5+K4gRsbPYaQckd6zHAZX+3DiG0Cy
	 E20k6z50Pdnbx/MqzioeDGLWo6GzxkFAWO9Lk4wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETSTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgETSTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:19:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BB020671;
        Wed, 20 May 2020 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589998740;
        bh=trnJEEy7OwEzJwuvyGL2l3v8wDg+b4PNHsrrpzNkbOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEe388rihi9A9Ygia+EhA/HSD+CGYhtoz7QcoOy1Avi1zhDX+Y3FViO3MRDa6CC/z
         nI6IqNKWN/EtZmX+w66BOrh8DcAnp5QN87UZ9HnHZ4CHE2XrfyvonumRrSJlK8xH8t
         XCnp4LcdBPL5aQ8Udu0ivaljY596i99S9SHjWBHk=
Date:   Wed, 20 May 2020 20:18:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH] kthread: Use TASK_IDLE state for newly created kernel
 threads
Message-ID: <20200520181858.GA343493@kroah.com>
References: <1589975710-9283-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589975710-9283-1-git-send-email-pkondeti@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:25:09PM +0530, Pavankumar Kondeti wrote:
> When kernel threads are created for later use, they will be in
> TASK_UNINTERRUPTIBLE state until they are woken up. This results
> in increased loadavg and false hung task reports. To fix this,
> use TASK_IDLE state instead of TASK_UNINTERRUPTIBLE when
> a kernel thread schedules out for the first time.
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  kernel/kthread.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index bfbfa48..b74ed8e 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -250,7 +250,7 @@ static int kthread(void *_create)
>  	current->vfork_done = &self->exited;
>  
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
> -	__set_current_state(TASK_UNINTERRUPTIBLE);
> +	__set_current_state(TASK_IDLE);
>  	create->result = current;
>  	/*
>  	 * Thread is going to call schedule(), do not preempt it,
> @@ -428,7 +428,7 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
>  
>  void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
>  {
> -	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
> +	__kthread_bind_mask(p, mask, TASK_IDLE);
>  }
>  
>  /**
> @@ -442,7 +442,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
>   */
>  void kthread_bind(struct task_struct *p, unsigned int cpu)
>  {
> -	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
> +	__kthread_bind(p, cpu, TASK_IDLE);
>  }
>  EXPORT_SYMBOL(kthread_bind);

It's as if people never read mailing lists:
	https://lore.kernel.org/r/DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com

Given that this is an identical resend of the previous patch, why are
you doing so, and what has changed since that original rejection?

greg k-h
