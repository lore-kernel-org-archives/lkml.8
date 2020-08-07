Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8825C2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHGXc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:32:28 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46483 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgHGXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:32:22 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Aug 2020 16:32:21 -0700
Received: from th-lint-015.qualcomm.com ([10.63.177.64])
  by ironmsg03-sd.qualcomm.com with ESMTP; 07 Aug 2020 16:32:20 -0700
Received: by th-lint-015.qualcomm.com (Postfix, from userid 2383757)
        id D5C8D174E; Fri,  7 Aug 2020 16:32:20 -0700 (PDT)
From:   Gurbir Arora <gurbaror@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, rishabhb@codeaurora.org,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: [PATCH 1/3] remoteproc: core: Add coredump to remoteproc ops
Date:   Fri,  7 Aug 2020 16:31:59 -0700
Message-Id: <1596843121-82576-2-git-send-email-gurbaror@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1596843121-82576-1-git-send-email-gurbaror@codeaurora.org>
References: <1596843121-82576-1-git-send-email-gurbaror@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each remoteproc might have different requirements for coredumps and might
want to choose the type of dumps it wants to collect. This change allows
remoteproc drivers to specify their own custom dump function to be executed
in place of rproc_coredump. If the coredump op is not specified by the
remoteproc driver it will be set to rproc_coredump by default.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Gurbir Arora <gurbaror@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 include/linux/remoteproc.h           | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7f90eee..283ecb6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1681,7 +1681,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
 		goto unlock_mutex;
 
 	/* generate coredump */
-	rproc_coredump(rproc);
+	rproc->ops->coredump(rproc);
 
 	/* load firmware */
 	ret = request_firmware(&firmware_p, rproc->firmware, dev);
@@ -2113,6 +2113,10 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	rproc->ops->sanity_check = rproc_elf_sanity_check;
 	rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
 
+	/* Default to rproc_coredump if no coredump functions is specified */
+	if (!rproc->ops->coredump)
+		rproc->ops->coredump = rproc_coredump;
+
 	return 0;
 }
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 2fa68bf..0ed1a2b 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -392,6 +392,7 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	void (*coredump)(struct rproc *rproc);
 	unsigned long (*panic)(struct rproc *rproc);
 };
 
-- 
1.9.1

