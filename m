Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C94DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0921206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406525AbgFYRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:02:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38688 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbgFYRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:02:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5759A2A5736
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_spi: Document missing function parameters
Date:   Thu, 25 Jun 2020 19:02:41 +0200
Message-Id: <20200625170241.224780-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects all kernel function members to be documented.

Fixes the following W=1 level warnings:

  cros_ec_spi.c:153: warning: Function parameter or member 'ec_dev' not described in 'receive_n_bytes'
  cros_ec_spi.c:153: warning: Function parameter or member 'buf' not described in 'receive_n_bytes'
  cros_ec_spi.c:153: warning: Function parameter or member 'n' not described in 'receive_n_bytes'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index f7cf7c6a04507..d17f5c74ae976 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -148,6 +148,10 @@ static int terminate_request(struct cros_ec_device *ec_dev)
  * receive_n_bytes - receive n bytes from the EC.
  *
  * Assumes buf is a pointer into the ec_dev->din buffer
+ *
+ * @ec_dev: ChromeOS EC device.
+ * @buf: Pointer to the buffer receiving the data.
+ * @n: Number of bytes received.
  */
 static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
 {
-- 
2.27.0

