Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CD20679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNTTYFpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCQCSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:18:24 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34337 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:18:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1954031pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qYzsFQul7XctVPY5JwH7zSO9+d5x1eixlhOf4FDnb04=;
        b=dNTTYFpDw2Rq52vC6Rt8JDGMz1N7SfvkWjLgoHSzbs6n9KnXZKYpIgaASTSH2xm21P
         Nif1djfW1GVY+Gp5VCM0Qb07qhQTDu0bdNvY4kZ4ifBCIviI9rSqiAghh7t0HbgF2DFQ
         8drsNUcW1ZXwne53kdSiGJqE4lFUeJxop96c1RsHpV9/OHxpmJ3RwiB8ArDIuAGyInUO
         gGy58ls/+DuDXP2KNV2R6RdMqj5COpHQ9awNu4LuOR4DXuAUmezctHuguyZ1CPKLu0N4
         T1pLAOd5CvDB2mXNXfIwFc8cJR7RZYWBr9tdud4w/ZbzV+3p4ArZkIy43YGvwJQ5KjRW
         CuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYzsFQul7XctVPY5JwH7zSO9+d5x1eixlhOf4FDnb04=;
        b=hS2Wz8s1yudpyssIoukFj8f+pU+vj9BJcGEi8fsANwOxm1rGuKNKPe9USVgjUyFLDM
         hGJ5662q0cCHaAISPa71T+NS/PF6pc0kias+rMA2DOXWcwIUm3SUQJYee2gRHLdS+jZV
         26L1oQkU5pda4S517UEHctCGWbth5A4uYtr5QNBIfCTLDEoHY4jVo4M5t9WRRRt+W7uP
         b+oIJN4smGmPUH00zKvL7sq7XbPCS1ClnUtAnwD8rymjg4QK2v1oRB2K2U0QnmkKcGW9
         gNY3j5SwNgRkg3OS8t8P/VSNpAK341SPejNL7/N28deCvhVy8FviOvm9edGILM7h4APE
         ad9g==
X-Gm-Message-State: ANhLgQ22kHDtg4S35mO4gO6dG5sQXSV39dGCodvfC6p2s7EZpGe1svIQ
        CvjiMZjm95vVknP1GY7Y2C4=
X-Google-Smtp-Source: ADFU+vv3AWKM3Sb7P2ln6qPVzUbrA5lMoJyJ+I93/rAth3sbj6cXAXuoOu1QUBOBf9PaiD4YMti3+w==
X-Received: by 2002:a17:90a:4487:: with SMTP id t7mr2629686pjg.104.1584411501611;
        Mon, 16 Mar 2020 19:18:21 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id w124sm1086610pfd.71.2020.03.16.19.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:18:20 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:18:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when
 reporting softlockup
Message-ID: <20200317021818.GD219881@google.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200315170903.17393-4-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315170903.17393-4-erosca@de.adit-jv.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/15 18:09), Eugeniu Rosca wrote:

[..]

> @@ -428,6 +428,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  			}
>  		}
>  
> +		console_verbose_start();
> +
>  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>  			smp_processor_id(), duration,
>  			current->comm, task_pid_nr(current));
> @@ -453,6 +455,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
>  		__this_cpu_write(soft_watchdog_warn, true);
> +
> +		console_verbose_end();
>  	} else
>  		__this_cpu_write(soft_watchdog_warn, false);


I'm afraid, as of now, this approach is not going to work the way it's
supposed to work in 100% of cases. Because the only thing that printk()
call sort of guarantees is that the message will be stored somewhere.
Either in the main kernel log buffer, on in one of auxiliary per-CPU
log buffers. It does not guarantee, generally speaking, that the message
will be printed on the console immediately.

Consider the following example:

	CPU0				CPU1
	console_lock();
	schedule();

					watchdog()
					 console_verbose_start();
					  printk()
					   log_store()
					    if (!console_trylock())
					      return;
					 console_verbose_end();

	...
	console_unlock()
	 print logbuf messages to the consoles
	 we missed the console_verbose_start/end
	 on CPU1



IIRC, we had a similar approach in the past. See commit 375899cddcbb26
("printk: make sure to print log on console"). And we reverted it, see
a6ae928c25835 ("Revert "printk: make sure to print log on console.").

	-ss
