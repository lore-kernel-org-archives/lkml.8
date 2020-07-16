Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F9EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15CC2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dp/wtm+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGPXOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:14:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39870 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgGPXOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:14:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594941263; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Nng1sYIDPTAcnUhkBssDTIQdylbGIkCeopFB3ZR9t2g=; b=dp/wtm+BmqSecCfAyfvaeHzXz24+PVu02+HV1ZsbqPf5h7qtt0N7Ldvx8m6Tfcytd4TsqIJ5
 IcMPYdsdGyFyeVnbNJLjXgWgB2fEYtsC0Ibhs4RAzATuNtuA8iwZvmGKEJn2c98iCMoNGzw6
 gSGof8EOEekqlDLyKkjtrB1f58M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-east-1.postgun.com with SMTP id
 5f10d31ef9ca681bd070159a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 22:22:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA519C433B2; Thu, 16 Jul 2020 22:22:21 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C296C433CA;
        Thu, 16 Jul 2020 22:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C296C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        sibis@codearora.org, tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v8 0/5] Extend coredump functionality
Date:   Thu, 16 Jul 2020 15:20:30 -0700
Message-Id: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
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
This patchset also includes Sibi Sankar's patch to deal with chunk sizes
lesser than segment size to make inline coredump work for modem.
https://patchwork.kernel.org/patch/11637157/

Changelog:

v8 -> v7:
- Split out the qcom_q6v5_mss refactoring into a new patch
- Remove zero size check in dump_segment function for mss
- Remove segment number being passed as private member for the segment
- Free the memory used by dump state header before signalling completion

v7 -> v6:
- Include Sibi's patch as part of this patchset
- Add a linefeed when displaying coredump conf in debugfs
- Fix a typo in remoteproc.h

v6 -> v5:
- Fix unsigned comaprison with negative bug found on gcc-9.3.0

v5 -> v4:
- Rebase on top of linux-next
- Modify qcom_q6v5_mss driver as a result of rebasing on latest tip.

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

Rishabh Bhatnagar (4):
  remoteproc: Move coredump functionality to a new file
  remoteproc: Add size and offset arguments to segment dump function
  remoteproc: Add inline coredump functionality
  remoteproc: Add coredump debugfs entry

Sibi Sankar (1):
  remoteproc: qcom_q6v5_mss: Replace mask based tracking with size

 drivers/remoteproc/Makefile              |   1 +
 drivers/remoteproc/qcom_q6v5_mss.c       |  25 ++-
 drivers/remoteproc/remoteproc_core.c     | 191 ------------------
 drivers/remoteproc/remoteproc_coredump.c | 325 +++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c  |  90 +++++++++
 drivers/remoteproc/remoteproc_internal.h |   4 +
 include/linux/remoteproc.h               |  21 +-
 7 files changed, 451 insertions(+), 206 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_coredump.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

