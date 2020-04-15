Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C852AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EA120737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954509;
	bh=GXGSjA7NBdSmlJIINRF+Qb+9W7TC8itEn3s06VY5gPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IMfu8ZTxFtOEmsdd4YlZy4IyBpHkvmxK7vnljUoUAhIPWmIHNivpwEexSgBmR0n+n
	 xAXWmQQnIsn9MJJwQ2ESWku7lxVLVcaYiCk4vzWftqrIMyiMyvMxgCZCyN1z7Xn+z8
	 61yic1YTh75oJLwCz3rtJk/pQJYBcaDxG/Y6koyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370008AbgDOMlr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409046AbgDOLn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:43:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B3F20775;
        Wed, 15 Apr 2020 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951036;
        bh=GXGSjA7NBdSmlJIINRF+Qb+9W7TC8itEn3s06VY5gPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHzZ5gD4oggPaqTdvxm1MArkNm+vEviVCy8BgyEOLtU51AWJ3ztDQqP95F67seA7d
         QoL1WMRP3djO4zcFrVcB5uTPkTfyh6WCK40S9CDEFaiZ2Zxr2W7REncMKdLHq7xjlU
         uRXtiuucug2hj8M80DKgNWTkN1v8TDP/kSktOm+4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 073/106] leds: core: Fix warning message when init_data
Date:   Wed, 15 Apr 2020 07:41:53 -0400
Message-Id: <20200415114226.13103-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ribalda@kernel.org>

[ Upstream commit 64ed6588c2ea618d3f9ca9d8b365ae4c19f76225 ]

The warning message when a led is renamed due to name collition can fail
to show proper original name if init_data is used. Eg:

[    9.073996] leds-gpio a0040000.leds_0: Led (null) renamed to red_led_1 due to name collision

Fixes: bb4e9af0348d ("leds: core: Add support for composing LED class device names")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 438774315e6c4..183de3cf6ef68 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -281,7 +281,7 @@ int led_classdev_register_ext(struct device *parent,
 
 	if (ret)
 		dev_warn(parent, "Led %s renamed to %s due to name collision",
-				led_cdev->name, dev_name(led_cdev->dev));
+				proposed_name, dev_name(led_cdev->dev));
 
 	if (led_cdev->flags & LED_BRIGHT_HW_CHANGED) {
 		ret = led_add_brightness_hw_changed(led_cdev);
-- 
2.20.1

