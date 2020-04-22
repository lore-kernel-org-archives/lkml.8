Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5382073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552252;
	bh=yaliotJxvLNaSp02wuihbJu/1ZddBCwFTwSf8FxJC0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7CPmeqVrNjuZk/v3YEjUCY1gPT8jdeXJHcF2Rs1x1HA2ukp0tCp+SHi6c4Tbav/F
	 kgreN/O9Wz/UW5zX1C1ZUc+VUgU6uhmFT6uf18k4DzUGRDzGuoWClfGzJ9jvE/AjJO
	 FNCAdHksRO3IWdlf8PpHYQVaLkbi6oi1pjXlx0To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgDVKoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgDVKTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF672075A;
        Wed, 22 Apr 2020 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550753;
        bh=yaliotJxvLNaSp02wuihbJu/1ZddBCwFTwSf8FxJC0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrhN0JszQdwiNvO4AdjCeEtuAhX6j/HV0XyIdp2AISnfoMcybtNI5p2bzx8wpie+o
         huHuGnO/bI9Jb98xee3tzJbvq2610mi43tgnkRFzs+123GQvv+WcedzO6D0d01UeFn
         Z2u9DJX3S2PMpOky+aUZirS8aTN3OfAzdKH56Mxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/118] leds: core: Fix warning message when init_data
Date:   Wed, 22 Apr 2020 11:57:18 +0200
Message-Id: <20200422095044.312629308@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 647b1263c5794..d3e83c33783e5 100644
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



