Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E085F2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nosamNqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgETGsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgETGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:48:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E9C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:48:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x13so1083355pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n1H7Tg2fQowOdnYnpiSDR4cBo8OXspCb45EM5CNo114=;
        b=nosamNqgvZ5i9YmM1K5t9D6CYJREYtDBGOFtJoC65I/5FWfbhGIyvqn2875FpkcAb1
         gBchnkXDaIC2XsY0dJ3G385VUh0NxjUlHVTfV8ETseo9SdPicrKvBUaoPxdVHAh3nsZH
         xn0ZyZ4mGVOiRafnAmYDvbZ+UuFREbHTwmy4K1D5WYtkwZCuVPJQrrJljKgKh55lnbZY
         dtkh+fe+ISVbw9gNI7fm/4fC9z8cIO/81MbI+7KmnxqAODiFbtnSCiB5zD95wPnZ3Z7k
         x0YOpYGjL2tZ+brHUWjBe3+byW/4l99dyxTa16eWE1rdwthsJ6XOY/ebqNW5Nmel3dp0
         hdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n1H7Tg2fQowOdnYnpiSDR4cBo8OXspCb45EM5CNo114=;
        b=O9V7Klu2TrnlUj11Rpoiph00NRTPYfV6vphs6fTpS2BdvSCUTQURiwk+CMpiPWzFI9
         eyHSOH7l0JWdWYZh0zgLbXIJZxO4F7tKiEAe3ZAbx1hx06+mwAoSOcYjgg3WEsDRAOi4
         mVQUnCTl/Gc76JLLjj2RbXZ25QZvxLeG4pqTzj2ef3UlJF7YkFmAkEAv4I/PvEYXaKZD
         vGvITQj1R+ICG402x+bNvZ+KHn0t0yL3/GMnYdtIhfNQ1QU2o71acdRtQ0+pJ4rqGisj
         7bCaA1Q2DipejAL3+XFbvWxADs1OnHQeE5dJ20NRexU8xLuo3JaTyCN4pBaFbIMBrpTb
         9I7A==
X-Gm-Message-State: AOAM531nim6CJVAx0Mnc58BQUSLI/vheGUfFgYYXpQCRzLBMwJUe+AaM
        tTYw3E6GeFMwaJWCkhZQWV2CPipIV+i8D0G5e4ZSTlP8fxvN1A==
X-Google-Smtp-Source: ABdhPJzVv5tCUpVfmRPhtYnqwKu+n4ll+MqCz1EDp9kx7Hk/VrQNAKI2ck+hoCW0VREJWKfGCZiw5sYcoE6NeQ7hesQ=
X-Received: by 2002:a63:5506:: with SMTP id j6mr2777011pgb.121.1589957301215;
 Tue, 19 May 2020 23:48:21 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Wed, 20 May 2020 14:47:54 +0800
Message-ID: <CAEK8JBDgHwX+kMA+Uo0=Ma4OPz65-cb-P5wCu1cPxo7cFRD-GQ@mail.gmail.com>
Subject: [ISSUE] acpi_cpufreq is added and removed frequently
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi expert,

I could see my CentOS7,  `udevadm monitor` reports this log very fast:

UDEV  [14258.464055] change
/devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4d (acpi)
KERNEL[14258.464065] add      /module/acpi_cpufreq (module)
KERNEL[14258.471130] remove   /module/acpi_cpufreq (module)
UDEV  [14258.473672] change
/devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4a (acpi)
KERNEL[14258.473684] add      /module/acpi_cpufreq (module)
KERNEL[14258.482001] remove   /module/acpi_cpufreq (module)
UDEV  [14258.485059] change
/devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4f (acpi)
KERNEL[14258.485070] add      /module/acpi_cpufreq (module)
KERNEL[14258.495195] remove   /module/acpi_cpufreq (module)


What's wrong with the system?

OS: CentOS 7.6
Kernel: 3.10.0-1062.1.2.el7 / kernel-4.18.0-147

[root@67_95 14:46:21 ~]$lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Gold 5122 CPU @ 3.60GHz
Stepping:              4
CPU MHz:               3677.124
CPU max MHz:           3700.0000
CPU min MHz:           1200.0000
BogoMIPS:              7200.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              16896K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni
pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16
xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
epb cat_l3 cdp_l3 invpcid_single intel_ppin intel_pt ssbd mba ibrs
ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust
bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f
avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl
xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total
cqm_mbm_local dtherm ida arat pln pts pku ospke spec_ctrl intel_stibp
flush_l1d

Any tips?
Thanks in advance.
