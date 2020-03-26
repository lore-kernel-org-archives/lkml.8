Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC65C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B361820775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ts6MhZup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgCZKkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:40:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44898 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgCZKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:40:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so5804235lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxS8NReL5wLyGB2edoUsfj2JR8VtmMSfbuxW8lCoGGk=;
        b=Ts6MhZupuhWTs7zzEjkS7jtiD8EKz423Kn3wMJK+Tf4K4/xGVGQx10q5OHELZ4T8K1
         d2nzk5+z6SUuB5/1yDSYo5i2M6ZERp4DeHZx75iyolxa7BeSyEYzpicIOAhotuqx/Lr1
         rtfi73TgadVZOdCY//QtFN/YgLWjnI5piZTBaMw++9zkPm/SOUHkPKAlkMKFQ1LEjSM2
         14Od23iHpEIjnJZ20kaMDhQtW3mdWpqPQ1IPBL4mhCRGvEFiPIHuGQMI+Zd3D5zhRt2u
         iH3tKT4s0cw0YiSL7fBDY/PFECbOf19efRTXz3++kvtGynjb/lvM2JA//k9Y1XS5mugB
         0TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxS8NReL5wLyGB2edoUsfj2JR8VtmMSfbuxW8lCoGGk=;
        b=UrSuGkaeyMZmNsHLBwX6WLlARD4IrEjFxyOmgH/ovOoTqqNZvD5BOWg1Ir6K4k1tbp
         dMe7KLYAuf/NtMBOjv4iGkc6TCH8iWzg0YZIiVZhQLKSDDdCD3kpQzWSZamgEsGqOY2L
         JvJC37J/kbl2qWvVepGeyMyvOxxJlaal7tqdoX7bGiN+UC0q0e+r005pnRFsUQPTd/NG
         UVSYr+yss1qoZnzj3e3NpiPnL3wfKuFVQ2LeW01i+MSVP39DvRMK3QQxK4LQGSsKyZAg
         CNfJNS2OH4AHuw2cfOeYgPYSUnSAyoUbXlDWeGf2IffqqtctAUYWz62th3hsqqBMwWZm
         XCAg==
X-Gm-Message-State: AGi0PuYFNciuSIKZu7CRFyJJb5oN2IA8tB0evrfobJ3+7UcwKxm9MgzT
        m8lhpi09xyA/sE+fhvTWxtUeR6W30eemdBNaSAQkIA==
X-Google-Smtp-Source: APiQypIH0/asSKjCqi3G0bfHo7Vu7Qb3KgVPbo+q4lFEo8Df8KOlLTGb4X9llGGI6Nw4MtbdWuP7kNKyofufyZI6Ni4=
X-Received: by 2002:a2e:b446:: with SMTP id o6mr4992867ljm.80.1585219199470;
 Thu, 26 Mar 2020 03:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
 <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
 <20200226164206.GA10128@bogus> <60024e70-0abc-4a06-cd14-42c61a2d2597@gmail.com>
 <b620ddd2-34a5-df5d-310f-4aa2f3e93a4a@gmail.com>
In-Reply-To: <b620ddd2-34a5-df5d-310f-4aa2f3e93a4a@gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Mar 2020 11:39:48 +0100
Message-ID: <CADYN=9JAt=pUB6DUGCfz_qaRAvSEWj6nFyyhvmCimaU6kOLk4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     robh@kernel.org, atull@kernel.org, devicetree@vger.kernel.org,
        geert+renesas@glider.be,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 02:56, Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/13/20 11:40 AM, Frank Rowand wrote:
> > Hi Anders,
> >
> > On 3/13/20 4:51 AM, Anders Roxell wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >>> On Thu, 20 Feb 2020 12:40:20 -0600, frowand.list@gmail.com wrote:
> >>>> From: Frank Rowand <frank.rowand@sony.com>
> >>>>
> >>>> Geert reports that gpio hog nodes are not properly processed when
> >>>> the gpio hog node is added via an overlay reply and provides an
> >>>> RFC patch to fix the problem [1].
> >>>>
> >>>> Add a unittest that shows the problem.  Unittest will report "1 failed"
> >>>> test before applying Geert's RFC patch and "0 failed" after applying
> >>>> Geert's RFC patch.
> >>>>
> >>>> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
> >>>>
> >>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >>
> >> I'm building arm64 on tag next-20200312, and booting in qemu, and I see
> >> this "Kernel panic":
> >
> > Thank you for the panic report.
> >
> > There has also been an x86_64 failure (with a very different stack trace).
> > I am going to investigate the x86_64 failure first.
>
> I have fixed the x86_64 failure:

