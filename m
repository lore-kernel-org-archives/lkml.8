Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96679C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E65420784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="omxUUzly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgDBOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:00:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33944 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbgDBOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:00:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so3999530qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cUYfx1/T0rN3mmFSrP/uDZKg64qpxAJKitWtdbfwY10=;
        b=omxUUzlycbm6U7R5rMbWth+4jjmtiEhYEoR12fCOy1sdDWnOAPSIIXJh7R+Efn+Cbd
         Uu4Tk+98wjCUIb6CuNDLH+rHr+IfybHi88VPNxjzsjVQG/lw1BoPZHvObgC01Zb306kc
         QCrQRFggKQoNhju4vvOowe+CK3eu+f9xXw28+KRtXT0HBgUZyTEPN9UxVWqFvvC8DXh1
         sShoPU1V/0lTskUfYlEPg/9He/pHE7q6DCHREq5C9PSzS/rLs7zsQ0YKm+5rn5qH4Mel
         Iu6R+KKVMIKYaITbA4KU4Qs7BVAy+px6435a8IJ53LCGfSAv/gP7L3NwV+MHCN6SRXlq
         jGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cUYfx1/T0rN3mmFSrP/uDZKg64qpxAJKitWtdbfwY10=;
        b=gR/R+6DDQshFsSCBBITRxEmExsPJ+hWPy5A8nfUuIcmG5nfG8y6OtFQAM4vLHcqDZ4
         t9andQ931NcLFJhXfUjOsosJTrejJj5syNlFmnfXSq4uk85c/MV8KhmMN/sDUvHx610p
         1EY9ESC9iy/dCdmqIFI7mAwmVvd73gHw6Nvk7mWSuCldsIRuCiJbCjMkrZPlulsubmRm
         1KRANBKG9wtSdytFus/rG+YEZ2B75Wmu+tLIH6ULUUxIJImvxkcMgsbZ2nQ73d4T2TtP
         gLWQFOMFHWkbR0C47CV++KjOvbmmHauIbLgo1kLyEwrc2JInvMsJQTwDN9DPjMqwqdXR
         hJ/A==
X-Gm-Message-State: AGi0PuZylzU2HQRNoN9/5ZFa8eHmc8BJBEmXWPWSbw47kd2zQ3tST1/+
        huOva6bLqjuSuWkUee1erjuh1A==
X-Google-Smtp-Source: APiQypIVFhJKX2ObXQDsmXbTYI41ob/mLqs87vmhRlymjY4OyVQ61SbpuN1/XLuJmTuJdRxUNBIjnQ==
X-Received: by 2002:a37:a93:: with SMTP id 141mr3601217qkk.244.1585836018508;
        Thu, 02 Apr 2020 07:00:18 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 206sm704735qkd.122.2020.04.02.07.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:00:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <87369mt9kf.fsf@mpe.ellerman.id.au>
Date:   Thu, 2 Apr 2020 10:00:16 -0400
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, tglx@linutronix.de,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0F26F4C-77A0-41DF-856A-B7E29C56A4B6@lca.pw>
References: <20200401214033.8448-1-cai@lca.pw>
 <87369mt9kf.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 2, 2020, at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>=20
> Qian Cai <cai@lca.pw> writes:
>> From: Peter Zijlstra <peterz@infradead.org>
>>=20
>> In the CPU-offline process, it calls mmdrop() after idle entry and =
the
>> subsequent call to cpuhp_report_idle_dead(). Once execution passes =
the
>> call to rcu_report_dead(), RCU is ignoring the CPU, which results in
>> lockdep complaining when mmdrop() uses RCU from either memcg or
>> debugobjects below.
>>=20
>> Fix it by cleaning up the active_mm state from BP instead. Every arch
>> which has CONFIG_HOTPLUG_CPU should have already called =
idle_task_exit()
>> from AP. The only exception is parisc because it switches them to
>> &init_mm unconditionally (see smp_boot_one_cpu() and smp_cpu_init()),
>> but the patch will still work there because it calls mmgrab(&init_mm) =
in
>> smp_cpu_init() and then should call mmdrop(&init_mm) in finish_cpu().
>=20
> Thanks for debugging this. How did you hit it in the first place?

Just repeatedly offline/online CPUs which will eventually cause an idle =
thread
refcount goes to 0 and trigger __mmdrop() and of course it needs to =
enable
lockdep (PROVE_RCU?) as well as having luck to hit the cgroup, workqueue
or debugobject code paths to call RCU.

