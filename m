Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D0F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193810;
	bh=iEMLbIMw6Kstlg/KuTl3PhFQw70OlF9F6IKd7TGBkxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oHfKH+Qhd9Svvf3EfGp609oOF7T67xDp57sbf0LYBY/bEsWAnM//OD71ARXjM1Ocf
	 nWwVj1Cz/UA2nexFmY9bX+WV3KxU+WIAXjTSc61BzreswuqoAgvIxRhCOAgEORv48R
	 +DDbcFgiaP6dF0EQoDSOfis9v0NYh32sGAwgR7ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgAPQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbgAPQ4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:56:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CB12051A;
        Thu, 16 Jan 2020 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193805;
        bh=iEMLbIMw6Kstlg/KuTl3PhFQw70OlF9F6IKd7TGBkxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0lcZmYifMnw2LQVGMFlVhVc5RINLJ5353w/HHb+z8lgDZU09nB1LEkhl5HBxj1kS
         oQm1PNb1rCT6zuIeI75RkuCGhxZ2Qk9GgsrfVtCex6iCVm1DMlrZP40wvQUQCiE1zG
         rbCCY67sOiX2rmUGObwN84N9UOtB2MSam3ilbI9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 070/671] pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b group
Date:   Thu, 16 Jan 2020 11:45:01 -0500
Message-Id: <20200116165502.8838-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
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
index 5811784d88cb..f5b4255570b2 100644
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

