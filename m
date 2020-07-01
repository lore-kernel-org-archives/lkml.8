Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A055C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13102074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1HfufrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgGAHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgGAHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:55:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78484C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:55:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so25784316ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PSqGyTJQJaUn0zbjG40ghzTcPCpjshT5c0elXwDGNjQ=;
        b=q1HfufrZCERs36ByVqzQZ1KgT1SmFbl1Bz30XrXZxs1l+fnkTnUY9NJ5ZdiAlkmlXl
         wEKT/wGr70RQWGafaKvD2GxqVfHRc3iCdaMOY5ryKCe1PAVOJzZRZVwpvfwgC1TUwx/8
         bjC3XYeWQRAftu7WNoV7rnxfUMpm8NpBH3MpmRBK4TVBjJFY5v5y4QPLdKDZwL0PHmTq
         RnwIS8PpAvu8Fo80St/qj+94u3LCWj4YyuILnd4gc2N0ypYeCPR7GY1BC7ldjlgmHuwE
         3PGm4OCNGfWZ70Ir3IIer8o89b6EukduA/DrNQwSyhxa5JToOvcXgG4zFNlW7YCD6YCM
         WLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PSqGyTJQJaUn0zbjG40ghzTcPCpjshT5c0elXwDGNjQ=;
        b=O+a3ZcUfSE3wvqqurvaFAB9a/RPuKXbhnC0bgFN2wc+DGx4DbSk8gPGiNC27xlYvck
         I8dLqvzztACdCB+/7gyWiidY2viyAA9vrU1WDmbdV71LSkQVf8n0Dc+XTP4zVRq5wZxh
         c1KFbY1oZk8vezHHaYQTN2D9Un4FZNbU194bS8o9Odg7DYydIAMlghCyIdDPfQ2JAQcv
         /mN0bNZIfbRwuIpYMlwLhIgSfvcxoy02s5WV951eHebfH2SQxsBKkxAd0/DaO0whCOPl
         dcFcFychza2S65BB1+2UCqb1/E27ElUDhbWEAOzC79clT9n6DX/yIkgRf02c10cvylQn
         NSUQ==
X-Gm-Message-State: AOAM531e4BF7nNsBLyImvmKy5a8vZsVE+uyjj8TrTQoRG8y/fAjvXZ5o
        qqP1ySLtRa6YAbSc/zF3ImiT0kBtyu23vB4G+vUttA==
X-Google-Smtp-Source: ABdhPJxqTuNpnxVRKVdFQ7l3KPMPtOAhLtUuFhrhD65O8azqovT/lonut3dQMYbk2Ap0yhVOJeXCAqqJc/5yh1hXn+s=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr12244080ljj.102.1593590105703;
 Wed, 01 Jul 2020 00:55:05 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Jul 2020 13:24:54 +0530
Message-ID: <CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com>
Subject: PANIC: mm: memcg/slab: percpu_ref_put_many - Unable to handle kernel
 paging request at virtual address ffff80096d78f000
To:     Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP mm test suite on arm64 Juno device the kernel panic
noticed on linux-next 20200630 tag.

Steps to reproduce:
- boot linux-next 20200630 kernel on arm64 device
- cd /opt/ltp
- ./runltp -f mm

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: f2b92b14533e646e434523abdbafddb727c23898
  git describe: next-20200630
  kernel-config:
https://builds.tuxbuild.com/_9rI4zfsOoS0so5wmsOaBQ/kernel.config

