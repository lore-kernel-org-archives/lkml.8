Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAC92078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgFOOOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:14:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:34462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbgFOOOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:14:15 -0400
IronPort-SDR: yiE0LHwNYMN41vBpGq3P3oE33Za8qORoQ44sPFZNaQW19qU1ZHlcF8ZlBl5ckwqpHIG3JV+gTl
 AYWilJhIvhDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:14:15 -0700
IronPort-SDR: kDSO4otepcTBV7dxQXyqnEF4xackA499ZjeVBuQ6C1mJL796s3mPq4nBDq2WOH3PWejrqsV/uM
 0ZGMUrAoE27Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476029252"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 07:14:14 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 4/4] firmware: rsu: add device attributes to sysfs interface
Date:   Mon, 15 Jun 2020 09:29:08 -0500
Message-Id: <1592231348-31334-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
References: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add the following device attributes to Intel Stratix10 Remote System
Update (RSU) sysfs interface:
	dcmf0
	dcmf1
	dcmf2
	dcmf3
	max_retry

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 .../testing/sysfs-devices-platform-stratix10-rsu   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
index ae9af98..a8daceb 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
+++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
@@ -126,3 +126,39 @@ Description:
 			1	no action
 			0	firmware record the notify code defined
 				in b[15:0].
+
+What:		/sys/devices/platform/stratix10-rsu.0/dcmf0
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) Decision firmware copy 0 version information.
+
+What:		/sys/devices/platform/stratix10-rsu.0/dcmf1
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) Decision firmware copy 1 version information.
+
+What:		/sys/devices/platform/stratix10-rsu.0/dcmf2
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) Decision firmware copy 2 version information.
+
+What:		/sys/devices/platform/stratix10-rsu.0/dcmf3
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) Decision firmware copy 3 version information.
+
+What:		/sys/devices/platform/stratix10-rsu.0/max_retry
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) max retry parameter is stored in the firmware
+		decision IO section, as a byte located at offset 0x18c.
-- 
2.7.4

