Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A95F2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibma5St4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGBBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgGBBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:09:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 18:09:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so9233407pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 18:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQEQS5p/+RjzH0qq3BBrpSd3Alq89nsezpjkTzvw95k=;
        b=ibma5St4sQQTI9fxuFS0Dl7IZc8oEUi1BtXgEPoNq0mIUKKf6Z7R/XGy92KtWrffNx
         vYC7ca34d+sedvj+8yLJJjmmAtKQ7Om73FWsFK8snVXdXZLADKVpt95SGNnCVHVOtepK
         yZwoBb7sagKD2u9Y+bfGSftDf7Jbl/M9AMeGb+yUeBfJleUUdCPHLJtEIAK8pqTyU+wu
         FYp0cWoqDFNDSW/Eim+PVm7nyCQMSlL24X9Fyx8kwI23/O1LYG5WET531b4Cwf8e6YRG
         amHHtY7MN+qSSHVjCKKnAG+9U9ELgiNpUsbnaWGFvUMFv4QUJZnBtuOWgsFQNX+iXZA+
         6BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQEQS5p/+RjzH0qq3BBrpSd3Alq89nsezpjkTzvw95k=;
        b=mmqfFO0ubL/qGjtkJUpziTyly0jx3v1StMHBSYPW+d1/aMDO9G55KsfmBm1JX5kk6p
         Od6UX/NrxVhYzrEWp/dqq+C64j1JTAigjryYRj/vRPoAQBMVh+/sy7oFuSeWEC3jOIcS
         AS6pz3VRl9jcosCuYvLvEWU+mw07jyWI2IUH9xlo8ipHRNFiK5X9qdBxiCcdkRQdQwuW
         iCPrnHpnjlOuaDEIi4nQ9jsbCYAWLsqFDqjglqfpX26f1xNggeQYCgfW6W5sTd99EKM5
         B5ito77Fn6P8W/0Fg3Cg0+2+YsvBgBV042x5zrwJo9KvAToby+UMXplcy9DvG/Q21cqW
         ss7A==
X-Gm-Message-State: AOAM533+XeEEL9Gh7kIPKQ2VP9wHIji/U0WYcPzFMkR1fLNCpmHJGl12
        U8g3XdgUHD+OYu4mKGOIFVWBhqDt
X-Google-Smtp-Source: ABdhPJxhkSRfIMMKu+cNzMWWQ+vIUGdTmDrIxYA0PXhoy3o3OzOj7KdBYlHvmetdIq6vh/zWA1893A==
X-Received: by 2002:a63:8ec2:: with SMTP id k185mr21573323pge.331.1593652158591;
        Wed, 01 Jul 2020 18:09:18 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id az16sm6091434pjb.7.2020.07.01.18.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 18:09:17 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:09:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v2] init: Align init_task to avoid conflict with
 MUTEX_FLAGS
Message-ID: <20200702010910.GA3545817@lianli.shorne-pla.net>
References: <20200626210754.3338389-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210754.3338389-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there anyone willing to pick this up?

I guess I could send it in the OpenRISC queue, but it doesn't really seem like
the right thing.

-Stafford

On Sat, Jun 27, 2020 at 06:07:53AM +0900, Stafford Horne wrote:
> When booting on 32-bit machines (seen on OpenRISC) I saw this warning
> with CONFIG_DEBUG_MUTEXES turned on.
> 
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:1242 __mutex_unlock_slowpath+0x328/0x3ec
>     DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
>     Modules linked in:
>     CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc1-simple-smp-00005-g2864e2171db4-dirty #179
>     Call trace:
>     [<(ptrval)>] dump_stack+0x34/0x48
>     [<(ptrval)>] __warn+0x104/0x158
>     [<(ptrval)>] ? __mutex_unlock_slowpath+0x328/0x3ec
>     [<(ptrval)>] warn_slowpath_fmt+0x7c/0x94
>     [<(ptrval)>] __mutex_unlock_slowpath+0x328/0x3ec
>     [<(ptrval)>] mutex_unlock+0x18/0x28
>     [<(ptrval)>] __cpuhp_setup_state_cpuslocked.part.0+0x29c/0x2f4
>     [<(ptrval)>] ? page_alloc_cpu_dead+0x0/0x30
>     [<(ptrval)>] ? start_kernel+0x0/0x684
>     [<(ptrval)>] __cpuhp_setup_state+0x4c/0x5c
>     [<(ptrval)>] page_alloc_init+0x34/0x68
>     [<(ptrval)>] ? start_kernel+0x1a0/0x684
>     [<(ptrval)>] ? early_init_dt_scan_nodes+0x60/0x70
>     irq event stamp: 0
> 
> I traced this to kernel/locking/mutex.c storing 3 bits of MUTEX_FLAGS in
> the task_struct pointer (mutex.owner).  There is a comment saying that
> task_structs are always aligned to L1_CACHE_BYTES.  This is not true for
> the init_task.
> 
> On 64-bit machines this is not a problem because symbol addresses are
> naturally aligned to 64-bits providing 3 bits for MUTEX_FLAGS.  Howerver,
> for 32-bit machines the symbol address only has 2 bits available.
> 
> Fix this by setting init_task alignment to at least L1_CACHE_BYTES.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> Changes since v1:
>  - Make alignment unconditional suggested by Peter
> 
>  init/init_task.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 15089d15010a..ab6173f8e6a8 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -65,6 +65,7 @@ struct task_struct init_task
>  #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
>  	__init_task_data
>  #endif
> +	__aligned(L1_CACHE_BYTES)
>  = {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	.thread_info	= INIT_THREAD_INFO(init_task),
> -- 
> 2.26.2
> 
