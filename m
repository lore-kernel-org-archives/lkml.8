Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3426B20DD4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592348646;
	bh=TIZiaa/qDG3AaJk/HXXgqxxOEvJw9NmOoxWKs8Y4cmw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qDJX5U+ySIjEg8LM5rxQO/HTSaTnIpmmOdaCwggmZW3hNJSgkdjXzXJaQppXn0Hcu
	 0kwsUksZjpxDax8Kea+V/lJ7i+UKE2DsBk65nSKFmhJ1tZ6CLQtSMmKsjMruBI57jd
	 zKDT0HfZCn8e1+gQCipvFfJpNw2uDKLEHUzWh33k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFPXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:04:04 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B59E20B80;
        Tue, 16 Jun 2020 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592348644;
        bh=TIZiaa/qDG3AaJk/HXXgqxxOEvJw9NmOoxWKs8Y4cmw=;
        h=Date:From:To:Cc:Subject:From;
        b=y5PzAAhJyBwRxGDn0hnX3QjYffp5OIpW3+nAn7bu6nsdOyT9stTqJ3oc9M/ppBaAU
         8i2cFkIhbsXgEgJFPowGsGl992V3bUaVK3Hj0Q+sE+AV6uOJageUk5BpEYJ5RwRP+2
         z47/9CXwvJgYqbKuv3pmbcxCFH35yW4aH2NpOe1k=
Date:   Tue, 16 Jun 2020 18:09:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] irqchip: Use struct_size() helper in devm_kzalloc()
Message-ID: <20200616230923.GA24937@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/irqchip/irq-imx-intmux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index c27577c81126..54d8bb4fc5a1 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -210,8 +210,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data) +
-			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, struct_size(data, irqchip_data, channum), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.27.0

