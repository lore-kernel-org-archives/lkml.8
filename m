Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C0AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B3B20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgDPCP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:15:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:24224 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgDPCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:15:25 -0400
IronPort-SDR: 5kUEnbAvK/Mx1yZRyTG6Q2TETDkYNkp+4Jc6PS4ZVc6s/PfyQahzaHIJgcs1WYvgJlcP7QVnne
 w3DGibsAAfXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 19:15:24 -0700
IronPort-SDR: NKlEa2tHbkW20Gfo3x7x+9Z+3A45Evl4V9/jfkTylSugrhsAx4kodqRLxGM+K9ve0DiT+boOEV
 5FX8N7/4lYmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245851601"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 19:15:23 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH] x86, smpboot: Disable frequency invariance when it's unsupported
Date:   Thu, 16 Apr 2020 10:12:10 +0800
Message-Id: <20200416021210.170736-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Intel SNR processors such as "Intel Atom(R) C6562", the
turbo_freq for 4C turbo may be zero which causes a divide by zero
exception and blocks the boot process when arch_scale_freq_tick().

When one of the preset base_freq or turbo_freq is meaningless,
we may disable frequency invariance.

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..741367ce4d14 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1958,6 +1958,9 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
 	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
 
+	if (*turbo_freq == 0 || *base_freq == 0)
+		return false;
+
 	return true;
 }
 
-- 
2.21.1

