Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB0C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1ED2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858782;
	bh=9V3jjgTzpelnI6wTA+g02EGTVUqj+7Cr04JWKXdlAQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QRiiR7UeEbvTL9Sl03GT9ZoZ14Y0wfLvZwNuWVD4xewWNSh22Ct8kg2KPfp9i1BhH
	 sFDd3vRUIFAQHQ2xRomDu5HrtpoYZrI/Aj26Y46BcWxkUY78WGSgiYeLQGeJbnni4H
	 TZOM9fv68Z5JDyabW772a13eTalf8lmsCSgMXIbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgG0OGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0OGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:06:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA352073E;
        Mon, 27 Jul 2020 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858781;
        bh=9V3jjgTzpelnI6wTA+g02EGTVUqj+7Cr04JWKXdlAQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbSV2YK+BV/jqVGp2XpKeCqC/p5AOqaBBPIluwbi/GsAURAYnejS2vWOiWtekyDX+
         q/yWM1nGmqzhCQdR+R5TjKoIZ3kruLRWhkAxWcR6C4SfZsysfa0xC565FCTZcHBYc5
         e3Y9Cp/8uc9U9tTTKjJ2/szaCE0T9prnOLK6Loao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/64] gpio: arizona: handle pm_runtime_get_sync failure case
Date:   Mon, 27 Jul 2020 16:03:40 +0200
Message-Id: <20200727134911.103438365@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit e6f390a834b56583e6fc0949822644ce92fbb107 ]

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200605025207.65719-1-navid.emamdoost@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-arizona.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index d4e6ba0301bc3..e09834b91ea52 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -111,6 +111,7 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
 		ret = pm_runtime_get_sync(chip->parent);
 		if (ret < 0) {
 			dev_err(chip->parent, "Failed to resume: %d\n", ret);
+			pm_runtime_put(chip->parent);
 			return ret;
 		}
 	}
-- 
2.25.1



