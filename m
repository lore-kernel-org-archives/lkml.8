Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1093CC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61CA20659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBTP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:59:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgBTP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 122CC29519F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 7/8] platform/chrome: cros_ec: Use cros_ec_cmd_xfer_status helper
Date:   Thu, 20 Feb 2020 16:58:58 +0100
Message-Id: <20200220155859.906647-8-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer(). In this case the change is trivial and the only
reason to do it is because we want to make cros_ec_cmd_xfer() a private
function for the EC protocol and let people only use the
cros_ec_cmd_xfer_status() to return Linux standard error codes.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6fc8f2c3ac51..e179411bdfbe 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -120,7 +120,7 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 
 	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
 
-	ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
+	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
 
 	/* For now, report failure to transition to S0ix with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-- 
2.25.0

