Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F33120707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948012;
	bh=TbxMJ9nGBQfEUpgYzJOA0QPGSQtVRry7JPkozFCBYQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AAB8DqqUFPj28qhMa8Y7iJW2UaJP7Tbp68j9nemFBZHdTrXGr0fs2Dg0omKuh5Tb
	 kMChHJBTBIZhTVGDC4lggOWygDZhR8CIUZwdMZylZo8qSIliSUqc/croCW6SD9ALGx
	 jKL/rtYGfqnvOAi9eN8b2fmncHLwHA86CY6hhFcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbgFWVdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbgFWULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:11:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5455206C3;
        Tue, 23 Jun 2020 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943092;
        bh=TbxMJ9nGBQfEUpgYzJOA0QPGSQtVRry7JPkozFCBYQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwUqc6rGfUuYO5+AOI57fCiaOeK0Ke66UG43ksUu1nFTWvbd9rlpYsuDH5loe0qn7
         m43tdSN/z6vwFRhmfdkK5fp8fjpv0RKCVaSs+8jkok+F3nm5TaOPdqmtcZTWqfsaNX
         5kkellhJakctOGalel8QdSJTMq3Z0cTzNTiuA3FQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 256/477] iio: light: gp2ap002: Take runtime PM reference on light read
Date:   Tue, 23 Jun 2020 21:54:13 +0200
Message-Id: <20200623195419.674080567@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit f6dbf83c17cb223ceabd7c42d441414f3e0e8a86 ]

The light sensor needs the regulators to be enabled which means
the runtime PM needs to be on.  This only happened when the
proximity part of the chip was enabled.

As fallout from this change, only report changes to the prox
state in the interrupt handler when it is explicitly enabled.

Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/gp2ap002.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index b7ef16b28280d..7a2679bdc987a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -158,6 +158,9 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 	int val;
 	int ret;
 
+	if (!gp2ap002->enabled)
+		goto err_retrig;
+
 	ret = regmap_read(gp2ap002->map, GP2AP002_PROX, &val);
 	if (ret) {
 		dev_err(gp2ap002->dev, "error reading proximity\n");
@@ -247,6 +250,8 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 	int ret;
 
+	pm_runtime_get_sync(gp2ap002->dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
@@ -255,13 +260,21 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			*val = ret;
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			goto out;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+out:
+	pm_runtime_mark_last_busy(gp2ap002->dev);
+	pm_runtime_put_autosuspend(gp2ap002->dev);
+
+	return ret;
 }
 
 static int gp2ap002_init(struct gp2ap002 *gp2ap002)
-- 
2.25.1



