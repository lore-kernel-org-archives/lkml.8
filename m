Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03403206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DwbKW2i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgC3Cme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:42:34 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34490 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgC3Cmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:42:33 -0400
Received: by mail-qv1-f68.google.com with SMTP id s18so3760524qvn.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v55YXPycKm4GI9yijRVyHBSIpHrT3TwnpN/s4/pGhPU=;
        b=DwbKW2i4eGuRzoKRlhMteNmq8s0X9240q1Je2oX1AdNqhieF8avbmx8xc3oW1Nv7KR
         3O1Uj4zWYv6hv1pMzxCdZz+CLe8n01Nz0xyWfgQVVtI9PhspfEPL4GXHkJzrQ0CxTvoz
         vGc2gwQrCTLzqb4QtIY0RyHG74SeYNq+ii37uNjuSxvYsIw6Lhxu+F0eE7Mt5+Pz8Rpq
         4RKo/+kPXol2x4jtr3L4FNJDy6VECmWud9AcXqjxjKRY/sPRqNBmgiWZDtNGP+0wrSaD
         ikC/Kw3uXr8WdjmOj15b36YE8UDc+jf5uwVV49xbLrgfhHL80wvLDbFCJZHaXPL7LjUd
         W2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v55YXPycKm4GI9yijRVyHBSIpHrT3TwnpN/s4/pGhPU=;
        b=Am5UTL99RBOgRxaTpTcQEAoLoBa6TIqZDOkjEh6V2LvPP8BXmdF4A/KiGmY45QUclC
         wpn+YLGxDL7kIePR4R3BTQrlZwmbO0Ypom133EJcwrTv3dlgaHBf1HKE5t/0zyfrKKD7
         7xRIqAq+1fGlPeLkcR/JWN9OYhCjS74K0w4PLFXtT8C2DtMiPC5CaeCMiHSh+LA15wKt
         Hpov6GPidnwYl1dIWCKkYT4aGoMiM1k0IQ7JjHyiZe0XB/3yewgC9IWpLBxKwUE2kMTw
         9k8GlwpjDQHfrkkfMz8OPD3FiaTWxLmW23wqyFdOLAPyLqGZsO33PtCvnouAzhmTfyXy
         aOhA==
X-Gm-Message-State: ANhLgQ0kRAIN7Yf7Mynji231rLcqkk8JwaI3I6vXvVWptf6sgQ7DkNkM
        RZEfJwxgYX1paHin6Y0x1gZpKw==
X-Google-Smtp-Source: ADFU+vti8sM4xOHmrxUMCeGg1/b5EUyiFcEfF96aPQ5V0SqxmKSmKX4VyNqjJjS+eSz+h4GtYoiyeg==
X-Received: by 2002:ad4:4468:: with SMTP id s8mr9477838qvt.115.1585536149272;
        Sun, 29 Mar 2020 19:42:29 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f1sm8648995qkl.91.2020.03.29.19.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 19:42:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121103506.GH14914@hirez.programming.kicks-ass.net>
Date:   Sun, 29 Mar 2020 22:42:27 -0400
Cc:     Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FC8821F-833D-4EE8-B6BD-F8ADB5F29A77@lca.pw>
References: <20200120101652.GM14879@hirez.programming.kicks-ass.net>
 <F96BF662-BB11-4AFB-BF05-CB1720441A92@lca.pw>
 <20200121103506.GH14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 5:35 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Jan 20, 2020 at 03:35:09PM -0500, Qian Cai wrote:
>>> On Jan 20, 2020, at 5:17 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> Bah.. that's horrible. Surely we can find a better place to do this =
in
>>> the whole hotplug machinery.
>>>=20
>>> Perhaps you can have takedown_cpu() do the mmdrop()?
>>=20
>> The problem is that no all arch_cpu_idle_dead() will call
>> idle_task_exit(). For example, alpha and parisc are not, so it needs
>=20
> How is that not broken? If the idle thread runs on an active_mm, we =
need
> to drop that reference. This needs fixing regardless.

It turns out alpha does not support cpu hotplug (no CONFIG_HOTPLUG_CPU),
and parisc will use &init_mm for idle tasks of secondary CPUs as in,

smp_callin()
  smp_cpu_init()

/* Initialise the idle task for this CPU */=09
mmgrab(&init_mm);
current->active_mm =3D &init_mm;
BUG_ON(current->mm);
enter_lazy_tlb(&init_mm, current);

>=20
>> to deal with some kind of ifdef dance in takedown_cpu() to
>> conditionally call mmdrop() which sounds even more horrible?
>>=20
>> If you really prefer it anyway, maybe something like touching every =
arch=E2=80=99s __cpu_die() to also call mmdrop() depends on arches?
>>=20
>> BTW, how to obtain the other CPU=E2=80=99s current task mm? Is that =
cpu_rq(cpu)->curr->active_mm?
>=20
> Something like this; except you'll need to go audit archs to make sure
> they all call idle_task_exit() and/or put in comments on why they =
don't
> have to (perhaps their bringup switches them to &init_mm =
unconditionally
> and the switch_mm() is not required).

