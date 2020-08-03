Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA50820738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv1qL/3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHCQO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHCQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:14:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F52C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:14:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so26273086ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tSBpQmpuiewbS5z6Oz2e+wP+GlWYteCnkz9IfbL1iAw=;
        b=fv1qL/3gxwgjph8hqIFsTsj2c5q6kMAx3FOxZkVD2XctB9LQxrQI6xNVaWRdun/Inb
         oHT2YEDBC7kfcQ9qgDe3PTlY2gxHaKUKzjlA5dBBt1X9TYZfoIwoS+BUItvw05uh9OxM
         F1bJTlNhLLecvhIyzdHzgIIV6jVRW22mXYwtkGXGj2a9S3Z6WKfs4ED1sktjfbZOohLB
         kLCGPnmSuZ3CgTQqqNGROxrDxrQmumJ07UMBVowJdqbCV7K5N+nAuF9V/VD2y6DkMD3P
         cxXof+33OVGiA3bUBp62YHZPlPmEHRAOmppBe7qDux6mks6AG/mgvcMyht0RqG2kPy6n
         CWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tSBpQmpuiewbS5z6Oz2e+wP+GlWYteCnkz9IfbL1iAw=;
        b=V8fqV2RyGPPRKBSLXoc5JOscoKPjlpMGNAoXBSStN+g7DYcUvZSNr8hQTE8+JjWDEj
         4dEaDCBJJdKb5bQEGP3OoTiw0llTZMkIkAbvj/HKihbWOIWvBIUmvVXRcSCl9p9hbISp
         NvzU8Tr7jWQyPU15wrmJid9Q8aAQOjEvEN0UUZth7nezqAJZ4ORBYloKMPxFNJWCk2yT
         GTjWWmUROaGgtTCRn8ypAXi9+mYDdMDmsdmNORkJicv7pRifV97yU45R6LCtzBGi8kqA
         RaIhgRF13qd8sRZAupVYO8zNvejyLjI0b2FoP1NSXgav9zbYD+SC1wb9FKula8HCswKU
         33yQ==
X-Gm-Message-State: AOAM53218RGhQTZcByTsUg/O0zavHmrAXGEhzM7rHucLUs9GfzHXZiX4
        RCQoKq83bNSuDiLdZA17eR8=
X-Google-Smtp-Source: ABdhPJxyZYxI7TYLkV2fkj5SRAFRT2Mkp7kQi+j94kRyxCt3fSDOBjn0CJ/tBX1fOHlBmjQFdyw9iQ==
X-Received: by 2002:a17:906:1c56:: with SMTP id l22mr17063449ejg.84.1596471266894;
        Mon, 03 Aug 2020 09:14:26 -0700 (PDT)
Received: from skbuf ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id m24sm16291795eje.80.2020.08.03.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:14:26 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:14:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200803161423.fin6365nw5sza4ns@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de>
 <jhjh7tjivew.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjh7tjivew.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:47:03PM +0100, Valentin Schneider wrote:
> 
> On 03/08/20 16:13, Thomas Gleixner wrote:
> > Vladimir Oltean <olteanv@gmail.com> writes:
> >>>  1) When irq accounting is disabled, RT throttling kicks in as
> >>>     expected.
> >>> 
> >>>  2) With irq accounting the RT throttler does not kick in and the RCU
> >>>     stall/lockups happen.
> >> What is this telling us?
> >
> > It seems that the fine grained irq time accounting affects the runtime
> > accounting in some way which I haven't figured out yet.
> >
> 
> With IRQ_TIME_ACCOUNTING, rq_clock_task() will always be incremented by a
> lesser-or-equal value than when not having the option; you start with the
> same delta_exec but slice some for the IRQ accounting, and leave the rest
> for the rq_clock_task() (+paravirt).
> 
> IIUC this means that if you spend e.g. 10% of the time in IRQ and 90% of
> the time running the stress-ng RT tasks, despite having RT tasks hogging
> the entirety of the "available time" it is still only 90% runtime, which is
> below the 95% default and the throttling doesn't happen.
> 
> I don't know if considering IRQ time in some way or another in
> sched_rt_runtime_exceeded() really is a way out here.
> 
> > Thanks,
> >
> >         tglx
> 

Not sure it this is relevant at all to the conversation we're having
(sorry if it isn't), but FWIW, on my armv7 board, enabling
CONFIG_IRQ_TIME_ACCOUNTING makes it completely unable to boot (the log
below is just earlyprintk):

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0xf00
[    0.000000] Linux version 5.8.0-rc7-02154-g1a0b51626a14-dirty (tigrisor@skbuf) (arm-linux-gnueabihf-gcc (Linaro GCC 7.3-2018.05) 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701], GNU ld (Linaro_Binutils-2018.05) 2.28.2.20170706) #383 SMP Mon Aug 3 19:03:50 EEST 2020
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: NXP LS1021A-TSN Board
[    0.000000] earlycon: uart8250 at MMIO 0x021c0500 (options '')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] Ignoring RAM at 0xb0000000-0xc0000000
[    0.000000] Consider using a HIGHMEM enabled kernel.
[    0.000000] cma: Reserved 64 MiB at 0xac000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000] percpu: Embedded 20 pages/cpu s51660 r8192 d22068 u81920
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 194880
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio,0x21c0500 root=/dev/mmcblk0p2 rootwait rw
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 687944K/786432K available (12288K kernel code, 1026K rwdata, 6980K rodata, 1024K init, 279K bss, 32952K reserved, 65536K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x36c/0x54c with crng_init=0
[    0.000000] timer_probe: no matching timers found
[    0.000000] Console: colour dummy device 80x30
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns

Thanks,
-Vladimir
