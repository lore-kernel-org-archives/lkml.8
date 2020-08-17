Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00479C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3194206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683339;
	bh=3KBZakJRxkbbYwWwnCEtdTABw4FSzfAUpMMNQhnP7D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Me0U6qtRG7ub3FpyRyoYkVv0xanBOeEAfcbyvqZsh4DMmec+3G+3oS7SD8GG3ZMtV
	 kiiJtdDxbkExgSSWQb6RYjkwemfSjvPov/8FdcO3jaho9lUE931ke2bxM/QjxwX6Iv
	 iPOeBEGHy76u0uEjvuXN5nfHLxAJ3d0EsvarK/+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbgHQQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388258AbgHQQDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:03:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709C820885;
        Mon, 17 Aug 2020 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680225;
        bh=3KBZakJRxkbbYwWwnCEtdTABw4FSzfAUpMMNQhnP7D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOb12HKXOC7xcOOlS94ctEw5/0QkrEsVwZpkX2fdwX4YN/3H0FL1wruGl1hrdySA1
         y+jRLhxpN52rTetJr16OvhYVv0ZJjwFttym5R11qkol5fCtXLJhe02zqdecsCsrdbW
         I+2HnqYu2A2sqd0Hk+SmK2m0HE0tkSVv8y5tWEaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 102/270] drm/etnaviv: Fix error path on failure to enable bus clk
Date:   Mon, 17 Aug 2020 17:15:03 +0200
Message-Id: <20200817143800.863280808@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit f8794feaf65cdc97767604cf864775d20b97f397 ]

Since commit 65f037e8e908 ("drm/etnaviv: add support for slave interface
clock") the reg clock is enabled before the bus clock and we need to undo
its enablement on error.

Fixes: 65f037e8e908 ("drm/etnaviv: add support for slave interface clock")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 8a26ea2a53348..85de8551ce866 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1463,7 +1463,7 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 	if (gpu->clk_bus) {
 		ret = clk_prepare_enable(gpu->clk_bus);
 		if (ret)
-			return ret;
+			goto disable_clk_reg;
 	}
 
 	if (gpu->clk_core) {
@@ -1486,6 +1486,9 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 disable_clk_bus:
 	if (gpu->clk_bus)
 		clk_disable_unprepare(gpu->clk_bus);
+disable_clk_reg:
+	if (gpu->clk_reg)
+		clk_disable_unprepare(gpu->clk_reg);
 
 	return ret;
 }
-- 
2.25.1



