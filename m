Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D5DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9B206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702407;
	bh=ml9s32sxFxF2khA9u9Gzm/r5nsPwJ65bZbYiix3UbLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8OwaJqjX/7BBhmsgFIMAyQ6zeuZ5S80hhk7HdeT1VySDQNsS7sINN9svPCvokYQ6
	 x06iIRQOXC0Z4IpAGVEp1/mTf+DLz2xL9df6+RJKcQI4DmzbD3/sWIcusBAnYLbpMZ
	 5AdcmKl/9ozY8SNKVzhR4VveATqsDmlMRP4m9bPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbgBNRqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389270AbgBNQCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E2E24654;
        Fri, 14 Feb 2020 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696132;
        bh=ml9s32sxFxF2khA9u9Gzm/r5nsPwJ65bZbYiix3UbLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogfAG4Q2/ulyttPT9laYVPuYkjmgcm9jBn3GQg19dbCDTkaqvaPDe0xDf64noPH/A
         6tF4ajsveknKCpkbi+0E1h0vBYPZy3rTSR5zMI2j7X73HXIEXdEKChaan9B3Ege4D9
         OzzikMlcqSMhGfPRSZ+9Z2/1Ly5wNOkbSiWS2OWM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 016/459] clk: meson: g12a: fix missing uart2 in regmap table
Date:   Fri, 14 Feb 2020 10:54:26 -0500
Message-Id: <20200214160149.11681-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit b1b3f0622a9d52ac19a63619911823c89a4d85a4 ]

UART2 peripheral is missing from the regmap fixup table of the g12a family
clock controller. As it is, any access to this clock would Oops, which is
not great.

Add the clock to the table to fix the problem.

Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Reported-by: Dmitry Shmidt <dimitrysh@google.com>
Tested-by: Dmitry Shmidt <dimitrysh@google.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index b3af61cc6fb94..d2760a021301d 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4692,6 +4692,7 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_bt656,
 	&g12a_usb1_to_ddr,
 	&g12a_mmc_pclk,
+	&g12a_uart2,
 	&g12a_vpu_intr,
 	&g12a_gic,
 	&g12a_sd_emmc_a_clk0,
-- 
2.20.1