I have to modify your code slightly (below) to pass compilation, but =
then it will
panic during cpu offline for some reasons,

[  258.972625][ T9006] Faulting instruction address: 0xc00000000010afc4
[  258.972640][ T9006] Oops: Kernel access of bad area, sig: 11 [#1]
[  258.972651][ T9006] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[  258.972675][ T9006] Modules linked in: kvm_hv kvm ip_tables x_tables =
xfs sd_mod bnx2x ahci mdio libahci tg3 libata libphy firmware_class =
dm_mirror dm_region_hash dm_log dm_mod
[  258.972716][ T9006] CPU: 84 PID: 9006 Comm: cpuhotplug04.sh Not =
tainted 5.6.0-rc7-next-20200327+ #7
[  258.972741][ T9006] NIP:  c00000000010afc4 LR: c00000000010afa0 CTR: =
fffffffffffffffd
[  258.972775][ T9006] REGS: c000201a54def7f0 TRAP: 0300   Not tainted  =
(5.6.0-rc7-next-20200327+)
[  258.972809][ T9006] MSR:  900000000280b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28224824  XER: 20040000
[  258.972839][ T9006] CFAR: c00000000015951c DAR: 0000000000000050 =
DSISR: 40000000 IRQMASK: 0=20
[  258.972839][ T9006] GPR00: c00000000010afa0 c000201a54defa80 =
c00000000165bd00 c000000001604180=20
[  258.972839][ T9006] GPR04: c00000008160496f 0000000000000000 =
ffff0a01ffffff10 0000000000000020=20
[  258.972839][ T9006] GPR08: 0000000000000050 0000000000000000 =
c00000000162c0e0 0000000000000002=20
[  258.972839][ T9006] GPR12: 0000000088224428 c000201fff69a900 =
0000000040000000 000000011a029798=20
[  258.972839][ T9006] GPR16: 000000011a029724 0000000119fc6968 =
0000000119f5f230 000000011a02d568=20
[  258.972839][ T9006] GPR20: 00000001554c66f0 0000000000000000 =
c000001ffc957820 c00000000010af80=20
[  258.972839][ T9006] GPR24: 0000001ffb8a0000 c0000000014f34a8 =
0000000000000056 c0000000010b7820=20
[  258.972839][ T9006] GPR28: c00000000168c654 0000000000000000 =
c00000000168c3a8 0000000000000000=20
[  258.973070][ T9006] NIP [c00000000010afc4] finish_cpu+0x44/0x90
atomic_dec_return_relaxed at arch/powerpc/include/asm/atomic.h:179
(inlined by) atomic_dec_return at include/linux/atomic-fallback.h:518
(inlined by) atomic_dec_and_test at include/linux/atomic-fallback.h:1035
(inlined by) mmdrop at include/linux/sched/mm.h:48
(inlined by) finish_cpu at kernel/cpu.c:579
[  258.973092][ T9006] LR [c00000000010afa0] finish_cpu+0x20/0x90
[  258.973113][ T9006] Call Trace:
[  258.973132][ T9006] [c000201a54defa80] [c00000000010afa0] =
finish_cpu+0x20/0x90 (unreliable)
[  258.973166][ T9006] [c000201a54defaa0] [c00000000010cd34] =
cpuhp_invoke_callback+0x194/0x15f0
cpuhp_invoke_callback at kernel/cpu.c:173
[  258.973202][ T9006] [c000201a54defb50] [c000000000111acc] =
_cpu_down.constprop.15+0x17c/0x410
[  258.973237][ T9006] [c000201a54defbc0] [c00000000010ff84] =
cpu_down+0x64/0xb0
[  258.973263][ T9006] [c000201a54defc00] [c000000000754760] =
cpu_subsys_offline+0x20/0x40
[  258.973299][ T9006] [c000201a54defc20] [c00000000074ab10] =
device_offline+0x100/0x140
[  258.973344][ T9006] [c000201a54defc60] [c00000000074ace0] =
online_store+0xa0/0x110
[  258.973378][ T9006] [c000201a54defcb0] [c000000000744508] =
dev_attr_store+0x38/0x60
[  258.973414][ T9006] [c000201a54defcd0] [c0000000005df770] =
sysfs_kf_write+0x70/0xb0
[  258.973438][ T9006] [c000201a54defd10] [c0000000005de92c] =
kernfs_fop_write+0x11c/0x270
[  258.973463][ T9006] [c000201a54defd60] [c0000000004c09bc] =
__vfs_write+0x3c/0x70
[  258.973487][ T9006] [c000201a54defd80] [c0000000004c3dbc] =
vfs_write+0xcc/0x200
[  258.973522][ T9006] [c000201a54defdd0] [c0000000004c415c] =
ksys_write+0x7c/0x140
[  258.973557][ T9006] [c000201a54defe20] [c00000000000b3f8] =
system_call+0x5c/0x68
[  258.973579][ T9006] Instruction dump:
[  258.973598][ T9006] f8010010 f821ffe1 4804e4ed 60000000 3d42fffd =
394a03e0 e9230560 7fa95000=20
[  258.973636][ T9006] 419e0030 f9430560 39090050 7c0004ac <7d404028> =
314affff 7d40412d 40c2fff4=20
[  258.973675][ T9006] ---[ end trace 4f72c711066ac397 ]---
[  259.076271][ T9006]=20
[  260.076362][ T9006] Kernel panic - not syncing: Fatal exception

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c49257a3b510..bc782562ae93 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
=20
+extern void mmdrop(struct mm_struct *mm);
+
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_sem for writing before modifying the
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0cca1a2b4930..302007a602a5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3,6 +3,7 @@
  *
  * This code is licenced under the GPL.
  */
+#include <linux/sched/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/init.h>
@@ -564,6 +565,22 @@ static int bringup_cpu(unsigned int cpu)
 	return bringup_wait_for_ap(cpu);
 }
