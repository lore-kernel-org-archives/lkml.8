Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D4CC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD6D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUmhodjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD3TGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgD3TGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:06:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA3C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so3847798pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqOW945RKza/JpsluftGvHrtnYoUZM59Kb7ny0dAINI=;
        b=HUmhodjJnkMQH959dPU/FHOgOs2RkforQQ0szf496o+WX6SXYZ4txDutrlJ09paeEp
         YnGrVxpyc9xN/RvDelHq5cnG+E5Qylju4uuR54oABDtxzQWRjrhIjB7uA2/YzKgTO2NF
         8q9gyK959A+0hmvuF/3G23aiz64pcm7snO5OKlLmXIWUm4i2y3rzcv+gKeAsisc35Zwe
         rFSVEwpl6IfoY3uEATOFabKnKC3GfqNUhFO6CnUobxWBKcvWri7GG7VdR3Iv0fdMVThD
         zf5MVpvxjIORR8qdHVS2pxNxojLobHj+LaZwc7Uzp9zEEUOHV1yloBTM5H1no6QO6BBS
         Itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqOW945RKza/JpsluftGvHrtnYoUZM59Kb7ny0dAINI=;
        b=XdpaaNmdiTeWJd/9nVrwgZ+8QWQbkDkcOzOa/A5PnyFrBfDmclAaSYK6ZKKYFcLQ/x
         vhqXkxta8YySBC2ECo/3/t6pUdNCtJ3zPyTiYcGGIByqV5o6g48eoI8owLao6wsx550p
         EnbJCV0xGVeJAHL/rCYP2rCG0GFOn814cUHaxDzJz72ABgpyxatdPEF+lu4+iduuFPbI
         jBEpaC3DY+T4WgtGyaU9f6WyfKK4okueFMrHLPhgK7fsnk6xY4++FPclho3b9T5zYP5X
         3mHLabjjdNxEqyXx6Z3I8q0ingbyJ8PCseR9MFRFt6rpbECumiEjG536O7YpDfliPE+N
         sH3A==
X-Gm-Message-State: AGi0PuYz03b/u6GwNEih/+799K0oGuDi/1PvX9EGM+POXwHIwcPGUM2Y
        dtBjw4gYXExCSmTAu3ytkOH6
X-Google-Smtp-Source: APiQypIoz9U4YuvrxFQ8f8sIIRfoCejZKyaTDPp9ytCz1Crot+vzDnqAgJj+U7x/JkSmrd7ZTxNQyw==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr414798pls.309.1588273579341;
        Thu, 30 Apr 2020 12:06:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id l37sm467863pje.12.2020.04.30.12.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:06:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/6] bus: mhi: core: Remove link_status() callback
Date:   Fri,  1 May 2020 00:35:52 +0530
Message-Id: <20200430190555.32741-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
References: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

If the MHI core detects invalid data due to a PCI read, it calls into
the controller via link_status() to double check that the link is infact
down.  All in all, this is pretty pointless, and racy.  There are no good
reasons for this, and only drawbacks.

Its pointless because chances are, the controller is going to do the same
thing to determine if the link is down - attempt a PCI access and compare
the result.  This does not make the link status decision any smarter.

Its racy because its possible that the link was down at the time of the
MHI core access, but then recovered before the controller access.  In this
case, the controller will indicate the link is not down, and the MHI core
will precede to use a bad value as the MHI core does not attempt to retry
the access.

Retrying the access in the MHI core is a bad idea because again, it is
racy - what if the link is down again?  Furthermore, there may be some
higher level state associated with the link status, that is now invalid
because the link went down.

The only reason why the MHI core could see "invalid" data when doing a PCI
access, that is actually valid, is if the register actually contained the
PCI spec defined sentinel for an invalid access.  In this case, it is
arguable that the MHI implementation broken, and should be fixed, not
worked around.

Therefore, remove the link_status() callback before anyone attempts to
implement it.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 6 ++----
 drivers/bus/mhi/core/main.c | 5 ++---
 include/linux/mhi.h         | 2 --
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index b38359c480ea..2af08d57ec28 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -812,10 +812,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (!mhi_cntrl)
 		return -EINVAL;
 
-	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put)
-		return -EINVAL;
-
-	if (!mhi_cntrl->status_cb || !mhi_cntrl->link_status)
+	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
+	    !mhi_cntrl->status_cb)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 3e9aa3b2da77..374e3db31ab7 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -20,9 +20,8 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
 {
 	u32 tmp = readl(base + offset);
 
-	/* If there is any unexpected value, query the link status */
-	if (PCI_INVALID_READ(tmp) &&
-	    mhi_cntrl->link_status(mhi_cntrl))
+	/* If the value is invalid, the link is down */
+	if (PCI_INVALID_READ(tmp))
 		return -EIO;
 
 	*out = tmp;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 3e76dc9cba5d..0794483b9a18 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -335,7 +335,6 @@ struct mhi_controller_config {
  * @syserr_worker: System error worker
  * @state_event: State change event
  * @status_cb: CB function to notify power states of the device (required)
- * @link_status: CB function to query link status of the device (required)
  * @wake_get: CB function to assert device wake (optional)
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
@@ -417,7 +416,6 @@ struct mhi_controller {
 
 	void (*status_cb)(struct mhi_controller *mhi_cntrl,
 			  enum mhi_callback cb);
-	int (*link_status)(struct mhi_controller *mhi_cntrl);
 	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
 	void (*wake_toggle)(struct mhi_controller *mhi_cntrl);
-- 
2.17.1

