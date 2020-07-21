Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7BFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C92065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qbx+DC6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgGURbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgGURa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:30:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F04C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:30:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so20108769qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OykxZsQsMyfs3BdJV+VY7xhQ+2COfW5S2cexVEvA5/E=;
        b=qbx+DC6t8UWmIKklaKa9PJV53XtsBOvH11SIgwj6xBsEIqBLxN9i8rj6iflyOP5cCz
         QiOtym1f5OBJsJWGSVxw+ofzolpXBk3eXCWJ2RrXuj3ykoyseW0nRe3+8EeP3yTDR72j
         FlPpoli5J143Qfui+x/mGY1tqCyQwb2jXRhawKYK39CG81MQ1VwZ1T/ZEfdDyxUVx1+O
         Bjo2ktjRN/JfZYlHUGGZCMqdwvVUzL+jWxMlPMVmwE9QLmUhMvPeK0iGwF4fpnQxoYjA
         L+YtHriqkbzXsa9E8fAOC6h6C28fyXzil4EIfwj7fSIUC2TGijAnQESp4XPo6NlK7H0H
         /Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OykxZsQsMyfs3BdJV+VY7xhQ+2COfW5S2cexVEvA5/E=;
        b=iYqYdZAfuSnyA2xDwfeFRXB6y4mkoJoXynyZut2FZpdhmWRzjZTMm+dhxCK1YIbnkI
         GvV+wThXnQBXQNbr1V5soueFGyYUbSYOtgsI5O+xGqP0NAaJSSvElGPjAM0J4qtuwdQZ
         4ZGVURo0zwLWB4CqkyrYT0bjqJciKtgJrm4lrhmic2gY1jhaILglSXf7VOvCbkzPEXGx
         sP1g7AbZkAJabVekkuMhQLWN+fn8g3GPP7BpccFVXWZE9dX3P9JT/oEWNnts2AnJgXzs
         wR7DqB0PClaCE+cwtEOzjf0nm6gg3CeOx278km1yyUkuaiXJp8RRmDdeule0TobGWvKj
         12uQ==
X-Gm-Message-State: AOAM531TV4cJ3RxG8kmB0wG7k75tX17asuwsweHvj+7iC0qDkveVi3dX
        deHE7/mAKW0jvL11+8e4dI+i7Q==
