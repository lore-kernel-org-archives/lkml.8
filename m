Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911CD2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="C40+LDSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFPNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:07:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42227C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:07:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y13so21434198eju.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MOIFQs7TIxA6MVDysgYwn9bpBuDmejoM8+SRDOgCyI4=;
        b=C40+LDSkSutW2sHliCgDJkk3TK1UEVpohP0bps7bcZGnOvkFVfoZI3y0/dy9tC4Mqr
         uDObdtFOZi1mluqBNjOsFUHRkdDIAqvtfraG46vdXW+89ko/q/duHUBng0ZPJKKA3BV4
         5ut9PYm2nLbNMlxGJn9DkOVcvLa/bb42+HpD4cH77BdctgxB3ho0oNV3blMA9hHLEn4u
         K/SovcB8RxJiCNWU6wozM2HiDPfPQwl7QFdStbQc9sYIYT+VmGA2sjsONvX3mBF+AyIV
         cEs+9bYQRl44lH3JYldAHatBbRHTH/7yhny+PQCJNJf3CT8G39jhN74AReVrliqP01Gg
         BfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MOIFQs7TIxA6MVDysgYwn9bpBuDmejoM8+SRDOgCyI4=;
        b=VpY2lmOFPRqABpM1s6q/3S0Iz2tXNwhzKdrO+gdnmSxW7W1iAXIlktELggKnbInhi6
         avTTe36tXVf7OTXvKDwQRK+zVuttfjwY8cKGLeSaX5mKDIZKtOFYwGvg1kSO9clrbkMy
         o+YGJ/ZzxygKIFnAAAGLSHB7CZG7YDAhdXg+80fCtTg6gl6GRk0HOxsBxHkAdoqalfeQ
         UMBRKSqTu8SOQ3l4jcnnsL0gTCSWR/uMBH224wNJHYAixStvsLo1Q3yuFzBZcbcrH43Z
         ALIuyF0SYb3pKJ0kfw18aqy2Fh2CwaGrV2pS+FANOmFtQ7ob/us2CWb+3nWa5l9v8JkW
         JBNA==
X-Gm-Message-State: AOAM5318OWjxpLO15dB72RXiqRFL4FJBPj7Aamlgc4h6+Vcn5UoNxYts
        H3qqeCjVWufyVsJRFBSFh/uvYBkk4aaqj61HHPVKeXrq5kORwg==
X-Google-Smtp-Source: ABdhPJzXDGqHpkv+dzW9BSt8zDFk+9UZCiKJn0XKLLopSu3j3fieRGQKRZrBPSoUP76ve1l3pYVErMZXbLZH9SpOs6I=
X-Received: by 2002:a17:906:5c0a:: with SMTP id e10mr2733548ejq.389.1592312831241;
 Tue, 16 Jun 2020 06:07:11 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 16 Jun 2020 15:07:00 +0200
