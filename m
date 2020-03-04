Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8653BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2720866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Y0dDF7rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgCDOZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:25:36 -0500
Received: from forward103j.mail.yandex.net ([5.45.198.246]:60300 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbgCDOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:25:36 -0500
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 8C8F06740CBB;
        Wed,  4 Mar 2020 17:25:32 +0300 (MSK)
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 87464CF40016;
        Wed,  4 Mar 2020 17:25:32 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id UCXxzZegUE-PVous9Uk;
        Wed, 04 Mar 2020 17:25:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1583331932;
        bh=Jng1nEj1zbxMUGN9K/Xjwz4cFmbLujsZJxv+9sN+qAg=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=Y0dDF7rKpb4+QNQNIAI98jMiP86mMDuVOZfHeceea3AJcf2ji3FFCHzWbNZEgI/w0
         RgLFBNe68h8LFeo1xcZGJMEdGCCH3OETtgRxicMb3csdQWnFyrzAE9j5AzwUWcykdi
         uVuoaB/FkBz45olpZs4yKqu3SD4fF3BtljG0IN1U=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id OSNMAAdVGo-PU3OCmWJ;
        Wed, 04 Mar 2020 17:25:30 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <NShubin@topcon.com>
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: imx_rproc: set pc on start
Date:   Wed,  4 Mar 2020 17:26:28 +0300
Message-Id: <20200304142628.8471-2-NShubin@topcon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304142628.8471-1-NShubin@topcon.com>
References: <20200304142628.8471-1-NShubin@topcon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case elf file interrupt vector is not supposed to be at OCRAM_S,
it is needed to write elf entry point to OCRAM_S + 0x4, to boot M4
firmware.

Otherwise firmware located anywhere besides OCRAM_S won't boot.

The firmware must set stack poiner as first instruction:

Reset_Handler:
    ldr   sp, = __stack      /* set stack pointer */

Signed-off-by: Nikita Shubin <NShubin@topcon.com>
---
 drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 796b6b86550a..d02007f05ebd 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -45,6 +45,8 @@
 
 #define IMX7D_RPROC_MEM_MAX		8
 
+#define IMX_BOOT_PC			0x4
+
 /**
  * struct imx_rproc_mem - slim internal memory structure
  * @cpu_addr: MPU virtual address of the memory region
@@ -85,6 +87,7 @@ struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
+	void __iomem			*bootreg;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
@@ -162,11 +165,16 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	int ret;
 
+	/* write entry point to program counter */
+	writel(rproc->bootaddr, priv->bootreg);
+
 	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
 				 dcfg->src_mask, dcfg->src_start);
 	if (ret)
 		dev_err(dev, "Failed to enable M4!\n");
 
+	dev_info(&rproc->dev, "Started from 0x%x\n", rproc->bootaddr);
+
 	return ret;
 }
 
@@ -182,6 +190,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 	if (ret)
 		dev_err(dev, "Failed to stop M4!\n");
 
+	/* clear entry points */
+	writel(0, priv->bootreg);
+
 	return ret;
 }
 
@@ -366,6 +377,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
+	priv->bootreg = imx_rproc_da_to_va(rproc, IMX_BOOT_PC, sizeof(u32));
+
 	/*
 	 * clk for M4 block including memory. Should be
 	 * enabled before .start for FW transfer.
-- 
2.24.1

