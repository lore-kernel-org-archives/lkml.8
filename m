Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23EC35255
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC59221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="juPEZQ/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHFGle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:41:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44588 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgHFGl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:41:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596696087; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5AfOnS+3Y+Pteg+tc8ZLv/GKO8Jt2d+yM7XEqrxfjHE=; b=juPEZQ/gCFxzEXUhJ6+ExJLPbDCU/I2fxgGf41YiTMmfTWF4BeKceU0Ia/pafEY3/dDYWwXi
 f+Cm6b7Nj/jsV4V5JzXkhIUjTq0F7XNxjZIE+5dLtHD0QumbzCJhKuqJiOeafUcBlVVWSMgR
 IbpfWrwGQcYd3zcLhWQhSasuIvU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f2ba6072f4952907d09d61c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 Aug 2020 06:41:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7BC39C433C9; Thu,  6 Aug 2020 06:41:11 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8CB7C433C6;
        Thu,  6 Aug 2020 06:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8CB7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     gregkh@linuxfoundation.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v5 3/4] docs: Add documentation for userspace client interface
Date:   Wed,  5 Aug 2020 23:41:02 -0700
Message-Id: <1596696063-17802-4-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596696063-17802-1-git-send-email-hemantk@codeaurora.org>
References: <1596696063-17802-1-git-send-email-hemantk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI userspace client driver is creating device file node
for user application to perform file operations. File
operations are handled by MHI core driver. Currently
Loopback MHI channel is supported by this driver.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 Documentation/mhi/index.rst |  1 +
 Documentation/mhi/uci.rst   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/mhi/uci.rst

diff --git a/Documentation/mhi/index.rst b/Documentation/mhi/index.rst
index 1d8dec3..c75a371 100644
--- a/Documentation/mhi/index.rst
+++ b/Documentation/mhi/index.rst
@@ -9,6 +9,7 @@ MHI
 
    mhi
    topology
+   uci
 
 .. only::  subproject and html
 
diff --git a/Documentation/mhi/uci.rst b/Documentation/mhi/uci.rst
new file mode 100644
index 0000000..5d92939
--- /dev/null
+++ b/Documentation/mhi/uci.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Userspace Client Interface (UCI)
+=================================
+
+UCI driver enables userspace clients to communicate to external MHI devices
+like modem and WLAN. It creates standard character device file nodes for user
+space clients to perform open, read, write, poll and close file operations.
+
+Device file node is created with format:-
+
+/dev/mhi_<controller_name>_<mhi_device_name>
+
+controller_name is the name of underlying bus used to transfer data.
+mhi_device_name is the name of the MHI channel being used by MHI client in
+userspace to send or receive data using MHI protocol.
+
+There is a separate character device file node created for each channel specified
+in mhi device id table. MHI channels are statically defined by MHI specification.
+Driver currently supports LOOPBACK channel 0 (Host to device) and 1 (Device to Host).
+
+LOOPBACK Channel
+----------------
+
+Userspace MHI client using LOOPBACK channel opens device file node. As part of
+open operation TREs to transfer ring of LOOPBACK channel 1 gets queued and channel
+doorbell is rung. When userspace MHI client performs write operation on device node,
+data buffer gets queued as a TRE to transfer ring of LOOPBACK channel 0. MHI Core
+driver rings the channel doorbell for MHI device to move data over underlying bus.
+When userspace MHI client driver performs read operation, same data gets looped back
+to MHI host using LOOPBACK channel 1. LOOPBACK channel is used to verify data path
+and data integrity between MHI Host and MHI device.
+
+Other Use Cases
+---------------
+
+Getting MHI device specific diagnostics information to userspace MHI diag client
+using DIAG channel 4 (Host to device) and 5 (Device to Host).
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

