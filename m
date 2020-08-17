Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180B922BED
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678857;
	bh=aIdBegmoJqYzGJqA0iO6D/hsXKMLYI+op7SBQVwN0VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uz7l3xtrVsx6djP0Hi7Xua3Q1OzwImgFA/LfbFkNNl4kUQVyABZLm2VrOwaLhuGd8
	 UEHSCxmNJFVpdhZB/k1sh3lJvucOd+MiqRpJwxFuJcHwaDHfetyccs0b5jouDlU255
	 yqiFi7eRdvRO56bSQlGnIdMvd9uWkwnwPsB9ikU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgHQPku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbgHQPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:33:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEDF20882;
        Mon, 17 Aug 2020 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678406;
        bh=aIdBegmoJqYzGJqA0iO6D/hsXKMLYI+op7SBQVwN0VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuvPQUnMKIyvAgo3saioii9q14Nr4H/oEYSnh8Hm8gH7fmB8cDVFGzBQkvG49FecP
         6mlHKEFY2ooc/KQ/4G2eo6v3BwMjPxZXINRvruug+0cuZ1YSvFDExDQiaE7SCyBjhD
         ylMN0b08tAYYqBX4kINDNQFW9XRzE9XmIzTvx/ZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 283/464] MIPS: OCTEON: add missing put_device() call in dwc3_octeon_device_init()
Date:   Mon, 17 Aug 2020 17:13:56 +0200
Message-Id: <20200817143847.311841897@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
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
index 1fd85c559700c..950e6c6e86297 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -518,6 +518,7 @@ static int __init dwc3_octeon_device_init(void)
 
 			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 			if (res == NULL) {
+				put_device(&pdev->dev);
 				dev_err(&pdev->dev, "No memory resources\n");
 				return -ENXIO;
 			}
@@ -529,8 +530,10 @@ static int __init dwc3_octeon_device_init(void)
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



