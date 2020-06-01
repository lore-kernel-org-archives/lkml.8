Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AA02076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgFAAqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:46:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:52794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFAAqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:46:51 -0400
IronPort-SDR: G3m0QKjonjgTIYkhr72rNz7xw9ShYHtexhU8ix5Dcam6wgDjrnwPU/ksxIoy9+vqkdyfz6oYwz
 cQIHRMNe3ZIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 17:46:51 -0700
IronPort-SDR: 0Xs46V2hEIESIwGQjp2CNHkkG0YcMN5J2ulkkFrL9nKOZzgPRRvze8Kt2LuiKHz+CgJJzQZ2WW
 Bqk11Oj8xY7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,458,1583222400"; 
   d="scan'208";a="293005923"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 17:46:49 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Two fixes for v5.8
Date:   Mon,  1 Jun 2020 08:42:55 +0800
Message-Id: <20200601004257.15591-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This encloses two fixes for v5.8.
- Make Intel SVM code 64-bit only
- Set U/S bit to make IOVA over first level compatible with 2nd level
  translations.

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Make Intel SVM code 64-bit only
  iommu/vt-d: Set U/S bit in first level page table by default

 drivers/iommu/Kconfig       | 2 +-
 drivers/iommu/intel-iommu.c | 5 ++---
 include/linux/intel-iommu.h | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

