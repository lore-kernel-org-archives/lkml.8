Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA01C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FCE22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916037;
	bh=7/xGhS2jXg70AQL+LrjRaZ6SVzc0mVFtwhK0uFYVNso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Os6bqtRRUR4p+4HVe33NsWKrHseOrDdrjkpVjmT7DyW1OgvWZgBt8wsktiZ0VZ95A
	 tH+obLWXdD4yibrso8z60gjFPy5OngCRvvOutxR9k9NTdmtQJEKyftSNB9vYP7cEFz
	 mb/dQB8S64BHZjDSZb9hNSxupSkpGZdKlvXzbLz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHTJdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgHTJbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7FEA21775;
        Thu, 20 Aug 2020 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915910;
        bh=7/xGhS2jXg70AQL+LrjRaZ6SVzc0mVFtwhK0uFYVNso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNIUOCv0Sfp579sMuTCU8chBMCn4CZVB7cHqQkrhnovB5A5dTGZNf90FH+/Kp7Mrn
         pTqca48eZDC+ClonahCvqcI9S+7YNKht+bWew2rXl6hQbpRpdejkBHqExfias+PORN
         PeTyicvpqUgPbrS/MrlT0E9QawL3s87w3eFFy18Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 177/232] clk: hsdk: Fix bad dependency on IOMEM
Date:   Thu, 20 Aug 2020 11:20:28 +0200
Message-Id: <20200820091621.388674950@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit bd8548d0dcdab514e08e35a3451667486d879dae ]

CONFIG_IOMEM does not exist.  The correct symbol to depend on is
CONFIG_HAS_IOMEM.

Fixes: 1e7468bd9d30a21e ("clk: Specify IOMEM dependency for HSDK pll driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200803084835.21838-1-geert+renesas@glider.be
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 326f91b2dda9f..5f952e111ab5a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -50,7 +50,7 @@ source "drivers/clk/versatile/Kconfig"
 config CLK_HSDK
 	bool "PLL Driver for HSDK platform"
 	depends on OF || COMPILE_TEST
-	depends on IOMEM
+	depends on HAS_IOMEM
 	help
 	  This driver supports the HSDK core, system, ddr, tunnel and hdmi PLLs
 	  control.
-- 
2.25.1



