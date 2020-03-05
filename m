Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6029EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D962072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q5g8rYEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCEUBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:01:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45082 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:01:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id a4so5121450qto.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EtvUYpx/Z6jkOZvIKTGZ1YcNxmsRMa5tAVsSg5EuMhY=;
        b=Q5g8rYEbooZCweqZN9vq52DV5MrDA80j55ts6X0pDZ5lQA7onJ4ZLCWhc1Ih5wtCZn
         bDB9MUgEAa4hLg2LgEvy3EN3aBTsbXRTYXG5+b6DxpzxbCoZEtqESFI6uPAxr0h7Ok5Z
         ZDi2D8FmgdAPKe4MJHMGZP2fBtt9d9ZQoeFUes3aj/+EIscyYpBwFB+sZmx5Tjun42eb
         hUPY7LkUcH0cAIiAcSvecVxXJerpkQY26TU2F3Ck4RyJg50ydFcNnAG5Xkeye628LHDQ
         eACQJjlGaMUXaL2fOMqECgtEKRq9fI4SdQbtsf7neiVrjGBah0jSzkSoVgPgYSGyXuzz
         3lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EtvUYpx/Z6jkOZvIKTGZ1YcNxmsRMa5tAVsSg5EuMhY=;
        b=g6VPfYj7OCO7jwwz6zRzXfCV7eYON4Xq6QNmnbv+aozGmm+4iNUzMKDkjagrppRCeI
         vesPQWB7EBH/cwQF07ZEJ9EhOf3uhd3K8kWH9a4kABUI21SM+PbBEvUiiLF8S0MynVdK
         EHOZtTFF5xXdd0GbfflhGUjQyoqibexORYWdNM2m5ev85QrZNt6XMx9CwyyvtavS2bTD
         DTleEB3pFtXCxqjZutTBch7AadUcm4arQEFVcgA2/FEO7bzRuWUg+L1aib89GvJzn8+2
         uPKuKGeSN9+mfTeE8EldFzhnu3lhUB2vATJnVlumC0ii8hB8H5xqAn4dT/41Z07XajzV
         ZUQA==
X-Gm-Message-State: ANhLgQ3YTqpIpu74lHpueOKtufCovQuaexbRdy6c94qmaJc1VBSaIn00
        mduLGS7ZPNc6Y+l+0eev+beqMw==
X-Google-Smtp-Source: ADFU+vs2fX0fSX8HT8ldaRkDqTnvkbe+A+L8CQ9JvxGCaw+F/gPTk0fICGkAht0UcmGT1kh4f+zKTA==
X-Received: by 2002:ac8:4cd1:: with SMTP id l17mr362984qtv.165.1583438476608;
        Thu, 05 Mar 2020 12:01:16 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w21sm17576346qth.17.2020.03.05.12.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 12:01:15 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/vt-d: fix RCU-list bugs in intel_iommu_init
Date:   Thu,  5 Mar 2020 15:00:46 -0500
Message-Id: <1583438446-9959-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places traverse RCU-list without holding any lock in
intel_iommu_init(). Fix them by acquiring dmar_global_lock.

 WARNING: suspicious RCU usage
 -----------------------------
 drivers/iommu/intel-iommu.c:5216 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 no locks held by swapper/0/1.

 Call Trace:
  dump_stack+0xa0/0xea
  lockdep_rcu_suspicious+0x102/0x10b
  intel_iommu_init+0x947/0xb13
  pci_iommu_init+0x26/0x62
  do_one_initcall+0xfe/0x500
  kernel_init_freeable+0x45a/0x4f8
  kernel_init+0x11/0x139
  ret_from_fork+0x3a/0x50
 DMAR: Intel(R) Virtualization Technology for Directed I/O

Fixes: d8190dc63886 ("iommu/vt-d: Enable DMA remapping after rmrr mapped")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fa6de2b6ad5..bc138ceb07bc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5193,6 +5193,7 @@ int __init intel_iommu_init(void)
 
 	init_iommu_pm_ops();
 
+	down_read(&dmar_global_lock);
 	for_each_active_iommu(iommu, drhd) {
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
@@ -5200,6 +5201,7 @@ int __init intel_iommu_init(void)
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 		iommu_device_register(&iommu->iommu);
 	}
+	up_read(&dmar_global_lock);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
@@ -5210,7 +5212,6 @@ int __init intel_iommu_init(void)
 	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
-	up_read(&dmar_global_lock);
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
@@ -5219,6 +5220,8 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
+	up_read(&dmar_global_lock);
+
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	intel_iommu_enabled = 1;
-- 
1.8.3.1

