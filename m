Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E799A206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585925611;
	bh=mZm2UukruDWuzMgf1nzUV9ZDd1DY335QNWej4RBvLBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fn7goXmfGYz/Zs77bduUwqk54fe+yJoTg5hO+Q82XfsABt+bCCiIEwuOobj1q4A5a
	 BlMiwTpHV4PUkeQXlxrOvUtaGE12rjqmZTDBnn9fpq7oD+PyF/Sw0WbiF6fWp0EhB2
	 zp/9NjnTRO8ILVOpE0LtxhA6/4/jIyGoG6F6EbH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbgDCOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:53:29 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38027 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbgDCOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:53:29 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so3698070qva.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uc42AQH4tToZy2skrxtoTfXeI+xoeSzapyZv5SU0eo8=;
        b=qf4g+hbbcI/nBowNBtDb64ExHtqIFgPwdjiy0Nc7tu0Oq3oyONhWJ/Rr1g6UD0QZs0
         Bx5WVGtBzAxHTe9WAqe23oKGOR2/ckREp5n1aH/r/ekokqmznvBbvWallZqdM4O4IDeS
         87EmF5B8It01mdLwudKlaAiejDjC75Wf/eF8Upl+DHWWqE8XGSDPSZDlMIs2F2KuUd5V
         5FxpIA9XCjfgncNwPFgyVYgoU8ylH720rVD97Cpf/kuKwv+hSs2fDYfKgxn7I26gAX5z
         xK0U9kFzv5ukf7nKXabOEyF22Ajf9JuEG9sLhPoL/CUiX3QZ/9JsMIqwd57KJmC7Ygvr
         zLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Uc42AQH4tToZy2skrxtoTfXeI+xoeSzapyZv5SU0eo8=;
        b=VLnqRjUu2aRj2a6P2ze9KRzHTfNUv3y1ovX2twKkkyPSKmIf58HIseF5iYFPrMEKxg
         7fciow0mbCK8/gbCUekAh3ZnRNwuV7088WI5gFT6EX5dYfLISa9e92XPxwUEgmPs+6uR
         82JK5jugleku1GQKJAdOCyO0YwI1wWiyF7Lx6ZxSh4mEvzafq8Vbi5RSjvPfQes9QLgc
         g36XnlPiMEgnBHxIOV9shjz53XCWHnCb0J9u1uiUjDFYFj24zOsbsuTs3jUPQNt9TvkC
         eXZj40ZsKO3mBsggaxfxt/Aso7SdMEUmtAk0so6b5iHJBARlnhEbsMJoTP3C290OA4Au
         oOpw==
X-Gm-Message-State: AGi0PuYvWGZpErZR+3M19bNbPjZryOWa7tgQmuO1nmp4rh0Z/qcqlS+Z
        eLPu3yuv3g/Rb16hVqBqyUc=
X-Google-Smtp-Source: APiQypKrTR0123hpnS11JtBJkhWIJ/xiXL8/KNpBXkfqK++URN7P9LfsHK2Z8GKTWsO7bJpkwDjOhA==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr8849577qvx.27.1585925608121;
        Fri, 03 Apr 2020 07:53:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id d2sm6092423qkl.98.2020.04.03.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:53:27 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:53:26 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200403145326.GA162390@mtj.duckdns.org>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <20200327232959.rpylymw2edhtxuwr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327232959.rpylymw2edhtxuwr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Mar 28, 2020 at 12:29:59AM +0100, Sebastian Andrzej Siewior wrote:
> The kernel test robot triggered a warning with the following race:
>    task-ctx A                            interrupt-ctx B
>  worker
>   -> process_one_work()
>     -> work_item()
>       -> schedule();
>          -> sched_submit_work()
>            -> wq_worker_sleeping()
>              -> ->sleeping = 1
>                atomic_dec_and_test(nr_running)
>          __schedule();                *interrupt*
>                                        async_page_fault()
>                                        -> local_irq_enable();
>                                        -> schedule();
>                                           -> sched_submit_work()
>                                             -> wq_worker_sleeping()
>                                                -> if (WARN_ON(->sleeping)) return
>                                           -> __schedule()
>                                             ->  sched_update_worker()
>                                               -> wq_worker_running()
>                                                  -> atomic_inc(nr_running);
>                                                  -> ->sleeping = 0;
> 
>       ->  sched_update_worker()
>         -> wq_worker_running()
>           if (!->sleeping) return
> 
> In this context the warning is pointless everything is fine.

This is not a usual control flow, right? Can we annotate this case specifically
instead of weakening santiy check for generic cases?

Thanks.

-- 
tejun
