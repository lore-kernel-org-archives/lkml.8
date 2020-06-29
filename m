Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="m6jfRbL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgF2UES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:04:18 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47737 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732126AbgF2UDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:03:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593461016; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qtpTpEyX7P3/UBQOBDIxCImXEpI/7q2pBRc6Go1iexs=; b=m6jfRbL6jUGwsJoj9KCMaMLth0fWWfF5kRhS5KvUjpPN/B8kOa85k54H/+GLfjPwlefSmjoD
 L6x+u0TSeBevQWZ3xU0jEIjo3O0F3Xq2GxiqAx2TU/AMwiRC/IM11B1RdaOf1NJKL/MMLDcT
 X5lZAlR+E+bCtkfAdy4HMiMYvqk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5efa490f4c9690533af33426 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 20:03:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BCC48C433AF; Mon, 29 Jun 2020 20:03:26 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD483C4339C;
        Mon, 29 Jun 2020 20:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD483C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v6 0/3] Extend coredump functionality
Date:   Mon, 29 Jun 2020 13:02:10 -0700
Message-Id: <1593460933-4262-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series moves the coredump functionality to a separate
file and adds "inline" coredump feature. Inline coredump directly
copies segments from device memory during coredump to userspace.
This avoids extra memory usage at the cost of speed. Recovery is
stalled until all data is read by userspace.

Changelog:

v6 -> v5:
- Fix unsigned comaprison with negative bug found on gcc-9.3.0

v5 -> v4:
- Rebase on top of linux-next

v4 -> v3:
- Write a helper function to copy segment memory for every dump format
- Change segment dump fn to add offset and size adn covert mss driver

v3 -> v2:
- Move entire coredump functionality to remoteproc_coredump.c
- Modify rproc_coredump to perform dump according to conf. set by userspace
- Move the userspace configuration to debugfs from sysfs.
- Keep the default coredump implementation as is

v2 -> v1:
- Introduce new file for coredump.
- Add userspace sysfs configuration for dump type.

Rishabh Bhatnagar (3):
  remoteproc: Move coredump functionality to a new file
  remoteproc: Add inline coredump functionality
  remoteproc: Add coredump debugfs entry

 drivers/remoteproc/Makefile              |   1 +
 drivers/remoteproc/qcom_q6v5_mss.c       |   9 +-
 drivers/remoteproc/remoteproc_core.c     | 191 ------------------
 drivers/remoteproc/remoteproc_coredump.c | 328 +++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c  |  86 ++++++++
 drivers/remoteproc/remoteproc_internal.h |   4 +
 include/linux/remoteproc.h               |  21 +-
 7 files changed, 443 insertions(+), 197 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_coredump.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

