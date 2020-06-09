Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3DD2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726662;
	bh=8su1/yDtzEiYTbiR3qLGi+y6W6cRci67Qbj9Nl2n2BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=euda1h9RjGCuAEiymR+KYQW8wcuzzTNBZJtCdVfK15y780Oof0cflPNLkxU+Y5Wgz
	 rpHemIgHS2s473uh5RPCwleSu3v3CG1sW+QHUiU3obijDy/UdAFTnUkoSyHTyjTGez
	 tZkexvSoph2lVrApz7A7nxMvSQyJ34/tZXXJDc/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgFIRuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730956AbgFIRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA212208B6;
        Tue,  9 Jun 2020 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724992;
        bh=8su1/yDtzEiYTbiR3qLGi+y6W6cRci67Qbj9Nl2n2BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C775qNLb4y3lR9pr3ja8SfxNqmBqjnBHuFIWdjDCo+JcCEeV2mi6MhiIbGFDlsrzk
         d1FaWvuO7uAlqTfDy5hSVTBTAN+5WdEp/OP4UHm942Ixm+ks/eOicfIIHVOdBYAeKR
         XwJ4s+k81kilb8zihS6HRR7c+YrW6m9ZqVxQ3OBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/46] i2c: altera: Fix race between xfer_msg and isr thread
Date:   Tue,  9 Jun 2020 19:44:25 +0200
Message-Id: <20200609174023.715903677@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

[ Upstream commit 5d4c7977499a736f3f80826bdc9744344ad55589 ]

Use a mutex to protect access to idev->msg_len, idev->buf, etc. which
are modified by both altr_i2c_xfer_msg() and altr_i2c_isr().

This is the minimal fix for easy backporting. A cleanup to remove the
spinlock will be added later.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
[wsa: updated commit message]
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-altera.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 8915ee30a5b4..1d59eede537b 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -81,6 +81,7 @@
  * @isr_mask: cached copy of local ISR enables.
  * @isr_status: cached copy of local ISR status.
  * @lock: spinlock for IRQ synchronization.
+ * @isr_mutex: mutex for IRQ thread.
  */
 struct altr_i2c_dev {
 	void __iomem *base;
@@ -97,6 +98,7 @@ struct altr_i2c_dev {
 	u32 isr_mask;
 	u32 isr_status;
 	spinlock_t lock;	/* IRQ synchronization */
+	struct mutex isr_mutex;
 };
 
 static void
@@ -256,10 +258,11 @@ static irqreturn_t altr_i2c_isr(int irq, void *_dev)
 	struct altr_i2c_dev *idev = _dev;
 	u32 status = idev->isr_status;
 
+	mutex_lock(&idev->isr_mutex);
 	if (!idev->msg) {
 		dev_warn(idev->dev, "unexpected interrupt\n");
 		altr_i2c_int_clear(idev, ALTR_I2C_ALL_IRQ);
-		return IRQ_HANDLED;
+		goto out;
 	}
 	read = (idev->msg->flags & I2C_M_RD) != 0;
 
@@ -312,6 +315,8 @@ static irqreturn_t altr_i2c_isr(int irq, void *_dev)
 		complete(&idev->msg_complete);
 		dev_dbg(idev->dev, "Message Complete\n");
 	}
+out:
+	mutex_unlock(&idev->isr_mutex);
 
 	return IRQ_HANDLED;
 }
@@ -323,6 +328,7 @@ static int altr_i2c_xfer_msg(struct altr_i2c_dev *idev, struct i2c_msg *msg)
 	u32 value;
 	u8 addr = i2c_8bit_addr_from_msg(msg);
 
+	mutex_lock(&idev->isr_mutex);
 	idev->msg = msg;
 	idev->msg_len = msg->len;
 	idev->buf = msg->buf;
@@ -347,6 +353,7 @@ static int altr_i2c_xfer_msg(struct altr_i2c_dev *idev, struct i2c_msg *msg)
 		altr_i2c_int_enable(idev, imask, true);
 		altr_i2c_fill_tx_fifo(idev);
 	}
+	mutex_unlock(&idev->isr_mutex);
 
 	time_left = wait_for_completion_timeout(&idev->msg_complete,
 						ALTR_I2C_XFER_TIMEOUT);
@@ -420,6 +427,7 @@ static int altr_i2c_probe(struct platform_device *pdev)
 	idev->dev = &pdev->dev;
 	init_completion(&idev->msg_complete);
 	spin_lock_init(&idev->lock);
+	mutex_init(&idev->isr_mutex);
 
 	ret = device_property_read_u32(idev->dev, "fifo-size",
 				       &idev->fifo_size);
-- 
2.25.1



