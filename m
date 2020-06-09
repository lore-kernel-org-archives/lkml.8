Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0EB20823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RyP9JX2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgFIMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:47:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54182 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFIMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:46:23 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F19D1227;
        Tue,  9 Jun 2020 14:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591706778;
        bh=7whrIeN77UWRmsTr1S+zsP7M0XhqPGZPPuqIh/7NIH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyP9JX2MWv5mksB6QTdQ5K3EngDF2sSHwmOzAq+oRaA5vcfl53GHpfar2IbXC9lHx
         FbYFXeOJO/xriftHoBcRIKlK4HuZ+NBv++xrH2kP71jrPdspofYEwtmhgWPocS/Qkg
         xA0gRZTcyT3x+6oGZR3prnmqLH9YLCudeFX95FY4=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jiri Kosina <trivial@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/17] drivers: gpio: Fix trivial spelling
Date:   Tue,  9 Jun 2020 13:45:56 +0100
Message-Id: <20200609124610.3445662-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpio/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index b989c9352da2..e560e45e84f8 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -5,7 +5,7 @@ subsystem.
 GPIO descriptors
 
 Starting with commit 79a9becda894 the GPIO subsystem embarked on a journey
-to move away from the global GPIO numberspace and toward a decriptor-based
+to move away from the global GPIO numberspace and toward a descriptor-based
 approach. This means that GPIO consumers, drivers and machine descriptions
 ideally have no use or idea of the global GPIO numberspace that has/was
 used in the inception of the GPIO subsystem.
-- 
2.25.1