X-Google-Smtp-Source: ABdhPJz5tghC+TotT9IT4mmDT7j/83Zf0g2pQ1ZnS+ZUwj7XBUh3vDZ0uJvlbVxOlKYHFTf3kLPhRg==
X-Received: by 2002:a37:a756:: with SMTP id q83mr14905027qke.328.1595352655070;
        Tue, 21 Jul 2020 10:30:55 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j72sm3051798qke.20.2020.07.21.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:30:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:30:52 -0400
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org
Cc:     mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fork: silence a false postive warning in __mmdrop
Message-ID: <20200721173051.GB3696@lca.pw>
References: <20200604150344.1796-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604150344.1796-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:03:44AM -0400, Qian Cai wrote:
> The linux-next commit bf2c59fce407 ("sched/core: Fix illegal RCU from
> offline CPUs") delayed,
> 
> idle->active_mm = &init_mm;
> 
> into finish_cpu() instead of idle_task_exit() which results in a false
> positive warning that was originally designed in the commit 3eda69c92d47
> ("kernel/fork.c: detect early free of a live mm").
> 
>  WARNING: CPU: 127 PID: 72976 at kernel/fork.c:697
>  __mmdrop+0x230/0x2c0
>  do_exit+0x424/0xfa0
>  Call Trace:
>  do_exit+0x424/0xfa0
>  do_group_exit+0x64/0xd0
>  sys_exit_group+0x24/0x30
>  system_call_exception+0x108/0x1d0
>  system_call_common+0xf0/0x278
> 
> Fixes: bf2c59fce407 ("sched/core: Fix illegal RCU from offline CPUs")
> Signed-off-by: Qian Cai <cai@lca.pw>

Peter, Andrew, can you take a look at this trivial patch? The offensive commit
is now in the mainline, and it is quite easy to trigger this warning by a
non-root user.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random -x 0-100 -f (it will switch to use a non-root user.)

[14933.435035][T1176230] ------------[ cut here ]------------
[14933.435062][T1176230] WARNING: CPU: 25 PID: 1176230 at kernel/fork.c:679 __mmdrop+0x1e0/0x270
[14933.435086][T1176230] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod tg3 firmware_class ahci libahci libphy libata dm_mirror dm_region_hash dm_log dm_mod
[14933.435176][T1176230] CPU: 25 PID: 1176230 Comm: trinity-c25 Not tainted 5.8.0-rc6-next-20200721 #5
[14933.435200][T1176230] NIP:  c0000000000c4560 LR: c0000000000d4fb4 CTR: 0000000000000000
[14933.435223][T1176230] REGS: c00000001520f910 TRAP: 0700   Not tainted  (5.8.0-rc6-next-20200721)
[14933.435255][T1176230] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002822  XER: 20040000
[14933.435294][T1176230] CFAR: c0000000000c43f4 IRQMASK: 0 
[14933.435294][T1176230] GPR00: c0000000000d4fb4 c00000001520fba0 c000000005911500 c000000f6e227080 
[14933.435294][T1176230] GPR04: 0000000000000001 fffffffffffff026 c0000007aa2a17e0 0000000000000001 
[14933.435294][T1176230] GPR08: 0000000000000000 c000000f6e227080 0000000000000001 bfffffffffffffff 
[14933.435294][T1176230] GPR12: 0000000000002000 c000000ffffeb780 0000000010037be0 00000000109ec8e0 
[14933.435294][T1176230] GPR16: 00000000109eccb0 0000000010037ff0 0000000000000001 00007fff8d000000 
[14933.435294][T1176230] GPR20: 00000000100380d0 00000000100380a8 000000001003a1d0 0000000010037f10 
[14933.435294][T1176230] GPR24: 00007fff8df100e0 00000000ed54649a c000000f6e227128 c00000001520fcc8 
[14933.435294][T1176230] GPR28: c000000fe7540890 c000000f6e227080 c000000fe7540080 c000000f6e227080 
[14933.435470][T1176230] NIP [c0000000000c4560] __mmdrop+0x1e0/0x270
[14933.435493][T1176230] LR [c0000000000d4fb4] do_exit+0x424/0xee0
[14933.435514][T1176230] Call Trace:
[14933.435524][T1176230] [c00000001520fba0] [c00c0000000164c0] 0xc00c0000000164c0 (unreliable)
[14933.435550][T1176230] [c00000001520fc60] [c0000000000d4fb4] do_exit+0x424/0xee0
[14933.435575][T1176230] [c00000001520fd60] [c0000000000d5b2c] do_group_exit+0x5c/0xd0
[14933.435600][T1176230] [c00000001520fda0] [c0000000000d5bbc] sys_exit_group+0x1c/0x20
[14933.435626][T1176230] [c00000001520fdc0] [c00000000002c978] system_call_exception+0xf8/0x180
[14933.435654][T1176230] [c00000001520fe20] [c00000000000c9e8] system_call_common+0xe8/0x214
[14933.435686][T1176230] Instruction dump:
[14933.435706][T1176230] 480c35e9 60000000 4bffff68 60000000 7c832378 38800000 482a8d81 60000000 
[14933.435750][T1176230] 4bfffee8 60000000 60000000 60000000 <0fe00000> 4bfffe94 60000000 60000000 
[14933.435795][T1176230] irq event stamp: 370444
[14933.435817][T1176230] hardirqs last  enabled at (370443): [<c0000000003b8964>] __slab_free+0x2e4/0x5e0
[14933.435868][T1176230] hardirqs last disabled at (370444): [<c00000000000964c>] program_check_common_virt+0x2bc/0x310
[14933.435913][T1176230] softirqs last  enabled at (352366): [<c0000000009b0790>] __do_softirq+0x650/0x920
[14933.435948][T1176230] softirqs last disabled at (352359): [<c0000000000d70dc>] irq_exit+0x17c/0x1b0
[14933.435971][T1176230] ---[ end trace 5823e9bcf4dee099 ]---

> ---
>  kernel/fork.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..5334efd2a680 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -694,7 +694,6 @@ void __mmdrop(struct mm_struct *mm)
>  {
>  	BUG_ON(mm == &init_mm);
>  	WARN_ON_ONCE(mm == current->mm);
> -	WARN_ON_ONCE(mm == current->active_mm);
>  	mm_free_pgd(mm);
>  	destroy_context(mm);
>  	mmu_notifier_subscriptions_destroy(mm);
> -- 
> 2.21.0 (Apple Git-122.2)
> 
