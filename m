Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71223C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A392206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD1LSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD1LSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:18:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374DC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:18:48 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOGE-0000UI-HE; Tue, 28 Apr 2020 13:18:46 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOGE-0007k1-4g; Tue, 28 Apr 2020 13:18:46 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] nvmem: core: skip nodes with compatibles other than "nvmem-cell"
Date:   Tue, 28 Apr 2020 13:18:27 +0200
Message-Id: <20200428111829.2215-3-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428111829.2215-1-a.fatoum@pengutronix.de>
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem cell binding used to apply to all objects which match
"^.*@[0-9a-f]+$", without taking a compatible into account, which
precluded extension of EEPROMs by child nodes other than nvmem.

A previous commit changed the binding, so that nvmem cells that
feature a compatible property must have "nvmem-cell" as the value,
otherwise they are skipped.

Adjust the driver to observe the new binding change. This change
does not change behavior for any device tree that was already
compliant with the nvmem binding.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/nvmem/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 05c6ae4b0b97..eb697f5ad07d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -547,6 +547,10 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	parent = dev->of_node;
 
 	for_each_child_of_node(parent, child) {
+		if (of_find_property(child, "compatible", NULL) &&
+		    !of_device_is_compatible(child, "nvmem-cell"))
+			continue;
+
 		addr = of_get_property(child, "reg", &len);
 		if (!addr || (len < 2 * sizeof(u32))) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
-- 
2.26.2

