Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F842C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BD42076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgFWCw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731981AbgFWCvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9057EB1A6;
        Tue, 23 Jun 2020 02:51:42 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 27/29] nvmem: core: Grammar fixes for help text
Date:   Tue, 23 Jun 2020 04:51:04 +0200
Message-Id: <20200623025106.31273-28-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's "an unsigned" but "a U".
Similarly, "an entry" but "a binary entry".

While at it, also drop superfluous articles for negative and zero.

Fixes: 8b977c5498b8 ("nvmem: core: add nvmem_cell_read_u64")
Fixes: 0a9b2d1ce422 ("nvmem: core: add nvmem_cell_read_u16")
Fixes: d026d70a2e94 ("nvmem: core: Add nvmem_cell_read_u32")
Fixes: f1f50eca5f90 ("nvmem: Introduce devm_nvmem_(un)register()")
Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 In theory, for clean backports this would need to be split into 5 pieces...
 Not sure whether anyone would actually do that for help text?
 Dropping the Fixes headers might be an alternative.
 
 v2: New
 
 drivers/nvmem/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fc480d636be2..95bed31391cd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -573,7 +573,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
- * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
  *
  * @config: nvmem device configuration with which nvmem device is created.
  *
@@ -728,7 +728,7 @@ static void devm_nvmem_release(struct device *dev, void *res)
 /**
  * devm_nvmem_register() - Register a managed nvmem device for given
  * nvmem_config.
- * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
  *
  * @dev: Device that uses the nvmem device.
  * @config: nvmem device configuration with which nvmem device is created.
@@ -772,7 +772,7 @@ static int devm_nvmem_match(struct device *dev, void *res, void *data)
  * @dev: Device that uses the nvmem device.
  * @nvmem: Pointer to previously registered nvmem device.
  *
- * Return: Will be an negative on error or a zero on success.
+ * Return: Will be negative on error or zero on success.
  */
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
@@ -1375,7 +1375,7 @@ static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 }
 
 /**
- * nvmem_cell_read_u16() - Read a cell value as an u16
+ * nvmem_cell_read_u16() - Read a cell value as a u16
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
@@ -1390,7 +1390,7 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
 
 /**
- * nvmem_cell_read_u32() - Read a cell value as an u32
+ * nvmem_cell_read_u32() - Read a cell value as a u32
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
@@ -1405,7 +1405,7 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
 /**
- * nvmem_cell_read_u64() - Read a cell value as an u64
+ * nvmem_cell_read_u64() - Read a cell value as a u64
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
-- 
2.26.2

