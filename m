Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05E2C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE4920838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X0a4/JKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:07:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgBJTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:07:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so4379994pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wXKXGly1PMIFo4PH4r9KP7MD5EVde6Oh8xOIxa8LfU=;
        b=X0a4/JKOhli8X/KeJCnZa8Hz+PTgCswHgRwy0C4ZGbO0LnVANWm+XoawNSIduFVH1Y
         j0LgzYRWnzencGlWIB97hp+s5kg4N45J9vR0exzze91M3f/0/yqPnKeuZxi2u2pVs7vC
         b0I1EUFrUddASr4ED0FWDBb8y9SNBwnrqaUj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wXKXGly1PMIFo4PH4r9KP7MD5EVde6Oh8xOIxa8LfU=;
        b=V7s2G2E2mHVIwIDpOR7m0ir8JQ71tOPy6UOH3d1OmULCIxhb/jgnW+AoLX1k+PImTS
         g0PXWMx3MdlOcAggTfwOnHwCU3aKvxuzIN7rGVJPG/TjetT6KRLi6E2SJQ8cXeC4cNo0
         J5fBq9ZNTx53FTqWEshHEYA8lhMNwkmFqAjAfv8Tum+dA5iT+ZskOPg1D8YT2zzIf/Et
         BlNlOuLvG5mjaOXj5pnewE40Zh1YOqxwhZLg4UlZMoRZhB2lE4vt9aeR2eOTMeudpR2f
         F1nbH79Vv/tCjBngHdSFD1ZZmcmgvFMElkLZlTGzBv98lEvnKROe+aTRPuiyleGgbcUR
         FF8A==
X-Gm-Message-State: APjAAAUZnK9MXdZycUslusdX0PwmUgkNCPRY4+jHdtafnFUsW7S+PMJL
        eFfCkQSl4QpId9BulJiQ2jkbwedNeII=
X-Google-Smtp-Source: APXvYqzCX4kvbqBO59/kezp3MhWwFQ7LA6iCNggX4v5e8KzVFfF6HGmB4zDnK4Z7r8a7SW1SMXJIPQ==
X-Received: by 2002:a62:7c49:: with SMTP id x70mr2376068pfc.200.1581361670669;
        Mon, 10 Feb 2020 11:07:50 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q6sm1118102pfh.127.2020.02.10.11.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:07:49 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH RESEND] mfd: cros_ec: Check DT node for usbpd-notify add
Date:   Mon, 10 Feb 2020 11:06:24 -0800
Message-Id: <20200210190623.18543-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to ensure there is indeed an EC device tree entry before
adding the cros-usbpd-notify device. This covers configs where both
CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
using device tree and not in ACPI.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Fixes: 4602dce0361e ("mfd: cros_ec: Add cros-usbpd-notify subdevice")
---

This patch was originally part 3/4 of a series for the Chrome OS EC
USBPD notify driver:
 https://patchwork.kernel.org/patch/11351271/

Resending this patch since the dependent components have been merged
into the upstream master tree or an immutable staging branch:
- Patches 1/4 and 4/4 of the original series have been included in
  the platform/chrome maintainer's immutable staging branch:
      https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=ib-chrome-platform-power-supply-cros-usbpd-notify
- Patch 2/4 has been merged to the mainline kernel as
  commit 4602dce0361ebc67b9bfbed9338eee588e3c7e7e.


Changes in RESEND:
- No changes.

Changes in v8:
- Patch first introduced in v8 of the series.

 drivers/mfd/cros_ec_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 39e61169505362..32c2b912b58b25 100644
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
2.25.0.341.g760bfbb309-goog

