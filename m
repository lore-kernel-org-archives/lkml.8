Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1BEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AE320767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955484;
	bh=uJOLIfl4FKvP8Jesaa0wKyt+zFZumfqh+bE3cWD19U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gA82aVwiu95I0Orf20EXmIK5Zry2rMeld9yzqqbzmljiaknUS7PfJT82zfSKXKpNj
	 BobdNvuQcEkyebjd1A4+ygZqj468q9s631RlrBYhQCdX6PIQFbDwQ/W7pFrYHfeqY1
	 gh91EtfJqA9uQJwZj6qQZ/eD9d77m0SU49f+RviY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505624AbgDOM57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408899AbgDOLgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BBE21556;
        Wed, 15 Apr 2020 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950610;
        bh=uJOLIfl4FKvP8Jesaa0wKyt+zFZumfqh+bE3cWD19U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rulmA085Y240As+2+iMoV+20XFEGnYj8TI4R5xhIegwOylwNx49ByLZMRlsDPUx1O
         2XJLkXOZFtZhpuU8JBBPvJKXBNe49j+bq9LJXWgBZX5R7AWx/Ezeo61KpWCaL4C6Ba
         ddf79Z0w+87Ow+kfCBFXKj9xvvcFlQrfD+xIG7Ho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 104/129] mfd: cros_ec: Check DT node for usbpd-notify add
Date:   Wed, 15 Apr 2020 07:34:19 -0400
Message-Id: <20200415113445.11881-104-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

[ Upstream commit f8db89d14efb770dd59aa0ca74386e5de68310d5 ]

Add a check to ensure there is indeed an EC device tree entry before
adding the cros-usbpd-notify device. This covers configs where both
CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
using device tree and not in ACPI.

Fixes: 4602dce0361e ("mfd: cros_ec: Add cros-usbpd-notify subdevice")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/cros_ec_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 39e6116950536..32c2b912b58b2 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -211,7 +211,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * explicitly added on platforms that don't have the PD notifier ACPI
 	 * device entry defined.
 	 */
-	if (IS_ENABLED(CONFIG_OF)) {
+	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
 		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
 			retval = mfd_add_hotplug_devices(ec->dev,
 					cros_usbpd_notify_cells,
-- 
2.20.1

