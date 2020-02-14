Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE70EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703108;
	bh=aubW97k/Xs3s9/rVKeTyIj14taE5kacqXBl/gi0ji2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gufx2u9j17G8T86oodoMsNuZEUmOGaxp4FPQhN/UztNr53Y3Y1fvY4GxDdBc7Pgds
	 4T1KBcVkPcHA14C7uPGnB9gLyGGP/YR7FNCNFf3N0BMQLmGH4ddJOSviJqMRAXjmK6
	 7f4WR5GvpbOVuRYwl1uWKvA4+nNI0kN4tsfIraLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgBNR61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbgBNP5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEFB24688;
        Fri, 14 Feb 2020 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695830;
        bh=aubW97k/Xs3s9/rVKeTyIj14taE5kacqXBl/gi0ji2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YU6dYAJcfbcYDWQrS+IPtnMnzHsq1DPeF3jrAUD6jhb0P6g5ZIv8kUiC01MAw5+ht
         z0W1NgswLw3GYETIboUL16jbnRY7qt1+gRiD9Gaoc9A7fHMlq6ywhrhSvwUcZR+R5b
         JFdzZF3aGXILrS0W8sOv/9/N5ivI2VtcjpOHtrBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Hao <haokexin@gmail.com>, kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 383/542] gpio: Fix the no return statement warning
Date:   Fri, 14 Feb 2020 10:46:15 -0500
Message-Id: <20200214154854.6746-383-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 9c6722d85e92233082da2b3623685bba54d6093e ]

In commit 242587616710 ("gpiolib: Add support for the irqdomain which
doesn't use irq_fwspec as arg") we have changed the return type of
gpiochip_populate_parent_fwspec_twocell/fourcell() from void to void *,
but forgot to add a return statement for these two dummy functions.
Add "return NULL" to fix the build warnings.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Link: https://lore.kernel.org/r/20200116095003.30324-1-haokexin@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e2480ef94c559..5dce9c67a961e 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -553,6 +553,7 @@ static inline void gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *chi
 						    unsigned int parent_hwirq,
 						    unsigned int parent_type)
 {
+	return NULL;
 }
 
 static inline void gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *chip,
@@ -560,6 +561,7 @@ static inline void gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *ch
 						     unsigned int parent_hwirq,
 						     unsigned int parent_type)
 {
+	return NULL;
 }
 
 #endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
-- 
2.20.1

