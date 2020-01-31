Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA89C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FFD2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNWV8Sbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgAaNZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:25:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34763 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgAaNZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:25:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so3464721pgi.1;
        Fri, 31 Jan 2020 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uw1FQaJ7B7AC5+CVRylYzOQ0kTnjKrLEQb7DZzSA/4Y=;
        b=gNWV8Sbx6ScYTDYJ64qE+QmSC0CcNXwNBov85Rbgtcoq60E/gJuRzF3sa8kHAUXIJP
         58L7Dr3G5zt65WHFz/ANSvk1GG6q/Q+zaFlW0i1WWjrWKZIiDRqQAy7erEGGyh8iHq1M
         njRkcSrYOEWMVtGijmDGF/NSUWjJCJEpS+7qA/qLfBIGcd+IOYB4ITOWFCCsKjNnJo1b
         0ajDUvQcs0NfvetIRZztrHzeE80KcezUL4ubQL2Qx2RpRcvR678e9533fvXHRmmIGAWt
         c+fkvufa3kcA+WHnbdvl1Mg7OPP0j2TOanwCmY0NDYGhJLDcligaOTVPDyT1mc4LyF7C
         bz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uw1FQaJ7B7AC5+CVRylYzOQ0kTnjKrLEQb7DZzSA/4Y=;
        b=NjEc1kPwWqP2b8Xt8vd13r4LMejCxXmFXTqQfJJng1zdmw+yf6WdX9Tq5VW22TzGfS
         XmhpXuCpOkXHrsMJvtGICxyKLkzXZsjU6pR2lO7r4sb3KB2tPImsu7BOf8hKiRQ73pOm
         dwYP0HVpQClHrpf0qtl6M1GSOi2rQXCvX3kgDdT2KzhWijx54CzhaJK0n1WKDzEzSq2Y
         m+xD8eSmSm5ITXh6gmDtJrMCDI4st71FiufzjcDoVfwR7QJ8HfbVU2/byD8+ism1zV93
         igwd51gHxUb/MuSl3qg0gxyRPfzGbmTYwaZh/7dzTw9FoXTs8qOQBd/KKnmCg2eXTAif
         Qs1A==
X-Gm-Message-State: APjAAAWq3pMqp9LuTInL00nGbGRUolnBIjoi/W8DBnmyGpwAUczcvnds
        keQsDyagOFZAzZw/Rfc+49o=
X-Google-Smtp-Source: APXvYqzJZa0hq1t1IkczddY1sn7dC2Nwyv/xkjvgnEZRNzMIFUYnDNpERPVWmI6YbILlckNXdk9bkQ==
X-Received: by 2002:a62:1b4f:: with SMTP id b76mr10986760pfb.163.1580477145176;
        Fri, 31 Jan 2020 05:25:45 -0800 (PST)
Received: from localhost (g52.222-224-164.ppp.wakwak.ne.jp. [222.224.164.52])
        by smtp.gmail.com with ESMTPSA id g18sm10448004pfi.80.2020.01.31.05.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:25:44 -0800 (PST)
Date:   Fri, 31 Jan 2020 22:25:42 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>, kbuild-all@lists.01.org,
        Jonas Bonn <jonas@southpole.se>,
        kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] openrisc: use mmgrab
Message-ID: <20200131132542.GY24874@lianli.shorne-pla.net>
References: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
 <201912301238.xfn6pKut%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301238.xfn6pKut%lkp@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:49:19PM +0800, kbuild test robot wrote:
> Hi Julia,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on vfio/next]
> [also build test ERROR on char-misc/char-misc-testing v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Julia-Lawall/use-mmgrab/20191230-011611
> base:   https://github.com/awilliam/linux-vfio.git next
> config: openrisc-simple_smp_defconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/openrisc/kernel/smp.c: In function 'secondary_start_kernel':
> >> arch/openrisc/kernel/smp.c:116:2: error: implicit declaration of function 'mmgrab'; did you mean 'igrab'? [-Werror=implicit-function-declaration]
>      116 |  mmgrab(mm);
>          |  ^~~~~~
>          |  igrab
>    cc1: some warnings being treated as errors
> 
> vim +116 arch/openrisc/kernel/smp.c
> 
>    107	
>    108	asmlinkage __init void secondary_start_kernel(void)
>    109	{
>    110		struct mm_struct *mm = &init_mm;
>    111		unsigned int cpu = smp_processor_id();
>    112		/*
>    113		 * All kernel threads share the same mm context; grab a
>    114		 * reference and switch to it.
>    115		 */
>  > 116		mmgrab(mm);
>    117		current->active_mm = mm;
>    118		cpumask_set_cpu(cpu, mm_cpumask(mm));
>    119	
>    120		pr_info("CPU%u: Booted secondary processor\n", cpu);
>    121	
>    122		setup_cpuinfo();
>    123		openrisc_clockevent_init();
>    124	
>    125		notify_cpu_starting(cpu);
>    126	
>    127		/*
>    128		 * OK, now it's safe to let the boot CPU continue
>    129		 */
>    130		complete(&cpu_running);
>    131	
>    132		synchronise_count_slave(cpu);
>    133		set_cpu_online(cpu, true);
>    134	
>    135		local_irq_enable();
>    136	
>    137		preempt_disable();
>    138		/*
>    139		 * OK, it's off to the idle thread for us
>    140		 */
>    141		cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>    142	}
>    143	
> 

Hello,  FYI I have fixed this commit and queued it on my 5.7 branch.

-Stafford
