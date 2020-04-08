Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0000C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979D52072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="S3jXt6pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgDHVAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:00:00 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:35758 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgDHU77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:59:59 -0400
Received: by mail-qv1-f47.google.com with SMTP id q73so4463677qvq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=dYstEsSqQX7IaGveGd4y7V+/6JpFwxf+9/QIg+c9QOM=;
        b=S3jXt6pLc/wXslGDPEq6psl8z356D2R2G0nWcbrgeI77RFmPglOXiN3H4kgwxZOny3
         3wFSB2J3EesPUNRP5+wjHlwkGEAnI3uu+Dxk4L1/atd2Yrp6RG3LwBIHhx2Doyegy/uB
         TpCFeRE/gUgdKi3IJWuTpKdeB/MsM7KmbbYSq4IklRQDW6in50yFb/IgDHyte4PjzrwB
         +Y8N8K0PfxhWl9IydlEE6snHpODT0vW9Q8M2pnWVk+HYK3XupoMa9h12NmBcAJU2KoCq
         aIRWTV7pWi6FnbnG3+lxLlZzzv/I4cVnVLYBy65KeOCkud76ElARd4Ab3LebFKk+KGu5
         YGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=dYstEsSqQX7IaGveGd4y7V+/6JpFwxf+9/QIg+c9QOM=;
        b=g80YKX9Uvc0p0HFArt8jwc7RP+6To80hDwGlgAEtFpRuTAwkDX2OzMUfYvTUmDeb2N
         T87QX2EK1MtK06qoddGsIitbpg30ZE2nrR19iKzXOVWWtf48cgWaOX4EOZ9dUgMxllIP
         WL9uidP3apPU4pZySNTuA1I1SzMwTWJHPsR63JAIQB/QFLDWbfqr1IB99TuEjxRwVBL2
         RXiU5AluTw4rUW0ZqBr2tqki+cpRde2qYd0MsqOYHSSo0+I6jbRCtTbYKosLfza2rZY3
         /bL1FqF5WNC/g2sZPmtEWX36Q7GKiiCDbLY3OdXOwno14hjxg9eFOLFnJPTHjMDgURc+
         mcNw==
X-Gm-Message-State: AGi0PuZOyZqsGGcz1RAskItQTSnC9voQqFPKEx/QGyDuZoSo5fcEsZUJ
        0fFXxzZjgzxSQ7mTBLnQYjHUIg==
X-Google-Smtp-Source: APiQypLC9SVGkIg4jeCqcn/cDoGKRO5MeBH2hjSY6kbDTRrnyXE+NxDN3kp7EFhkAp7pKNvSCcgv/g==
X-Received: by 2002:a0c:9e68:: with SMTP id z40mr9255056qve.242.1586379598529;
        Wed, 08 Apr 2020 13:59:58 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w30sm21219394qtw.21.2020.04.08.13.59.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 13:59:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: KCSAN + KVM = host reset
Message-Id: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
Date:   Wed, 8 Apr 2020 16:59:56 -0400
Cc:     "paul E. McKenney" <paulmck@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
To:     Elver Marco <elver@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a simple thing on this AMD host would trigger a reset right =
away.
Unselect KCSAN kconfig makes everything work fine (the host would also
reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D before =
running qemu-kvm).

/usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host -smp =
2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2 -cdrom =
ubuntu-18.04-server-cloudimg.iso -nic user,hostfwd=3Dtcp::2222-:22 =
-serial mon:stdio -nographic

With this config on today=E2=80=99s linux-next,

https://raw.githubusercontent.com/cailca/linux-mm/master/kcsan.config

Cherry-picked a few commits from -rcu (in case if it ever matters)

48b1fc1 kcsan: Add option to allow watcher interruptions
2402d0e kcsan: Add option for verbose reporting
43f7646 x86/mm/pat: Mark an intentional data race

=3D=3D=3D console output =3D=3D=3D
Kernel 5.6.0-next-20200408+ on an x86_64

hp-dl385g10-05 login:=20

<...host reset...>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
HPE ProLiant System BIOS A40 v1.20 (03/09/2018)
(C) Copyright 1982-2018 Hewlett Packard Enterprise Development LP
Early system initialization, please wait...=20


iLO 5 IPv4: 10.73.196.44
iLO 5 IPv6: FE80::D6C9:EFFF:FECE:717E

  2%: Early Processor Initialization
  4%: Processor Root Ports Initialization
  8%: SMBIOS Table Initialization
 12%: HPE SmartMemory Initialization
 17%: iLO Embedded Health Initialization
 21%: ACPI Table Initialization
 25%: System Security Initialization
 30%: BIOS Configuration Initialization
 39%: Early PCI Initialization - Start
 47%: Early PCI Initialization - Complete
 60%: Switching console output to Primary Video. Please wait=E2=80=A6
=3D=3D=3D=3D=3D=3D=3D=3D

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              32
On-line CPU(s) list: 0-31
Thread(s) per core:  2
Core(s) per socket:  8
Socket(s):           2
NUMA node(s):        8
Vendor ID:           AuthenticAMD
CPU family:          23
Model:               1
Model name:          AMD EPYC 7251 8-Core Processor
Stepping:            2
CPU MHz:             2830.383
CPU max MHz:         2100.0000
CPU min MHz:         1200.0000
BogoMIPS:            4191.58
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           64K
L2 cache:            512K
L3 cache:            4096K
NUMA node0 CPU(s):   0,1,16,17
NUMA node1 CPU(s):   2,3,18,19
NUMA node2 CPU(s):   4,5,20,21
NUMA node3 CPU(s):   6,7,22,23
NUMA node4 CPU(s):   8,9,24,25
NUMA node5 CPU(s):   10,11,26,27
NUMA node6 CPU(s):   12,13,28,29
NUMA node7 CPU(s):   14,15,30,31
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext =
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid =
extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 =
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy =
svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit =
wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb =
hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap =
clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf =
xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean =
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload =
vgif overflow_recov succor smca

# cat /sys/kernel/debug/kcsan=20
enabled: 1
used_watchpoints: 0
setup_watchpoints: 13777602
data_races: 47
assert_failures: 0
no_capacity: 598865
report_races: 0
races_unknown_origin: 226
unencodable_accesses: 0
encoding_false_positives: 0=
