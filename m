Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B03C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334B3206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="bWBROmv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgCOQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:34:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64744 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgCOQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:34:37 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gQ4p54xLzw;
        Sun, 15 Mar 2020 17:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584290075; bh=oF4fToN7nP/Zl85lCuxvHIXhKDtSv8yMR5bAdcpMjlg=;
        h=Date:From:Subject:To:Cc:From;
        b=bWBROmv9TBek8zS/v/acljGFwo/1L5vHK3J1DnRI6uI+IFICD7RKon8T9RgF8vxAX
         KgfaK0CNDrJfA1DK6Ea3y9iDGUjOrHeIeC3evDRK456t7lioso/olWxoUfso58ig1z
         cK6UloUsJ9f6/ykcPsYxTROkdQsTf7fWAM6o4Fi77mKa9qWLlTJZYsOy0DT2rEZqLG
         Uj7uEysdUHuntODAuySAUjdzjZ2y75gwegBvR4HJwG89b6am+sQyOLy3bCM5Yb/G17
         9nQvHrMpLKTj1ewBe3O1Dmdl9NVuy6ruw0qvpelNDwSVjj+7pwhGC5iCBkIhw/3eXu
         9UPgLOvjqtXWw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 17:34:34 +0100
Message-Id: <64270a8cc4bfca77ef4e280e5ab4623f4525ff39.1584290011.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] gpiolib: gpio_name_to_desc: factor out !name check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since name == NULL can't ever match, move the check out of
IRQ-disabled region.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/gpio/gpiolib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 175c6363cf61..20fbeffbdd91 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -301,6 +301,9 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 	struct gpio_device *gdev;
 	unsigned long flags;
 
+	if (!name)
+		return NULL;
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
@@ -309,7 +312,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 		for (i = 0; i != gdev->ngpio; ++i) {
 			struct gpio_desc *desc = &gdev->descs[i];
 
-			if (!desc->name || !name)
+			if (!desc->name)
 				continue;
 
 			if (!strcmp(desc->name, name)) {
-- 
2.20.1

