Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AFDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF91420674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHkOp+M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgESKl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:41:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:41:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so15265483wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXxkCen/zIzWAVYZRGp0Kup7dkI0f7XaE2jW9ck8KnI=;
        b=JHkOp+M/CjqaKJTgNHhegxOFjABee6pxv/RQmCGH8DsqeIZPYJ3K4FZKqZulAy0HnL
         UXdYoQlgHmGcqnMOpwSqMmkMRtdJXNhwNaIjk5/eUJkilqDDu0dGrtbG3l4FZpIfCqxD
         P+jVEn2HnPKwGjZBTr8ffsIG1sP3UcN9yfyI5vSkFkC8SspwYBv45WxrRWZN42OUkYQM
         28pqdUQv4bT1JiQnHMd0ceYyvUXYeOZUKAC/w0vNnhsr16prafI0vcIxBREhNB7/PuAw
         wTLrbpFptATBG3z7qz8tTOCsA7ZySrJE8fqrcpeUaF7WntcARbhTbm8tE/de06BIksGj
         bjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXxkCen/zIzWAVYZRGp0Kup7dkI0f7XaE2jW9ck8KnI=;
        b=ofF67aaUyTMDXE0YnAKeVU7gPXCjsdCzKqLCgtdVzarg/INSLKYe2hVsBu5brtHCNq
         ETNwCOLra6gcNPehz2Dzb7+WTo9NrnGdU0OteEMPds3zDCauF4oGnNy0Yy7StYxdxJ3/
         iRr4Vi+9tra3THwcPJhfSrxcFcn7cpBxWjl24E72KlGsBGmOsxpn9lJzL8wn8qa/9Q/L
         t7XmUO7BVticn5vnG39P1Am/VHVqFAM6grCx7xph5UoGNifMlxwt9Si2k3FbwEst0lui
         uvAw+oC+tyBBcDkL9WxIvP4sFXuDOavulhRwHJsHO78PRWze/zb4tjFB1nrFVEnR8+bU
         Hi5A==
X-Gm-Message-State: AOAM533FKuyljCX/svj6H0IwXYJ7+K7Y1B4sBD5mt+lXFtABvrFmXzIY
        8hTMpeLXcsblahbg6aqkAONOlA==
X-Google-Smtp-Source: ABdhPJxI9hHAtjBprvirEkNxdsK9H7V1Yykq/ZJEdnUyCFW3JFUs2vMu+RhotxOD5DsAjFlPFptI7g==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr25138459wru.151.1589884913554;
        Tue, 19 May 2020 03:41:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g187sm3368484wmf.30.2020.05.19.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:41:52 -0700 (PDT)
Date:   Tue, 19 May 2020 11:41:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, sumit.garg@linaro.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Avoid suspicious RCU usage warning
Message-ID: <20200519104151.6evv3hizm5dbjjq2@holly.lan>
References: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:53:58PM -0700, Douglas Anderson wrote:
> At times when I'm using kgdb I see a splat on my console about
> suspicious RCU usage.  I managed to come up with a case that could
> reproduce this that looked like this:
> 
>   WARNING: suspicious RCU usage
>   5.7.0-rc4+ #609 Not tainted
>   -----------------------------
>   kernel/pid.c:395 find_task_by_pid_ns() needs rcu_read_lock() protection!
> 
>   other info that might help us debug this:
> 
>     rcu_scheduler_active = 2, debug_locks = 1
>   3 locks held by swapper/0/1:
>    #0: ffffff81b6b8e988 (&dev->mutex){....}-{3:3}, at: __device_attach+0x40/0x13c
>    #1: ffffffd01109e9e8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x20c/0x7ac
>    #2: ffffffd01109ea90 (dbg_slave_lock){....}-{2:2}, at: kgdb_cpu_enter+0x3ec/0x7ac
> 
>   stack backtrace:
>   CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc4+ #609
>   Hardware name: Google Cheza (rev3+) (DT)
>   Call trace:
>    dump_backtrace+0x0/0x1b8
>    show_stack+0x1c/0x24
>    dump_stack+0xd4/0x134
>    lockdep_rcu_suspicious+0xf0/0x100
>    find_task_by_pid_ns+0x5c/0x80
>    getthread+0x8c/0xb0
>    gdb_serial_stub+0x9d4/0xd04
>    kgdb_cpu_enter+0x284/0x7ac
>    kgdb_handle_exception+0x174/0x20c
>    kgdb_brk_fn+0x24/0x30
>    call_break_hook+0x6c/0x7c
>    brk_handler+0x20/0x5c
>    do_debug_exception+0x1c8/0x22c
>    el1_sync_handler+0x3c/0xe4
>    el1_sync+0x7c/0x100
>    rpmh_rsc_probe+0x38/0x420
>    platform_drv_probe+0x94/0xb4
>    really_probe+0x134/0x300
>    driver_probe_device+0x68/0x100
>    __device_attach_driver+0x90/0xa8
>    bus_for_each_drv+0x84/0xcc
>    __device_attach+0xb4/0x13c
>    device_initial_probe+0x18/0x20
>    bus_probe_device+0x38/0x98
>    device_add+0x38c/0x420
> 
> If I understand properly we should just be able to blanket kgdb under
> one big RCU read lock and the problem should go away.  We'll add it to
> the beast-of-a-function known as kgdb_cpu_enter().
> 
> With this I no longer get any splats and things seem to work fine.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

In principle this looks OK but I'm curious why we don't cuddle these
calls up to the local interrupt locking (and also whether we want to
keep hold of the lock during stepping). If nothing else that would make
review easier.


Daniel.


> ---
> 
>  kernel/debug/debug_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 2b7c9b67931d..5155cf06731b 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -564,6 +564,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  	int online_cpus = num_online_cpus();
>  	u64 time_left;
>  
> +	rcu_read_lock();
> +
>  	kgdb_info[ks->cpu].enter_kgdb++;
>  	kgdb_info[ks->cpu].exception_state |= exception_state;
>  
> @@ -635,6 +637,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  			atomic_dec(&slaves_in_kgdb);
>  			dbg_touch_watchdogs();
>  			local_irq_restore(flags);
> +			rcu_read_unlock();
>  			return 0;
>  		}
>  		cpu_relax();
> @@ -773,6 +776,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  	dbg_touch_watchdogs();
>  	local_irq_restore(flags);
>  
> +	rcu_read_unlock();
> +
>  	return kgdb_info[cpu].ret_state;
>  }
>  
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
