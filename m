Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB06C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544F02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgICCwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:52:01 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34054 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgICCv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:51:59 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Sep 2020 19:51:58 -0700
Received: from th-lint-039.qualcomm.com ([10.63.179.124])
  by ironmsg01-sd.qualcomm.com with ESMTP; 02 Sep 2020 19:51:58 -0700
Received: by th-lint-039.qualcomm.com (Postfix, from userid 2383757)
        id 532621B65; Wed,  2 Sep 2020 19:51:58 -0700 (PDT)
From:   Gurbir Arora <gurbaror@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, rishabhb@codeaurora.org,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: [PATCH v2 1/3] remoteproc: core: Add multiple components to remoteproc ops
Date:   Wed,  2 Sep 2020 19:51:54 -0700
Message-Id: <1599101516-243760-2-git-send-email-gurbaror@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599101516-243760-1-git-send-email-gurbaror@codeaurora.org>
References: <1599101516-243760-1-git-send-email-gurbaror@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each remoteproc might have different requirements for coredumps and might
want to choose the type of dumps it wants to collect. This change allows
remoteproc drivers to specify their own custom dump function to be executed
in place of rproc_coredump. If the coredump op is not specified by the
remoteproc driver it will be set to rproc_coredump by default.The
priv_cleanup op cleans up the private resources used by the
remoteproc.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Gurbir Arora <gurbaror@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 include/linux/remoteproc.h           | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7f90eee..dcc1341 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1681,7 +1681,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
 		goto unlock_mutex;
 
 	/* generate coredump */
-	rproc_coredump(rproc);
+	rproc->ops->coredump(rproc);
 
 	/* load firmware */
 	ret = request_firmware(&firmware_p, rproc->firmware, dev);
@@ -2103,6 +2103,10 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	if (!rproc->ops)
 		return -ENOMEM;
 
+	/* Default to rproc_coredump if no coredump function is specified */
+	if (!rproc->ops->coredump)
+		rproc->ops->coredump = rproc_coredump;
+
 	if (rproc->ops->load)
 		return 0;
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 2fa68bf..747d7e3 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -373,8 +373,10 @@ enum rsc_handling_status {
  *			expects to find it
  * @sanity_check:	sanity check the fw image
  * @get_boot_addr:	get boot address to entry point specified in firmware
+ * @coredump:   collect firmware dump after the subsystem is shutdown
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
+ * @priv_cleanup: cleans up the private resources used by the rproc
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -392,7 +394,9 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	void (*coredump)(struct rproc *rproc);
 	unsigned long (*panic)(struct rproc *rproc);
+	void (*priv_cleanup)(struct rproc *rproc);
 };
 
 /**
-- 
2.7.4

