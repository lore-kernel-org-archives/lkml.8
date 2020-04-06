Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2306D2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="KpnFHusq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDFLcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:32:19 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:39608 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgDFLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:32:18 -0400
Received: from mxback27o.mail.yandex.net (mxback27o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::78])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 1047E67409B6;
        Mon,  6 Apr 2020 14:32:14 +0300 (MSK)
Received: from iva6-add863d6e49c.qloud-c.yandex.net (iva6-add863d6e49c.qloud-c.yandex.net [2a02:6b8:c0c:7ea0:0:640:add8:63d6])
        by mxback27o.mail.yandex.net (mxback/Yandex) with ESMTP id D7Ch6kcz29-WDfWYrPo;
        Mon, 06 Apr 2020 14:32:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1586172734;
        bh=8uEW0zqccUGzY8Atll6dm+xMaA+rH6YNmty2LTtP4t0=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=KpnFHusqtimVXVvdAOK7ru7dkQ/hdhsjfdDLbbXWn2mQNKJIej9BWZS9a8hgG4AKI
         qMQqz//B181cIXDovpv3OxKl2XRQ9vTyTNF4zp6XOxoiRvQifCdlyeQZATMXHNEHBJ
         DTkFS0V11ZOrunF9WxwNf305IQHJmIik/aJ0rAnU=
Authentication-Results: mxback27o.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-add863d6e49c.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CHTIIrjdik-WC2ug4GN;
        Mon, 06 Apr 2020 14:32:12 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   nikita.shubin@maquefel.me
To:     nikita.shubin@maquefel.me
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] remoteproc: imx_rproc: mailbox support
Date:   Mon,  6 Apr 2020 14:33:09 +0300
Message-Id: <20200406113310.3041-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406113310.3041-1-nikita.shubin@maquefel.me>
References: <20200304142628.8471-1-NShubin@topcon.com>
 <20200406113310.3041-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mailboxes to imx_rproc

Signed-off-by: Nikita Shubin <NShubin@topcon.com>
---
 drivers/remoteproc/Kconfig     |   2 +
 drivers/remoteproc/imx_rproc.c | 142 ++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 94afdde4bc9f..02d23a54c9cf 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -17,6 +17,8 @@ if REMOTEPROC
 config IMX_REMOTEPROC
 	tristate "IMX6/7 remoteproc support"
 	depends on ARCH_MXC
+	select MAILBOX
+	select IMX_MBOX
 	help
 	  Say y here to support iMX's remote processors (Cortex M4
 	  on iMX7D) via the remote processor framework.
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index bebc58d0f711..d2bede4ccb70 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -14,6 +14,9 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <linux/mailbox_client.h>
+
+#include "remoteproc_internal.h"
 
 #define IMX7D_SRC_SCR			0x0C
 #define IMX7D_ENABLE_M4			BIT(3)
@@ -47,6 +50,12 @@
 
 #define IMX_BOOT_PC			0x4
 
