Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B912C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C43520719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tY2vXeIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCZQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:50:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15902 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCZQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:50:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585241449; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kzGBufw4XcOfd9u6lXmQ6aW6t3E2LZcw3C5ePtsICcM=; b=tY2vXeIYykdwbyEKiPLWRDvddWqwKVmjBDA3tDehnb6mJA/fWWbJaSYLBioQY0ZaSy5aeqhJ
 s8PnuK9pwXVkj4jXKwixEnrrpDc6hiw7hcw4RCWRNO8LHGvMxbFf8oavWZf044CwkrdMKKC8
 S/T6x+1BfT8l+0r3lVlvwsyQV3U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7cdd68.7f5cbc4c7960-smtp-out-n01;
 Thu, 26 Mar 2020 16:50:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEE96C44791; Thu, 26 Mar 2020 16:50:47 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAAB9C433D2;
        Thu, 26 Mar 2020 16:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAAB9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 0/2] Add character device interface to remoteproc
Date:   Thu, 26 Mar 2020 09:50:38 -0700
Message-Id: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
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
