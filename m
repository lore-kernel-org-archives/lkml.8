Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A9120758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648374;
	bh=/Uzg2tuykg7lC6MMvx9CJYJZWVruD3HfqHqckUtCNp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QEmxi8LzkDniJDqWRWd84gZTXyLVdBFpAdW8iFgXU6evR2U0uKejjP9lH2Qygk7Sl
	 /sU/M+t1/IWXbzpsJj4HERXsSe1HDA35NoW9YPinVpeUSWPY2va8DZem/QLaDWgurl
	 znwW43PPJP3E+2FrFbwH5VYzDi5inXhW2eX2SBS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHQHMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgHQHLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:36 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401C922D6D;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=/Uzg2tuykg7lC6MMvx9CJYJZWVruD3HfqHqckUtCNp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVpFV95mhSEm07RTgGkw0K7JlJQYxFoaLYi6LjNM/54uLeBJny153hoDotX3LPOOl
         1cANRqHljD2N8WuCnH/psVvr24W163sglZyhn83aa99pPU2vw+LkSPcNR2RLl0Vq/T
         780Psq/2ZafRpbsWfTCrUf8scSjPReIR8sOgCoVc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00Bdkq-DH; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 34/44] staging: regulator: hi6421v600-regulator: don't use usleep_range for off_on_delay
Date:   Mon, 17 Aug 2020 09:10:53 +0200
Message-Id: <4f17adca2b04c401e5de5556700638648ce25c0c.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator's core already handles it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index abd1f43dd5ec..31b8ff19fd31 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
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

