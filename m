Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263BC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD42073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEMRJ4SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCXGLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCXGLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so8798486pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0rm/hJBOldUA/aelJL/2EPkyPaOyJlZ3C53n4HhDybY=;
        b=KEMRJ4SFDvRpOJmhr1f/KS419BcRJyaqRe755EAdgeGhjJ2Q8FVBtVAtK3ALS2CBtn
         K9pOYMZVsG2iu6D4aYIHUsNBiiexxY5M1khLEFQbY0i8ANwYdG4Gt+EjMM0ZuZAY0b7x
         8/oZbhA/hEIOuCPH3B20NZlasLhAzHbmFr36vF/flk7zmvulQGDmdr05nqXfDMJAPYn+
         P43QRSMo/1MH2Y+39neYdm9e6SN6aDZMxspJ/0HTA071hAquE0jQOqbKFTG0pbcYi5Pr
         YzvYpjcUH6THCtm/LDvjXrlNEl7YP6IVCmHWflNDWL5lD5lcatOEmD3UuCKv5An5/HcC
         VPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0rm/hJBOldUA/aelJL/2EPkyPaOyJlZ3C53n4HhDybY=;
        b=BTsJwaAvMi25MEuC42aJqvyQCUNo8XqgZKB6gNvxnaRQjPyv+MXgxPGss1RZQQY4R3
         g4/jmPE8uDYPdHBgvuIeUF4xbB8GAZYwT4YsOD5sj/wDFbpdOqBa3n99aRBiWa4tVn73
         yUk6qp+5s+HhsW8uIl/QYjGD/pZLRrtQUW7xoI+1091VJwmanYZH4zcMgTJBddnzheew
         ZJprDqjV4zV/kr8Bquw7SaWL2hqKZ8dxORBNaKhaTVAwJAIZ3yrOjYR0qckAnlCd7ZJR
         2WHPjiV2AA8kT6EG6TJRUVq3tF2F8a+r126p6XD9zMlG9Z5re7wJuitTmpJkdZ+FcdYu
         48GA==
X-Gm-Message-State: ANhLgQ2gu6qT6LaR03EwpfQRTLKCvreojS1X1WiY+0ZWqfO389GJt0tY
        NqECF5/lmsgzQeUGhQpp3k1x
X-Google-Smtp-Source: ADFU+vtdkmKcfs5JkcvwJtgfg9WSWwDNy1nKFYd5TW6336wHwH1zN4PM5212jXW26bwnPfgtG4WjVw==
X-Received: by 2002:a63:9248:: with SMTP id s8mr25359532pgn.253.1585030272176;
        Mon, 23 Mar 2020 23:11:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id d3sm1198230pjc.42.2020.03.23.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:11:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/7] bus: mhi: core: Add support for reading MHI info from device
Date:   Tue, 24 Mar 2020 11:40:45 +0530
Message-Id: <20200324061050.14845-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MHI register base has several registers used for getting the MHI
specific information such as version, family, major, and minor numbers
from the device. This information can be used by the controller drivers
for usecases such as applying quirks for a specific revision etc...

While at it, let's also rearrange the local variables
in mhi_register_controller().

Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c     | 19 +++++++++++++++++--
 drivers/bus/mhi/core/internal.h | 10 ++++++++++
 include/linux/mhi.h             | 17 +++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index eb7f556a8531..d136f6c6ca78 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -802,12 +802,12 @@ static int parse_config(struct mhi_controller *mhi_cntrl,
 int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 			    struct mhi_controller_config *config)
 {
-	int ret;
-	int i;
 	struct mhi_event *mhi_event;
 	struct mhi_chan *mhi_chan;
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_device *mhi_dev;
+	u32 soc_info;
+	int ret, i;
 
 	if (!mhi_cntrl)
 		return -EINVAL;
@@ -874,6 +874,21 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
 	}
 
+	/* Read the MHI device info */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
+			   SOC_HW_VERSION_OFFS, &soc_info);
+	if (ret)
+		goto error_alloc_dev;
+
+	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
+					SOC_HW_VERSION_FAM_NUM_SHFT;
+	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
+					SOC_HW_VERSION_DEV_NUM_SHFT;
+	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
+					SOC_HW_VERSION_MAJOR_VER_SHFT;
+	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
+					SOC_HW_VERSION_MINOR_VER_SHFT;
+
 	/* Register controller with MHI bus */
 	mhi_dev = mhi_alloc_device(mhi_cntrl);
 	if (IS_ERR(mhi_dev)) {
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 18066302e6e2..5deadfaa053a 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -196,6 +196,16 @@ extern struct bus_type mhi_bus_type;
 #define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
 #define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
 
+#define SOC_HW_VERSION_OFFS (0x224)
+#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
+#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
+#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
+#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
+#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
+#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
+#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
+#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
+
 #define EV_CTX_RESERVED_MASK GENMASK(7, 0)
 #define EV_CTX_INTMODC_MASK GENMASK(15, 8)
 #define EV_CTX_INTMODC_SHIFT 8
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d83e7772681b..ad1996001965 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -310,6 +310,10 @@ struct mhi_controller_config {
  * @sw_ev_rings: Number of software event rings
  * @nr_irqs_req: Number of IRQs required to operate (optional)
  * @nr_irqs: Number of IRQ allocated by bus master (required)
+ * @family_number: MHI controller family number
+ * @device_number: MHI controller device number
+ * @major_version: MHI controller major revision number
+ * @minor_version: MHI controller minor revision number
  * @mhi_event: MHI event ring configurations table
  * @mhi_cmd: MHI command ring configurations table
  * @mhi_ctxt: MHI device context, shared memory between host and device
@@ -348,6 +352,15 @@ struct mhi_controller_config {
  * Fields marked as (required) need to be populated by the controller driver
  * before calling mhi_register_controller(). For the fields marked as (optional)
  * they can be populated depending on the usecase.
+ *
+ * The following fields are present for the purpose of implementing any device
+ * specific quirks or customizations for specific MHI revisions used in device
+ * by the controller drivers. The MHI stack will just populate these fields
+ * during mhi_register_controller():
+ *  family_number
+ *  device_number
+ *  major_version
+ *  minor_version
  */
 struct mhi_controller {
 	struct device *cntrl_dev;
@@ -375,6 +388,10 @@ struct mhi_controller {
 	u32 sw_ev_rings;
 	u32 nr_irqs_req;
 	u32 nr_irqs;
+	u32 family_number;
+	u32 device_number;
+	u32 major_version;
+	u32 minor_version;
 
 	struct mhi_event *mhi_event;
 	struct mhi_cmd *mhi_cmd;
-- 
2.17.1

