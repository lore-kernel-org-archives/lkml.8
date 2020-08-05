Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C6922CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHEUZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:48318 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHEUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:07 -0400
IronPort-SDR: v/CKGYZIam4YgNDycXSSr5lATQMmuvmQlFevLkGDADIJG2IvkmRS4yJntgQsQLIbUyi0FCcHPV
 WtBSqW4QoKDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150111857"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="150111857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:07 -0700
IronPort-SDR: kezO5/WussJGFg7dIssbmvAgKMSBF5DGkXV8yXkCCdnijdhBXgkkVd/g4Cd0AEp0/8xEnuhIle
 TgkbDC/7mJ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958427"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
Date:   Wed,  5 Aug 2020 13:24:05 -0700
Message-Id: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Drop the platform device solution
- A new uncore PCI sub driver solution is introduced which searches
  the PCIe Root Port device via pci_get_device() and id table.
  Register a PCI bus notifier for the remove notification. Once the
  device is removed, the uncore driver can be notified to unregister
  the corresponding PMU.
- Modify the parameters of uncore_pci_pmu_unregister() function.

The Snow Ridge integrated PCIe3 uncore performance monitoring unit (PMU)
can be used to collect the performance data, e.g., the utilization
between the PCIe devices and the components (in M2IOSF) which are
responsible for translating and managing the requests to/from the
device. The performance data is very useful for analyzing the
performance of the PCIe devices.

The PCIe3 uncore PMU was once supported in the Linux kernel, but it was
removed by the commit 2167f1625c2f ("perf/x86/intel/uncore: Remove
PCIe3 unit for SNR") due to the conflict between the PCIe Root Port
driver and the perf uncore driver. The counters of the PCIe3 uncore PMU
are located in the configuration space of the PCIe Root Port device,
which already has a bonded driver portdrv_pci. One device can only have
one bonded driver. The uncore driver is always failed to be loaded.

To re-enable the PCIe3 uncore PMU support in the uncore driver, a new
solution should be introduced, which has to meet the requirements as
below:
- must have a reliable way to find the PCIe Root Port device from the
  uncore driver;
- must be able to access the uncore counters of the PCIe Root Port
  device from the uncore driver;
- must support hotplug. When the PCIe Root Port device is removed, the
  uncore driver has to be notified and unregisters the PCIe3 uncore
  PMU.

In the v1 patch set, a new platform device solution is implemented to
address the issue, but it's rejected.
https://lkml.kernel.org/r/20200708183034.GA466341@bjorn-Precision-5520

A new uncore PCI sub driver solution is introduced from the V2 patch
set, which:
- searches the PCIe Root Port device via pci_get_device() and id table.
  The matched pci_dev can be used to register a PMU for accessing the
  counters in the PCIe Root Port device.
- register a PCI bus notifier. Once the device is removed, the uncore
  driver can be notified to unregister the corresponding PMU.

Kan Liang (6):
  perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
  perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
  perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
  perf/x86/intel/uncore: Generic support for the PCI sub driver
  perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge

 arch/x86/events/intel/uncore.c       | 273 +++++++++++++++++++++++++++--------
 arch/x86/events/intel/uncore.h       |   1 +
 arch/x86/events/intel/uncore_snbep.c |  53 +++++++
 3 files changed, 265 insertions(+), 62 deletions(-)

-- 
2.7.4

