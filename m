Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E38C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4105820855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160591;
	bh=hjjPZ+xnMhZ86K6z5Wn6FLIQv01DCsLxEblk3ZGxpJ8=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=rgdv6rioswXaFmseeuGki+TllOSRzft+stCNzpQAHFBOsY7ik8MmVeSmWO6Aa1RvH
	 dCpSmvuCZoU015/uCzd5Qe7dOldxiyXN9p1ZjQa+tz4D68KEj/HnNr6Ve9/yIQikhe
	 UteSsnvQMg6mnwcxO2QiaDp6qdIRkBS7Ayau2r70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgHKPnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbgHKPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0CE22D70;
        Tue, 11 Aug 2020 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=hjjPZ+xnMhZ86K6z5Wn6FLIQv01DCsLxEblk3ZGxpJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcfC/S7tXq9JiHu48/OuLJVTxysxKcX8CrKHOFKapbTErUvENYJJftyCXsySgIz2l
         xLQGRfMXCepCSAra0/likgFRc5Tzswj6G6ZHyAlKC0FnLX3F4KlWG5cJcv22Qc+zis
         SRlWXB5h0RZLhy0Dm060fp/1cF3dMx4YaVfPUchg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnT-6P; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 26/33] regulator: hi6421v600-regulator: don't use usleep_range for off_on_delay
Date:   Tue, 11 Aug 2020 17:41:52 +0200
Message-Id: <cc4c25e122407c4138cdcaf55a9a7539b514bb3a.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator's core already handles it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index abd1f43dd5ec..31b8ff19fd31 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -73,9 +73,6 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	/* keep a distance of off_on_delay from last time disabled */
-	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 1000);
-
 	dev_dbg(&rdev->dev, "%s: off_on_delay=%d us\n",
 		__func__, rdev->desc->off_on_delay);
 
-- 
2.26.2

