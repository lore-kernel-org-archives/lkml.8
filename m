Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A675FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DB6207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwuBeekm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgETIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:50:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF7C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:50:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j21so1112900pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3mM+2Z399Yd1EcnwuwQ/qJbzHvyzcMhgniUJnRWo7dk=;
        b=cwuBeekmwM7tgsE57IgOKAGQ3MXGgsViQDxggli5T9lsHXSYONkjaK+7QKSjBei9wv
         yGw1SyZpRrVtJ93MSllb79x+HltqXGtbxVE8SG9+XKjrVDv9uix4hPArLawS6pRf2q3S
         OrAayRnsu0wOSfzf2vznxTwb+M21JMbL4ngIgsif28a7jrLPn4iLYeLKDawIUjKTFMsw
         E2+23SMLznz2o031NUW6XWGUTzGqPP7VM1Rx0ol0wXjqh0E7Fpn8imtLUV71ScuLtEnW
         fieQv2Hl8kEMlyzBSjcwBqCaA9yCDjaiIr+G5EduBr+XkqZzoXINYDOlccOasa+lj69k
         URIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3mM+2Z399Yd1EcnwuwQ/qJbzHvyzcMhgniUJnRWo7dk=;
        b=YzfH1DMYkyDCj7pwQh6+/rb/vRvcnrRwJXAkAC7s3nleynQg+tBFyhj2all0Mgeedu
         V3fflAsM8Bub2cqhjfs5Xv7+sPW82JGlCXL1+aYeMZy30i0IAYmTXi+pzcsfPVXvaD+U
         sgD7P6I2epAlnLNGwX6J2ozA0qhm4nhZNdC6jN6+4KVZZVavQ8bmuhjhhWWBoYCGOzxc
         uUeqh2TiGw4chum7RGy7HBeBAnCw12odPdeyhn+XCKjOmL859+PlHONMtPqG628Fpr2E
         UF2FDwY9iSIP4//mvgIJ9jpgzQD4QsEgJqoi+xW/kk17XjoDz+f2cZdSy+4VPIxiKBP0
         W98w==
X-Gm-Message-State: AOAM531580n9mAJRs6RrFHgbQJmYLyDVcj9MieNNvlRHMp4P7qGZd2R+
        rrzcpAIfy9jllpN+Kj2CZ0DrCzTjfOFvb9hL0PzZbdlzeqoVVQ==
X-Google-Smtp-Source: ABdhPJyY9rOSdnACBpt3/9Kv2x6E6LQWE/howuP4P40hdMOb77PvmIyJAx58mtUjHrbQIDyu3FxkeRBguGKCArRCKOc=
X-Received: by 2002:aa7:8c44:: with SMTP id e4mr3310249pfd.108.1589964609801;
 Wed, 20 May 2020 01:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBDgHwX+kMA+Uo0=Ma4OPz65-cb-P5wCu1cPxo7cFRD-GQ@mail.gmail.com>
In-Reply-To: <CAEK8JBDgHwX+kMA+Uo0=Ma4OPz65-cb-P5wCu1cPxo7cFRD-GQ@mail.gmail.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Wed, 20 May 2020 16:49:43 +0800
Message-ID: <CAEK8JBDkXZ+ct==m8SCEvPNz=WO2vH2RJs2R1G0BkVxVNAOgrQ@mail.gmail.com>
Subject: Re: [ISSUE] acpi_cpufreq is added and removed frequently
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, the trouble maker has been found.
A background program call 'udevadm retrigger' periodically.
Closed.

Feng Li <lifeng1519@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi expert,
>
> I could see my CentOS7,  `udevadm monitor` reports this log very fast:
>
> UDEV  [14258.464055] change
> /devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4d (acpi)
> KERNEL[14258.464065] add      /module/acpi_cpufreq (module)
> KERNEL[14258.471130] remove   /module/acpi_cpufreq (module)
> UDEV  [14258.473672] change
> /devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4a (acpi)
> KERNEL[14258.473684] add      /module/acpi_cpufreq (module)
> KERNEL[14258.482001] remove   /module/acpi_cpufreq (module)
> UDEV  [14258.485059] change
> /devices/LNXSYSTM:00/device:00/ACPI0004:01/LNXCPU:4f (acpi)
> KERNEL[14258.485070] add      /module/acpi_cpufreq (module)
> KERNEL[14258.495195] remove   /module/acpi_cpufreq (module)
>
>
> What's wrong with the system?
>
> OS: CentOS 7.6
> Kernel: 3.10.0-1062.1.2.el7 / kernel-4.18.0-147
>
> [root@67_95 14:46:21 ~]$lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                16
> On-line CPU(s) list:   0-15
> Thread(s) per core:    2
> Core(s) per socket:    4
> Socket(s):             2
> NUMA node(s):          2
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 85
> Model name:            Intel(R) Xeon(R) Gold 5122 CPU @ 3.60GHz
> Stepping:              4
> CPU MHz:               3677.124
> CPU max MHz:           3700.0000
> CPU min MHz:           1200.0000
> BogoMIPS:              7200.00
> Virtualization:        VT-x
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              1024K
> L3 cache:              16896K
> NUMA node0 CPU(s):     0,2,4,6,8,10,12,14
> NUMA node1 CPU(s):     1,3,5,7,9,11,13,15
> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs
> bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni
> pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16
> xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
> epb cat_l3 cdp_l3 invpcid_single intel_ppin intel_pt ssbd mba ibrs
> ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust
> bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f
> avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl
> xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total
> cqm_mbm_local dtherm ida arat pln pts pku ospke spec_ctrl intel_stibp
> flush_l1d
>
> Any tips?
> Thanks in advance.
