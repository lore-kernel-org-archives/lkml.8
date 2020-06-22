Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F104206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkidEGVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFVJKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgFVJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:10:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:10:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q19so18443468lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AK8DZwwigYtW3+xkOKTtd+Xyw5qcINqKJ7XViLL3UuY=;
        b=hkidEGVSIzTHpDdXSTVB7xKMIKvjQUPjcjBGPrSs0aMRl0VlBcvA4XYAZgWEOk2jPg
         V14+ISKhamzgr6P9exiaOAB7XKdRfSoZlzd+exY3J/PYgNmSLTKl6Pl10ST/4GhJdrZ4
         JNpfyu/JgUwmdhErghDY8P270cVXW8Wzxoosi15WFbmrNsJJsN3cigmToxnTDV33QUxP
         ERotsZdUWDj+/IQDr5Wnep7+EomZiGG8wakJxySJnseCusU6LEbn/pE0kc8OEibXYaR0
         +HMOrZFZahXo2egbO+D/YuNHxU8ebdeR2YvlB9PBP0FFyuFB32GEm/tE4ttjz/JXy7mU
         rFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AK8DZwwigYtW3+xkOKTtd+Xyw5qcINqKJ7XViLL3UuY=;
        b=PElaLyfBvjK0qlQMAoC5b681K17IwbJGLp1AjMEDe4v+OJ/pyOeb+BCQObhhi94tPu
         Zay9zbjQOQ3atFVvmy/Qh4Ev2sXK1RedNExZb1CsPoT2p6mo45udMImpBIMV2gSnSh9k
         qwUC13jD92YIwlmbrwGpbevuS3JAZsQsrB/DI79CKFu3I1o5piSJi81IiMCNxqg+vP7T
         Rg2UDhFTIVpayN6leWQpI5E42X8EpNgDrNsv43LODp1Eb3k4KEWmXTz1Nv5ssUH30Uew
         +eXbh+lN4XPOty4eFrmqgtGw+992BA9Lk33cmDP1xw5L/38Mi9Hq+vh9PmSECUIT+/xv
         uwPg==
X-Gm-Message-State: AOAM533XJNXznO/1l+2sWRz3miE40WFg8J5rzwdt+QZ75nzzOIQ6xVUs
        xuBvG+4EXxNHagNWZP+V+PQDBhNq5Mh8L3svjeT/xQ==
X-Google-Smtp-Source: ABdhPJxfOQYh0QXSoG7vf3HKvNv9bNY2i8gnhLB9MMqvyJK2xUGOXbTu5EYJsBVFGYUmBJDNRXXc18YEmZrvE1BHzJs=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr7847810ljj.102.1592817020709;
 Mon, 22 Jun 2020 02:10:20 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Jun 2020 14:40:09 +0530
Message-ID: <CA+G9fYvVfSEBsZCaiMCpCKfJNdbFzrKGdXR0KeRYG+nhDiEpuA@mail.gmail.com>
Subject: selftests: kvm: Test results on x86_64
To:     kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, xudong.hao@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,
Linaro test farm selftests kvm test cases results.
  * kvm_mmio_warning_test =E2=80=94 SKIP
  * kvm_svm_vmcall_test =E2=80=94 SKIP
  * kvm_clear_dirty_log_test =E2=80=94 PASS
  * kvm_cr4_cpuid_sync_test =E2=80=94 PASS
  * kvm_debug_regs =E2=80=94 PASS
  * kvm_demand_paging_test =E2=80=94 PASS
  * kvm_dirty_log_test =E2=80=94 PASS
  * kvm_evmcs_test =E2=80=94 PASS
  * kvm_hyperv_cpuid =E2=80=94 PASS
  * kvm_ * kvm_create_max_vcpus =E2=80=94 PASS
  * kvm_platform_info_test =E2=80=94 PASS
  * kvm_set_memory_region_test =E2=80=94 PASS
  * kvm_set_sregs_test =E2=80=94 PASS
  * kvm_smm_test =E2=80=94 PASS
  * kvm_state_test =E2=80=94 PASS
  * kvm_steal_time =E2=80=94 PASS
  * kvm_sync_regs_test =E2=80=94 PASS
  * kvm_vmx_close_while_nested_test =E2=80=94 PASS
  * kvm_vmx_dirty_log_test =E2=80=94 PASS
  * kvm_vmx_preemption_timer_test =E2=80=94 PASS
  * kvm_vmx_set_nested_state_test =E2=80=94 PASS
  * kvm_vmx_tsc_adjust_test =E2=80=94 PASS
  * kvm_xss_msr_test =E2=80=94 PASS

