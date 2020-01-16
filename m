Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769282468D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VNS30gze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394334AbgAPRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:48:09 -0500
Received: from mail.efficios.com ([167.114.26.124]:53310 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394319AbgAPRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:48:04 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 12:48:03 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 71D8E244DF1;
        Thu, 16 Jan 2020 12:41:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HX7ngnA8TMm3; Thu, 16 Jan 2020 12:41:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1E023244EEF;
        Thu, 16 Jan 2020 12:41:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E023244EEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579196496;
        bh=Ru5guD9vkjoHa8ITAqIsg69uJf3lqm/wZ2degfKpy4k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VNS30gzevq3SrFJjiFF4QG5kOegfaEx+QHi+syYK/vKJK4AbzXwY8hrSS3B5h4K+K
         dc5uS1gJPj7gw4CXkSyBiD1FgwfoFBWC1W8CizZboMhlx3J6D8yVl3usGB59VFYKjq
         +ITIVB0jXVNS1Z7m3Qs5iZYColHHXZG3CjRzG+p9qqWzHubRB4dAZ3ZOkG6P6XW3vD
         Foi0QZgGPBy5rK75UPCQZu/oyZ5rlnGWo7srUwlY/SqiWt4Q073wXW0P1qcGmVaHzb
         S5LxnfP8kqUCSdGG7IcRNbSbZnEN8vNkJEFio2dV6mRLO7hrKnKfet1L71PIvyiAXN
         w0k/2e5YCVlbA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ntsglEfqopQx; Thu, 16 Jan 2020 12:41:36 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0761B2450C1;
        Thu, 16 Jan 2020 12:41:36 -0500 (EST)
Date:   Thu, 16 Jan 2020 12:41:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Li Zefan <lizefan@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
Subject: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Index: LCpgHYsKGbsNKD4rV33Ft2KJ/GZobw==
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the following regression with CONFIG_CPUSET=y. Note that
I am not using cpusets at all (only using the root cpuset I'm given
at boot), it's just configured in. I am currently working on a 5.2.5
kernel. I am simply combining use of taskset(1) (setting the affinity
mask of a process) and cpu hotplug. The result is that with
CONFIG_CPUSET=y, setting the affinity mask including an offline CPU number
don't keep that CPU in the affinity mask, and it is never put back when the
CPU comes back online. CONFIG_CPUSET=n behaves as expected, and puts back
the CPU into the affinity mask reported to user-space when it comes back
online.


* With CONFIG_CPUSET=y (unexpected behavior):

# echo 0 > /sys/devices/system/cpu/cpu1/online

% taskset 0x7 ./loop &
% taskset -p $!
pid 1341's current affinity mask: 5

# echo 1 > /sys/devices/system/cpu/cpu1/online

taskset -p $!
pid 1341's current affinity mask: 5

kill $!


* With CONFIG_CPUSET=n (expected behavior):

(Offlining CPU, then start task)

# echo 0 > /sys/devices/system/cpu/cpu1/online

% taskset 0x7 ./loop &
% taskset -p $!
pid 1358's current affinity mask: 5

# echo 1 > /sys/devices/system/cpu/cpu1/online

taskset -p $!
pid 1358's current affinity mask: 7

kill $!


Test system lscpu output:

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              32
On-line CPU(s) list: 0-31
Thread(s) per core:  2
Core(s) per socket:  8
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               60
Model name:          Intel Core Processor (Haswell, no TSX, IBRS)
Stepping:            1
CPU MHz:             2399.996
BogoMIPS:            4799.99
Hypervisor vendor:   KVM
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            4096K
NUMA node0 CPU(s):   0-7,16-23
NUMA node1 CPU(s):   8-15,24-31
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ibrs ibpb fsgsbase bmi1 avx2 smep bmi2 erms invpcid xsaveopt



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
