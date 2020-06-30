Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF577C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E3E20772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgF3VB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:01:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:26203 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgF3VBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:01:07 -0400
IronPort-SDR: hcrVbj4dn4yiegO9XhpvrocQpZpEkmal6ZOsP/jxOKzcbg/68SvDWEOdHPm8/cc2fuAk0V1xfo
 UqLSXsuT+qtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147935004"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="147935004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:01:05 -0700
IronPort-SDR: yETbtdM0jc0glKQU6iGOOpflx13N+0/kfuQWSpAlJHwZkS4t3OAQuR8VyXVC/vwz8VTCWrXwPv
 V3jQHPlWgG0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="425337223"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 14:01:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/7] iommu/vt-d: Misc tweaks and fixes for vSVA
Date:   Tue, 30 Jun 2020 14:07:31 -0700
Message-Id: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu and all,

This is a series to address some of the issues we found in vSVA support.
Most of the patches deal with exception handling, we also removed some bits
that are not currently supported.

Many thanks to Kevin Tian's review.

Jacob & Yi


Changelog:

v2 Address reviews from Baolu
	- Fixed addr field in devTLB flush (5/7)
	- Assign address for single page devTLB invalidation (4/7)
	- Coding style tweaks

Jacob Pan (4):
  iommu/vt-d: Remove global page support in devTLB flush
  iommu/vt-d: Fix PASID devTLB invalidation
  iommu/vt-d: Warn on out-of-range invalidation address
  iommu/vt-d: Disable multiple GPASID-dev bind

Liu Yi L (3):
  iommu/vt-d: Enforce PASID devTLB field mask
  iommu/vt-d: Handle non-page aligned address
  iommu/vt-d: Fix devTLB flush for vSVA

 drivers/iommu/intel/dmar.c  | 24 +++++++++++++++++++-----
 drivers/iommu/intel/iommu.c | 37 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 drivers/iommu/intel/svm.c   | 22 +++++++++-------------
 include/linux/intel-iommu.h |  5 ++---
 5 files changed, 62 insertions(+), 37 deletions(-)

-- 
2.7.4

