Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC5C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4917B206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jIDM39AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEFCcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgEFCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:32:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64451C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:32:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s9so511757qkm.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=x2mjGNFfmmZahp45ws6PBDbVmm++7qCEp4Rk/JW+N5g=;
        b=jIDM39ADXTzJMH9ax3N2VUFuNN/fZ21oOVXwx8Gk4xKuNGYgPlJc9iaXlURTGJHyvx
         liLpVB6Tcb0hJspbXx5lF4mSO8ReM72l6C35J5dRvhfSITYhwZIos3SiAoEte5YgZR6p
         VjRF5K38Dra4xy+yjY6EOegs+BymNq1b+ReBxGopATS6KA9ccuUAqcB235gk5A1jkzeN
         MgoIxGbGn3+K2m4PvOenaZfUbfUbefX6rJPhMos7yb0/wTktbEYHuDY5zsGe5eUX7k5+
         tzLbLCglRVhwiKPRR92hsSNOLQgAk2cyLpOdwo7///+VpslJJE39nl9ch5zyTkbOwkVs
         WCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=x2mjGNFfmmZahp45ws6PBDbVmm++7qCEp4Rk/JW+N5g=;
        b=bi0BZzrH9kJyoqQFDhZF9Tg44eMd8u1JRcfcWlVlDU4GpROVsHciWmestKiT24bVd/
         MwHsYlkGtCIssPcab3n/6cp38RKqivh1lEA2H7FNitOJDswQkMVGWHcqKzWAVTscA/g8
         8ZGB7qL6R+eVAvPj3Lg1rz38lRN9+e1KvSmFEp2KkAPofxgWpZDZCUBZvxbp6OwGd5h+
         yAJALWSa1vXyq/bhmGgMiNzg6h0S7KskJuFi8EEDDdC5B6MgtTSr0SaO9vOWTqlAWIaf
         XJxdKlYngYrw8tb6uxehSDwbHCBuZ9mIRRymqghmLYO7GTTsXjjoyE1xjC085eUo37jQ
         sKWw==
X-Gm-Message-State: AGi0PubC7uc8UUl1UWpzMtCBAu07S/QZgM2dwu4WAsBpgxBzYqmZyehk
        wVB2q62yQUKUeNhTidJrSQwbDw==
X-Google-Smtp-Source: APiQypKSmSDY6UmAxcB/kzovWM8WTS+WMMm6XuxrGEvKpCMMl2JrUpe7ZBy4gsfsayP1PtDmoBKUew==
X-Received: by 2002:a05:620a:b03:: with SMTP id t3mr1720139qkg.209.1588732337335;
        Tue, 05 May 2020 19:32:17 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x7sm608633qkx.36.2020.05.05.19.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 19:32:16 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Intel KVM entry failed, hardware error 0x0
Message-Id: <014D7571-6281-457C-9CF3-693809E9F651@lca.pw>
Date:   Tue, 5 May 2020 22:32:15 -0400
Cc:     KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today=E2=80=99s linux-next started to fail with this config,

https://raw.githubusercontent.com/cailca/linux-mm/master/kcsan.config

qemu-kvm-2.12.0-99.module+el8.2.0+5827+8c39933c.x86_64

I believe it was working yesterday. Before I bury myself bisecting it, =
does anyone have any thought?

# /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host =
-smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2 -cdrom =
ubuntu-18.04-server-cloudimg.iso -nic user,hostfwd=3Dtcp::2222-:22 =
-nographic

KVM: entry failed, hardware error 0x0
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000306f2
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00010002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 =
HLT=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 =
DR3=3D0000000000000000=20
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000

[28040.962363][T78789] *** Guest State ***
[28040.981990][T78789] CR0: actual=3D0x0000000000000030, =
shadow=3D0x0000000060000010, gh_mask=3Dfffffffffffffff7
[28041.030248][T78789] CR4: actual=3D0x0000000000002040, =
shadow=3D0x0000000000000000, gh_mask=3Dffffffffffffe871
[28041.075900][T78789] CR3 =3D 0x0000000000000000
[28041.096369][T78789] RSP =3D 0x0000000000000000  RIP =3D =
0x000000000000fff0
[28041.127519][T78789] RFLAGS=3D0x00010002         DR7 =3D =
0x0000000000000400
[28041.158730][T78789] Sysenter RSP=3D0000000000000000 =
CS:RIP=3D0000:0000000000000000
[28041.193409][T78789] CS:   sel=3D0xf000, attr=3D0x0009b, =
limit=3D0x0000ffff, base=3D0x00000000ffff0000
[28041.234135][T78789] DS:   sel=3D0x0000, attr=3D0x00093, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.274796][T78789] SS:   sel=3D0x0000, attr=3D0x00093, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.315631][T78789] ES:   sel=3D0x0000, attr=3D0x00093, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.357025][T78789] FS:   sel=3D0x0000, attr=3D0x00093, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.397808][T78789] GS:   sel=3D0x0000, attr=3D0x00093, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.438806][T78789] GDTR:                           limit=3D0x0000ffff,=
 base=3D0x0000000000000000
