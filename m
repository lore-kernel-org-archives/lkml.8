Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52632206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034932;
	bh=3mXHuIbUAn2ZlS3EHaOUlbTu8JdHRMn00oCcVfkK2NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIEqz02gfPJfIq6ETDoL8kmdPzvoN1lBWYlkhHYKi6XqL4Se4BNVLUZyBXK3nIYnJ
	 UYOOTCy0nENL1lINwbVq2squMjL0oLBqGq8Du09po4Q/hhPslaSviYTOj1mq5GlEiE
	 t+545OYRffqLaqHoRbTlyT0qwjrm/QbwHhg751iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgFASIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbgFASIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:08:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EF92068D;
        Mon,  1 Jun 2020 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034926;
        bh=3mXHuIbUAn2ZlS3EHaOUlbTu8JdHRMn00oCcVfkK2NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUdEAOhwG0sittEl/ivrRw3AVsjIx8WYnvx0ixPkTPEyKXAAtdk5o5o3sIlmMa46t
         fFBxAAnS8lAJ0vQ80opl6mwIpXNC1HSvH/rfJZLvjFbJNnXdbJZs4+CvcE3u6tsBwY
         eTSehGxah3IORDn0GGr0fVWyP0JAvuqtSkLHhGd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/142] gpio: exar: Fix bad handling for ida_simple_get error path
Date:   Mon,  1 Jun 2020 19:53:53 +0200
Message-Id: <20200601174045.626573803@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 333830aa149a87cabeb5d30fbcf12eecc8040d2c ]

The commit 7ecced0934e5 ("gpio: exar: add a check for the return value
of ida_simple_get fails") added a goto jump to the common error
handler for ida_simple_get() error, but this is wrong in two ways:
it doesn't set the proper return code and, more badly, it invokes
ida_simple_remove() with a negative index that shall lead to a kernel
panic via BUG_ON().

This patch addresses those two issues.

Fixes: 7ecced0934e5 ("gpio: exar: add a check for the return value of ida_simple_get fails")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-exar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index fae327d5b06e..6890d32d9f25 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -145,8 +145,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	mutex_init(&exar_gpio->lock);
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
-	if (index < 0)
-		goto err_destroy;
+	if (index < 0) {
+		ret = index;
+		goto err_mutex_destroy;
+	}
 
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;
@@ -173,6 +175,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 
 err_destroy:
 	ida_simple_remove(&ida_index, index);
+err_mutex_destroy:
 	mutex_destroy(&exar_gpio->lock);
 	return ret;
 }
-- 
2.25.1



