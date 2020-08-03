Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C07C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E895206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEOn4xxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vl4LyNJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgHCIEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:04:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:04:13 -0700 (PDT)
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596441850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GS51V+Fb9RGolp7kRY+9tiBxNylzWSfrE28RS+V2Exo=;
        b=SEOn4xxXom3rfakH/j+gzHHEJJK0V5qhJhxWo4wed5NY9polCYbZs7jYZP4xMXdscAT2Wc
        vfVy0lmeyRghXYt98Uy2xRCJIZ5wyU2u8HjAEfiwjttl52NN9X6086uWdz5Xdn3rJg8wi5
        9Zxu2mlx9btI8qfC1zPI01ONEO/IqNXMMBJJmxvXABiWkABrkysFPN3GcOZEF4PZuwbcCY
        hsKG+G0VoUp/NPTnE1p3uiYCbW65J+5MQB1YjrojTijLVhGh6nTdTSonaKYbtG7mVWHfIJ
        4bmcfJCsJJDbhqJYB9GMWxDYchKdPTrHDeW+2xtqDK4UHK1EubtzXES4HbBMRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596441850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GS51V+Fb9RGolp7kRY+9tiBxNylzWSfrE28RS+V2Exo=;
        b=Vl4LyNJUOZx5tvyc90jF7k/c258xkDV8muocSZLQSpKO1JKeo9xvLvResLjAFp3qNLqc9O
        Mt+W7aZINLRxWqDA==
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200730082228.r24zgdeiofvwxijm@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf>
Date:   Mon, 03 Aug 2020 10:04:01 +0200
Message-ID: <873654m9zi.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Jul 30 2020, Vladimir Oltean wrote:
> On Thu, Jul 30, 2020 at 09:23:44AM +0200, Kurt Kanzenbach wrote:
>> On Wed Jul 29 2020, Vladimir Oltean wrote:
>> > For more context, here is my original report of the issue:
>> > https://lkml.org/lkml/2020/6/4/1062
>> >
>> > Just like you, I could not reproduce the RCU stalls and system hang on=
 a
>> > 5.6-rt kernel, just on mainline and derivatives, using the plain
>> > defconfig.
>> >
>> > The issue is not specific to Layerscape or i.MX8, but rather I was able
>> > to see the same behavior on Marvell Armada 37xx as well as Qualcomm
>> > MSM8976.
>> >
>> > So, while of course I agree that disabling IRQ time accounting for arm=
64
>> > isn't a real solution, it isn't by far an exaggerated proposal either.
>> > Nonetheless, the patch is just a RFC and should be treated as such. We
>> > are at a loss when it comes to debugging this any further and we would
>> > appreciate some pointers.
>>=20
>> Yeah, sure. I'll try to reproduce this issue first. So it triggers with:
>>=20
>>  * arm64
>>  * mainline, not -rt kernel
>>  * opened serial console
>>  * irq accounting enabled
>>=20
>> Anything else?
>>=20
>> Thanks,
>> Kurt
>
> Thanks for giving a helping hand, Kurt. The defconfig should be enough.
> In the interest of full disclosure, the only arm64 device on which we
> didn't reproduce this was the 16-core LX2160A. But we did reproduce on
> that with maxcpus=3D1 though. And also on msm8976 with all 8 cores booted.
> Just mentioning this in case you're testing on a 16-core system, you
> might want to reduce the number a bit.

OK. I've reproduced it on a Marvell Armada SoC with v5.6 mainline. See
splats below. Running with irq time accounting enabled, kills the
machine immediately. However, I'm not getting the possible deadlock
warnings in 8250 as you did. So that might be unrelated.

Unfortunately I have no idea what to debug here.

Thanks,
Kurt

Splats:

