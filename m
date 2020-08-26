Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAFDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720E62071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHZK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:28:07 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:30003 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728132AbgHZK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:28:05 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:28:01 +0800
Received: from localhost.localdomain (61.148.243.98) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:27:59 +0800
From:   FelixCuioc <FelixCui-oc@zhaoxin.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <kbuild-all@lists.01.org>, <CobeChen-oc@zhaoxin.com>,
        <RaymondPang-oc@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH v2 0/3]  Add support for ACPI device in RMRR to access reserved memory
Date:   Wed, 26 Aug 2020 06:27:49 -0400
Message-ID: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [61.148.243.98]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS allocate reserved memory ranges that may be DMA targets.
BIOS may report each such reserved memory region through the
RMRR structures,along with the devices that requires access to
the specified reserved memory region.

The purpose of this series is to achieve ACPI device in RMRR
access reserved memory.Therefore,it is necessary to increase
the analysis of acpi device in RMRR and establish a mapping
for this device.

The first patch adds interfaces for detecting ACPI device in RMRR
and in order to distinguish it from pci device,some interface
functions are modified.

The second patch adds support for probing ACPI device in RMRR.
In probe_acpi_namespace_devices(),add support for direct mapping
of ACPI device and add support for physical node of acpi device
to be NULL.

The last patch adds mutex_unlock(&adev->physical_node_lock)
before returning in probe_acpi_namespace_devices().

v1->v2:
   - Split the patch set to small series of patches
   - Move the processing of physical node of acpi device for NULL
     to probe_acpi_namespace_devices().
   - Add mutex_unlock(&adev->physical_node_lock) before returning
     in probe_acpi_namespace_devices().


FelixCuioc (3):
  iommu/vt-d:Add support for detecting ACPI device in RMRR
  iommu/vt-d:Add support for probing ACPI device in RMRR
  iommu/vt-d:Add mutex_unlock() before returning

 drivers/iommu/intel/dmar.c  | 74 ++++++++++++++++++++-----------------
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++-
 drivers/iommu/iommu.c       |  6 +++
 include/linux/dmar.h        | 12 +++++-
 include/linux/iommu.h       |  3 ++
 5 files changed, 109 insertions(+), 36 deletions(-)

-- 
2.17.1

