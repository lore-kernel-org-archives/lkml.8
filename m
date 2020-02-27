Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29CAC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920F02467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgB0Juq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:50:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgB0Juq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:50:46 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1j7Foa-0006ms-Av; Thu, 27 Feb 2020 10:50:44 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1j7FoZ-0001JB-N2; Thu, 27 Feb 2020 10:50:43 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvmem: core: don't consider subnodes not matching binding
Date:   Thu, 27 Feb 2020 10:47:29 +0100
Message-Id: <20200227094728.3950-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.25.0
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
Hello,

I am open to other suggestions on how to restrict nvmem from claiming
specific subnodes. I would have preferred a cells { } container, like the
partitons { } container used for MTD partitions, but as we have to stay
backward-compatible anyway, a solution is needed for the current binding
as well.

Cheers,
Ahmad
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1e4a798dce6e..1688287a765f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -271,6 +271,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	parent = dev->of_node;
 
 	for_each_child_of_node(parent, child) {
+		if (!strchr(child->name, '@'))
+			continue;
 		addr = of_get_property(child, "reg", &len);
 		if (!addr || (len < 2 * sizeof(u32))) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
-- 
2.25.0

