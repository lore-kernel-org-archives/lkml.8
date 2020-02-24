Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF8C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBXXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:21:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:48177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXXVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:21:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 15:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="255749662"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 15:21:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Replace Intel SVM with IOMMU SVA APIs
Date:   Mon, 24 Feb 2020 15:26:34 -0800
Message-Id: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared virtual address (SVA) capable accelerator device drivers on Intel
platform are required to call VT-d driver directly to bind a device with
a given address space. It is conceptually incorrect with the following
reasons:
- A device driver is bypassing IOMMU generic layer
- Device driver cannot be reused across architectures
- Opens a door to duplicated code

Generic SVA APIs was introduced[1] and partially merged upstream which
created a common ground for vendor IOMMU driver to consolidate SVA code.

On the other hand, Uacce (Unified/User-space-access-intended Accelerator
Framework) [2] is emerging to be a generic user-kernel interface for SVA
capable devices.

IOMMU generic SVA APIs are used by Uacce. Therefore, replacing VT-d SVM
code with IOMMU SVA APIs are required by device drivers want to use
Uacce.

The features below will continue to work but are not included in this patch
in that they are handled mostly within the IOMMU subsystem.
- IO page fault
- mmu notifier

Consolidation of the above will come after generic IOMMU sva code[1].
There should not be any changes needed for accelerator device drivers
during this time.

References:
[1] http://jpbrucker.net/sva/
[2] https://lkml.org/lkml/2020/1/15/604

Jacob Pan (2):
  iommu/vt-d: Report SVA feature with generic flag
  iommu/vt-d: Replace intel SVM APIs with generic SVA APIs

 drivers/iommu/intel-iommu.c |   8 +++
 drivers/iommu/intel-svm.c   | 123 ++++++++++++++++++++++++--------------------
 include/linux/intel-iommu.h |   7 +++
 include/linux/intel-svm.h   |  85 ------------------------------
 4 files changed, 83 insertions(+), 140 deletions(-)

-- 
2.7.4

