Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A53C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76951206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgEEWgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:36:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:41848 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEEWgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:44 -0400
IronPort-SDR: 6TqkiRBul+J1/KqRwGzJtXxgMY2EVFssNf2/u1hJ+hOZhUGvhkRytIMnp8+hGhXtcyl5GUFAKD
 wXbRfMQAdq+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:43 -0700
IronPort-SDR: O4Oz6xFaEVnd2TgvMjNIqQIlTT1Pc1RFfmGDjk463uJFNz4gJ1t+FGCc5ukcLiWGeH2embQcpk
 vpcCNwq0hatg==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410815"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 0/7] x86/resctrl: Support wider MBM counters
Date:   Tue,  5 May 2020 15:36:11 -0700
Message-Id: <cover.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 submission available from:
https://lore.kernel.org/lkml/cover.1585763047.git.reinette.chatre@intel.com

Changes since V1:
- Add four new preparatory patches to this series to eliminate the
  unnecessary reading of monitoring properties from every CPU (reading from
  one CPU is sufficient) and remove some unnecessary existing code:
  - Rename resctrl_sched.h to resctrl.h because it will no longer be
    dedicated to work done during scheduling.(Borislav)
  - Move functions reading the monitoring properties via CPUID to
    resctrl subsystem, continue calling them from common CPU code.(Borislav)
  - Read monitoring CPU properties once, no longer from every CPU.(Borislav)
  - Remove unnecessary sanity checks on properties read from CPU.(Borislav)
- Split (1) obtaining the new enumerable MBM counter width from the
  system and (2) using it within resctrl into two patches.

Below is from V1 submission:

Memory Bandwidth Monitoring (MBM) is an Intel Resource Director
Technology (RDT) feature that tracks Total and Local bandwidth
generated which misses the L3 cache.

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits and the first-generation
MBM implementation uses 24 bit counters. Software is required to poll
at 1 second or faster to ensure that data is retrieved before a counter
rollover occurs more than once under worst conditions.

As system bandwidths scale the software requirement is maintained with
the introduction of a per-resource enumerable MBM counter width.

This series adds support for the new enumerable MBM counter width.

Details about the feature can be found in Chapter 9 of the most
recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Reinette Chatre (7):
  x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h
  x86/cpu: Move resctrl CPUID code to resctrl
  x86/resctrl: Remove unnecessary RMID checks
  x86/resctrl: Query LLC monitoring properties once during boot
  x86/resctrl: Maintain MBM counter width per resource
  x86/resctrl: Support CPUID enumeration of MBM counter width
  x86/resctrl: Support wider MBM counters

 MAINTAINERS                                   |  2 +-
 arch/x86/include/asm/processor.h              |  3 +-
 .../asm/{resctrl_sched.h => resctrl.h}        |  9 +++--
 arch/x86/kernel/cpu/amd.c                     |  3 ++
 arch/x86/kernel/cpu/common.c                  | 40 -------------------
 arch/x86/kernel/cpu/intel.c                   |  7 ++++
 arch/x86/kernel/cpu/resctrl/core.c            | 32 ++++++++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  8 ++--
 arch/x86/kernel/cpu/resctrl/internal.h        | 15 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c         | 27 +++++++++----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  4 +-
 arch/x86/kernel/process_32.c                  |  2 +-
 arch/x86/kernel/process_64.c                  |  2 +-
 14 files changed, 91 insertions(+), 65 deletions(-)
 rename arch/x86/include/asm/{resctrl_sched.h => resctrl.h} (92%)

-- 
2.21.0

