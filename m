Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED2C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9215A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195259;
	bh=qR9z+vhMoovUMCDKsNJsPHdQQAm57/Nlj/ycMZRmjCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9L2O7eETpd0muniXeP0c5vfFY8Ei/P36HMlR/x+uO6w5FhJhHJdWzj22AoTO7BH0
	 eBOcMgWVFZuJtnY7w6ezZ0ELhvrTM5yAnKepibPcqZ19EGdXiBg7+6dT8d0woXEoUL
	 EMpl0bBb6RPAdW4I0TJb5kg1/s3wY3hqHiq2RX4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbgAPRU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391298AbgAPRRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA5A246B2;
        Thu, 16 Jan 2020 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195074;
        bh=qR9z+vhMoovUMCDKsNJsPHdQQAm57/Nlj/ycMZRmjCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FNtyjz6JKGPjsKlTcuwYT7jPGBkMfal1bp4yRXw1uBs5rU7bDFHvK4LBaX1945nk
         fWr24knHfxhrxa+E847lDk7p3tVbR47cOGQC2rqi6/Gfs3f9hDVYxjvtMzslGvuY60
         PnSucxR9rbCTULbkqYNemmNzp7W4TKMwZlsUy7W0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 025/371] pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 group
Date:   Thu, 16 Jan 2020 12:11:33 -0500
Message-Id: <20200116171719.16965-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 96bb2a6ab4eca10e5b6490b3f0738e9f7ec22c2b ]

The lcd0_data24_1_pins[] array contains the LCD0 D1[2-5] pin numbers,
but the lcd0_data24_1_mux[] array lacks the corresponding pin marks.

Fixes: 06c7dd866da70f6c ("sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index d8077065636e..e9739dbcb356 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2154,6 +2154,7 @@ static const unsigned int lcd0_data24_1_mux[] = {
 	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
 	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
 	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
 	LCD0_D16_MARK, LCD0_D17_MARK, LCD0_D18_PORT163_MARK,
 	LCD0_D19_PORT162_MARK, LCD0_D20_PORT161_MARK, LCD0_D21_PORT158_MARK,
 	LCD0_D22_PORT160_MARK, LCD0_D23_PORT159_MARK,
-- 
2.20.1

