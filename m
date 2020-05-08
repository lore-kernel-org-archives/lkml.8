Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A621473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942110;
	bh=7fa/eJupouYkwqroFu6QkxFryOR+WnizWgdKI1tS3Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Khk6NLeltJTY0Bafmo5pHJIPM5DdjDYqAKR83PmKVPwKqyG5Bl0fsSEi37ysS33Pb
	 9Aho/fnlwjK+rFni6AwOrB0iFbp8sb58LpJNA7S4WCFMFUwPC5L47pWqhh3qNDZ6Ht
	 nmD7GCcchqJFY9vQuSNXO1A9r+SvJOseTJKC5rmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgEHMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbgEHMsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B9421473;
        Fri,  8 May 2020 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942101;
        bh=7fa/eJupouYkwqroFu6QkxFryOR+WnizWgdKI1tS3Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0oIAm6c5l9bDFU4i+PCARmWjYmLUnifq6pGvJib1pXBe1veMa+37IQ2woIIKoNfco
         kEpaAnyzlul7CcsHyAwsW/sls4f/HfvMxMrk7HPsL0pmXs0FOBujZZgrVwemYKeRyq
         C4mcKmZUdOay9mlk4O0I+SWbrCapb59q+hev7oYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 297/312] at803x: fix reset handling
Date:   Fri,  8 May 2020 14:34:48 +0200
Message-Id: <20200508123145.266175751@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit d57019d1858a6f9b3ca05d76d793466ae428cfa3 upstream.

The driver of course "knows" that the chip's reset signal is active low,
so  it drives the GPIO to 0  to reset the PHY and to 1 otherwise; however
all this will only work iff the GPIO  is  specified as active-high in the
device tree!  I think both the driver and the device trees (if there are
any -- I was unable to find them) need to be fixed in this case...

Fixes: 13a56b449325 ("net: phy: at803x: Add support for hardware reset")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/at803x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -198,7 +198,7 @@ static int at803x_probe(struct phy_devic
 	if (!priv)
 		return -ENOMEM;
 
-	gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod_reset))
 		return PTR_ERR(gpiod_reset);
 
@@ -274,10 +274,10 @@ static void at803x_link_change_notify(st
 
 				at803x_context_save(phydev, &context);
 
-				gpiod_set_value(priv->gpiod_reset, 0);
-				msleep(1);
 				gpiod_set_value(priv->gpiod_reset, 1);
 				msleep(1);
+				gpiod_set_value(priv->gpiod_reset, 0);
+				msleep(1);
 
 				at803x_context_restore(phydev, &context);
 


