Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E020AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4142072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218130;
	bh=bZEy0wfqUW4qgDCnKRR5qhgh4FTE7JLaUDFBxS9Am/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGGeMdVSB5ha5yKV8cTDpW821rFbzX6eNm09USdFjJYjVM+ABr8jLotsvxLCqEopW
	 MVlg0q4tertmfOviT7R0i2H2gxdGTIBko2yEOm327NolGE4slwLnG+L0YNhTQF3zoz
	 m5CtrbegisrRReG+U/xieqPtiN23EKnM3QTpfV2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgAPX0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbgAPX0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:26:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D102072B;
        Thu, 16 Jan 2020 23:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217183;
        bh=bZEy0wfqUW4qgDCnKRR5qhgh4FTE7JLaUDFBxS9Am/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+hQgsWpu+NFQDhunRrcuVyCq0TlW3sOE66ubP188Jk+IqdCY6qIDvRBGZw1uRkI7
         n956K6FyNpNaKtbLZptNmtoZHOXcga7KHYr/Jm5jRu1QJZBkQOvOCBthy3Aw03GtG5
         Q8zx3uywZ3MP+RkaIF0ZpmSUXei+tU7gKqKHi8Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johnson Chen <johnsonch.chen@moxa.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 181/203] gpio: mpc8xxx: Add platform device to gpiochip->parent
Date:   Fri, 17 Jan 2020 00:18:18 +0100
Message-Id: <20200116231800.216930758@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johnson CH Chen (陳昭勳) <JohnsonCH.Chen@moxa.com>

[ Upstream commit 322f6a3182d42df18059a89c53b09d33919f755e ]

Dear Linus Walleij,

In old kernels, some APIs still try to use parent->of_node from struct gpio_chip,
and it could be resulted in kernel panic because parent is NULL. Adding platform
device to gpiochip->parent can fix this problem.

Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
Link: https://patchwork.kernel.org/patch/11234609
Link: https://lore.kernel.org/r/HK0PR01MB3521489269F76467DFD7843FFA450@HK0PR01MB3521.apcprd01.prod.exchangelabs.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index a031cbcdf6ef..d72a3a5507b0 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -346,6 +346,7 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gc = &mpc8xxx_gc->gc;
+	gc->parent = &pdev->dev;
 
 	if (of_property_read_bool(np, "little-endian")) {
 		ret = bgpio_init(gc, &pdev->dev, 4,
-- 
2.20.1



