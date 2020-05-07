Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20736C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067002073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgEGPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgEGPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:09:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jWi6u-0008H6-Py; Thu, 07 May 2020 15:06:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: most: usb: sanity check channel before using it as an index into arrays
Date:   Thu,  7 May 2020 16:06:52 +0100
Message-Id: <20200507150652.52238-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently channel is being sanity checked after it has been used as
an index into some arrays. Fix this by moving the sanity check of
channel before the arrays are indexed with it.

Addresses-Coverity: ("Negative array index read")
Fixes: 59ed0480b950 ("Staging: most: replace pr_*() functions by dev_*()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/most/usb/usb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
index b31a49c37f7f..24ebd3071380 100644
--- a/drivers/staging/most/usb/usb.c
+++ b/drivers/staging/most/usb/usb.c
@@ -664,11 +664,6 @@ static int hdm_configure_channel(struct most_interface *iface, int channel,
 	struct most_dev *mdev = to_mdev(iface);
 	struct device *dev = &mdev->usb_device->dev;
 
-	mdev->is_channel_healthy[channel] = true;
-	mdev->clear_work[channel].channel = channel;
-	mdev->clear_work[channel].mdev = mdev;
-	INIT_WORK(&mdev->clear_work[channel].ws, wq_clear_halt);
-
 	if (!conf) {
 		dev_err(dev, "Bad config pointer.\n");
 		return -EINVAL;
@@ -677,6 +672,12 @@ static int hdm_configure_channel(struct most_interface *iface, int channel,
 		dev_err(dev, "Channel ID out of range.\n");
 		return -EINVAL;
 	}
+
+	mdev->is_channel_healthy[channel] = true;
+	mdev->clear_work[channel].channel = channel;
+	mdev->clear_work[channel].mdev = mdev;
+	INIT_WORK(&mdev->clear_work[channel].ws, wq_clear_halt);
+
 	if (!conf->num_buffers || !conf->buffer_size) {
 		dev_err(dev, "Misconfig: buffer size or #buffers zero.\n");
 		return -EINVAL;
-- 
2.25.1

