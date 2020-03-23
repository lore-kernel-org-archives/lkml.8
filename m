Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288F920409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCWP36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:29:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36175 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:29:57 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jGP1X-00020E-7M; Mon, 23 Mar 2020 16:29:55 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jGP1W-00007c-JR; Mon, 23 Mar 2020 16:29:54 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, Christian Eggers <CEggers@arri.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: core: don't consider subnodes not matching binding
Date:   Mon, 23 Mar 2020 16:28:50 +0100
Message-Id: <20200323152850.32657-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.25.1
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

The nvmem cell binding applies to objects which match "^.*@[0-9a-f]+$",
but so far the driver has matched all objects and failed if they didn't
have the expected properties.

The driver's behavior in this regard precludes future extension of
EEPROMs by child nodes other than nvmem and clashes with the barebox
bootloader binding that extends the fixed-partitions MTD binding to
EEPROMs as it tries to interpret the "fixed-partitions"-compatible
partitions node as a nvmem cell.

Solve this issue by skipping all subnodes that don't contain an @.

This still allows for cell names like `partitions@0,0', but this
is much less likely to cause future collisions.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  use ->full_name instead of ->name as to not break existing correct
  cells (Christian)
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243f36..f051051fb1a8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -278,6 +278,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	parent = dev->of_node;
 
 	for_each_child_of_node(parent, child) {
+		if (!strchr(kbasename(child->full_name), '@'))
+			continue;
 		addr = of_get_property(child, "reg", &len);
 		if (!addr || (len < 2 * sizeof(u32))) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
-- 
2.25.1