=20
+static int finish_cpu(unsigned int cpu)
+{
+	struct task_struct *idle =3D idle_thread_get(cpu);
+	struct mm_struct *mm =3D idle->active_mm;
+
+	/*
+	 * idle_task_exit() will have switched to &init_mm, now
+	 * clean up any remaining active_mm state.
+	 */
+	if (mm !=3D &init_mm) {
+		idle->active_mm =3D &init_mm;
+		mmdrop(mm);
+	}
+	return 0;
+}
+
 /*
  * Hotplug state machine related functions
  */
@@ -1549,7 +1566,7 @@ static struct cpuhp_step cpuhp_hp_states[] =3D {
 	[CPUHP_BRINGUP_CPU] =3D {
 		.name			=3D "cpu:bringup",
 		.startup.single		=3D bringup_cpu,
-		.teardown.single	=3D NULL,
+		.teardown.single	=3D finish_cpu,
 		.cant_stop		=3D true,
 	},
 	/* Final state before CPU kills itself */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac8b65298774..16aad39216a2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6248,13 +6248,14 @@ void idle_task_exit(void)
 	struct mm_struct *mm =3D current->active_mm;
=20
 	BUG_ON(cpu_online(smp_processor_id()));
+	BUG_ON(current !=3D this_rq()->idle);
=20
 	if (mm !=3D &init_mm) {
 		switch_mm(mm, &init_mm, current);
-		current->active_mm =3D &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+
+	/* finish_cpu(), as ran on the BP, will clean up the active_mm =
state */
 }
=20
 /*


>=20
> ---
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..2b4d8a69e8d9 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -564,6 +564,23 @@ static int bringup_cpu(unsigned int cpu)
> 	return bringup_wait_for_ap(cpu);
> }
>=20
> +static int finish_cpu(unsigned int cpu)
> +{
> +	struct task_struct *idle =3D idle_thread_get(cpu);
> +	struct mm_struct *mm =3D idle->active_mm;
> +
> +	/*
> +	 * idle_task_exit() will have switched to &init_mm, now
> +	 * clean up any remaining active_mm state.
> +	 */
> +
> +	if (mm =3D=3D &init_mm)
> +		return;
> +
> +	idle->active_mm =3D &init_mm;
> +	mmdrop(mm);
> +}
> +
> /*
>  * Hotplug state machine related functions
>  */
> @@ -1434,7 +1451,7 @@ static struct cpuhp_step cpuhp_hp_states[] =3D {
> 	[CPUHP_BRINGUP_CPU] =3D {
> 		.name			=3D "cpu:bringup",
> 		.startup.single		=3D bringup_cpu,
> -		.teardown.single	=3D NULL,
> +		.teardown.single	=3D finish_cpu,
> 		.cant_stop		=3D true,
> 	},
> 	/* Final state before CPU kills itself */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fc1dfc007604..8f049fb77a3d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6188,13 +6188,14 @@ void idle_task_exit(void)
> 	struct mm_struct *mm =3D current->active_mm;
>=20
> 	BUG_ON(cpu_online(smp_processor_id()));
> +	BUG_ON(current !=3D this_rq()->idle);
>=20
> 	if (mm !=3D &init_mm) {
> 		switch_mm(mm, &init_mm, current);
> -		current->active_mm =3D &init_mm;
> 		finish_arch_post_lock_switch();
> 	}
> -	mmdrop(mm);
> +
> +	/* finish_cpu(), as ran on the BP, will clean up the active_mm =
state */
> }
>=20
> /*

