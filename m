Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E97C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA36206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="nkjpfeD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgDFLcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:32:21 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:40284 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbgDFLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:32:21 -0400
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 8EFA959802A0;
        Mon,  6 Apr 2020 14:32:17 +0300 (MSK)
Received: from iva6-add863d6e49c.qloud-c.yandex.net (iva6-add863d6e49c.qloud-c.yandex.net [2a02:6b8:c0c:7ea0:0:640:add8:63d6])
        by mxback18j.mail.yandex.net (mxback/Yandex) with ESMTP id fq58GT5zVa-WGOSMI2V;
        Mon, 06 Apr 2020 14:32:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1586172737;
        bh=ucsdRRT+zZSKCrcUo+bbn9vGVT94WMNFHwYtuQ4aOdo=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=nkjpfeD1NrlyznWG1s4dpWYU0knd/9uazEY/jrjGtdM0jdYIc61Xhbag4hEliGnyI
         STJL8HAK46Z6jVb3nKduhgGd/FzatvD1mTX3A8e2+tatR+0SWnYswGIS+8w1dqrdOH
         TILdnV2QXTcgHDkX2GVeQnMO9sT2zcOejFbPOzVU=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-add863d6e49c.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CHTIIrjdik-WF2uGgoU;
        Mon, 06 Apr 2020 14:32:15 +0300
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
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] remoteproc: imx_rproc: memory regions
Date:   Mon,  6 Apr 2020 14:33:10 +0300
Message-Id: <20200406113310.3041-4-nikita.shubin@maquefel.me>
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

Add support for carveout memory regions required for vdev vring's and
buffer.

Search in device tree and allocate memory regions like for ocram:

vdev0vring0: vdev0vring0@00920000 {
	compatible = "shared-dma-pool";
        reg = <0x00920000 0x2000>;
        no-map;
};

vdev0vring1: vdev0vring1@00922000 {
	compatible = "shared-dma-pool";
	reg = <0x00922000 0x2000>;
	no-map;
};

vdev0buffer: vdev0buffer@00924000 {
	compatible = "shared-dma-pool";
	reg = <0x00924000 0x4000>;
	no-map;
};

imx7d-cm4 {
	compatible = "fsl,imx7d-cm4";
	memory-region = <&ocram>, <&vdev0vring0>, <&vdev0vring1>, \
		<&vdev0buffer>;
}

vdev0vring0, vdev0vring1, vdev0buffer are required for virtio
functioning.

Signed-off-by: Nikita Shubin <NShubin@topcon.com>
---
 drivers/remoteproc/imx_rproc.c | 119 ++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index d2bede4ccb70..cdcff2bd2867 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
@@ -238,6 +239,29 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	return -ENOENT;
 }
 
+static int imx_rproc_sys_to_da(struct imx_rproc *priv, u64 sys,
+				int len, u64 *da)
+{
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int i;
+
+	/* parse address translation table */
+	for (i = 0; i < dcfg->att_size; i++) {
+		const struct imx_rproc_att *att = &dcfg->att[i];
+
+		if (sys >= att->sa && sys + len <= att->sa + att->size) {
+			unsigned int offset = sys - att->sa;
+
+			*da = att->da + offset;
+			return 0;
+		}
+	}
+
+	dev_warn(priv->dev, "Translation failed: sys = 0x%llx len = 0x%x\n",
+			 sys, len);
+	return -ENOENT;
+}
+
 static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -372,16 +396,109 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 		err = mbox_send_message(ddata->mb[i].chan, &vqid);
 		if (err < 0)
 			dev_err(&rproc->dev, "%s: failed (%s, err:%d)\n",
-					__func__, ddata->mb[i].name, err);
+				__func__, ddata->mb[i].name, err);
 			return;
 	}
 }
 
+static int imx_rproc_mem_alloc(struct rproc *rproc,
+				struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
+	va = ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%x\n",
+				&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int imx_rproc_mem_release(struct rproc *rproc,
+				struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap(mem->va);
+
+	return 0;
+}
+
+static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_iterator it;
+	struct rproc_mem_entry *mem = 0;
+	struct reserved_mem *rmem;
+	u64 da;
+	int index = 0;
+
+	/* Register associated reserved memory regions */
+	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
+	while (of_phandle_iterator_next(&it) == 0) {
+		rmem = of_reserved_mem_lookup(it.node);
+		if (!rmem) {
+			dev_err(dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Let's assume all data in device tree is from
+		 * CPU A7 point of view then we should translate
+		 * rmem->base into M4 da
+		 */
+		if (imx_rproc_sys_to_da(priv, rmem->base, rmem->size, &da)) {
+			dev_err(dev, "memory region not valid %pa\n",
+				&rmem->base);
+			return -EINVAL;
+		}
+
+		if (strcmp(it.node->name, "vdev0buffer")) {
+			/* Register memory region */
+			mem = rproc_mem_entry_init(dev, NULL,
+						(dma_addr_t)rmem->base,
+						rmem->size, da,
+						imx_rproc_mem_alloc,
+						imx_rproc_mem_release,
+						it.node->name);
+
+			if (mem)
+				rproc_coredump_add_segment(rproc, da,
+							rmem->size);
+		} else {
+			mem = rproc_of_resm_mem_entry_init(dev, index,
+							rmem->size,
+							rmem->base,
+							it.node->name);
+		}
+
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+		index++;
+	}
+
+	return rproc_elf_load_rsc_table(rproc, fw);
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.da_to_va	= imx_rproc_da_to_va,
 	.kick		= imx_rproc_kick,
+	.load		= rproc_elf_load_segments,
+	.parse_fw	= imx_rproc_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
-- 
2.25.1

