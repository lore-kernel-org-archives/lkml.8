Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE502053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oTcfFWKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgF2TBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:01:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32667 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgF2TAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593457223; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MGpgHTPanseMUSP/5lHDa6o1Mxq+oOakQ9xuKUP30WY=; b=oTcfFWKeY+TcNxeQMFBvU5xW/rxPfn4d9Xncxw4QCJhKroeqpxZQK1mzt6kZvkYAPHbK8AmM
 Jn/h+oOFvZ67uQ9kf3RjZA6yBKPepUNYVMNF0xfq0vb3jWx9qULEZ2aLxu12BkEr6m8hWxKA
 5HEOwXVLm8L6W6cr9tDJak8hTOs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5efa1958fe1db4db892338cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 16:39:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 621F0C433C6; Mon, 29 Jun 2020 16:39:52 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6CBEC433C8;
        Mon, 29 Jun 2020 16:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6CBEC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 0/9] Introduce features and debugfs/sysfs entries for MHI
Date:   Mon, 29 Jun 2020 09:39:33 -0700
Message-Id: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce independent bus and device voting mechanism for clients and save
hardware information from BHI.
Allow reading and modifying some MHI variables for debug, test, and
informational purposes using debugfs.
Read values for device specific hardware information to be used by OEMs in
factory testing such as serial number and PK hash using sysfs.

This set of patches was tested on arm64 and x86.

v4:
-Removed bus: mhi: core: Introduce independent voting mechanism patch
-Removed bus vote function from debugfs due to independent voting removal
-Added helper resume APIs to aid consolidation of spread out code
-Added a clean-up patch and a missing host resume in voting API

v3:
-Add patch to check for pending packets in suspend as a dependency for the
independent voting mechanism introduction
-Include register dump entry for debugfs to dump MHI, BHI, and BHIe registers
-Update commit message for the debugfs patch
-Updated Documentation/ABI with the required info for sysfs
-Updated debugfs patch to include a new KConfig entry and dependencies
-Updated reviewed-by for some patches

v2:
-Added a new debugfs.c file for specific debugfs entries and code
-Updated commit text and addressed some comments for voting change
-Made sure sysfs is only used for serial number and OEM PK hash usage

Bhaumik Bhatt (9):
  bus: mhi: core: Remove double occurrence for mhi_ctrl_ev_task()
    declaration
  bus: mhi: core: Abort suspends due to outgoing pending packets
  bus: mhi: core: Use helper API to trigger a non-blocking host resume
  bus: mhi: core: Trigger a host resume when device vote is requested
  bus: mhi: core: Use generic name field for an MHI device
  bus: mhi: core: Introduce helper function to check device state
  bus: mhi: core: Introduce debugfs entries and counters for MHI
  bus: mhi: core: Read and save device hardware information from BHI
  bus: mhi: core: Introduce sysfs entries for MHI

 Documentation/ABI/stable/sysfs-bus-mhi |  25 ++
 MAINTAINERS                            |   1 +
 drivers/bus/mhi/Kconfig                |   8 +
 drivers/bus/mhi/core/Makefile          |   5 +-
 drivers/bus/mhi/core/boot.c            |  17 +-
 drivers/bus/mhi/core/debugfs.c         | 444 +++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/init.c            |  65 ++++-
 drivers/bus/mhi/core/internal.h        |  38 ++-
 drivers/bus/mhi/core/main.c            |  27 +-
 drivers/bus/mhi/core/pm.c              |  19 +-
 include/linux/mhi.h                    |  18 +-
 11 files changed, 633 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi
 create mode 100644 drivers/bus/mhi/core/debugfs.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