+#define IMX_MBOX_NB_VQ			2
+#define IMX_MBOX_NB_MBX		2
+
+#define IMX_MBX_VQ0		"vq0"
+#define IMX_MBX_VQ1		"vq1"
+
 /**
  * struct imx_rproc_mem - slim internal memory structure
  * @cpu_addr: MPU virtual address of the memory region
@@ -80,6 +89,14 @@ struct imx_rproc_dcfg {
 	size_t				att_size;
 };
 
+struct imx_mbox {
+	const unsigned char name[10];
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	struct work_struct vq_work;
+	int vq_id;
+};
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -88,6 +105,8 @@ struct imx_rproc {
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
 	void __iomem			*bootreg;
+	struct imx_mbox mb[IMX_MBOX_NB_MBX];
+	struct workqueue_struct *workqueue;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
@@ -251,10 +270,118 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return va;
 }
 
+static void imx_rproc_mb_vq_work(struct work_struct *work)
+{
+	struct imx_mbox *mb = container_of(work, struct imx_mbox, vq_work);
+	struct rproc *rproc = dev_get_drvdata(mb->client.dev);
+
+	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
+		dev_dbg(&rproc->dev, "no message found in vq%d\n", mb->vq_id);
+}
+
+static void imx_rproc_mb_callback(struct mbox_client *cl, void *data)
+{
+	struct rproc *rproc = dev_get_drvdata(cl->dev);
+	struct imx_mbox *mb = container_of(cl, struct imx_mbox, client);
+	struct imx_rproc *ddata = rproc->priv;
+
+	queue_work(ddata->workqueue, &mb->vq_work);
+}
+
+static const struct imx_mbox imx_rproc_mbox[IMX_MBOX_NB_MBX] = {
+	{
+		.name = IMX_MBX_VQ0,
+		.vq_id = 0,
+		.client = {
+			.rx_callback = imx_rproc_mb_callback,
+			.tx_block = false,
+		},
+	},
+	{
+		.name = IMX_MBX_VQ1,
+		.vq_id = 1,
+		.client = {
+			.rx_callback = imx_rproc_mb_callback,
+			.tx_block = false,
+		},
+	},
+};
+
+static void imx_rproc_request_mbox(struct rproc *rproc)
+{
+	struct imx_rproc *ddata = rproc->priv;
+	struct device *dev = &rproc->dev;
+	unsigned int i;
+	const unsigned char *name;
+	struct mbox_client *cl;
+
+	/* Initialise mailbox structure table */
+	memcpy(ddata->mb, imx_rproc_mbox, sizeof(imx_rproc_mbox));
+
+	for (i = 0; i < IMX_MBOX_NB_MBX; i++) {
+		name = ddata->mb[i].name;
+
+		cl = &ddata->mb[i].client;
+		cl->dev = dev->parent;
+
+		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
+
+		dev_dbg(dev, "%s: name=%s, idx=%u\n",
+			__func__, name, ddata->mb[i].vq_id);
+
+		if (IS_ERR(ddata->mb[i].chan)) {
+			dev_warn(dev, "cannot get %s mbox\n", name);
+			ddata->mb[i].chan = NULL;
+		}
+
+		if (ddata->mb[i].vq_id >= 0)
+			INIT_WORK(&ddata->mb[i].vq_work, imx_rproc_mb_vq_work);
+	}
+}
+
+static void imx_rproc_free_mbox(struct rproc *rproc)
+{
+	struct imx_rproc *ddata = rproc->priv;
+	unsigned int i;
+
+	dev_dbg(&rproc->dev, "%s: %d boxes\n",
+		__func__, ARRAY_SIZE(ddata->mb));
+
+	for (i = 0; i < ARRAY_SIZE(ddata->mb); i++) {
+		if (ddata->mb[i].chan)
+			mbox_free_channel(ddata->mb[i].chan);
+		ddata->mb[i].chan = NULL;
+	}
+}
+
+static void imx_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct imx_rproc *ddata = rproc->priv;
+	unsigned int i;
+	int err;
+
+	if (WARN_ON(vqid >= IMX_MBOX_NB_VQ))
+		return;
+
+	for (i = 0; i < IMX_MBOX_NB_MBX; i++) {
+		if (vqid != ddata->mb[i].vq_id)
+			continue;
+		if (!ddata->mb[i].chan)
+			return;
+		dev_dbg(&rproc->dev, "sending message : vqid = %d\n", vqid);
+		err = mbox_send_message(ddata->mb[i].chan, &vqid);
+		if (err < 0)
+			dev_err(&rproc->dev, "%s: failed (%s, err:%d)\n",
+					__func__, ddata->mb[i].name, err);
+			return;
+	}
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.da_to_va	= imx_rproc_da_to_va,
+	.kick		= imx_rproc_kick,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
@@ -384,14 +511,26 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
+	priv->workqueue = create_workqueue(dev_name(dev));
+	if (!priv->workqueue) {
+		dev_err(dev, "cannot create workqueue\n");
+		ret = -ENOMEM;
+		goto err_put_clk;
+	}
+
+	imx_rproc_request_mbox(rproc);
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
-		goto err_put_clk;
+		goto err_free_mb;
 	}
 
 	return 0;
 
+err_free_mb:
+	imx_rproc_free_mbox(rproc);
+	destroy_workqueue(priv->workqueue);
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
 err_put_rproc:
@@ -407,6 +546,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
+	imx_rproc_free_mbox(rproc);
 	rproc_free(rproc);
 
 	return 0;
-- 
2.25.1

