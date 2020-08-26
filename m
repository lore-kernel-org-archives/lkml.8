Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B520707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgHZND5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:03:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgHZNDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CFE101E;
        Wed, 26 Aug 2020 06:03:53 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 838463F68F;
        Wed, 26 Aug 2020 06:03:52 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: cppc: add FFH support using AMUs
Date:   Wed, 26 Aug 2020 14:03:05 +0100
Message-Id: <20200826130309.28027-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

This series adds support for CPPC's delivered and reference performance
counters through the FFH methods by using the AMU equivalent core and
constant cycle counters.

This support is added in patch 4/4, while the first 3 patches generalise
the existing AMU counter read and validation functionality to be reused
for this usecase.

The specification that drove this implementation can be found at [1],
chapter 3.2.

The code was tested on a Armv8-A Base Platform FVP: Architecture Envelope
Model [2] with the following _CPC entry for all CPUs:

Name(_CPC, Package()
{
  23, // NumEntries
  3, // Revision
  100, // Highest Performance - Fixed 100MHz
  100, // Nominal Performance - Fixed 100MHz
  1, // Lowest Nonlinear Performance
  1, // Lowest Performance
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Guaranteed Performance Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Desired Perf Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Minimum Performance Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Maximum Performance Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Performance Red. Tolerance Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Time Window Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Counter Wraparound Time
  ResourceTemplate(){Register(FFixedHW, 0x40, 0, 1, 0x4)}, // Reference Performance Counter Register
  ResourceTemplate(){Register(FFixedHW, 0x40, 0, 0, 0x4)}, // Delivered Performance Counter Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Performance Ltd Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // CPPC Enable Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Autonomous Selection Enable
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Autonomous Activity Window Register
  ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)}, // Energy Performance Preference Register
  100, // Reference Performance - Fixed 100MHz
  1, // Lowest Frequency
  100, // Nominal Frequency - Fixed 100MHz
})

The following configuration is necessary for Activity Monitors use:

   cluster0.has_arm_v8-4=1
   cluster1.has_arm_v8-4=1
   cluster0.has_amu=1
   cluster1.has_amu=1

To be noted:
 - The FVP has fixed core and constant frequency of 100MHz
 - The kernel I used for testing had some extra debug information as you
   can see below:

$ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_cur_freq
[   23.850590] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (2402*100)/2402=100.
100000
[   23.851246] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (2402*100)/2402=100.
100000
[   23.851826] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (2873*100)/2872=100.
100000
[   23.852326] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (2402*100)/2402=100.
100000
[   23.852747] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (2309*100)/2309=100.
100000
[   23.853228] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (1333*100)/1333=100.
100000
[   23.854097] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (18762*100)/20003=93.
93000
[   23.854890] CPPC: Delivered perf (core_cnt*ref_perf/const_cnt): (20047*100)/20051=99.
99000

[1] https://documentation-service.arm.com/static/5f106ad60daa596235e80081
[2] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms

Thanks,
Ionela.

Ionela Voinescu (4):
  arm64: cpufeature: restructure AMU feedback function
  arm64: wrap and generalise counter read functions
  arm64: split counter validation function
  arm64: implement CPPC FFH support using AMUs

 arch/arm64/include/asm/cpufeature.h |   6 +-
 arch/arm64/kernel/cpufeature.c      |  15 ++-
 arch/arm64/kernel/topology.c        | 147 ++++++++++++++++++++++------
 3 files changed, 129 insertions(+), 39 deletions(-)


base-commit: 3a00d3dfd4b68b208ecd5405e676d06c8ad6bb63
-- 
2.17.1

