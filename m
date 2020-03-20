Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF6DC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D749220732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCTE0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:26:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:30843 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgCTE0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:26:52 -0400
IronPort-SDR: 98h98vT6ItZolzUME2ETey+5BLHurjdjb8x7dGeePQGUFNUWl8JqHnfW5B2SQ8vx3s+97vvk3R
 nxuETh9v9bOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 21:26:51 -0700
IronPort-SDR: u1lUJXpNdjjpPlfGeZRG2MXjJh0/X80d973Mj70lS+4rReMxMX17Qfvyq2F7C+g22rlOQBwkoh
 E5OCLijL9fNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="234391238"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2020 21:26:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/3] Misc bug fixes for VT-d SVM
Date:   Thu, 19 Mar 2020 21:32:28 -0700
Message-Id: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few bug fixes while testing Intel SVM code.

Jacob Pan (3):
  iommu/vt-d: Remove redundant IOTLB flush
  iommu/vt-d: Fix mm reference leak
  iommu/vt-d: Add build dependency on IOASID

 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/intel-svm.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4

