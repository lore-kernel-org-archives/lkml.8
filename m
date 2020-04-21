Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BFC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE3D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="u6FSFf5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgDUSKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:10:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44053 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgDUSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:10:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587492645; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=H8EubTh7i79BjoFT6UN3le3v6KCqE0B7/X8zxpL77s8=; b=u6FSFf5yDld8D4LAFE5vDXhFdVL/HUbLVG4XE0eyuUi9Cdu598yTlOai1wCT8q/jvUuaBCCX
 Uwr2bNPF+KUiYKuhsk/qMvepVXxeW6X42DowvXx8cmU4C2lr6RqryutZP3YPTtvgmgHmDUvs
 fmBxH5R+1CECfvXlrCcdMkXS/0s=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f3712.7fc3727ea420-smtp-out-n03;
 Tue, 21 Apr 2020 18:10:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48218C433F2; Tue, 21 Apr 2020 18:10:26 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EDAFC433BA;
        Tue, 21 Apr 2020 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EDAFC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 2/2] remoteproc: core: Register the character device interface
Date:   Tue, 21 Apr 2020 11:10:18 -0700
Message-Id: <1587492618-15896-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
References: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the character device during rproc_add. This would create
a character device node at /dev/remoteproc<index>. Userspace
applications can interact with the remote processor using this
interface.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e..76ba171 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1916,6 +1916,13 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
+	/* add char device for this remoteproc */
+	ret = rproc_char_device_add(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to add char dev for %s\n", rproc->name);
+		return ret;
+	}
+
 	/* if rproc is marked always-on, request it to boot */
 	if (rproc->auto_boot) {
 		ret = rproc_trigger_auto_boot(rproc);
@@ -2137,6 +2144,7 @@ int rproc_del(struct rproc *rproc)
 	mutex_unlock(&rproc->lock);
 
 	rproc_delete_debug_dir(rproc);
+	rproc_char_device_remove(rproc);
 
 	/* the rproc is downref'ed as soon as it's removed from the klist */
 	mutex_lock(&rproc_list_mutex);
@@ -2220,6 +2228,7 @@ static int __init remoteproc_init(void)
 {
 	rproc_init_sysfs();
 	rproc_init_debugfs();
+	rproc_init_cdev();
 
 	return 0;
 }
@@ -2231,6 +2240,7 @@ static void __exit remoteproc_exit(void)
 
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	rproc_exit_cdev();
 }
 module_exit(remoteproc_exit);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
