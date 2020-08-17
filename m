Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60880C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9FC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690962;
	bh=h+tYd+bZNAwHmeZmlBWeOiSqa8F/jt2io4cs8+AGino=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMtHLy7mOKKGjF6r65h+jdhF3WONZ0/UDGFbuBc6kyNB72bLaqxas0IMa/Em33bWn
	 Ma0181edQdFSXPAl51W36wc+m1qxB5Y1aiNNmZSZIUlFIwEoAQH2Kam2jHMKWrPgmy
	 XRuqQoYwS7eqnXITDn7MsOobFXzcpmfid+R9RSMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbgHQTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgHQPrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:47:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5660820885;
        Mon, 17 Aug 2020 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679233;
        bh=h+tYd+bZNAwHmeZmlBWeOiSqa8F/jt2io4cs8+AGino=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AAejbyAg3Wq/UJ0gTMxmkIEBVU0o2lVP9JFDyRepBA9dAIAI6Fhyun5AR+p9LPXO
         RqbFAVHTb8HtKqNiTg/vdy0ftbRrUQ7k6oNYclf0JLT5BVOosWih+onF7x5R2NA0Xs
         py8N1BVJSyFthSFbmGnwKmMw/kN0Ft/k5x9teMBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 141/393] iio: amplifiers: ad8366: Change devm_gpiod_get() to optional and add the missed check
Date:   Mon, 17 Aug 2020 17:13:11 +0200
Message-Id: <20200817143826.449126537@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 9ca39411f9a9c833727750431da8dfd96ff80005 ]

Since if there is no GPIO, nothing happens, replace devm_gpiod_get()
with devm_gpiod_get_optional().
Also add IS_ERR() to fix the missing-check warning.

Fixes: cee211f4e5a0 ("iio: amplifiers: ad8366: Add support for the ADA4961 DGA")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/amplifiers/ad8366.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 62167b87caea8..8345ba65d41d8 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -262,8 +262,11 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADA4961:
 	case ID_ADL5240:
 	case ID_HMC1119:
-		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
-			GPIOD_OUT_HIGH);
+		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(st->reset_gpio)) {
+			ret = PTR_ERR(st->reset_gpio);
+			goto error_disable_reg;
+		}
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
-- 
2.25.1



