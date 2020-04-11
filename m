Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C11C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E50215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646256;
	bh=XlDL9/obX38EZGmMCq4P4RUovdf1i/YmOm2y0WYDwfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CPgon4sg2EGpyB9s1vXQAQYq6yaTxFHy8N+lQNocwE8wTCgIp/RY4IGhn4UEN7rDl
	 rAgErabBtIuSe5aI6duhCHQBhC24yQqmfXxeM/D6O77AG4YSNdTIuOpDXli7Kv+MuS
	 iO7RMiFdb2TwQxEpqO4vmWITrY34SEuxJn3wBOwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDKXEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgDKXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B9B218AC;
        Sat, 11 Apr 2020 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646244;
        bh=XlDL9/obX38EZGmMCq4P4RUovdf1i/YmOm2y0WYDwfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pc+wYlZOptEovpeBPPfXYKil7XfsSlJSlYPUdL2/VXlIchdr5i7mZcKl2x7etGkUT
         fN3gJowd010s+Mp97a9xaa6bX8juEflBtdp6lx5JA4J7o22XpXLpSr6M/EFJxxj1W1
         a6edW9B44Gcx+X5z37gK6NcLxOnjr7xaYWYMQEyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 013/149] tools/power/x86/intel-speed-select: Fix mailbox usage for CLOS_PM_QOS_CONFIG
Date:   Sat, 11 Apr 2020 19:01:30 -0400
Message-Id: <20200411230347.22371-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 8ddbda76245f5d10e00020db34455404019efc91 ]

Even for the products using MMIO, this message needs to be sent via
mail box. The previous fix done for this didn't properly address this.
That fix simply removed sending command via MMIO, but still didn't
trigger sending via mailbox.

Add additional condition to check for CLOS_PM_QOS_CONFIG, when MMIO
is supported on a platform.

Fixes: cd0e63706549 (tools/power/x86/intel-speed-select: Use mailbox for CLOS_PM_QOS_CONFIG)
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/intel-speed-select/isst-config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2b2b8167c65be..6a973e7832228 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -571,7 +571,8 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 		"mbox_send: cpu:%d command:%x sub_command:%x parameter:%x req_data:%x\n",
 		cpu, command, sub_command, parameter, req_data);
 
-	if (isst_platform_info.mmio_supported && command == CONFIG_CLOS) {
+	if (isst_platform_info.mmio_supported && command == CONFIG_CLOS &&
+	    sub_command != CLOS_PM_QOS_CONFIG) {
 		unsigned int value;
 		int write = 0;
 		int clos_id, core_id, ret = 0;
-- 
2.20.1

