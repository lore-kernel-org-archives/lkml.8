Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741E22073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404978AbgFXQkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:40:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43110 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbgFXQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:40:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jo8RJ-0006cj-Hp; Wed, 24 Jun 2020 16:39:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: avoid null pointer dereference when iface is null
Date:   Wed, 24 Jun 2020 17:39:57 +0100
Message-Id: <20200624163957.11676-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the pointer iface is null then the reporting of this
error will dereference iface when printing an error message causing which
is not ideal.  Since the majority of callers to most_register_interface
report an error when -EINVAL is returned a simple fix is to just remove
the error message, I doubt it will be missed.

Addresses-Coverity: ("Dereference after null check")
Fixes: 57562a72414c ("Staging: most: add MOST driver's core module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/most/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index f781c46cd4af..353ab277cbc6 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1283,10 +1283,8 @@ int most_register_interface(struct most_interface *iface)
 	struct most_channel *c;
 
 	if (!iface || !iface->enqueue || !iface->configure ||
-	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS)) {
-		dev_err(iface->dev, "Bad interface or channel overflow\n");
+	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
 		return -EINVAL;
-	}
 
 	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
 	if (id < 0) {
-- 
2.27.0