|root@marvell ~ # [  150.996487] rcu: INFO: rcu_sched detected stalls on CP=
Us/tasks:
|[  150.999764]  (detected by 0, t=3D2602 jiffies, g=3D9697, q=3D24)
|[  151.005403] rcu: All QSes seen, last rcu_sched kthread activity 2602 (4=
294952389-4294949787), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
|[  151.018034] stress-ng-hrtim R  running task        0  2251   2248 0x000=
00001
|[  151.025290] Call trace:
|[  151.027808]  dump_backtrace+0x0/0x198
|[  151.031563]  show_stack+0x1c/0x28
|[  151.034971]  sched_show_task+0x224/0x248
|[  151.039002]  rcu_sched_clock_irq+0x7c4/0x840
|[  151.043392]  update_process_times+0x34/0x70
|[  151.047694]  tick_sched_handle.isra.0+0x34/0x70
|[  151.052350]  tick_sched_timer+0x50/0xa0
|[  151.056295]  __hrtimer_run_queues+0x18c/0x5b0
|[  151.060773]  hrtimer_interrupt+0xec/0x248
|[  151.064896]  arch_timer_handler_phys+0x38/0x48
|[  151.069465]  handle_percpu_devid_irq+0xd0/0x3c8
|[  151.074124]  generic_handle_irq+0x2c/0x40
|[  151.078246]  __handle_domain_irq+0x68/0xc0
|[  151.082456]  gic_handle_irq+0x64/0x150
|[  151.086308]  el1_irq+0xbc/0x140
|[  151.089536]  lock_acquire+0xdc/0x250
|[  151.093210]  __might_fault+0x68/0x88
|[  151.096880]  setup_rt_frame+0x2a4/0xee8
|[  151.100823]  do_notify_resume+0x3b0/0x488
|[  151.104945]  work_pending+0x8/0x14
|[  151.108443] rcu: rcu_sched kthread starved for 2613 jiffies! g9697 f0x2=
 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D1
