Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C466CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B7B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597235349;
	bh=MH1bvUjYC37bx2LZsXr1vc95Xh18NFGKlhDeP1Az7Yk=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=N7NTUkOzRK1QXbYj1LzH+UVfi2AkyCmKUYN9OJ5QibAXT952Dii+k9vY7/VbTE3BO
	 843ZjpW9Q5SRXfnd9axQDXfGHUIk88X12s+rpeTDmUTv5wVvsdC9ID49PU+pv9vMFg
	 /9gk0h/J+GIIckes9uJes8kqg1A0FI9DiPHmyq8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHLM3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgHLM3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:29:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60BC8207DA;
        Wed, 12 Aug 2020 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597235347;
        bh=MH1bvUjYC37bx2LZsXr1vc95Xh18NFGKlhDeP1Az7Yk=;
        h=From:To:Cc:Subject:Date:From;
        b=U2ZdjKoqMvxZ6bw27Fdv+EH1RuGUhKoEqxoMwdRkQ+BVRSwc3wfj4uXnVeG2K3TZj
         PYVdVJe2YDxiMoEOxVRKlgs319noSudbizIrvP3Edx/2D3kTHEXOlB9sMkkdZXqsGf
         /WxwExAPsQ1e3rFLhj9dY5l8ESMJGNz499awdLjc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5psP-005f6M-9m; Wed, 12 Aug 2020 14:29:05 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: Kconfig: fix a typo
Date:   Wed, 12 Aug 2020 14:29:03 +0200
Message-Id: <42221553381256444745b6c495bb74b97aa23464.1597235340.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

individul -> individual

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a37d7d171382..e42d11849947 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -493,7 +493,7 @@ config MFD_HI6421_PMIC
 	  Add support for HiSilicon Hi6421 PMIC. Hi6421 includes multi-
 	  functions, such as regulators, RTC, codec, Coulomb counter, etc.
 	  This driver includes core APIs _only_. You have to select
-	  individul components like voltage regulators under corresponding
+	  individual components like voltage regulators under corresponding
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
-- 
2.26.2

