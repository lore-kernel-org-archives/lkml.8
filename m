Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8AAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC1522522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CHjGe4+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAUSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:10:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55058 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FTbjmTPewhmuZeI4RXiIzCWj8QRQqw5GhRQOtHVv+dc=; b=CHjGe4+nP671nkSnHLv1XH8kc
        t//WmmqJb7tD1MqKGKVq0gRrITiatPK5VqYD8ukB2rLZGmP2qmwe4HhQidekE2c5Mv2JJAbhIdBfv
        5jV3xc8yRSsgiqmjGzMdjT7eykoxcGa2cSLhavfrMvYwzgN5iKiij1oWThcs7AEB4Z1wpc6X5Z5jw
        iU3sN/wYSVgi3wsYuTlD92rt2mYk802LhCk2kGEGHNQnEppUqYwrnRx5B1uiSaZLRcQPunKaVUgVj
        KoSFCXL78XQtQP8iqImB7pY1QCSpuruZLF/zhvke/hwYuwWwp77kb5G/lf4knIITcx2ijShNz2pdR
        ULStvBuCg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37284)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1itxy3-0006Q1-1Q; Tue, 21 Jan 2020 18:09:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1itxxy-00042T-5z; Tue, 21 Jan 2020 18:09:30 +0000
Date:   Tue, 21 Jan 2020 18:09:30 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Nadav Amit <namit@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] smp: Create a new function to shutdown nonboot
 cpus
Message-ID: <20200121180930.GJ25745@shell.armlinux.org.uk>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-2-qais.yousef@arm.com>
 <20200121170350.GC18808@shell.armlinux.org.uk>
 <20200121174751.5opyyjwxfnwdgcev@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121174751.5opyyjwxfnwdgcev@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:47:52PM +0000, Qais Yousef wrote:
> On 01/21/20 17:03, Russell King - ARM Linux admin wrote:
> > On Mon, Nov 25, 2019 at 11:27:41AM +0000, Qais Yousef wrote:
> > > +void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> > > +{
> > > +	unsigned int cpu;
> > > +
> > > +	if (!cpu_online(primary_cpu)) {
> > > +		pr_info("Attempting to shutdodwn nonboot cpus while boot cpu is offline!\n");
> > > +		cpu_online(primary_cpu);
> 
> Eh, that should be cpu_up(primary_cpu)!
> 
> Which I have to say I'm not if is the right thing to do.
> migrate_to_reboot_cpu() picks the first online cpu if reboot_cpu (assumed 0) is
> offline
> 
> migrate_to_reboot_cpu():
>  225         /* Make certain the cpu I'm about to reboot on is online */
>  226         if (!cpu_online(cpu))
>  227                 cpu = cpumask_first(cpu_online_mask);
> 
> > > +	}
> > > +
> > > +	for_each_present_cpu(cpu) {
> > > +		if (cpu == primary_cpu)
> > > +			continue;
> > > +		if (cpu_online(cpu))
> > > +			cpu_down(cpu);
> > > +	}
> > 
> > How does this avoid racing with userspace attempting to restart CPUs
> > that have already been taken down by this function?
> 
> This is meant to be called from machine_shutdown() only.
> 
> But you've got a point.
> 
> The previous logic that used disable_nonboot_cpus(), which in turn called
> freeze_secondary_cpus() didn't hold hotplug lock. So I assumed the higher level
> logic of machine_shutdown() ensures that hotplug lock is held to synchronize
> with potential other hotplug operations.

freeze_secondary_cpus() takes the CPU maps lock while it takes CPUs
down, and then disables cpu hotplug by incrementing
cpu_hotplug_disabled.  Incrementing that prevents cpu_up() and
cpu_down() being used, thereby preventing userspace from changing the
online state of any CPU in the system.

> But I can see now that it doesn't.
> 
> With this series that migrates users to use device_{online,offline}, holding
> the lock_device_hotplug() should protect against such races.
> 
> Worth noting that this an existing problem in the code and not something
> I introduced, of course it makes sense to fix it properly as part of this
> series.
> 
> I'm not sure how the other archs deal with this TBH.
> 
> Thanks for having a look!
> 
> Cheers
> 
> --
> Qais Yousef
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
