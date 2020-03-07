Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AC9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FC62070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCGLwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 06:52:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:37877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCGLwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:52:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 03:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="388090627"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.93]) ([10.254.211.93])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2020 03:52:28 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: fix RCU-list bugs in intel_iommu_init
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <1583438446-9959-1-git-send-email-cai@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d2297b6-f719-68d5-973b-df9405caa7a0@linux.intel.com>
Date:   Sat, 7 Mar 2020 19:52:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583438446-9959-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/3/6 4:00, Qian Cai wrote:
> There are several places traverse RCU-list without holding any lock in
> intel_iommu_init(). Fix them by acquiring dmar_global_lock.
> 
>   WARNING: suspicious RCU usage
>   -----------------------------
>   drivers/iommu/intel-iommu.c:5216 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by swapper/0/1.
> 
>   Call Trace:
>    dump_stack+0xa0/0xea
>    lockdep_rcu_suspicious+0x102/0x10b
>    intel_iommu_init+0x947/0xb13
>    pci_iommu_init+0x26/0x62
>    do_one_initcall+0xfe/0x500
>    kernel_init_freeable+0x45a/0x4f8
>    kernel_init+0x11/0x139
>    ret_from_fork+0x3a/0x50
>   DMAR: Intel(R) Virtualization Technology for Directed I/O
> 
> Fixes: d8190dc63886 ("iommu/vt-d: Enable DMA remapping after rmrr mapped")
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks for the fix.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6fa6de2b6ad5..bc138ceb07bc 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5193,6 +5193,7 @@ int __init intel_iommu_init(void)
>   
>   	init_iommu_pm_ops();
>   
> +	down_read(&dmar_global_lock);
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -5200,6 +5201,7 @@ int __init intel_iommu_init(void)
>   		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>   		iommu_device_register(&iommu->iommu);
>   	}
> +	up_read(&dmar_global_lock);
>   
>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>   	if (si_domain && !hw_pass_through)
> @@ -5210,7 +5212,6 @@ int __init intel_iommu_init(void)
>   	down_read(&dmar_global_lock);
>   	if (probe_acpi_namespace_devices())
>   		pr_warn("ACPI name space devices didn't probe correctly\n");
> -	up_read(&dmar_global_lock);
>   
>   	/* Finally, we enable the DMA remapping hardware. */
>   	for_each_iommu(iommu, drhd) {
> @@ -5219,6 +5220,8 @@ int __init intel_iommu_init(void)
>   
>   		iommu_disable_protect_mem_regions(iommu);
>   	}
> +	up_read(&dmar_global_lock);
> +
>   	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
>   
>   	intel_iommu_enabled = 1;
> 
