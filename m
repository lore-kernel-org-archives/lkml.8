Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD3C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DFF2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKCzKNvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDKJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 05:56:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgDKJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:56:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so5019174wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=qjMYQ0iAaWweXpTQNNyUqpGALrond8OJMZAVfeor5uE=;
        b=gKCzKNvYbTjjCQWsKK5GfxCraMEvmCQe4PCQ/UnyXe35Sx+GthUxQilgo+0h+WjjwC
         sHTbbIWVB+l/6KNv3suodO4DWwauFMOzns8LbmJo+i/2S/kS63aSn2sHX8xmP2Dfx9FU
         Ipn54irWHuKvohwaQKyUSbzoLeuanUGXV8tOvTQkOH6sHLrWwIGgai224itQtHM41wmL
         68BY+lpw0aqq1Ubtkxcc8pbek9NyEhgOr3NlcoC8ot1Rr6Kabnm0YBkttTnbWatOEwgh
         kXt/kEh7TrIPf/1CRnOEPNF97jW/iMnNIUKdkhcqmvlOUBJJhmHlhF8Y4rXMYMFqQuG2
         99Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=qjMYQ0iAaWweXpTQNNyUqpGALrond8OJMZAVfeor5uE=;
        b=nRMfo+fgir9eHtKfWZY/7IyfI5YY7qpfa4NJXmVWMCRwVqqGFtNop7JpgAHuNVvmxk
         J1QuTJ9dZpXe8JSX0Lxs4B1wL7pycIMHLiRPdmo983idCjCR2TmgORfZ5KIP/U5e/C5g
         bWHlHocrA4xCnTXew86iAAVfUSa7XU4nOVx3Wl4qQ5WjhxClsbR8dxG43D3HkieFsgyZ
         QKo3EONM550aTr+u77d+R8hz38AffPlFZMPJzR5l1UdpAD+2XeSskNbKLqR+uOUOlPx7
         z03bv+tiS5gbMRgPs2wCs7NtBvws0PfYgYQDkNkwRAZilKEda+cm6t2dWr8al+fUCJOl
         eY2w==
X-Gm-Message-State: AGi0Pua5zbj8jynxnUnxjYptABiyJtbQlPCuJNgkKpZyZso8wKRpAEJ5
        3rUs3KgAJN3qbEjgM52wA8w=
X-Google-Smtp-Source: APiQypKE+RThIscaTwtKUIzXMFyYjxqapK6SyURz8SwYEokLVce/ecr1hceGQPRbg8Oh5bVkNafRjw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr9722699wme.5.1586599008565;
        Sat, 11 Apr 2020 02:56:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id 17sm3331505wmo.2.2020.04.11.02.56.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2020 02:56:48 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: BUG: kernel NULL pointer dereference, address: 0000000000000026
 after switching to 5.7 kernel
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "Russell, Kent" <Kent.Russell@amd.com>
References: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
Date:   Sat, 11 Apr 2020 11:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------508D5A2C9492BF1F16DFD628"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------508D5A2C9492BF1F16DFD628
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Yeah, that is a known issue.

You could try the attached patch, but please be aware that it is not 
even compile tested because of the Easter holidays here.

Thanks,
Christian.

