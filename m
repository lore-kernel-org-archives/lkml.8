Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF118C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A78420757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SQVoc/4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEVFPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:15:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:40249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgEVFPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590124479;
        bh=lEbCr0DqQYakl+sanCrnx0aCVUsaO0F62dEVddlHjUU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SQVoc/4sXQ4ThHCjTyRHTVADT3Oy4YptU0fKX5SwTj9eChZY6Qs+ZRlM+m9XFHUya
         GeC3TvMTsvt9g0CgoYWIODj7IiNDhtYwbAR3MLerUoigkdNXQ8iMxc3WD0kgINBm4V
         96oxOptYvPZObFapeSjkX6aDPeAib9ZWBoUDHSxs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.65.3] ([94.21.100.154]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1jG9eA45BI-00md9n; Fri, 22
 May 2020 07:14:39 +0200
Date:   Fri, 22 May 2020 07:14:31 +0200 (CEST)
From:   Tibor Billes <tbilles@gmx.com>
X-X-Sender: tbilles@serpens
To:     Ian Rogers <irogers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Panic related to perf (bisected)
In-Reply-To: <CAP-5=fVX+VXR8dSgJfNLsg+TNtZBzeeCLevZJY9=cvyprkU-fg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2005220701250.29844@serpens>
References: <9f6564e8-8990-3a93-50da-c7e666f319ea@gmx.com> <CAP-5=fVX+VXR8dSgJfNLsg+TNtZBzeeCLevZJY9=cvyprkU-fg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NSJBa//cbQUbnhy6DeakxUnOf05YJx3V5rlkAtRBlcrk+DXdFHv
 uZq7I0WxVERWSgqqqkryBtiM+rPisokVh75JiyVIF9f3QVgXvprQj0waJKeWb0RoVI1f8mY
 VHHR1a+hrxNpXRlDvxRDPOJA00Kl5zG70N18UOLtvR+jMt4JGxRP3a0tGHQbsHzYTqFDzS+
 d0QEAmJaY923UITZ2nzgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9KUFEtvTW9o=:+Y3wA8T5WSA3w7IudM7Odp
 U+Yx3WGfsj0Cr8qAOTTHGhiBawTQAW4jwutosVurYNMrw4gtDpxR1w9gdqoCOCXjuOJ0pkd0h
 To+Ytw8mgnMhURf0jj7zeO9JUgxAWNKOvdhCgF6Iodvo9aXd5uvzD+cVrvhNitADioh9216nK
 tAWIE9wYQGBP5W3+YKloGfofJ9MULBbhBJNRmInpkWedfWHsz8LdtV5ebQwJCvRrQDy7IsdMY
 /0qn+su1BPq9xWSYNVhIqFvgQgeADzF/I4epoezGEJ7FQTUxatkbZOwAD7vLClRrUQ78UbIMd
 CH+kj28dO2BfCT1c7YBG6lo5rzQfh51CejMpBtG5MWqXJjS7xUJcq6ajxu9E81woHW7Q3BF/C
 jJpzveKKm/5GKvLD1Sr9LF/7ZWEUsld8y3XndMWai2OSj/vFcUZpomhW7TKaVhg4JO8L9D8MA
 tHwliwiQbX7uHsw4uQODa+S2o546yXi/WN1+0md2wsxVSm2eKe8mSr1+uf6pLyfhXD3WC5Bwp
 ABGA7qv/Alfu4LvYkGmXKaJNDY6rU+HdCPxBaX+IfbhQJl1sdTmZJci0aT451GhDWCMlILcdO
 fiNRVBVjZuXbtWeN1gJgBXH7NWGhldp+kLRGUwAopWe1kYvxn+b/dQk1SLTaFRa/P0j1sfrVn
 FqVAQo4ASV3q8PcGhRwf4USIbjanR8XfGuHFumjcLoqKOmRi/K1YXsMwjIQcEa670t2k7Fliz
 jUOCkaqtwQNq+IFU2ELIT8ow0tZaz4apVopYlPrhWrzTyu+nD5b79MKR5YdEAexOkhs6m2djT
 xpHladcr2JWqLpygR5q3503KLZBoCpucnEgQJHDsDtqArXUmHI3gySe3NvFaR60ZGdIq752m7
 tN/6+dVT2l92k3SNVh8kq/UEWBdpOLx9UUyXcIMHgaoYwwBQEhbzOOhsmpF6wyy7i/hN3eAzH
 plIG05wxC9xIXJaq2v0xKI3j6rwLkfeb1Hfartm/48axGJYIXmIgYAvuu2O/NXxeGxD8WLTcw
 yjBU0bSYYHK5GIvFj/vOj9z1J8rvUqvTNtgbkXMeNehKyZ1CC/7QBIwAUGwYIdZwn6oAmfKbO
 sL7kwHVATWA+zOItZ/Tz/KtY/Dxqn0rDVdWNhrkfBKghDj3Rg1PszLRZb/vfXOvd/TNdMRmh3
 iJj4bMfTdBxbx9N4utAnqiSEEeIPl6FPlvU9so7VYjcaiWpumn/WfpT3eyL4Vn14FlXoyJQ/7
 czBL6STc0rwjWJ2ql
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 May 2020, Ian Rogers wrote:

> On Sat, May 16, 2020 at 6:36 AM Billes Tibor <tbilles@gmx.com> wrote:
> >
> > Hi,
> >
> > I've been hitting a freeze on my laptop since 5.3, but haven't got the
> > time to finish bisecting it. Now
> > I had, and here is what I found:
> >
> > - 5.2 series works correctly (tested 5.2.9 and 5.2.15)
> > - 5.3 series and newer kernels freeze. The newest I tested is 5.6.10
> > (which also freezes). There will
> >    be a complete bisect log at the end of the mail.
> >
> > There are several circumstances to reproduce the freeze. At least this
> > is what I found relevant:
> > - The freeze does not occur after a fresh boot, it needs a sleep-wakeu=
p
> > cycle.
> > - Run `perf stat -a --topdown -- sleep 8s` every minute (It is part of
> > some metrics I collect using Zabbix)
> > - Some workload (building the kernel or gaming) increases the chance o=
f
> > freezing, but it can occur
> >    without user interaction too.
> >
> > The freeze usually comes within a few minutes after wakeup. The longes=
t
> > was about an hour. (For
> > comparison, if I don't do a sleep-wakeup, the machine works fine for 8=
+
> > hours).
> >
> > First, there is a warning in syslog, then I took pictures of the actua=
l
> > panic.
> >
> > The warning:
> > May 16 13:28:46 serpens kernel: [33128.086217] ------------[ cut here
> > ]------------
> > May 16 13:28:46 serpens kernel: [33128.086222] WARNING: CPU: 0 PID: 0 =
at
> > arch/x86/events/core.c:1506 x86_pmu_del+0x140/0x160
> > May 16 13:28:46 serpens kernel: [33128.086223] Modules linked in:
> > nouveau mxm_wmi ttm ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc
> > iptable_filter binfmt_misc essiv authenc uvcvideo iwlmvm
> > videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev mac80211
> > videobuf2_common snd_hda_codec_realtek snd_hda_codec_generic libarc4
> > snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep intel_rapl_msr
> > iwlwifi snd_hda_core intel_rapl_common snd_pcm x86_pkg_temp_thermal
> > snd_seq mei_me cfg80211 snd_seq_device snd_timer mei intel_powerclamp
> > snd soundcore ideapad_laptop coretemp sparse_keymap ip_tables x_tables
> > dm_crypt hid_generic usbhid hid i915 intel_gtt i2c_algo_bit
> > drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm
> > aesni_intel glue_helper crypto_simd r8169 ahci cryptd psmouse libahci
> > realtek drm_panel_orientation_quirks video wmi
> > May 16 13:28:46 serpens kernel: [33128.086247] CPU: 0 PID: 0 Comm:
> > swapper/0 Not tainted 5.6.10 #52
> > May 16 13:28:46 serpens kernel: [33128.086247] Hardware name: LENOVO
> > 20378/Lenovo Y50-70, BIOS 9ECN36WW(V2.00) 01/12/2015
> > May 16 13:28:46 serpens kernel: [33128.086249] RIP:
> > 0010:x86_pmu_del+0x140/0x160
> > May 16 13:28:46 serpens kernel: [33128.086250] Code: 63 d8 48 c7 84 dd
> > 20 07 00 00 00 00 00 00 4c 89 e7 89 85 14 02 00 00 e8 fe 27 16 00 e9 e=
f
> > fe ff ff 44 8d 6b 01 e9 5d ff ff ff <0f> 0b 5b 5d 41 5c 41 5d c3 31 db
> > e9 41 ff ff ff 41 bd 01 00 00 00
> > May 16 13:28:46 serpens kernel: [33128.086251] RSP:
> > 0018:ffffa2a380003e40 EFLAGS: 00010046
> > May 16 13:28:46 serpens kernel: [33128.086252] RAX: 0000000000000005
> > RBX: 0000000000000005 RCX: 0000000000000010
> > May 16 13:28:46 serpens kernel: [33128.086253] RDX: 0000000000000005
> > RSI: 0000000000000005 RDI: ffff907c4d4b1000
> > May 16 13:28:46 serpens kernel: [33128.086254] RBP: ffff907d932125a0
> > R08: 0000000000000002 R09: 0000000000029f80
> > May 16 13:28:46 serpens kernel: [33128.086254] R10: ffffa2a380003eb0
> > R11: 0000000000000000 R12: ffff907c4d4b1000
> > May 16 13:28:46 serpens kernel: [33128.086255] R13: 0000000000000006
> > R14: ffff907d9326fc0c R15: ffff907d9326fb00
> > May 16 13:28:46 serpens kernel: [33128.086256] FS:
> > 0000000000000000(0000) GS:ffff907d93200000(0000) knlGS:000000000000000=
0
> > May 16 13:28:46 serpens kernel: [33128.086256] CS:  0010 DS: 0000 ES:
> > 0000 CR0: 0000000080050033
> > May 16 13:28:46 serpens kernel: [33128.086257] CR2: 00007f713c5b44b0
> > CR3: 000000008300a001 CR4: 00000000001606f0
> > May 16 13:28:46 serpens kernel: [33128.086257] Call Trace:
> > May 16 13:28:46 serpens kernel: [33128.086259]  <IRQ>
> > May 16 13:28:46 serpens kernel: [33128.086263]
> > event_sched_out.isra.116+0x89/0x1f0
> > May 16 13:28:46 serpens kernel: [33128.086264]
> > group_sched_out.part.118+0x55/0xd0
> > May 16 13:28:46 serpens kernel: [33128.086265] ctx_sched_out+0x207/0x2=
40
> > May 16 13:28:46 serpens kernel: [33128.086267]
> > perf_mux_hrtimer_handler+0x267/0x310
> > May 16 13:28:46 serpens kernel: [33128.086269]  ?
> > __perf_install_in_context+0x220/0x220
> > May 16 13:28:46 serpens kernel: [33128.086270]
> > __hrtimer_run_queues+0xfa/0x260
> > May 16 13:28:46 serpens kernel: [33128.086272] hrtimer_interrupt+0xe5/=
0x240
> > May 16 13:28:46 serpens kernel: [33128.086275]  ?
> > recalibrate_cpu_khz+0x10/0x10
> > May 16 13:28:46 serpens kernel: [33128.086278]
> > smp_apic_timer_interrupt+0x62/0x120
> > May 16 13:28:46 serpens kernel: [33128.086280] apic_timer_interrupt+0x=
f/0x20
> > May 16 13:28:46 serpens kernel: [33128.086281]  </IRQ>
> > May 16 13:28:46 serpens kernel: [33128.086284] RIP:
> > 0010:cpuidle_enter_state+0xb6/0x3f0
> > May 16 13:28:46 serpens kernel: [33128.086285] Code: c4 0f 1f 44 00 00
> > 31 ff e8 d7 bf a9 ff 80 7c 24 0b 00 74 12 9c 58 f6 c4 02 0f 85 12 03 0=
0
> > 00 31 ff e8 0e 74 af ff fb 45 85 ed <0f> 88 ad 02 00 00 49 63 c5 4c 2b
> > 24 24 48 8d 14 40 48 8d 14 90 48
> > May 16 13:28:46 serpens kernel: [33128.086285] RSP:
> > 0018:ffffffffb5003e58 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> > May 16 13:28:46 serpens kernel: [33128.086286] RAX: ffff907d9322a700
> > RBX: ffff907d93232c00 RCX: 000000000000001f
> > May 16 13:28:46 serpens kernel: [33128.086287] RDX: 00001e213bcf5a93
> > RSI: 0000000033518eeb RDI: 0000000000000000
> > May 16 13:28:46 serpens kernel: [33128.086288] RBP: ffffffffb50be6a0
> > R08: 0000000000000002 R09: 0000000000029f80
> > May 16 13:28:46 serpens kernel: [33128.086288] R10: ffffffffb5003e40
> > R11: 000000000000004c R12: 00001e213bcf5a93
> > May 16 13:28:46 serpens kernel: [33128.086289] R13: 0000000000000001
> > R14: 0000000000000001 R15: ffffffffffffffff
> > May 16 13:28:46 serpens kernel: [33128.086291]  ?
> > cpuidle_enter_state+0x99/0x3f0
> > May 16 13:28:46 serpens kernel: [33128.086292] cpuidle_enter+0x29/0x40
> > May 16 13:28:46 serpens kernel: [33128.086295]  do_idle+0x1ff/0x270
> > May 16 13:28:46 serpens kernel: [33128.086296] cpu_startup_entry+0x19/=
0x20
> > May 16 13:28:46 serpens kernel: [33128.086299] start_kernel+0x4a6/0x4b=
3
> > May 16 13:28:46 serpens kernel: [33128.086302]
> > secondary_startup_64+0xa4/0xb0
> > May 16 13:28:46 serpens kernel: [33128.086303] ---[ end trace
> > 6d25af1bc8d0e9ca ]---
> >
> > Here are the photos of the panic: https://postimg.cc/gallery/Ywm0Ywd
> > (Same panic, just taken
> > multiple photos to be readable).
> >
> > Here is another photo of a panic from another machine:
> > https://i.postimg.cc/d00s8Ncb/DSC-0395.jpg
> > Same setup regarding perf stat -a and the sleep-wakeup, but can't
> > remember the exact kernel
> > version I was running.
> >
> > I tried reverting fd7d55172d1e2e501e6da0a5c1de25f06612dc2e which is th=
e
> > first bad commit
> > according to my bisect, but there were conflicts, and I'm not a kernel
> > developer, I couldn't resolve
> > them.
>
> The bisect shows bad and good alongside each other and so isn't
> categorically pointing at that change, which should be benign with
> your command lines given cgroup profiling isn't used.

I was under the impression this is how bisect works, good and bad
revisions progress as the binary search tries to pick commits in the
middle and sometimes it is before, and sometime it is after the commit in
question. Given the above I don't understand what you mean by 'so isn't
categorically pointing at that change'. Could you please explain? Is
there a way for me to do a more precise bisect? Are there any related
DEBUG configs to enable extra asserts?

> There were
> related fixes, such as 7fa343b7fdc4f351de4e3f28d5c285937dd1f42f and
> 90c91dfb86d0ff545bd329d3ddd72c147e2ae198 but neither mention panics.
> The crash is happening in the PMU code rather than the generic perf
> handling, so maybe that is at issue?

Thanks for clarifying some details!

Tibor

>
> Sorry to not have a fix for your problem,
> Ian
>
> > Bisect log:
> >
> > git bisect start
> > # bad: [70c707aae3e586f6ebc677ad733a9c3cea32f7ac] Linux 5.5.1
> > git bisect bad 70c707aae3e586f6ebc677ad733a9c3cea32f7ac
> > # good: [aad39e30fb9e6e7212318a1dad898f36f1075648] Linux 5.2.9
> > git bisect good aad39e30fb9e6e7212318a1dad898f36f1075648
> > # good: [0ecfebd2b52404ae0c54a878c872bb93363ada36] Linux 5.2
> > git bisect good 0ecfebd2b52404ae0c54a878c872bb93363ada36
> > # bad: [3c30819dc68ab9498216421b6846123900c0a6d3] Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
> > git bisect bad 3c30819dc68ab9498216421b6846123900c0a6d3
> > # bad: [d9b9c893048e9d308a833619f0866f1f52778cf5] Merge tag
> > 'ceph-for-5.3-rc1' of git://github.com/ceph/ceph-client
> > git bisect bad d9b9c893048e9d308a833619f0866f1f52778cf5
> > # bad: [db0457338ece7482378d88e50ad298191c3e6947] Merge branch
> > 'for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatchin=
g
> > git bisect bad db0457338ece7482378d88e50ad298191c3e6947
> > # bad: [608745f12462e2d8d94d5cc5dc94bf0960a881e3] Merge branch
> > 'perf-core-for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect bad 608745f12462e2d8d94d5cc5dc94bf0960a881e3
> > # good: [947fbd4ca9fb38f320b076e68cfccab977c5ea01] Merge tag
> > 'please-pull-for_5.3' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras
> > git bisect good 947fbd4ca9fb38f320b076e68cfccab977c5ea01
> > # good: [0dcb4efb1095d0a1f5f681c2b94e98b009cc5d77] ALSA: firewire-lib:
> > code refactoring for local variables
> > git bisect good 0dcb4efb1095d0a1f5f681c2b94e98b009cc5d77
> > # good: [cf2d213e49fdf47e4c10dc629a3659e0026a54b8] Merge tag
> > 'pm-5.3-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> > git bisect good cf2d213e49fdf47e4c10dc629a3659e0026a54b8
> > # bad: [fe96245c7f38c4ea92c1c599b43f176e27d9921e] perf hists: Add
> > block_info in hist_entry
> > git bisect bad fe96245c7f38c4ea92c1c599b43f176e27d9921e
> > # good: [87407fa58b6645cecd24102f58476b8dd7ce778d] perf config: Update
> > default value for llvm.clang-bpf-cmd-template
> > git bisect good 87407fa58b6645cecd24102f58476b8dd7ce778d
> > # skip: [78d6ccce03e86de34c7000bcada493ed0679e350] perf build: Handle
> > slang being in /usr/include and in /usr/include/slang/
> > git bisect skip 78d6ccce03e86de34c7000bcada493ed0679e350
> > # good: [b9271f0c65e12efd9b6319f57a378aac1be98b22] Merge tag 'v5.2-rc6=
'
> > into perf/core, to refresh branch
> > git bisect good b9271f0c65e12efd9b6319f57a378aac1be98b22
> > # good: [203dffacf592317e54480704f569a09f8b7ca380] Documentation/ABI:
> > Document umwait control sysfs interfaces
> > git bisect good 203dffacf592317e54480704f569a09f8b7ca380
> > # bad: [cf8b6970f4fc31898f3d9e25159aa57e235ca4d1] perf symbols: We nee=
d
> > util.h in symbol-elf.c for zfree()
> > git bisect bad cf8b6970f4fc31898f3d9e25159aa57e235ca4d1
> > # bad: [9f94c7f947e919c343b30f080285af53d0fa9902] perf tools: Increase
> > MAX_NR_CPUS and MAX_CACHES
> > git bisect bad 9f94c7f947e919c343b30f080285af53d0fa9902
> > # good: [122f1c51b11a9e572263c4965d772381fcef06c5] perf/x86/rapl: Get
> > MSR values from new probe framework
> > git bisect good 122f1c51b11a9e572263c4965d772381fcef06c5
> > # bad: [2d7102a0453769fd37e9f4ce68652e104fbf5c84] perf tools: Fix
> > cache.h include directive
> > git bisect bad 2d7102a0453769fd37e9f4ce68652e104fbf5c84
> > # good: [637d97b53cdded02da55d0a25cda6fd6af3bd042] perf/x86/rapl: Get
> > quirk state from new probe framework
> > git bisect good 637d97b53cdded02da55d0a25cda6fd6af3bd042
> > # bad: [fd7d55172d1e2e501e6da0a5c1de25f06612dc2e] perf/cgroups: Don't
> > rotate events for cgroups unnecessarily
> > git bisect bad fd7d55172d1e2e501e6da0a5c1de25f06612dc2e
> > # first bad commit: [fd7d55172d1e2e501e6da0a5c1de25f06612dc2e]
> > perf/cgroups: Don't rotate events for cgroups unnecessarily
> >
> > Is there any more information that I can gather to make this issue
> > easier to fix?
> >
> > Thanks,
> > Tibor Billes
>