Great.

>
>    https://lore.kernel.org/linux-devicetree/1585187131-21642-1-git-send-email-frowand.list@gmail.com/
>
> Can you check if the two patches in that series fixes the problem that you
> are seeing?

I got a new error instead.

next-20200325 before I applied your patches [1]:

[ 1933.602460][ T2795] random: get_random_u64 called from
arch_mmap_rnd+0x90/0xb8 with crng_init=1
[ 1933.602770][ T2795] random: get_random_u64 called from
randomize_stack_top+0x50/0xb8 with crng_init=1
[ 1933.603017][ T2795] random: get_random_u32 called from
arch_align_stack+0x70/0x90 with crng_init=1
[ 1936.391730][    T1] systemd[1]: Mounted Configuration File System.
[ [0;32m  OK   [0m] Mounted Configuration File System.
[ 1937.577008][ T2787] Unable to handle kernel paging request at
virtual address ccccccccccccccd4
[ 1937.604944][ T2787] Mem abort info:
[ 1937.622884][ T2787]   ESR = 0x96000004
[ 1937.624443][ T2787]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1937.651817][ T2787]   SET = 0, FnV = 0
[ 1937.672276][ T2787]   EA = 0, S1PTW = 0
[ 1937.679201][ T2787] Data abort info:
[ 1937.680594][ T2787]   ISV = 0, ISS = 0x00000004
[ 1937.705713][ T2787]   CM = 0, WnR = 0
[ 1937.707184][ T2787] [ccccccccccccccd4] address between user and
kernel address ranges
[ 1937.725628][ T2787] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 1937.727743][ T2787] Modules linked in:
[ 1937.729157][ T2787] CPU: 0 PID: 2787 Comm: systemd-journal Tainted:
G    B   W       T 5.6.0-rc7-next-20200325-11880-gbae0ebe545c5 #1
[ 1937.733403][ T2787] Hardware name: linux,dummy-virt (DT)
[ 1937.735393][ T2787] pstate: 40400005 (nZcv daif +PAN -UAO)
[ 1937.737480][ T2787] pc : sysfs_file_ops+0xd0/0xf0
[ 1937.739292][ T2787] lr : sysfs_file_ops+0xd0/0xf0
[ 1937.741052][ T2787] sp : ffff000062287a80
[ 1937.742614][ T2787] x29: ffff000062287a80 x28: ffff000060868040
[ 1937.744875][ T2787] x27: ffff000068553810 x26: ffff000062287d80
[ 1937.747164][ T2787] x25: ffff00006263b200 x24: ffff000068415528
[ 1937.749355][ T2787] x23: ffff000068415538 x22: 0000000000000001
[ 1937.751610][ T2787] x21: ffff000068553810 x20: 0000000000000000
[ 1937.753908][ T2787] x19: cccccccccccccccc x18: 0000000000007ec0
[ 1937.756130][ T2787] x17: 0000000000002208 x16: 0000000000001650
[ 1937.758384][ T2787] x15: 0000000000000000 x14: 0000000000000000
[ 1937.760481][ T2787] x13: 0000000000000000 x12: 0000000000002240
[ 1937.762720][ T2787] x11: 00000000f1f1f1f1 x10: ffff000060868040
[ 1937.764810][ T2787] x9 : ffffa00010a03d28 x8 : 1fffe0000c3c2730
[ 1937.766856][ T2787] x7 : ffff80000c3c2730 x6 : dfffa00000000000
[ 1937.768926][ T2787] x5 : ffff000060868040 x4 : 0000000000000000
[ 1937.770980][ T2787] x3 : ffffa00010a03bc8 x2 : 0000000000000001
[ 1937.773041][ T2787] x1 : ffffa0001626d000 x0 : 0000000000000000
[ 1937.775068][ T2787] Call trace:
[ 1937.776252][ T2787]  sysfs_file_ops+0xd0/0xf0
[ 1937.777785][ T2787]  sysfs_kf_seq_show+0x70/0x240
[ 1937.779429][ T2787]  kernfs_seq_show+0xa8/0xc0
[ 1937.781004][ T2787]  seq_read+0x350/0x860
[ 1937.782437][ T2787]  kernfs_fop_read+0x94/0x3f8
[ 1937.784013][ T2787]  __vfs_read+0x68/0xc8
[ 1937.785456][ T2787]  vfs_read+0x15c/0x2b0
[ 1937.786876][ T2787]  ksys_read+0x104/0x1e8
[ 1937.788318][ T2787]  __arm64_sys_read+0x54/0x68
[ 1937.789931][ T2787]  el0_svc_common.constprop.0+0x294/0x338
[ 1937.791822][ T2787]  do_el0_svc+0xe8/0x108
[ 1937.793287][ T2787]  el0_svc+0x74/0x88
[ 1937.794656][ T2787]  el0_sync_handler+0xcc/0x77c
[ 1937.796259][ T2787]  el0_sync+0x17c/0x180
[ 1937.797758][ T2787] Code: b40000b3 97e8e4d9 91002260 97f6c841 (f9400673)
[ 1937.800049][ T2787] ---[ end trace 8e9be5808e45ebb1 ]---
[ 1937.801854][ T2787] Kernel panic - not syncing: Fatal exception
[ 1937.803844][ T2787] Kernel Offset: disabled
[ 1937.805325][ T2787] CPU features: 0x080002,20002004
[ 1937.806961][ T2787] Memory Limit: none
[ 1937.808349][ T2787] ---[ end Kernel panic - not syncing: Fatal exception ]---

