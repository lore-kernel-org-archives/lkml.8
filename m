Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978CBC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5220714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dEkSd3/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCTXgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:36:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58298 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgCTXgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:36:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584747390; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kzGBufw4XcOfd9u6lXmQ6aW6t3E2LZcw3C5ePtsICcM=; b=dEkSd3/btQP/+4M5NfL/4BnAJN/EXopRt5aYNRYiVwhs2ReNLXLZhwW0YcREl3ibUQh55YsD
 a0r9ldw/5Nf7K1HbdMglihgsae0dLyldIFtvfaSwLZLw4ir/PtHXectn2CDZ2L4hB+VosAPg
 qTYx1EIeTf4eTLjq1A85OfDLMLI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e75537c.7f43c15068f0-smtp-out-n02;
 Fri, 20 Mar 2020 23:36:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADEC9C433CB; Fri, 20 Mar 2020 23:36:27 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15BCFC433D2;
        Fri, 20 Mar 2020 23:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15BCFC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 0/2] Add character device interface to remoteproc
Date:   Fri, 20 Mar 2020 16:36:15 -0700
Message-Id: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a character device interface to remoteproc
framework. This interface can be used by userspace clients in order
to boot and shutdown the remote processor.
Currently there is only a sysfs interface which the userspace
clients can use. If a usersapce application crashes after booting
the remote processor through the sysfs interface the remote processor
does not get any indication about the crash. It might still assume
that the  application is running.
For example modem uses remotefs service to data from disk/flash memory.
If the remotefs service crashes, modem still keeps on requesting data
which might lead to crash on modem. Even if the service is restarted the
file handles modem requested previously would become stale.
Adding a character device interface makes the remote processor tightly
coupled with the user space application. A crash of the application
leads to a close on the file descriptors therefore shutting down the
remoteproc.

Rishabh Bhatnagar (2):
  remoteproc: Add userspace char device driver
  remoteproc: core: Register the character device interface

 drivers/remoteproc/Makefile               |   1 +
 drivers/remoteproc/remoteproc_core.c      |   8 +-
 drivers/remoteproc/remoteproc_internal.h  |   3 +
 drivers/remoteproc/remoteproc_userspace.c | 126 ++++++++++++++++++++++++++++++
 include/linux/remoteproc.h                |   2 +
 5 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/remoteproc_userspace.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
