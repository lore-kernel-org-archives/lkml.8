Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22325207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446885;
	bh=rJPraC/C8Ksrn6ifI008vEA8iGgmjPEhbid1XHUD2y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQxxL+7HH23WHpznawi6V71my7H5441GKuqDdSJBcJYbQx49CQK7l1loU3//v4cKX
	 UudgVwel+HqDy5XXYyLUa3nKTPq7gPEgCfHvLleCaIVosQmRIDMI2OssjqJIPyqFWx
	 Kv1Op9cXH2TsF9vpYyTyLIahInfaoHp5AB/5Ncnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgFRCVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgFRBSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:18:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6316206F1;
        Thu, 18 Jun 2020 01:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443120;
        bh=rJPraC/C8Ksrn6ifI008vEA8iGgmjPEhbid1XHUD2y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoyvw7E/XSM6riLrmVIp7gWf9F+WFxyVyfVOnsf+CtHMBspy2X5Bha+UVyMyRhJda
         pTvn9vafLwr6A7OOFW9nZmrmvz/LsFObxDqr1ZVQhIZPvDrSxuEfJ94xb9kbxI7qlQ
         ZozPFncVrZogErIET4USGTG7E7041wMeJ365BADk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 095/266] pinctrl: rza1: Fix wrong array assignment of rza1l_swio_entries
Date:   Wed, 17 Jun 2020 21:13:40 -0400
Message-Id: <20200618011631.604574-95-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 4b4e8e93eccc2abc4209fe226ec89e7fbe9f3c61 ]

The rza1l_swio_entries referred to the wrong array rza1h_swio_pins,
which was intended to be rza1l_swio_pins. So let's fix it.

This is detected by the following gcc warning:

drivers/pinctrl/pinctrl-rza1.c:401:35: warning: ‘rza1l_swio_pins’
defined but not used [-Wunused-const-variable=]
 static const struct rza1_swio_pin rza1l_swio_pins[] = {
                                   ^~~~~~~~~~~~~~~

Fixes: 039bc58e73b77723 ("pinctrl: rza1: Add support for RZ/A1L")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20200417111604.19143-1-yanaijie@huawei.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-rza1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
index 017fc6b3e27e..ca9da61cfc4e 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -418,7 +418,7 @@ static const struct rza1_bidir_entry rza1l_bidir_entries[RZA1_NPORTS] = {
 };
 
 static const struct rza1_swio_entry rza1l_swio_entries[] = {
-	[0] = { ARRAY_SIZE(rza1h_swio_pins), rza1h_swio_pins },
+	[0] = { ARRAY_SIZE(rza1l_swio_pins), rza1l_swio_pins },
 };
 
 /* RZ/A1L (r7s72102x) pinmux flags table */
-- 
2.25.1

