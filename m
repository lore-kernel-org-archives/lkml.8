Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62ABC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B423D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WFlO0IVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgD0P7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:59:51 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48808 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgD0P7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:59:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588003186; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f/y8ZmWjuFPw09AupAp8NTMvIoR6jRpIZRqaRrwFPNU=; b=WFlO0IVSN0O59fOQSn0ThoDA8UVRXgy/8ocagrwUfst0UbPdV5wonTrCNL1GWjFDZTm7LfIY
 1VyhRUUtY94giI/af7SwDGvaBrOqYU6v6iRWZ9hERVEy/ldxmwlzLOWckCqVEShFpd304VrK
 LEn41UgvXbqWmhRs11A9zUp4ZlM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea70167.7f721d3453e8-smtp-out-n03;
 Mon, 27 Apr 2020 15:59:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35566C43636; Mon, 27 Apr 2020 15:59:34 +0000 (UTC)
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC024C433CB;
        Mon, 27 Apr 2020 15:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC024C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 3/6] bus: mhi: core: Offload register accesses to the controller
Date:   Mon, 27 Apr 2020 09:59:10 -0600
Message-Id: <1588003153-13139-4-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
References: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading or writing MHI registers, the core assumes that the physical
link is a memory mapped PCI link.  This assumption may not hold for all
MHI devices.  The controller knows what is the physical link (ie PCI, I2C,
SPI, etc), and therefore knows the proper methods to access that link.
The controller can also handle link specific error scenarios, such as
reading -1 when the PCI link went down.

Therefore, it is appropriate that the MHI core requests the controller to
make register accesses on behalf of the core, which abstracts the core
from link specifics, and end up removing an unnecessary assumption.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c     |  3 ++-
 drivers/bus/mhi/core/internal.h |  3 ---
 drivers/bus/mhi/core/main.c     | 12 ++----------
 include/linux/mhi.h             |  6 ++++++
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 2af08d57..eb2ab05 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -813,7 +813,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		return -EINVAL;
 
 	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
-	    !mhi_cntrl->status_cb)
+	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
+	    !mhi_cntrl->write_reg)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 5deadfa..095d95b 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -11,9 +11,6 @@
 
 extern struct bus_type mhi_bus_type;
 
-/* MHI MMIO register mapping */
-#define PCI_INVALID_READ(val) (val == U32_MAX)
-
 #define MHIREGLEN (0x0)
 #define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
 #define MHIREGLEN_MHIREGLEN_SHIFT (0)
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 473278b8..580d72b 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -18,15 +18,7 @@
 int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
 			      void __iomem *base, u32 offset, u32 *out)
 {
-	u32 tmp = readl(base + offset);
-
-	/* If the value is invalid, the link is down */
-	if (PCI_INVALID_READ(tmp))
-		return -EIO;
-
-	*out = tmp;
-
-	return 0;
+	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
 }
 
 int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
@@ -48,7 +40,7 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 		   u32 offset, u32 val)
 {
-	writel(val, base + offset);
+	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
 void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index be704a4..225a03a 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -342,6 +342,8 @@ struct mhi_controller_config {
  * @runtimet_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
+ * @read_reg: Read a MHI register via the physical link (required)
+ * @write_reg: Write a MHI register via the physical link (required)
  * @buffer_len: Bounce buffer length
  * @bounce_buf: Use of bounce buffer
  * @fbc_download: MHI host needs to do complete image transfer (optional)
@@ -425,6 +427,10 @@ struct mhi_controller {
 			  struct mhi_buf_info *buf);
 	void (*unmap_single)(struct mhi_controller *mhi_cntrl,
 			     struct mhi_buf_info *buf);
+	int (*read_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			u32 *out);
+	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			  u32 val);
 
 	size_t buffer_len;
 	bool bounce_buf;
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