---

Test run output,
----------------------
# selftests kvm cr4_cpuid_sync_test
kvm: cr4_cpuid_sync_test_ #
[PASS] 1 selftests kvm cr4_cpuid_sync_test
selftests: kvm_cr4_cpuid_sync_test [PASS]
# selftests kvm evmcs_test
kvm: evmcs_test_ #
[PASS] 2 selftests kvm evmcs_test
selftests: kvm_evmcs_test [PASS]
# selftests kvm hyperv_cpuid
kvm: hyperv_cpuid_ #
[PASS] 3 selftests kvm hyperv_cpuid
selftests: kvm_hyperv_cpuid [PASS]
# selftests kvm mmio_warning_test
kvm: mmio_warning_test_ #
# Unrestricted guest must be disabled, skipping test
guest: must_be #
[SKIP] 4 selftests kvm mmio_warning_test # SKIP
selftests: kvm_mmio_warning_test [SKIP]
# selftests kvm platform_info_test
kvm: platform_info_test_ #
[PASS] 5 selftests kvm platform_info_test
selftests: kvm_platform_info_test [PASS]
# selftests kvm set_sregs_test
kvm: set_sregs_test_ #
[PASS] 6 selftests kvm set_sregs_test
selftests: kvm_set_sregs_test [PASS]
# selftests kvm smm_test
kvm: smm_test_ #
[PASS] 7 selftests kvm smm_test
selftests: kvm_smm_test [PASS]
# selftests kvm state_test
kvm: state_test_ #
[PASS] 8 selftests kvm state_test
selftests: kvm_state_test [PASS]
# selftests kvm vmx_preemption_timer_test
kvm: vmx_preemption_timer_test_ #
# Stage 2 L1 PT expiry TSC (3201585458) , L1 TSC deadline (3201479648)
2: L1_PT #
# Stage 2 L2 PT expiry TSC (3201495292) , L2 TSC deadline (3201522112)
2: L2_PT #
[PASS] 9 selftests kvm vmx_preemption_timer_test
selftests: kvm_vmx_preemption_timer_test [PASS]
# selftests kvm svm_vmcall_test
kvm: svm_vmcall_test_ #
# nested SVM not enabled, skipping test
SVM: not_enabled, #
[SKIP] 10 selftests kvm svm_vmcall_test # SKIP
selftests: kvm_svm_vmcall_test [SKIP]
# selftests kvm sync_regs_test
kvm: sync_regs_test_ #
[PASS] 11 selftests kvm sync_regs_test
selftests: kvm_sync_regs_test [PASS]
# selftests kvm vmx_close_while_nested_test
kvm: vmx_close_while_nested_test_ #
[PASS] 12 selftests kvm vmx_close_while_nested_test
selftests: kvm_vmx_close_while_nested_test [PASS]
# selftests kvm vmx_dirty_log_test
kvm: vmx_dirty_log_test_ #
[PASS] 13 selftests kvm vmx_dirty_log_test
selftests: kvm_vmx_dirty_log_test [PASS]
# selftests kvm vmx_set_nested_state_test
kvm: vmx_set_nested_state_test_ #
[PASS] 14 selftests kvm vmx_set_nested_state_test
selftests: kvm_vmx_set_nested_state_test [PASS]
# selftests kvm vmx_tsc_adjust_test
kvm: vmx_tsc_adjust_test_ #
# IA32_TSC_ADJUST is -4294972445 (-1 * TSC_ADJUST_VALUE + -5149).
is: -4294972445_(-1 #
# IA32_TSC_ADJUST is -4294972445 (-1 * TSC_ADJUST_VALUE + -5149).
is: -4294972445_(-1 #
# IA32_TSC_ADJUST is -8589944064 (-2 * TSC_ADJUST_VALUE + -9472).
is: -8589944064_(-2 #
# IA32_TSC_ADJUST is -8589944064 (-2 * TSC_ADJUST_VALUE + -9472).
is: -8589944064_(-2 #
[PASS] 15 selftests kvm vmx_tsc_adjust_test
selftests: kvm_vmx_tsc_adjust_test [PASS]
# selftests kvm xss_msr_test
kvm: xss_msr_test_ #
[PASS] 16 selftests kvm xss_msr_test
selftests: kvm_xss_msr_test [PASS]
# selftests kvm debug_regs
kvm: debug_regs_ #
[PASS] 17 selftests kvm debug_regs
selftests: kvm_debug_regs [PASS]
# selftests kvm clear_dirty_log_test
kvm: clear_dirty_log_test_ #
# Test iterations 32, interval 10 (ms)
iterations: 32,_interval #
# Testing guest mode PA-bitsANY, VA-bits48,  4K pages
guest: mode_PA-bitsANY, #
# guest physical test memory offset 0x7fbfffc000
physical: test_memory #
# Dirtied 1024 pages
1024: pages_ #
# Total bits checked dirty (336379), clear (7790178), track_next (4375)
bits: checked_dirty #
[PASS] 18 selftests kvm clear_dirty_log_test
selftests: kvm_clear_dirty_log_test [PASS]
# selftests kvm demand_paging_test
kvm: demand_paging_test_ #
# Testing guest mode PA-bitsANY, VA-bits48,  4K pages
guest: mode_PA-bitsANY, #
[  380.911249] livepatch: 'test_klp_livepatch': patching complete
[  380.972587] livepatch: sysctl: setting key
\"kernel.ftrace_enabled\": Device or resource busy
kernel.ftrace_enabled =3D 0
[  380.991823] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  380.998568] livepatch: 'test_klp_livepatch': starting unpatching transit=
ion
[  381.940511] livepatch: 'test_klp_livepatch': unpatching complete
[  381.974079] % rmmod test_klp_livepatch
[  382.037538] ERROR: livepatch kselftest(s) failed
[  382.077768] kselftest: Running tests in lkdtm
# guest physical test memory offset 0x7fbffff000
physical: test_memory #
# Finished creating vCPUs and starting uffd threads
creating: vCPUs_and #
# Started all vCPUs
all: vCPUs_ #
# All vCPU threads joined
vCPU: threads_joined #
# Total guest execution time 1.507741712s
guest: execution_time #
# Overall demand paging rate 43134.113526 pgs/sec
demand: paging_rate #
[PASS] 19 selftests kvm demand_paging_test
selftests: kvm_demand_paging_test [PASS]
# selftests kvm dirty_log_test
kvm: dirty_log_test_ #
# Test iterations 32, interval 10 (ms)
iterations: 32,_interval #
# Testing guest mode PA-bitsANY, VA-bits48,  4K pages
guest: mode_PA-bitsANY, #
# guest physical test memory offset 0x7fbfffc000
physical: test_memory #
# Dirtied 1024 pages
1024: pages_ #
# Total bits checked dirty (76993), clear (8049564), track_next (4519)
bits: checked_dirty #
[PASS] 20 selftests kvm dirty_log_test
selftests: kvm_dirty_log_test [PASS]
# selftests kvm kvm_create_max_vcpus
kvm: kvm_create_max_vcpus_ #
# KVM_CAP_MAX_VCPU_ID 1023
1023: _ #
# KVM_CAP_MAX_VCPUS 288
288: _ #
# Testing creating 288 vCPUs, with IDs 0...287.
creating: 288_vCPUs, #
# Testing creating 288 vCPUs, with IDs 735...1022.
creating: 288_vCPUs, #
[PASS] 21 selftests kvm kvm_create_max_vcpus
selftests: kvm_kvm_create_max_vcpus [PASS]
# selftests kvm set_memory_region_test
kvm: set_memory_region_test_ #
# Testing KVM_RUN with zero added memory regions
KVM_RUN: with_zero #
# Allowed number of memory slots 509
number: of_memory #
# Adding slots 0..508, each memory region with 2048K size
slots: 0..508,_each #
# Testing MOVE of in-use region, 10 loops
MOVE: of_in-use #
# Testing DELETE of in-use region, 10 loops
DELETE: of_in-use #
[PASS] 22 selftests kvm set_memory_region_test
selftests: kvm_set_memory_region_test [PASS]
# selftests kvm steal_time
kvm: steal_time_ #
[PASS] 23 selftests kvm steal_time
selftests: kvm_steal_time [PASS]

--=20
Linaro LKFT
https://lkft.linaro.org
