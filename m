Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BEC20758
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GPLMjknd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHUDrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:47:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30017 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgHUDrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:47:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597981661; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=v4omXDyJrk7uYAAmIxOtInrF8HunhhxjwsUJAmCO+X8=; b=GPLMjknd7m8hnYcpypfsBs3DRmWLsHEFSXd/mqml9u2IJQXHWuH1YgeQ5C+QhH9mrLOOoyo+
 5qIV5kwbbCgSyBPDpmjs3v3r1zqXXKVStT5x04n+prxM68jzK7yVBj73ATEa0ZmIIK1l/bv0
 6XrWr8D7p0ZPpBqxHQ9XVcVHpFU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3f43cf0dab4fdee212a3b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 03:47:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1ACABC433B1; Fri, 21 Aug 2020 03:47:27 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51B76C433CA;
        Fri, 21 Aug 2020 03:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51B76C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v10 18/24] coresight: cti: Fix bug clearing sysfs links on callback
Date:   Fri, 21 Aug 2020 11:44:39 +0800
Message-Id: <20200821034445.967-19-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200821034445.967-1-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

During module unload, a coresight driver module will call back into
the CTI driver to remove any links between the two devices.

The current code has 2 issues:-
1) in the CTI driver the matching code is matching to the wrong device
so misses all the links.
2) The callback is called too late in the unload process resulting in a
crash.

This fixes both the issues.

Fixes: 177af8285b59 ("coresight: cti: Enable CTI associated with devices")
Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti.c | 2 +-
 drivers/hwtracing/coresight/coresight.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 73304374a155..ec286d617b73 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -608,7 +608,7 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 		ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
 		ctidev = &ctidrv->ctidev;
 		list_for_each_entry(tc, &ctidev->trig_cons, node) {
-			if (tc->con_dev == csdev->ect_dev) {
+			if (tc->con_dev == csdev) {
 				cti_remove_sysfs_link(ctidrv, tc);
 				tc->con_dev = NULL;
 				break;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index c2174fed263b..6c09be15d60c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1254,8 +1254,6 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	if (cti_assoc_ops && cti_assoc_ops->remove)
-		cti_assoc_ops->remove(csdev);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
@@ -1590,6 +1588,8 @@ void coresight_unregister(struct coresight_device *csdev)
 {
 	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
+	if (cti_assoc_ops && cti_assoc_ops->remove)
+		cti_assoc_ops->remove(csdev);
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
 	coresight_release_platform_data(csdev, csdev->pdata);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

