Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE3C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB530206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHARvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:51:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:40851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHARvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:51:10 -0400
IronPort-SDR: j9aOGPZoXJA/GlSS3Tnlyjz8AylDIiOtNRPtqlhDL3zR7ckVAdMYuNuklg8lQ1Ju8E3UrdsTRg
 jQyy4PXcRbMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="132006354"
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="scan'208";a="132006354"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 10:51:10 -0700
IronPort-SDR: eKzzKAP34nw+zm16F3aePLIEVEsH+akO3pfC7qCweLbc/DwFNOkrWSUKvo7vKrgMyuMn3KZapy
 urhDAh66Rnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="scan'208";a="491883798"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2020 10:51:08 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1vf2-0000ZK-48; Sat, 01 Aug 2020 17:51:08 +0000
Date:   Sun, 2 Aug 2020 01:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        SW_Drivers@habana.ai
Cc:     kbuild-all@lists.01.org, Ofir Bitton <obitton@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [RFC PATCH] habanalabs: hl_fence_release() can be static
Message-ID: <20200801175057.GA49250@68026f9d7d78>
References: <20200730131347.30261-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730131347.30261-1-oded.gabbay@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 command_submission.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index d19ac641b1719..e482d8d135602 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -38,7 +38,7 @@ void hl_sob_reset_error(struct kref *ref)
 			hw_sob->q_idx, hw_sob->sob_id);
 }
 
-void hl_fence_release(struct kref *kref)
+static void hl_fence_release(struct kref *kref)
 {
 	struct hl_fence *fence =
 		container_of(kref, struct hl_fence, refcount);
@@ -98,7 +98,7 @@ void hl_fence_get(struct hl_fence *fence)
 		kref_get(&fence->refcount);
 }
 
-void hl_fence_init(struct hl_fence *fence)
+static void hl_fence_init(struct hl_fence *fence)
 {
 	kref_init(&fence->refcount);
 	fence->error = 0;
