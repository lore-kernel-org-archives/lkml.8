Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BDFC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD612467A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195221;
	bh=XEBX5LKGTgkXutyRuySDGSRfdAJUs1xVRWBHLLs2zVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CPKANP0YmWngmukhAVV3l9W8j0Xcz/v0/Vo/H6Rlb0IdZazeXIalaESnD1GoBq0Gg
	 YGkzx5KysGERAuWI0wGNe5m+Pby3stD/nBaMA0JflRG7KCUsD2jdG3/lymJiWminVJ
	 1OaAnVCDUg0r64ai38SFDcgUNaPmzrpfHc828HtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391369AbgAPRSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391308AbgAPRR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820A2246B1;
        Thu, 16 Jan 2020 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195075;
        bh=XEBX5LKGTgkXutyRuySDGSRfdAJUs1xVRWBHLLs2zVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoNtHikn77I4+YKORryaXz/EaDK8Bu0TdgdyvPLqUBcCS0sW1rMk1bz2aP3wTuclP
         nRm5JM0YsUIeIHkfdueZkuQtEdIm1yxu1d6Pcf7SGS5X2TeevB+knsXGG5H/S5IY86
         J1pXhQ8z89QQ1yXFJlyBzaBGGECw1E3fJD9vD+CQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 026/371] pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group
Date:   Thu, 16 Jan 2020 12:11:34 -0500
Message-Id: <20200116171719.16965-26-sashal@kernel.org>
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

[ Upstream commit 884fa25fb6e5e63ab970d612a628313bb68f37cc ]

The qspi_data4_b_mux[] array contains pin marks for the clock and chip
select pins.  The qspi_data4_b_pins[] array rightfully does not contain
the corresponding pin numbers, as the control pins are provided by a
separate group (qspi_ctrl_b).

Fixes: 2d0c386f135e4186 ("pinctrl: sh-pfc: r8a7791: Add QSPI pin groups")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index c01ef02d326b..8600ba82f59c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -3220,8 +3220,7 @@ static const unsigned int qspi_data4_b_pins[] = {
 	RCAR_GP_PIN(6, 4),
 };
 static const unsigned int qspi_data4_b_mux[] = {
-	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
-	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
+	MOSI_IO0_B_MARK, MISO_IO1_B_MARK, IO2_B_MARK, IO3_B_MARK,
 };
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
-- 
2.20.1

