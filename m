Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD612067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918293;
	bh=xjcrObf4mN7gNPTFMw+wXKdHvmzDyVR5jK6iKPHu5FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6z95Tg0mPiTVN7g+tg+nQY4h+8F17QA72aX8/QfBLAANf1fwCKTaBDA7Bg14920m
	 j4iqqMT1s/4Ob/1Xtr+5tyNXqSdOV4alMzsqEkmEtZqUuqRSdYDT7aYWB1PFxSbkId
	 sa0bABGL6RdKJAF831em4mp85gpK7SeS9Ojmj9rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgHTKLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbgHTKLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:11:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A05206DA;
        Thu, 20 Aug 2020 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918276;
        bh=xjcrObf4mN7gNPTFMw+wXKdHvmzDyVR5jK6iKPHu5FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cebYvtTzFOOcdOjZ2VcC4Ahkz3xBYTc+hM3nsYXcIY85xa2lt2sQ0V9Q1/blhxVuN
         jP22TrFXWyQP9w0cExVM7zxE69ASEkaZ92LLTkJwXxlf7G0RZ1lnnqpStdWlWGxqt/
         r5wYXYiu90KbfDJh3XFxDzRMadcnnDLdN1MQSfuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 113/228] MIPS: OCTEON: add missing put_device() call in dwc3_octeon_device_init()
Date:   Thu, 20 Aug 2020 11:21:28 +0200
Message-Id: <20200820091613.242981944@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e8b9fc10f2615b9a525fce56981e40b489528355 ]

if of_find_device_by_node() succeed, dwc3_octeon_device_init() doesn't have
a corresponding put_device(). Thus add put_device() to fix the exception
handling for this function implementation.

Fixes: 93e502b3c2d4 ("MIPS: OCTEON: Platform support for OCTEON III USB controller")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/cavium-octeon/octeon-usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index bfdfaf32d2c49..75189ff2f3c78 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -517,6 +517,7 @@ static int __init dwc3_octeon_device_init(void)
 
 			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 			if (res == NULL) {
+				put_device(&pdev->dev);
 				dev_err(&pdev->dev, "No memory resources\n");
 				return -ENXIO;
 			}
@@ -528,8 +529,10 @@ static int __init dwc3_octeon_device_init(void)
 			 * know the difference.
 			 */
 			base = devm_ioremap_resource(&pdev->dev, res);
-			if (IS_ERR(base))
+			if (IS_ERR(base)) {
+				put_device(&pdev->dev);
 				return PTR_ERR(base);
+			}
 
 			mutex_lock(&dwc3_octeon_clocks_mutex);
 			dwc3_octeon_clocks_start(&pdev->dev, (u64)base);
-- 
2.25.1