Message-ID: <CAMGffEmgLbd8mjEE4xM-U7MGCsWsdHEHCqs2erMdJ7+CUCFaCA@mail.gmail.com>
Subject: [BUG] divide error select_idle_sibling+0x36b
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have a kernel panic in production with following call trace:
[7623813.967125] divide error: 0000 [#1] SMP
[7623813.967473] Modules linked in: fuse xt_conntrack sch_htb
dm_service_time sd_mod sg ib_srp scsi_transport_srp ip6table_filter
ip6_tables xt_ETHOIP6(O) nf_conntrac
k_ipv4 nf_defrag_ipv4 dummy intel_rapl iosf_mbi cpufreq_conservative
cpufreq_powersave cpufreq_userspace vhost_net(O) tun(O)
ethoip6_pmtud(O) xt_hl ethoip6_nl(O) xt_t
cpudp vhost x86_pkg_temp_thermal coretemp nf_conntrack ib_umad
iptable_filter dcdbas tap kvm_intel kvm irqbypass crct10dif_pclmul
crc32_pclmul intel_cstate intel_rapl
_perf rdma_ucm rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs input_leds
led_class ahci libahci iTCO_wdt lpc_ich iTCO_vendor_support mfd_core
libata ipmi_si ipmi_devintf ipmi
_msghandler acpi_power_meter evdev button dm_multipath scsi_mod
ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor
[7623813.970271]  async_tx xor raid6_pq raid1 raid0 linear md_mod
mlx4_ib ib_core crc32c_intel mlx4_core mlx_compat xhci_pci i2c_i801
xhci_hcd
[7623813.970839] CPU: 10 PID: 46544 Comm: qemu-2.7 Tainted: G
 O    4.14.154-1-pserver #4.14.154-1.1~deb9
[7623813.971396] Hardware name: Dell Inc. PowerEdge M640/03MN20, BIOS
2.4.8 11/27/2019
[7623813.971949] task: ffff9ac3db9f5400 task.stack: ffffb06ba8d78000
[7623813.972288] RIP: 0010:select_idle_sibling+0x36b/0x380
[7623813.972605] RSP: 0018:ffffb06ba8d7b978 EFLAGS: 00010046
[7623813.972923] RAX: 000000000000f150 RBX: 0000000000000004 RCX:
0000000000000000
[7623813.973475] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff9ac4809553e0
[7623813.974038] RBP: ffff9ac4809553e0 R08: ffffffffffffffff R09:
0000000000000000
[7623813.974595] R10: 0000000000000008 R11: 0000000000000000 R12:
000000000000003a
[7623813.975150] R13: ffff9ac478944100 R14: ffffffffa00d66a0 R15:
0000000000000200
[7623813.975702] FS:  00007f15c78c6700(0000) GS:ffff9ac480940000(0000)
knlGS:00000000bf070000
[7623813.976255] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[7623813.976573] CR2: 0000000001110000 CR3: 0000002f45147006 CR4:
00000000007626e0
[7623813.977124] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[7623813.977676] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[7623813.978243] PKRU: 55555554

[7623813.978557] Call Trace:
[7623813.978876]  select_task_rq_fair+0x8e4/0xa70
[7623813.979193]  ? enqueue_task_fair+0x68/0x6c0
[7623813.979521]  ? check_preempt_curr+0x4e/0x90
[7623813.979837]  try_to_wake_up+0x10a/0x4e0
[7623813.980154]  swake_up_locked+0x20/0x40
[7623813.980470]  swake_up+0x1a/0x30
[7623813.980806]  kvm_vcpu_kick+0x2f/0x80 [kvm]
[7623813.981132]  __apic_accept_irq+0x26e/0x310 [kvm]
[7623813.981465]  kvm_irq_delivery_to_apic+0x21c/0x300 [kvm]
[7623813.981793]  kvm_lapic_reg_write+0x118/0x650 [kvm]
[7623813.982119]  ? segmented_read+0xe2/0x100 [kvm]
[7623813.982446]  kvm_apic_write_nodecode+0x58/0x80 [kvm]
[7623813.982767]  handle_apic_write+0x22/0x30 [kvm_intel]
[7623813.983086]  vmx_handle_exit+0xaf/0x18d0 [kvm_intel]
[7623813.983405]  ? atomic_switch_perf_msrs+0x6f/0xa0 [kvm_intel]
[7623813.983724]  ? vmx_vcpu_run+0x402/0x590 [kvm_intel]
[7623813.984050]  kvm_arch_vcpu_ioctl_run+0x9c3/0x17d0 [kvm]
[7623813.984379]  ? kvm_arch_vcpu_load+0x68/0x250 [kvm]
[7623813.984705]  ? kvm_vcpu_ioctl+0x312/0x5d0 [kvm]
[7623813.985029]  kvm_vcpu_ioctl+0x312/0x5d0 [kvm]
[7623813.985348]  do_vfs_ioctl+0xa2/0x600
[7623813.985668]  ? SyS_futex+0x7a/0x170
[7623813.985984]  SyS_ioctl+0x74/0x80
[7623813.986298]  do_syscall_64+0x60/0x110
[7623813.986617]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[7623813.986935] RIP: 0033:0x7f15d2a44017
[7623813.987251] RSP: 002b:00007f15c78c5878 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[7623813.987804] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
00007f15d2a44017
[7623813.988373] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
0000000000000015
[7623813.988927] RBP: 0000555ec113b9d0 R08: 0000555ebec2b9b0 R09:
00007ffc6a145080
[7623813.989492] R10: 0000000000000001 R11: 0000000000000246 R12:
0000000000000000
[7623813.990044] R13: 00007f15d6ff8000 R14: 0000000000000006 R15:
0000555ec113b9d0
[7623813.990595] Code: ff ff 85 c0 89 1c 24 0f 84 f9 fc ff ff eb da 48
39 c8 0f 83 71 fe ff ff e9 69 ff ff ff bb ff ff ff 7f e9 8c fe ff ff
89 c9 31 d2 <48> f7 f1 48 89 c3 e9 7d fe ff ff 66 2e 0f 1f 84 00 00 00
00 00
[7623813.991416] RIP: select_idle_sibling+0x36b/0x380 RSP: ffffb06ba8d7b978

I checked in kdump.

crash> bt -l
PID: 46544  TASK: ffff9ac3db9f5400  CPU: 10  COMMAND: "qemu-2.7"
 #0 [ffffb06ba8d7b680] machine_kexec at ffffffff9f04afd6
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/arch/x86/kernel/mach=
ine_kexec_64.c:
338
 #1 [ffffb06ba8d7b6d0] __crash_kexec at ffffffff9f0f3181
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/kexec_core.c:=
 948
 #2 [ffffb06ba8d7b790] crash_kexec at ffffffff9f0f3e48
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/./include/linux/comp=
iler.h:
209
 #3 [ffffb06ba8d7b7a8] oops_end at ffffffff9f01c210
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/arch/x86/kernel/dump=
stack.c:
279
 #4 [ffffb06ba8d7b7c8] do_trap at ffffffff9f019d1b
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/arch/x86/kernel/trap=
s.c:
213
 #5 [ffffb06ba8d7b808] do_error_trap at ffffffff9f01a1e6
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/arch/x86/kernel/trap=
s.c:
304
 #6 [ffffb06ba8d7b8c0] divide_error at ffffffff9fa00cbb
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/arch/x86/entry/entry=
_64.S:
960
    [exception RIP: select_idle_sibling+875]
    RIP: ffffffff9f09a5fb  RSP: ffffb06ba8d7b978  RFLAGS: 00010046
    RAX: 000000000000f150  RBX: 0000000000000004  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff9ac4809553e0
    RBP: ffff9ac4809553e0   R8: ffffffffffffffff   R9: 0000000000000000
    R10: 0000000000000008  R11: 0000000000000000  R12: 000000000000003a
    R13: ffff9ac478944100  R14: ffffffffa00d66a0  R15: 0000000000000200
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/fair.c:=
 5797
 #7 [ffffb06ba8d7b9c8] select_task_rq_fair at ffffffff9f09aef4
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/fair.c:=
 5998
 #8 [ffffb06ba8d7bab0] try_to_wake_up at ffffffff9f09422a
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/core.c:=
 1567
 #9 [ffffb06ba8d7bb10] swake_up_locked at ffffffff9f0ac340
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/./include/linux/list=
.h:
120
#10 [ffffb06ba8d7bb20] swake_up at ffffffff9f0ac37a
    /build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/swait.c=
: 39
#11 [ffffb06ba8d7bb38] kvm_vcpu_kick at ffffffffc0c3623f [kvm]

5787          */
5788         avg_idle =3D this_rq()->avg_idle / 512;
5789         avg_cost =3D this_sd->avg_scan_cost + 1;
5790
5791         if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
5792                 return -1;
5793
5794         if (sched_feat(SIS_PROP)) {
5795                 u64 span_avg =3D sd->span_weight * avg_idle;
5796                 if (span_avg > 4*avg_cost)
5797                         nr =3D div_u64(span_avg, avg_cost);
---------------> panic here
5798                 else
5799                         nr =3D 4;
5800         }
5801

<pre>
/build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/fair.c: 577=
8
0xffffffff9f09a5ed <select_idle_sibling+861>: mov    $0x7fffffff,%ebx
0xffffffff9f09a5f2 <select_idle_sibling+866>: jmpq
0xffffffff9f09a483 <select_idle_sibling+499>
/build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/./include/linux/math64.h=
: 22
0xffffffff9f09a5f7 <select_idle_sibling+871>: mov    %ecx,%ecx
/build/pb-linux-4.14-wpyADo/pb-linux-4.14-4.14.154/kernel/sched/fair.c: 579=
7
0xffffffff9f09a5f9 <select_idle_sibling+873>: xor    %edx,%edx
0xffffffff9f09a5fb <select_idle_sibling+875>: div    %rcx
0xffffffff9f09a5fe <select_idle_sibling+878>: mov    %rax,%rbx
0xffffffff9f09a601 <select_idle_sibling+881>: jmpq
0xffffffff9f09a483 <select_idle_sibling+499>
0xffffffff9f09a606 <select_idle_sibling+886>: nopw   %cs:0x0(%rax,%rax,1)
crash>

</pre>
RDX:RAX div RCX, RCX is 0, so divide error.

I checked in latest upstream, seem the code is the same, could you
suggest how can I further debug the problem.

It may worth mentioning, the pserver reported unstable clocksource
after reboot, could this be the root cause of the panic?

[ 8226.213761] INFO: NMI handler (ghes_notify_nmi) took too long to
run: 18446744073541.390 msecs
[ 8226.213764] INFO: NMI handler (perf_event_nmi_handler) took too
long to run: 168.170 msecs
[ 8226.045599] perf: interrupt took too long (1313824 > 2500),
lowering kernel.perf_event_max_sample_rate to 100
[14792.092572] clocksource: timekeeping watchdog on CPU10: Marking
clocksource 'tsc' as unstable because the skew is too large:
[14792.092580] clocksource:                       'hpet' wd_now:
a4959d7d wd_last: a3de841d mask: ffffffff
[14792.092581] clocksource:                       'tsc' cs_now:
496f3ad3d79f90 cs_last: 496f3aaa67ff7e mask: ffffffffffffffff
[14792.092584] tsc: Marking TSC unstable due to clocksource watchdog
[14792.092598] TSC found unstable after boot, most likely due to
broken BIOS. Use 'tsc=3Dunstable'.
[14791.924432] sched_clock: Marking unstable (14792681905573,
-589293039)<-(14792645239415, -552646967)
[14792.093494] clocksource: Switched to clocksource hpet


Regards!

--=20
Jinpu Wang
Linux Kernel Developer

Application Support (IONOS Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone:
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Dr. Christian B=C3=B6ing, H=C3=BCseyin Dogan, Dr. Martin Endre=C3=
=9F,
Hans-Henning Kettler, Arthur Mai, Matthias Steinberg, Achim Wei=C3=9F
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

Diese E-Mail kann vertrauliche und/oder gesetzlich gesch=C3=BCtzte
Informationen enthalten. Wenn Sie nicht der bestimmungsgem=C3=A4=C3=9Fe Adr=
essat
sind oder diese E-Mail irrt=C3=BCmlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgem=C3=A4=C3=9Fen Adressaten ist untersagt, diese E-Mail zu
speichern, weiterzuleiten oder ihren Inhalt auf welche Weise auch
immer zu verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