>=20
> A link to the original thread would have helped me:
>=20
>  https://lore.kernel.org/lkml/20200113190331.12788-1-cai@lca.pw/
>=20
>> WARNING: suspicious RCU usage
>> -----------------------------
>> kernel/workqueue.c:710 RCU or wq_pool_mutex should be held!
>>=20
>> other info that might help us debug this:
>>=20
>> RCU used illegally from offline CPU!
>> Call Trace:
>> dump_stack+0xf4/0x164 (unreliable)
>> lockdep_rcu_suspicious+0x140/0x164
>> get_work_pool+0x110/0x150
>> __queue_work+0x1bc/0xca0
>> queue_work_on+0x114/0x120
>> css_release+0x9c/0xc0
>> percpu_ref_put_many+0x204/0x230
>> free_pcp_prepare+0x264/0x570
>> free_unref_page+0x38/0xf0
>> __mmdrop+0x21c/0x2c0
>> idle_task_exit+0x170/0x1b0
>> pnv_smp_cpu_kill_self+0x38/0x2e0
>> cpu_die+0x48/0x64
>> arch_cpu_idle_dead+0x30/0x50
>> do_idle+0x2f4/0x470
>> cpu_startup_entry+0x38/0x40
>> start_secondary+0x7a8/0xa80
>> start_secondary_resume+0x10/0x14
>=20
> Do we know when this started happening? ie. can we determine a Fixes
> tag?

I don=E2=80=99t know. I looked at some commits that it seems the code =
was like that
even 10-year ago. It must be nobody who cares to run lockdep =
(PROVE_RCU?)
with CPU hotplug very regularly.

>=20
>> <Peter to sign off here>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/powerpc/platforms/powernv/smp.c |  1 -
>> include/linux/sched/mm.h             |  2 ++
>> kernel/cpu.c                         | 18 +++++++++++++++++-
>> kernel/sched/core.c                  |  5 +++--
>> 4 files changed, 22 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/powernv/smp.c =
b/arch/powerpc/platforms/powernv/smp.c
>> index 13e251699346..b2ba3e95bda7 100644
>> --- a/arch/powerpc/platforms/powernv/smp.c
>> +++ b/arch/powerpc/platforms/powernv/smp.c
>> @@ -167,7 +167,6 @@ static void pnv_smp_cpu_kill_self(void)
>> 	/* Standard hot unplug procedure */
>>=20
>> 	idle_task_exit();
>> -	current->active_mm =3D NULL; /* for sanity */
>=20
> If I'm reading it right, we'll now be running with active_mm =3D=3D =
init_mm
> in the offline loop.
>=20
> I guess that's fine, I can't think of any reason it would matter, and =
it
> seems like we were NULL'ing it out just for paranoia's sake not =
because
> of any actual problem.
>=20
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>=20
>=20
> cheers
>=20
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index c49257a3b510..a132d875d351 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
>> 		__mmdrop(mm);
>> }
>>=20
>> +void mmdrop(struct mm_struct *mm);
>> +
>> /*
>>  * This has to be called after a get_task_mm()/mmget_not_zero()
>>  * followed by taking the mmap_sem for writing before modifying the
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 2371292f30b0..244d30544377 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -3,6 +3,7 @@
>>  *
>>  * This code is licenced under the GPL.
>>  */
>> +#include <linux/sched/mm.h>
>> #include <linux/proc_fs.h>
>> #include <linux/smp.h>
>> #include <linux/init.h>
>> @@ -564,6 +565,21 @@ static int bringup_cpu(unsigned int cpu)
>> 	return bringup_wait_for_ap(cpu);
>> }
>>=20
>> +static int finish_cpu(unsigned int cpu)
>> +{
>> +	struct task_struct *idle =3D idle_thread_get(cpu);
>> +	struct mm_struct *mm =3D idle->active_mm;
>> +
>> +	/*
>> +	 * idle_task_exit() will have switched to &init_mm, now
>> +	 * clean up any remaining active_mm state.
>> +	 */
>> +	if (mm !=3D &init_mm)
>> +		idle->active_mm =3D &init_mm;
>> +	mmdrop(mm);
>> +	return 0;
>> +}
>> +
>> /*
>>  * Hotplug state machine related functions
>>  */
>> @@ -1549,7 +1565,7 @@ static struct cpuhp_step cpuhp_hp_states[] =3D =
{
>> 	[CPUHP_BRINGUP_CPU] =3D {
>> 		.name			=3D "cpu:bringup",
>> 		.startup.single		=3D bringup_cpu,
>> -		.teardown.single	=3D NULL,
>> +		.teardown.single	=3D finish_cpu,
>> 		.cant_stop		=3D true,
>> 	},
>> 	/* Final state before CPU kills itself */
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a2694ba82874..8787958339d5 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6200,13 +6200,14 @@ void idle_task_exit(void)
>> 	struct mm_struct *mm =3D current->active_mm;
>>=20
>> 	BUG_ON(cpu_online(smp_processor_id()));
>> +	BUG_ON(current !=3D this_rq()->idle);
>>=20
>> 	if (mm !=3D &init_mm) {
>> 		switch_mm(mm, &init_mm, current);
>> -		current->active_mm =3D &init_mm;
>> 		finish_arch_post_lock_switch();
>> 	}
>> -	mmdrop(mm);
>> +
>> +	/* finish_cpu(), as ran on the BP, will clean up the active_mm =
state */
>> }
>>=20
>> /*
>> --=20
>> 2.21.0 (Apple Git-122.2)

