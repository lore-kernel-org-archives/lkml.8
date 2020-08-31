Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F291C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245F22068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHaMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:48:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:63596 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:48:05 -0400
IronPort-SDR: 0MgR2zE8zdDsloIoBw00NEev0JzIx9hogOsPseyWbjfJkZ65aBv5diAFKhMdAv1qF1EvXxy1YH
 wI/duPFov5FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156218018"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="156218018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 05:48:04 -0700
IronPort-SDR: emdustJcVUWlTr14wJNQlZ7o7e47Bv5Z6xBRRiyfA/R4iqQ4giO7pd0gQI8d/twlp7i5mWuFSS
 UDZ/FpPBlrrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="501840019"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2020 05:48:04 -0700
Received: from [10.251.9.29] (kliang2-MOBL.ccr.corp.intel.com [10.251.9.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CE84E5802BC;
        Mon, 31 Aug 2020 05:48:03 -0700 (PDT)
Subject: Re: [PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <34e64852-0fe0-a1f2-d8a2-2356b3676619@linux.intel.com>
Date:   Mon, 31 Aug 2020 08:48:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you please share the comments for this patch set?

Thanks,
Kan

On 8/5/2020 4:24 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Drop the platform device solution
> - A new uncore PCI sub driver solution is introduced which searches
>    the PCIe Root Port device via pci_get_device() and id table.
>    Register a PCI bus notifier for the remove notification. Once the
>    device is removed, the uncore driver can be notified to unregister
>    the corresponding PMU.
> - Modify the parameters of uncore_pci_pmu_unregister() function.
> 
> The Snow Ridge integrated PCIe3 uncore performance monitoring unit (PMU)
> can be used to collect the performance data, e.g., the utilization
> between the PCIe devices and the components (in M2IOSF) which are
> responsible for translating and managing the requests to/from the
> device. The performance data is very useful for analyzing the
> performance of the PCIe devices.
> 
> The PCIe3 uncore PMU was once supported in the Linux kernel, but it was
> removed by the commit 2167f1625c2f ("perf/x86/intel/uncore: Remove
> PCIe3 unit for SNR") due to the conflict between the PCIe Root Port
> driver and the perf uncore driver. The counters of the PCIe3 uncore PMU
> are located in the configuration space of the PCIe Root Port device,
> which already has a bonded driver portdrv_pci. One device can only have
> one bonded driver. The uncore driver is always failed to be loaded.
> 
> To re-enable the PCIe3 uncore PMU support in the uncore driver, a new
> solution should be introduced, which has to meet the requirements as
> below:
> - must have a reliable way to find the PCIe Root Port device from the
>    uncore driver;
> - must be able to access the uncore counters of the PCIe Root Port
>    device from the uncore driver;
> - must support hotplug. When the PCIe Root Port device is removed, the
>    uncore driver has to be notified and unregisters the PCIe3 uncore
>    PMU.
> 
> In the v1 patch set, a new platform device solution is implemented to
> address the issue, but it's rejected.
> https://lkml.kernel.org/r/20200708183034.GA466341@bjorn-Precision-5520
> 
> A new uncore PCI sub driver solution is introduced from the V2 patch
> set, which:
> - searches the PCIe Root Port device via pci_get_device() and id table.
>    The matched pci_dev can be used to register a PMU for accessing the
>    counters in the PCIe Root Port device.
> - register a PCI bus notifier. Once the device is removed, the uncore
>    driver can be notified to unregister the corresponding PMU.
> 
> Kan Liang (6):
>    perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
>    perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
>    perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
>    perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
>    perf/x86/intel/uncore: Generic support for the PCI sub driver
>    perf/x86/intel/uncore: Support PCIe3 unit on Snow Ridge
> 
>   arch/x86/events/intel/uncore.c       | 273 +++++++++++++++++++++++++++--------
>   arch/x86/events/intel/uncore.h       |   1 +
>   arch/x86/events/intel/uncore_snbep.c |  53 +++++++
>   3 files changed, 265 insertions(+), 62 deletions(-)
> 
