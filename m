Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E32C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0E120674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3lcZX/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgCPCUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:20:19 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36620 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgCPCUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:20:18 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so4502612pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7oX6Q9J91aVBByyMt2VEWlfb+zkW4AWq2uFQgZ9WqGM=;
        b=r3lcZX/TYAFfYxXf0+MiRmp6KxhyRgXp6n+oUNzCPbopahhswj/Lo/eRn/Qj/C0MBC
         zsx11h4QmpYw6tTI9HLFrPCqhvXVWW8BeNIIOMazM5YTco4jtZi5CemPKxC7YdZfzLzN
         agjqy2g4GvPadXeGKhDRdNCnT7rxTa31OUab1dYniv5DpInOHjmAG/wjBR8rqvoOD495
         dQlS/YcR/vXkObFUUV8pcI4zJoG4TM5/w3qUpXMZSDydQt06rEj5Wronst2BylgPI7DE
         qw++FZLQ7gkvOfRa1S0XapX+UVGcNwbcQAFaigGkA05YfFO5JvQsAQO9Qf3MaFWjb1xv
         wtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7oX6Q9J91aVBByyMt2VEWlfb+zkW4AWq2uFQgZ9WqGM=;
        b=FFzqSczz91iG44LW2ZpbSoQKHdsHN0p5cuu6UyZd0o2P6tEQ4KZbbDn32OXRIDV50l
         1Cm+HFqPSxxt7DJ2E6/NUmFMzzA2X9o3hoFVG9zYRlUlp1UXx45JDxPR3iG40QQw54O3
         fg1+ae4playpjMDc0ZmpkXVT27Svz4rmt2uuwIRvroSWyUgaBFhXiQG34j23KyHSD1RS
         x1rcKinkRh13Qp0wvMGk1XIs2yb8Lvje8PvpCIvxGNu6qMKLSHlfwJhmz6nh8PIhsLG/
         TDTFJmdbuy7J4ISL5tLFRepzR7XidkLmAEDWCRO38CWrRuAuXdyQKx54qdDKsiscaTmt
         KxQQ==
X-Gm-Message-State: ANhLgQ2WTRtAVBICZ8jdVhp8vILx4q5ZWnYHGXjMcuHY1Sjkefx7QVuF
        WifJGHUTomQK1NZKyvDjOQs=
X-Google-Smtp-Source: ADFU+vuIEZGszcK+3GeOlJY/K/G7FunX5P0wpf8NdH/JNA+4GSXRQI6BDlzKVF5hd9pNOWAwVW02xQ==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr24918481plt.2.1584325217356;
        Sun, 15 Mar 2020 19:20:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11sm2294385pfa.149.2020.03.15.19.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 19:20:16 -0700 (PDT)
Date:   Sun, 15 Mar 2020 19:20:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>, pbunyan@redhat.com
Subject: Re: [RFC PATCH v2] tick: Make tick_periodic() check for missing ticks
Message-ID: <20200316022014.GA30856@roeck-us.net>
References: <20200207193929.27308-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207193929.27308-1-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 07, 2020 at 02:39:29PM -0500, Waiman Long wrote:
> The tick_periodic() function is used at the beginning part of the
> bootup process for time keeping while the other clock sources are
> being initialized.
> 
> The current code assumes that all the timer interrupts are handled in
> a timely manner with no missing ticks. That is not actually true. Some
> ticks are missed and there are some discrepancies between the tick time
> (jiffies) and the timestamp reported in the kernel log.  Some systems,
> however, are more prone to missing ticks than the others.  In the extreme
> case, the discrepancy can actually cause a soft lockup message to be
> printed by the watchdog kthread. For example, on a Cavium ThunderX2
> Sabre arm64 system:
> 
>  [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!
> 
> On that system, the missing ticks are especially prevalent during the
> smp_init() phase of the boot process. With an instrumented kernel,
> it was found that it took about 24s as reported by the timestamp for
> the tick to accumulate 4s of time.
> 
> Investigation and bisection done by others seemed to point to the
> commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or
> lack thereof") as the culprit. It could also be a firmware issue as
> new firmware was promised that would fix the issue.
> 
> To properly address this problem, we cannot assume that there will
> be no missing tick in tick_periodic(). This function is now modified
> to follow the example of tick_do_update_jiffies64() by using another
> reference clock to check for missing ticks. Since the watchdog timer
> uses running_clock(), it is used here as the reference. With this patch
> applied, the soft lockup problem in the arm64 system is gone and tick
> time tracks much more closely to the timestamp time.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Since this patch is in linux-next, roughly 10% of my x86 and x86_64
qemu emulation boots are stalling. Typical log:

[    0.002016] smpboot: Total of 1 processors activated (7576.40 BogoMIPS)
[    0.002016] devtmpfs: initialized
[    0.002016] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.002016] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
[    0.002016] xor: measuring software checksum speed

another:

[    0.002653] Freeing SMP alternatives memory: 44K
[    0.002653] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (IBRS update) (family: 0x6, model: 0x2c, stepping: 0x1)
[    0.002653] Performance Events: unsupported p6 CPU model 44 no PMU driver, software events only.
[    0.002653] rcu: Hierarchical SRCU implementation.
[    0.002653] smp: Bringing up secondary CPUs ...
[    0.002653] x86: Booting SMP configuration:
[    0.002653] .... node  #0, CPUs:      #1
[    0.000000] smpboot: CPU 1 Converting physical 0 to logical die 1

... and then there is silence until the test aborts.

This is only (or at least predominantly) seen if the system running
the emulation is under load.

Reverting this patch fixes the problem.

Guenter