|[  151.118741] rcu: RCU grace-period kthread stack dump:
|[  151.123939] rcu_sched       R  running task        0    10      2 0x000=
00028
|[  151.131196] Call trace:
|[  151.133707]  __switch_to+0x104/0x170
|[  151.137384]  __schedule+0x36c/0x860
|[  151.140966]  schedule+0x7c/0x108
|[  151.144280]  schedule_timeout+0x204/0x4c0
|[  151.148403]  rcu_gp_kthread+0x5b0/0x1798
|[  151.152435]  kthread+0x110/0x140
|[  151.155749]  ret_from_fork+0x10/0x18
|[  181.665482] BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0 =
nice=3D0 stuck for 55s!
|[  181.671022] BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0 =
nice=3D0 stuck for 56s!
|[  181.679198] BUG: workqueue lockup - pool cpus=3D0-1 flags=3D0x4 nice=3D=
0 stuck for 56s!
|[  181.686902] Showing busy workqueues and worker pools:
|[  181.692059] workqueue events: flags=3D0x0
|[  181.696226]   pwq 2: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2/=
256 refcnt=3D3
|[  181.703039]     pending: dbs_work_handler, mv88e6xxx_ptp_overflow_check
|[  181.709826]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2/=
256 refcnt=3D3
|[  181.716783]     pending: vmstat_shepherd, switchdev_deferred_process_wo=
rk
|[  181.723804] workqueue events_unbound: flags=3D0x2
|[  181.728526]   pwq 4: cpus=3D0-1 flags=3D0x4 nice=3D0 active=3D1/512 ref=
cnt=3D3
|[  181.735029]     pending: flush_to_ldisc
|[  181.738947] workqueue events_freezable: flags=3D0x4
|[  181.743755]   pwq 2: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1/=
256 refcnt=3D2
|[  181.750741]     pending: mmc_rescan
|[  181.754359] workqueue events_power_efficient: flags=3D0x82
|[  181.759825]   pwq 4: cpus=3D0-1 flags=3D0x4 nice=3D0 active=3D5/256 ref=
cnt=3D7
|[  181.766329]     pending: gc_worker, neigh_periodic_work, neigh_periodic=
_work, do_cache_clean, check_lifetime
|[  181.776488] workqueue mm_percpu_wq: flags=3D0x8
|[  181.780942]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/=
256 refcnt=3D2
|[  181.787924]     pending: vmstat_update
|[  181.791808] workqueue pm: flags=3D0x4
|[  181.795368]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/=
256 refcnt=3D2
|[  181.802349]     pending: pm_runtime_work
|[  181.806412] workqueue writeback: flags=3D0x4a
|[  181.810686]   pwq 4: cpus=3D0-1 flags=3D0x4 nice=3D0 active=3D1/256 ref=
cnt=3D3
|[  181.817224]     pending: wb_workfn
|[  181.820756] workqueue ipv6_addrconf: flags=3D0x40008
|[  181.825684]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/=
1 refcnt=3D2
|[  181.832456]     pending: addrconf_verify_work
|[  181.836968] workqueue nfsd4: flags=3D0x2
|[  181.840794]   pwq 4: cpus=3D0-1 flags=3D0x4 nice=3D0 active=3D1/256 ref=
cnt=3D3
|[  181.847329]     pending: laundromat_main
|[  229.043792] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
|[  229.047053]  (detected by 0, t=3D10407 jiffies, g=3D9697, q=3D29)
|[  229.052785] rcu: All QSes seen, last rcu_sched kthread activity 10407 (=
4294960194-4294949787), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
|[  229.065505] stress-ng-hrtim R  running task        0  2251   2248 0x000=
00001
|[  229.072763] Call trace:
|[  229.075276]  dump_backtrace+0x0/0x198
|[  229.079037]  show_stack+0x1c/0x28
|[  229.082443]  sched_show_task+0x224/0x248
|[  229.086476]  rcu_sched_clock_irq+0x7c4/0x840
|[  229.090866]  update_process_times+0x34/0x70
|[  229.095165]  tick_sched_handle.isra.0+0x34/0x70
|[  229.099824]  tick_sched_timer+0x50/0xa0
|[  229.103767]  __hrtimer_run_queues+0x18c/0x5b0
|[  229.108246]  hrtimer_interrupt+0xec/0x248
|[  229.112368]  arch_timer_handler_phys+0x38/0x48
|[  229.116938]  handle_percpu_devid_irq+0xd0/0x3c8
|[  229.121597]  generic_handle_irq+0x2c/0x40
|[  229.125718]  __handle_domain_irq+0x68/0xc0
|[  229.129930]  gic_handle_irq+0x64/0x150
|[  229.133781]  el1_irq+0xbc/0x140
|[  229.137008]  lock_acquire+0xdc/0x250
|[  229.140682]  __might_fault+0x68/0x88
|[  229.144354]  preserve_fpsimd_context+0x160/0x2f8
|[  229.149101]  setup_rt_frame+0x48c/0xee8
|[  229.153044]  do_notify_resume+0x3b0/0x488
|[  229.157167]  work_pending+0x8/0x14
|[  229.160666] rcu: rcu_sched kthread starved for 10418 jiffies! g9697 f0x=
2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D1
|[  229.171053] rcu: RCU grace-period kthread stack dump:
|[  229.176250] rcu_sched       R  running task        0    10      2 0x000=
00028
|[  229.183506] Call trace:
|[  229.186019]  __switch_to+0x104/0x170
|[  229.189697]  __schedule+0x36c/0x860
|[  229.193277]  schedule+0x7c/0x108
|[  229.196592]  schedule_timeout+0x204/0x4c0
|[  229.200714]  rcu_gp_kthread+0x5b0/0x1798
|[  229.204747]  kthread+0x110/0x140
|[  229.208061]  ret_from_fork+0x10/0x18

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl8nxPEACgkQeSpbgcuY
8KZBeQ/+N0TBZ5Ex1UKhQ2B69p8bii6WBHmXkZ523zwqdCnxyegCk9LyjgFpnzLB
b7GWvU5wb1fzFf9EWKNHM+CPyh3ZGsrI7CbrObgBE86fQXR3b6/DbcDrIRZd+XIv
q6phgjDc/PN2aFf4A/7zlZrVkAXRgVVzbkMnXANgBYL4zgDVxChNrE+QLvL+Hwf7
wieIv0Jwh2ei+DPhm72Yq6sUDjrs5RwM8tYXioW72t8YIos2pSvc9mW4OX0o+kLd
JTFBw25u95QipuKvLxNB+51g5hIcwEYug0WfHDCvofe5H+qX2rMrOc5A92A0xooW
GWh0i/8y79kkJlVvqDQij/0UDhqEwZr9Ek7Qwqe8ogwhXW19S+pkPeIpgDHl1G5D
f2ueKVAfJ4GYwN6Kle3ZPDQkUpiZlk7OHjJQdyoluOWV1/9YDVEOYYk7e98t9Nbs
uPummG3Y37GsXy5s30Iq8XGMEBsyGZL2EyGQ/RLLj0C3iVf9dEGe2bdf1DEiz8MQ
d9Tv5T2RMS3WJq2n2jszypyAFY+oAmucQaF+7sMY2lvXzK+lE1iBuZu5kdaKQH4j
nlbZEfsSQWuyPeE8s1nyQVYkursfL92PEmCQ3xlZXJUvzQEnjta9zdGxAsT3v6E2
blYdHgQDvVRfRv9pMYDKukZlLd4v0atq3HLxlBl1KmQ5iBpk2ts=
=P8JH
-----END PGP SIGNATURE-----
--=-=-=--
