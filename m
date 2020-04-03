Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF3214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404289AbgDCSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:36:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:4672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:36:27 -0400
IronPort-SDR: xcQjVXWohWLBEVxt883Fi5405qyujURHVWiZNgFCBp0zUbpIpS5SrvqLkL9wBsy10LWahFwO0H
 zIurmKGG4FmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 11:36:27 -0700
IronPort-SDR: miaWFJZnZ7svohocQv3RMDcQmjUNraHfVhuJGa7NDJLGtcHr2RCCYiPU/yhuVRMOXY5PJmqdux
 i2iT3pxaaLLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="268439804"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2020 11:36:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v11 00/10] Nested Shared Virtual Address (SVA) VT-d support
Date:   Fri,  3 Apr 2020 11:42:04 -0700
Message-Id: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to enable SVA virtualization, i.e. enable use of SVA
within a guest user application.

This is the remaining portion of the original patchset that is based on
Joerg's x86/vt-d branch. The preparatory and cleanup patches are merged here.
(git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git)

Only IOMMU portion of the changes are included in this series. Additional
support is needed in VFIO and QEMU (will be submitted separately) to complete
this functionality.

To make incremental changes and reduce the size of each patchset. This series
does not inlcude support for page request services.

In VT-d implementation, PASID table is per device and maintained in the host.
Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables

This is the remaining VT-d only portion of V5 since the uAPIs and IOASID common
code have been applied to Joerg's IOMMU core branch.
(https://lkml.org/lkml/2019/10/2/833)

The complete set with VFIO patches are here:
https://github.com/jacobpan/linux.git:siov_sva

The complete nested SVA upstream patches are divided into three phases:
    1. Common APIs and PCI device direct assignment
    2. Page Request Services (PRS) support
    3. Mediated device assignment

With this set and the accompanied VFIO code, we will achieve phase #1.

Thanks,

Jacob

ChangeLog:
	- v11 Misc fixes and improvements based on review by Kevin & Eric
	  - Fixed devTLB granularity conversion
	  - Simplified VT-d granulairy lookup by replacing 2D map array
	    with invalid entries.
	  - Fixed locking in bind guest PASID
	  - Added nesting domain attr check
	  - Squashed agaw checking patch with user
	  - Use rate limitted error message for all user originated calls
 
	- v10
	  - Addressed Eric's review in v7 and v9. Most fixes are in 3/10 and
	    6/10. Extra condition checks and consolidation of duplicated codes.

	- v9
	  - Addressed Baolu's comments for v8 for IOTLB flush consolidation,
	    bug fixes
	  - Removed IOASID notifier code which will be submitted separately
	    to address PASID life cycle management with multiple users.

	- v8
	  - Extracted cleanup patches from V7 and accepted into maintainer's
	    tree (https://lkml.org/lkml/2019/12/2/514).
	  - Added IOASID notifier and VT-d handler for termination of PASID
	    IOMMU context upon free. This will ensure success of VFIO IOASID
	    free API regardless PASID is in use.
	    (https://lore.kernel.org/linux-iommu/1571919983-3231-1-git-send-email-yi.l.liu@intel.com/)

	- V7
	  - Respect vIOMMU PASID range in virtual command PASID/IOASID allocator
	  - Caching virtual command capabilities to avoid runtime checks that
	    could cause vmexits.

	- V6
	  - Rebased on top of Joerg's core branch
	  (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core)
	  - Adapt to new uAPIs and IOASID allocators

	- V5
	  Rebased on v5.3-rc4 which has some of the IOMMU fault APIs merged.
 	  Addressed v4 review comments from Eric Auger, Baolu Lu, and
	    Jonathan Cameron. Specific changes are as follows:
	  - Refined custom IOASID allocator to support multiple vIOMMU, hotplug
	    cases.
	  - Extracted vendor data from IOMMU guest PASID bind data, for VT-d
	    will support all necessary guest PASID entry fields for PASID
	    bind.
	  - Support non-identity host-guest PASID mapping
	  - Exception handling in various cases

	- V4
	  - Redesigned IOASID allocator such that it can support custom
	  allocators with shared helper functions. Use separate XArray
	  to store IOASIDs per allocator. Took advice from Eric Auger to
	  have default allocator use the generic allocator structure.
	  Combined into one patch in that the default allocator is just
	  "another" allocator now. Can be built as a module in case of
	  driver use without IOMMU.
	  - Extended bind guest PASID data to support SMMU and non-identity
	  guest to host PASID mapping https://lkml.org/lkml/2019/5/21/802
	  - Rebased on Jean's sva/api common tree, new patches starts with
	   [PATCH v4 10/22]

	- V3
	  - Addressed thorough review comments from Eric Auger (Thank you!)
	  - Moved IOASID allocator from driver core to IOMMU code per
	    suggestion by Christoph Hellwig
	    (https://lkml.org/lkml/2019/4/26/462)
	  - Rebased on top of Jean's SVA API branch and Eric's v7[1]
	    (git://linux-arm.org/linux-jpb.git sva/api)
	  - All IOMMU APIs are unmodified (except the new bind guest PASID
	    call in patch 9/16)

	- V2
	  - Rebased on Joerg's IOMMU x86/vt-d branch v5.1-rc4
	  - Integrated with Eric Auger's new v7 series for common APIs
	  (https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7)
	  - Addressed review comments from Andy Shevchenko and Alex Williamson on
	    IOASID custom allocator.
	  - Support multiple custom IOASID allocators (vIOMMUs) and dynamic
	    registration.


Jacob Pan (9):
  iommu/vt-d: Move domain helper to header
  iommu/uapi: Define a mask for bind data
  iommu/vt-d: Use a helper function to skip agaw for SL
  iommu/vt-d: Add nested translation helper function
  iommu/vt-d: Add bind guest PASID support
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function
  iommu/vt-d: Cache virtual command capability register
  iommu/vt-d: Add custom allocator for IOASID

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

 drivers/iommu/dmar.c        |  37 +++++
 drivers/iommu/intel-iommu.c | 277 ++++++++++++++++++++++++++++++++----
 drivers/iommu/intel-pasid.c | 340 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.h |  25 +++-
 drivers/iommu/intel-svm.c   | 206 +++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  70 ++++++++-
 include/linux/intel-svm.h   |  17 +++
 include/uapi/linux/iommu.h  |   5 +-
 8 files changed, 925 insertions(+), 52 deletions(-)

-- 
2.7.4

