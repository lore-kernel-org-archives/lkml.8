Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70DEC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B312465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018170;
	bh=fiK0s/xTvzDzKNqirZotKCXavuNiVg4gYefAnuuqHZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yEalFZMCfbipIutEM/OcGsoTNJy0zCVss/k7zhLI8ajKKHLYDATCMUzejqf0b81yE
	 /c0NGMJ3hnKJYYadhqR/Ovabyc011xA4zANvFSDTz01Bkrwd2fC9EOWiotIax2Bob8
	 AjKMMbWKLHX4Po9UX+BMAcgmkvhTAjlGHAx3udFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANQJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:09:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37468 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgANQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xt6GnhTDfc3bD8Q64HOc7iLmr7E81WzZ/2lkzS6cxG8=; b=toxylGguSp1y
        jgz14kGxL62CIhRaCUkz0mYmO3hOsG6pJm22ENuH2ABM81ezvh8IuQ1ZUjp5P6Dj8knC32FXDbzQZ
        0Xesc+/fduOKT6WBY8VJob+So10TdzgfRnhelHyJXGOHT2cuWvN7zzPvy/AJwBqxnH4eS4xtKSixD
        oiTIY=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkp-0001YW-PW; Tue, 14 Jan 2020 16:09:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 82112D02C7B; Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mpq7920: Convert to use .probe_new" to the regulator tree
In-Reply-To: <20200114124449.28408-2-axel.lin@ingics.com>
Message-Id: <applied-20200114124449.28408-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mpq7920: Convert to use .probe_new

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5b379b2bf87710834ed90d367acb58e652e624af Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 14 Jan 2020 20:44:49 +0800
Subject: [PATCH] regulator: mpq7920: Convert to use .probe_new

Use the new .probe_new instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200114124449.28408-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mpq7920.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index b133bab514a9..54c862edf571 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -260,8 +260,7 @@ static void mpq7920_parse_dt(struct device *dev,
 	of_node_put(np);
 }
 
-static int mpq7920_i2c_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int mpq7920_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct mpq7920_regulator_info *info;
@@ -321,7 +320,7 @@ static struct i2c_driver mpq7920_regulator_driver = {
 		.name = "mpq7920",
 		.of_match_table = of_match_ptr(mpq7920_of_match),
 	},
-	.probe = mpq7920_i2c_probe,
+	.probe_new = mpq7920_i2c_probe,
 	.id_table = mpq7920_id,
 };
 module_i2c_driver(mpq7920_regulator_driver);
-- 
2.20.1

