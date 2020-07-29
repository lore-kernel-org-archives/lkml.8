Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A753020786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wbmECtW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgG2DrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:47:18 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53337 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbgG2DrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:47:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595994437; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5AfOnS+3Y+Pteg+tc8ZLv/GKO8Jt2d+yM7XEqrxfjHE=; b=wbmECtW0Em3nta7IXK5hzhojiyNWlCIn1VqoG5XMXRuMpJcnfigKw3hKcqPXzA8UqUF2lJM8
 vSEnZmf/s2Thw8VXbyLPYIR7cOuxcj82bw3f8DtehXW+fMbXo/Jqn0aVTi6xnW00aEXbIKWp
 mcHwseUbWCM6cN0ixNMP4ROPDhs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-east-1.postgun.com with SMTP id
 5f20f12636e6de324ed9f1b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Jul 2020 03:46:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5319DC4339C; Wed, 29 Jul 2020 03:46:45 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77343C433C6;
        Wed, 29 Jul 2020 03:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77343C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] docs: Add documentation for userspace client interface
Date:   Tue, 28 Jul 2020 20:46:34 -0700
Message-Id: <1595994395-20143-4-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595994395-20143-1-git-send-email-hemantk@codeaurora.org>
References: <1595994395-20143-1-git-send-email-hemantk@codeaurora.org>
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