test crash log,
thp01.c:123: INFO: Using 8192 args of size 4096
thp01.c:81: INFO: left: 0, right: 4096, mid: 4096
thp01.c:81: INFO: left: 0, right: 2048, mid: 2048
thp01.c:81: INFO: left: 1024, right: 2048, mid: 1024
[  321.974581] Unable to handle kernel paging request at virtual
address ffff80096d78f000
[  321.982517] Mem abort info:
[  321.985309]   ESR = 0x96000005
[  321.988378]   EC = 0x25: DABT (current EL), IL = 32 bits
[  321.993704]   SET = 0, FnV = 0
[  321.996766]   EA = 0, S1PTW = 0
[  321.999920] Data abort info:
[  322.002808]   ISV = 0, ISS = 0x00000005
[  322.006653]   CM = 0, WnR = 0
[  322.009621] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081869000
[  322.016338] [ffff80096d78f000] pgd=00000009fffff003,
p4d=00000009fffff003, pud=0000000000000000
[  322.025063] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  322.030639] Modules linked in: rfkill tda998x cec drm_kms_helper
drm crct10dif_ce fuse
[  322.038579] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G    B
  5.8.0-rc3-next-20200630 #1
[  322.047375] Hardware name: ARM Juno development board (r2) (DT)
[  322.053301] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
[  322.058886] pc : percpu_ref_put_many+0x44/0xc8
[  322.063333] lr : percpu_ref_put_many+0x1c/0xc8
[  322.067777] sp : ffff800011f23d50
[  322.071091] x29: ffff800011f23d50 x28: 0000000000000000
[  322.076408] x27: ffff800011c53e40 x26: 0000000000000000
[  322.081725] x25: ffff800011f23ea0 x24: ffff800011c53fc0
[  322.087041] x23: 000000000000000a x22: ffff000975cf1c00
[  322.092358] x21: ffff000975cf1c00 x20: ffff000954e00b11
[  322.097674] x19: 0000000000000001 x18: 0000000000000000
[  322.102990] x17: 0000000000000000 x16: 0000000000000000
[  322.108307] x15: 0000007bcba8e34a x14: 0000000000000000
[  322.113623] x13: 0000000000000002 x12: 0000000000000000
[  322.118938] x11: 0000000000000000 x10: 0000000000000309
[  322.124254] x9 : 0000000000000010 x8 : ffff00097ef73230
[  322.129570] x7 : ffff80096d78f000 x6 : fffffe00252ff4c0
[  322.134886] x5 : ffff00097ef73220 x4 : fffffe00252ff4c8
[  322.140203] x3 : ffff80096d78f000 x2 : ffff000975cf1c00
[  322.145519] x1 : ffffffffffffffff x0 : ffff80096d78f000
[  322.150835] Call trace:
[  322.153281]  percpu_ref_put_many+0x44/0xc8
[  322.157381]  uncharge_page+0xb4/0xf0
[  322.160958]  mem_cgroup_uncharge+0x40/0x70
[  322.165056]  __put_page+0x4c/0x68
[  322.168374]  free_page_and_swap_cache+0xf0/0x108
[  322.172995]  tlb_remove_table_rcu+0x30/0x58
[  322.177181]  rcu_core+0x2e4/0x4f0
[  322.180496]  rcu_core_si+0x10/0x20
[  322.183899]  efi_header_end+0x120/0x240
[  322.187737]  irq_exit+0xc0/0xe0
[  322.190879]  __handle_domain_irq+0x68/0xc0
[  322.194978]  gic_handle_irq+0x54/0xa8
[  322.198640]  el1_irq+0xb8/0x180
[  322.201783]  cpuidle_enter_state+0x8c/0x2f8
[  322.205969]  cpuidle_enter+0x38/0x50
[  322.209546]  call_cpuidle+0x1c/0x40
[  322.213035]  do_idle+0x1f4/0x288
[  322.216263]  cpu_startup_entry+0x28/0x48
[  322.220189]  secondary_start_kernel+0x14c/0x188
[  322.224726] Code: b9001041 d538d083 cb1303e1 8b030000 (c85f7c05)
[  322.230833] ---[ end trace 72b11acd97d36f34 ]---
[  322.235453] Kernel panic - not syncing: Fatal exception in interrupt
[  322.241815] SMP: stopping secondary CPUs
[  322.245896] Kernel Offset: disabled
[  322.249384] CPU features: 0x240022,24006004
[  322.253567] Memory Limit: none
[  322.256627] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1535950#L10517

-- 
Linaro LKFT
https://lkft.linaro.org