and with the two patches applied I see this [2]:

node:test-bus:test-unittest0'
[ 1839.107618][    T1] PM: Removing info for
platform:testcase-data:overlay-node:test-bus:test-unittest0
[ 1839.111218][    T1] kobject:
'testcase-data:overlay-node:test-bus:test-unittest0'
((____ptrval____)): kobject_uevent_env
[ 1839.116021][    T1] kobject:
'testcase-data:overlay-node:test-bus:test-unittest0'
((____ptrval____)): fill_kobj_path: path =
'/devices/platform/testcase-data:overlay-node:test-bus:test-unittest0'
[ 1839.124287][    T1] kobject:
'testcase-data:overlay-node:test-bus:test-unittest0'
((____ptrval____)): kobject_release, parent (____ptrval____) (delayed
1000)
[ 1839.130497][    T1] Unexpected kernel BRK exception at EL1
[ 1839.132466][    T1] Internal error: ptrace BRK handler: f20003e8
[#1] PREEMPT SMP
[ 1839.134933][    T1] Modules linked in:
[ 1839.136395][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
W       T 5.6.0-rc7-next-20200325-11882-ge7ffe3ef0d63 #1
[ 1839.140051][    T1] Hardware name: linux,dummy-virt (DT)
[ 1839.141976][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
[ 1839.143958][    T1] pc : of_unittest_untrack_overlay+0x6c/0x13c
[ 1839.146026][    T1] lr : of_unittest_untrack_overlay+0x6c/0x13c
[ 1839.148046][    T1] sp : ffff000069807af0
[ 1839.149468][    T1] x29: ffff000069807af0 x28: ffffa00017258000
[ 1839.151579][    T1] x27: ffffa00017258400 x26: 0000000000000000
[ 1839.153635][    T1] x25: ffffa00017258480 x24: ffffa00013418a20
[ 1839.155735][    T1] x23: 0000000000000000 x22: ffffa000152dc880
[ 1839.157828][    T1] x21: 0000000000000000 x20: 00000000ffffffff
[ 1839.160076][    T1] x19: 00000000ffffffff x18: 0000000000001ca0
[ 1839.162198][    T1] x17: 00000000000019d8 x16: 0000000000001c60
[ 1839.164321][    T1] x15: 00000000000019b8 x14: 616c65642820295f
[ 1839.166388][    T1] x13: 5f5f5f6c61767274 x12: 705f5f5f5f282074
[ 1839.168503][    T1] x11: 00000000f1f1f1f1 x10: ffff00006a3f8040
[ 1839.170589][    T1] x9 : ffffa00013d6f370 x8 : 1ffff40002a5a688
[ 1839.172686][    T1] x7 : ffff940002a5a688 x6 : dfffa00000000000
[ 1839.174781][    T1] x5 : ffff00006a3f8040 x4 : 0000000000000000
[ 1839.176871][    T1] x3 : ffffa00011f234ac x2 : 00000000ffffffff
[ 1839.178947][    T1] x1 : ffff00006a3f8040 x0 : 0000000000000000
[ 1839.181034][    T1] Call trace:
[ 1839.182286][    T1]  of_unittest_untrack_overlay+0x6c/0x13c
[ 1839.184295][    T1]  of_unittest+0x3330/0x3638
[ 1839.185892][    T1]  do_one_initcall+0x480/0xa40
[ 1839.187598][    T1]  kernel_init_freeable+0x794/0x95c
[ 1839.189394][    T1]  kernel_init+0x20/0x1f8
[ 1839.190924][    T1]  ret_from_fork+0x10/0x18
[ 1839.192523][    T1] Code: 97955a2c d4210000 14000024 97955a29 (d4207d00)
[ 1839.194889][    T1] ---[ end trace 39370fb7c4bf9e64 ]---
[ 1839.196706][    T1] Kernel panic - not syncing: Fatal exception
[ 1839.198735][    T1] Kernel Offset: disabled
[ 1839.200246][    T1] CPU features: 0x080002,20002004
[ 1839.201900][    T1] Memory Limit: none
[ 1839.203340][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---

Cheers,
Anders
[1] https://people.linaro.org/~anders.roxell/output-next-20200325.log
[2] https://people.linaro.org/~anders.roxell/output-next-20200325.test.log

>
> Thanks,
>
> Frank
>
>
> >
> > Can you please send the kernel .config?
> >
> > Thanks,
> >
> > Frank
> >
> >
> >>
> >> [...]
> >> [  172.779435][    T1] systemd[1]: Mounted POSIX Message Queue File System.
> >> [[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
> >> [  172.844551][    T1] systemd[1]: Mounted Huge Pages File System.
> >> [[0;32m  OK  [0m] Mounted Huge Pages File System.
> >> [  172.917332][    T1] systemd[1]: Mounted Debug File System.
> >> [[0;32m  OK  [0m] Mounted Debug File System.
> >> [  173.465694][  T251] _warn_unseeded_randomness: 6 callbacks suppressed
> >> [  173.465803][  T251] random: get_random_u64 called from arch_mmap_rnd+0x94/0xb0 with crng_init=1
> >> [  173.466000][  T251] random: get_random_u64 called from randomize_stack_top+0x4c/0xb0 with crng_init=1
> >> [  173.466163][  T251] random: get_random_u32 called from arch_align_stack+0x6c/0x88 with crng_init=1
> >> [  173.544157][    T1] systemd[1]: Started Create Static Device Nodes in /dev.
> >> [[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
> >> [  174.283422][  T240] Unable to handle kernel paging request at virtual address 978061b552800000
> >> [  174.286169][  T240] Mem abort info:
> >> [  174.303268][  T240]   ESR = 0x96000004
> >> [  174.304652][  T240]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> [  174.323298][  T240]   SET = 0, FnV = 0
> >> [  174.324677][  T240]   EA = 0, S1PTW = 0
> >> [  174.325937][  T240] Data abort info:
> >> [  174.345383][  T240]   ISV = 0, ISS = 0x00000004
> >> [  174.359310][  T240]   CM = 0, WnR = 0
> >> [  174.360641][  T240] [978061b552800000] address between user and kernel address ranges
> >> [  174.378712][  T240] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >> [  174.381030][  T240] Modules linked in:
> >> [  174.382362][  T240] CPU: 0 PID: 240 Comm: systemd-journal Tainted: G    B   W         5.6.0-rc5-next-20200312-00018-g5c00c2e7cf27 #6
> >> [  174.386251][  T240] Hardware name: linux,dummy-virt (DT)
> >> [  174.388056][  T240] pstate: 40400005 (nZcv daif +PAN -UAO)
> >> [  174.389892][  T240] pc : sysfs_kf_seq_show+0x114/0x250
> >> [  174.391638][  T240] lr : sysfs_kf_seq_show+0x114/0x250
> >> [  174.393325][  T240] sp : ffff00006374faa0
> >> [  174.394697][  T240] x29: ffff00006374faa0 x28: ffff000062620040
> >> [  174.396751][  T240] x27: ffff000062b0a010 x26: 978061b552800000
> >> [  174.398779][  T240] x25: ffff000068aae020 x24: ffff000068aae010
> >> [  174.400798][  T240] x23: ffff00006311c000 x22: ffff000064f4f800
> >> [  174.402794][  T240] x21: 0000000000001000 x20: ffff000068aae008
> >> [  174.404820][  T240] x19: 0000000000001000 x18: 0000000000000000
> >> [  174.406792][  T240] x17: 0000000000000000 x16: 0000000000000000
> >> [  174.408814][  T240] x15: 0000000000000000 x14: 0000000000000000
> >> [  174.410805][  T240] x13: ffff80000c623a00 x12: 1fffe0000c623800
> >> [  174.412829][  T240] x11: 1fffe0000c6239ff x10: ffff80000c6239ff
> >> [  174.414821][  T240] x9 : 0000000000000000 x8 : ffff00006311d000
> >> [  174.416865][  T240] x7 : 0000000000000000 x6 : 000000000000003f
> >> [  174.418907][  T240] x5 : 0000000000000040 x4 : 000000000000002d
> >> [  174.420932][  T240] x3 : ffffa000109a1274 x2 : 0000000000000001
> >> [  174.422924][  T240] x1 : ffffa00016010000 x0 : 0000000000000000
> >> [  174.424954][  T240] Call trace:
> >> [  174.426097][  T240]  sysfs_kf_seq_show+0x114/0x250
> >> [  174.427769][  T240]  kernfs_seq_show+0xa4/0xb8
> >> [  174.429306][  T240]  seq_read+0x3a4/0x8e8
> >> [  174.430678][  T240]  kernfs_fop_read+0x8c/0x6e0
> >> [  174.432244][  T240]  __vfs_read+0x64/0xc0
> >> [  174.433622][  T240]  vfs_read+0x158/0x2b0
> >> [  174.435014][  T240]  ksys_read+0xfc/0x1e0
> >> [  174.436427][  T240]  __arm64_sys_read+0x50/0x60
> >> [  174.437944][  T240]  el0_svc_common.constprop.1+0x294/0x330
> >> [  174.439795][  T240]  do_el0_svc+0xe4/0x100
> >> [  174.441218][  T240]  el0_svc+0x70/0x80
> >> [  174.442550][  T240]  el0_sync_handler+0xd0/0x7b4
> >> [  174.444143][  T240]  el0_sync+0x164/0x180
> >> [  174.445578][  T240] Code: aa1703e0 97f6e03a aa1a03e0 97f6e880 (f9400355)
> >> [  174.447885][  T240] ---[ end trace 5bcb796ff4270d74 ]---
> >> [  174.449629][  T240] Kernel panic - not syncing: Fatal exception
> >> [  174.451590][  T240] Kernel Offset: disabled
> >> [  174.453005][  T240] CPU features: 0x80002,20002004
> >> [  174.454597][  T240] Memory Limit: none
> >> [  174.455955][  T240] ---[ end Kernel panic - not syncing: Fatal exception ]---
> >>
> >> When I say CONFIG_OF_UNITTEST=n it works.
> >> If I revert there it starts to work when I revert the last one,
> >> f4056e705b2e, from the list below:
> >>
> >> 485bb19d0b3e of: unittest: make gpio overlay test dependent on CONFIG_OF_GPIO
> >> 0ac174397940 of: unittest: annotate warnings triggered by unittest
> >> f4056e705b2e of: unittest: add overlay gpio test to catch gpio hog problem
> >>
> >> Cheers,
> >> Anders
> >>
> >>>> ---
> >>>>
> >>>> changes since v1:
> >>>>   - base on 5.6-rc1
> >>>>   - fixed node names in overlays
> >>>>   - removed unused fields from struct unittest_gpio_dev
> >>>>   - of_unittest_overlay_gpio() cleaned up comments
> >>>>   - of_unittest_overlay_gpio() moved saving global values into
> >>>>     probe_pass_count and chip_request_count more tightly around
> >>>>     test code expected to trigger changes in the global values
> >>>>
> >>>> v1 of this patch incorrectly reported that it had made changes
> >>>> since the RFC version, but it was mistakenly created from the
> >>>> wrong branch.
> >>>>
> >>>> There are checkpatch warnings.
> >>>>   - New files are in a directory already covered by MAINTAINERS
> >>>>   - The undocumented compatibles are restricted to use by unittest
> >>>>     and should not be documented under Documentation
> >>>>   - The printk() KERN_<LEVEL> warnings are false positives.  The level
> >>>>     is supplied by a define parameter instead of a hard coded constant
> >>>>   - The lines over 80 characters are consistent with unittest.c style
> >>>>
> >>>> This unittest was also valuable in that it allowed me to explore
> >>>> possible issues related to the proposed solution to the gpio hog
> >>>> problem.
> >>>>
> >>>>
> >>>>  drivers/of/unittest-data/Makefile             |   8 +-
> >>>>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
> >>>>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
> >>>>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
> >>>>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
> >>>>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
> >>>>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
> >>>>  drivers/of/unittest.c                         | 253 ++++++++++++++++++++++++++
> >>>>  8 files changed, 370 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
> >>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
> >>>>
> >>>
> >>> Applied, thanks.
> >>>
> >>> Rob
> >>
> >>
> >
> >
>
