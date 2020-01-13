Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39EC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECBC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578928429;
	bh=cblG6jxxlafHhIzsSgF7BHDUBf9573DDn6boPbkUTNA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CP0fRJysXQfY8Zeb+MAPvv/TispZ5W1Q+KX6kFG0aEhou3Df+cyZjTdNY4s+ZuzyS
	 9hUznlhmYDRlsmmhBlkza43XGSarfZMfgiHa/H/z4Vbux0dbBrNGsvGUSefJ6FACKx
	 EmkyMqdvhZ3CAFIV+oss+oBTIhIVUktdwcoNKTvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAMPNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:13:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uFrGaqBqMIFQTWoUTLd2AHJDxVD5++0b99e80k3M46A=; b=X5fJP4DySo80
        Ov4suuYvmlevk2n4zlKDRNZHfd4egno6ebxVPkdZUFKkTIFybM75JX6tUZOQcQ5CYRJtNlQLZuSQ/
        +h7iJ2MZY75Vjxtb10BLIt67bLg8Hxsvq27NpRhSc44R5c9g1De1Svyx4+EdNAiM/4JlAarbikC32
        a+7UU=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir1P9-0003Nc-0v; Mon, 13 Jan 2020 15:13:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B7236D01ECC; Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mpq7920: Check the correct variable in mpq7920_regulator_register()" to the regulator tree
In-Reply-To: <20200113125805.xri6jqoxy2ldzqyg@kili.mountain>
Message-Id: <applied-20200113125805.xri6jqoxy2ldzqyg@kili.mountain>
X-Patchwork-Hint: ignore
Date:   Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mpq7920: Check the correct variable in mpq7920_regulator_register()

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

From 7eec67869893bc34bd3a3126e5124a4ef017e0cd Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 13 Jan 2020 15:59:33 +0300
Subject: [PATCH] regulator: mpq7920: Check the correct variable in
 mpq7920_regulator_register()

There is a typo in the error checking.  We should be checking
"->rdev[i]" instead of just "->rdev".

Fixes: 6501c1f54a17 ("regulator: mpq7920: add mpq7920 regulator driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200113125805.xri6jqoxy2ldzqyg@kili.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mpq7920.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index ab1b847c57e5..80f3131f0d1b 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -274,8 +274,8 @@ static inline int mpq7920_regulator_register(
 
 		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
 					 config);
-		if (IS_ERR(info->rdev))
-			return PTR_ERR(info->rdev);
+		if (IS_ERR(info->rdev[i]))
+			return PTR_ERR(info->rdev[i]);
 	}
 
 	return 0;
-- 
2.20.1

