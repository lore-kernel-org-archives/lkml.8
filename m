Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55062C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B220885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445462;
	bh=F7qbqL1Z+GbMg1N+HaFfBKK6cwEGtVkA9j5hs000wNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPV6/5gtUMxXtE6Ti3LMJDmpoa5M/JyKT10pvkHTJBxBLRp3DFpi4idJpVeA4zOiq
	 2nhUBUKCIAvjwl4lGQR6J+YoatMFKtIud5RSn0fzYhtVtNTg8D2UGaC7o7RpK9uXxt
	 PDp4mD+3GHb0v6UnJpQZuVTPTusA48Qjo1reoRuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgFRB5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbgFRBZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE8C221F1;
        Thu, 18 Jun 2020 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443507;
        bh=F7qbqL1Z+GbMg1N+HaFfBKK6cwEGtVkA9j5hs000wNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZxEngux8K33UpCAgVfUXRQAh7uOZtlqzMDySARQ2ErhoWzO455bGE26B15BIy6sc
         DhZqS4N7u2z8uztXuqpNcTvZc13djm/5//T/CHaWEsxi9ZqNK4f/tPBRBtN/kUzW1r
         fgUkxmx93rCG0lL/Hrz2jgsovb3hFA1Vxxu7DuuQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 132/172] extcon: adc-jack: Fix an error handling path in 'adc_jack_probe()'
Date:   Wed, 17 Jun 2020 21:21:38 -0400
Message-Id: <20200618012218.607130-132-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bc84cff2c92ae5ccb2c37da73756e7174b1b430f ]

In some error handling paths, a call to 'iio_channel_get()' is not balanced
by a corresponding call to 'iio_channel_release()'.

This can be achieved easily by using the devm_ variant of
'iio_channel_get()'.

This has the extra benefit to simplify the remove function.

Fixes: 19939860dcae ("extcon: adc_jack: adc-jack driver to support 3.5 pi or simliar devices")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-adc-jack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 18026354c332..b1fb38b7f270 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -128,7 +128,7 @@ static int adc_jack_probe(struct platform_device *pdev)
 	for (i = 0; data->adc_conditions[i].id != EXTCON_NONE; i++);
 	data->num_conditions = i;
 
-	data->chan = iio_channel_get(&pdev->dev, pdata->consumer_channel);
+	data->chan = devm_iio_channel_get(&pdev->dev, pdata->consumer_channel);
 	if (IS_ERR(data->chan))
 		return PTR_ERR(data->chan);
 
@@ -170,7 +170,6 @@ static int adc_jack_remove(struct platform_device *pdev)
 
 	free_irq(data->irq, data);
 	cancel_work_sync(&data->handler.work);
-	iio_channel_release(data->chan);
 
 	return 0;
 }
-- 
2.25.1