[28041.479557][T78789] LDTR: sel=3D0x0000, attr=3D0x00082, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.522599][T78789] IDTR:                           limit=3D0x0000ffff,=
 base=3D0x0000000000000000
[28041.564289][T78789] TR:   sel=3D0x0000, attr=3D0x0008b, =
limit=3D0x0000ffff, base=3D0x0000000000000000
[28041.604705][T78789] EFER =3D     0x0000000000000000  PAT =3D =
0x0007040600070406
[28041.638146][T78789] DebugCtl =3D 0x0000000000000000  DebugExceptions =
=3D 0x0000000000000000
[28041.676235][T78789] Interruptibility =3D 00000000  ActivityState =3D =
00000000
[28041.709019][T78789] InterruptStatus =3D 0000
[28041.728432][T78789] *** Host State ***
[28041.746774][T78789] RIP =3D 0xffffffffc05ab620  RSP =3D =
0xffffb24ec6c9fb08
[28041.777531][T78789] CS=3D0010 SS=3D0018 DS=3D0000 ES=3D0000 FS=3D0000 =
GS=3D0000 TR=3D0040
[28041.811313][T78789] FSBase=3D00007f697ffff700 GSBase=3Dffff8d799f980000=
 TRBase=3Dfffffe00001e0000
[28041.851017][T78789] GDTBase=3Dfffffe00001de000 =
IDTBase=3Dfffffe0000000000
[28041.881294][T78789] CR0=3D0000000080050033 CR3=3D00000008802c8003 =
CR4=3D00000000001626e0
[28041.917895][T78789] Sysenter RSP=3D0000000000000000 =
CS:RIP=3D0000:0000000000000000
[28041.953737][T78789] EFER =3D 0x0000000000000d01  PAT =3D =
0x0007040600070406
[28041.986043][T78789] *** Control State ***
[28042.006510][T78789] PinBased=3D000000ff CPUBased=3Db5a06dfa =
SecondaryExec=3D000037eb
[28042.043823][T78789] EntryControls=3D0000d1ff ExitControls=3D002befff
[28042.074416][T78789] ExceptionBitmap=3D00060042 PFECmask=3D00000000 =
PFECmatch=3D00000000
[28042.110314][T78789] VMEntry: intr_info=3D00000000 errcode=3D00000000 =
ilen=3D00000000
[28042.144970][T78789] VMExit: intr_info=3D00000000 errcode=3D00000000 =
ilen=3D00000003
[28042.178829][T78789]         reason=3D00000030 =
qualification=3D0000000000000184
[28042.211619][T78789] IDTVectoring: info=3D00000000 errcode=3D00000000
[28042.240511][T78789] TSC Offset =3D 0xffffbe0284927b21
[28042.264284][T78789] SVI|RVI =3D 00|00 TPR Threshold =3D 0x00
[28042.289414][T78789] APIC-access addr =3D 0x0000000e5dfc0000 virt-APIC =
addr =3D 0x0000000d2e76c000
[28042.330409][T78789] PostedIntrVec =3D 0xf2
[28042.349513][T78789] EPT pointer =3D 0x000000105a27005e
[28042.372955][T78789] PLE Gap=3D00000080 Window=3D00001000
[28042.396744][T78789] Virtual processor ID =3D 0x0001

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  1
Core(s) per socket:  12
Socket(s):           4
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               63
Model name:          Intel(R) Xeon(R) CPU E5-4650 v3 @ 2.10GHz
Stepping:            2
CPU MHz:             1400.623
BogoMIPS:            4195.13
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            30720K
NUMA node0 CPU(s):   0-5,24-29
NUMA node1 CPU(s):   6-11,30-35
NUMA node2 CPU(s):   12-17,36-41
NUMA node3 CPU(s):   18-23,42-47
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good =
nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor =
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 =
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand =
lahf_lm abm cpuid_fault epb invpcid_single pti intel_ppin ssbd ibrs ibpb =
stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust =
bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc cqm_occup_llc =
dtherm arat pln pts flush_l1d=