Am 10.04.20 um 21:51 schrieb Mikhail Gavrilov:
> Hi folks.
> After upgrade kernel to 5.7 I see every boot in kernel log following
> error messages:
>
> [    2.569513] [drm] Found UVD firmware ENC: 1.2 DEC: .43 Family ID: 19
> [    2.569538] [drm] PSP loading UVD firmware
> [    2.570038] BUG: kernel NULL pointer dereference, address: 0000000000000026
> [    2.570045] #PF: supervisor read access in kernel mode
> [    2.570050] #PF: error_code(0x0000) - not-present page
> [    2.570055] PGD 0 P4D 0
> [    2.570060] Oops: 0000 [#1] SMP NOPTI
> [    2.570065] CPU: 5 PID: 667 Comm: uvd_enc_1.1 Not tainted
> 5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
> [    2.570072] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
> [    2.570085] RIP: 0010:__kthread_should_park+0x5/0x30
> [    2.570090] Code: 00 e9 fe fe ff ff e8 ca 3a 08 00 e9 49 fe ff ff
> 48 89 df e8 dd 38 08 00 84 c0 0f 84 6a ff ff ff e9 a6 fe ff ff 0f 1f
> 44 00 00 <f6> 47 26 20 74 12 48 8b 87 88 09 00 00 48 8b 00 48 c1 e8 02
> 83 e0
> [    2.570103] RSP: 0018:ffffad8141723e50 EFLAGS: 00010246
> [    2.570107] RAX: 7fffffffffffffff RBX: ffff8a8d1d116ed8 RCX: 0000000000000000
> [    2.570112] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> [    2.570116] RBP: ffff8a8d28c11300 R08: 0000000000000000 R09: 0000000000000000
> [    2.570120] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a8d1d152e40
> [    2.570125] R13: ffff8a8d1d117280 R14: ffff8a8d1d116ed8 R15: ffff8a8d1ca68000
> [    2.570131] FS:  0000000000000000(0000) GS:ffff8a8d3aa00000(0000)
> knlGS:0000000000000000
> [    2.570137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.570142] CR2: 0000000000000026 CR3: 00000007e3dc6000 CR4: 00000000003406e0
> [    2.570147] Call Trace:
> [    2.570157]  drm_sched_get_cleanup_job+0x42/0x130 [gpu_sched]
> [    2.570166]  drm_sched_main+0x6f/0x530 [gpu_sched]
> [    2.570173]  ? lockdep_hardirqs_on+0x11e/0x1b0
> [    2.570179]  ? drm_sched_get_cleanup_job+0x130/0x130 [gpu_sched]
> [    2.570185]  kthread+0x131/0x150
> [    2.570189]  ? __kthread_bind_mask+0x60/0x60
> [    2.570196]  ret_from_fork+0x27/0x50
> [    2.570203] Modules linked in: fjes(-) amdgpu(+) amd_iommu_v2
> gpu_sched ttm drm_kms_helper drm crc32c_intel igb nvme nvme_core dca
> i2c_algo_bit wmi pinctrl_amd br_netfilter bridge stp llc fuse
> [    2.570223] CR2: 0000000000000026
> [    2.570228] ---[ end trace 80c25d326e1e0d7c ]---
> [    2.570233] RIP: 0010:__kthread_should_park+0x5/0x30
> [    2.570238] Code: 00 e9 fe fe ff ff e8 ca 3a 08 00 e9 49 fe ff ff
> 48 89 df e8 dd 38 08 00 84 c0 0f 84 6a ff ff ff e9 a6 fe ff ff 0f 1f
> 44 00 00 <f6> 47 26 20 74 12 48 8b 87 88 09 00 00 48 8b 00 48 c1 e8 02
> 83 e0
> [    2.570250] RSP: 0018:ffffad8141723e50 EFLAGS: 00010246
> [    2.570255] RAX: 7fffffffffffffff RBX: ffff8a8d1d116ed8 RCX: 0000000000000000
> [    2.570260] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> [    2.570265] RBP: ffff8a8d28c11300 R08: 0000000000000000 R09: 0000000000000000
> [    2.570271] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a8d1d152e40
> [    2.570276] R13: ffff8a8d1d117280 R14: ffff8a8d1d116ed8 R15: ffff8a8d1ca68000
> [    2.570281] FS:  0000000000000000(0000) GS:ffff8a8d3aa00000(0000)
> knlGS:0000000000000000
> [    2.570287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.570292] CR2: 0000000000000026 CR3: 00000007e3dc6000 CR4: 00000000003406e0
> [    2.570299] BUG: sleeping function called from invalid context at
> include/linux/percpu-rwsem.h:49
> [    2.570306] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
> 667, name: uvd_enc_1.1
> [    2.570311] INFO: lockdep is turned off.
> [    2.570315] irq event stamp: 14
> [    2.570319] hardirqs last  enabled at (13): [<ffffffffb1b8c976>]
> _raw_spin_unlock_irqrestore+0x46/0x60
> [    2.570330] hardirqs last disabled at (14): [<ffffffffb1004932>]
> trace_hardirqs_off_thunk+0x1a/0x1c
> [    2.570338] softirqs last  enabled at (0): [<ffffffffb10e04f6>]
> copy_process+0x706/0x1bc0
> [    2.570345] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    2.570351] CPU: 5 PID: 667 Comm: uvd_enc_1.1 Tainted: G      D
>        5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
> [    2.570358] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
> [    2.570365] Call Trace:
> [    2.570373]  dump_stack+0x8b/0xc8
> [    2.570380]  ___might_sleep.cold+0xb6/0xc6
> [    2.570385]  exit_signals+0x1c/0x2d0
> [    2.570390]  do_exit+0xb1/0xc30
> [    2.570395]  ? kthread+0x131/0x150
> [    2.570400]  rewind_stack_do_exit+0x17/0x20
> [    2.570559] [drm] Found VCE firmware Version: 57.6 Binary ID: 4
> [    2.570572] [drm] PSP loading VCE firmware
> [    3.146462] [drm] reserve 0x400000 from 0x83fe800000 for PSP TMR
>
> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname -r`/vmlinux __kthread_should_park+0x5
> __kthread_should_park+0x5/0x30:
> to_kthread at kernel/kthread.c:75
> (inlined by) __kthread_should_park at kernel/kthread.c:109
>
> I think this issue related to amdgpu driver.
> Can anyone look into it?
>
> Thanks.
>
> Full kernel log here:
> https://pastebin.com/RrSp6KYL
>
> --
> Best Regards,
> Mike Gavrilov.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------508D5A2C9492BF1F16DFD628
Content-Type: text/x-patch;
 name="0001-drm-scheduler-fix-drm_sched_get_cleanup_job.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-scheduler-fix-drm_sched_get_cleanup_job.patch"

From 66585faf442465bd71dd10c4601eab23f235aa29 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Sat, 11 Apr 2020 11:54:01 +0200
Subject: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are racing to initialize sched->thread here, just always check the
current thread.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a18eabf692e4..9380fa58c8f1 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -674,7 +674,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	 */
 	if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
 	    !cancel_delayed_work(&sched->work_tdr)) ||
-	    __kthread_should_park(sched->thread))
+	    kthread_should_park())
 		return NULL;
 
 	spin_lock(&sched->job_list_lock);
-- 
2.20.1


--------------508D5A2C9492BF1F16DFD628--
