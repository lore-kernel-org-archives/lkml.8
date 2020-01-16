Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B472124694
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196198;
	bh=nZ+rhucHjfZ5qUxINywK+hynvejPhBJ35eVjtPq6reg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmo8dVPHdULO9/TnqNS/Ct4hKbihZbFZOzTU93pIZE0v84kPN0BOi7o/qQXTbrx6n
	 XkuiVLTTyq6kBgEgBdAL0NrbenW99Bg+k0tG6BYq6YzVmuxSZtxHk5xw62Kehe6C+M
	 2FNS6KBiVt10jQdQcEULHPbFHJdEnD6nmnscmEm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393133AbgAPRga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393078AbgAPRfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:35:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 999BC246BA;
        Thu, 16 Jan 2020 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196110;
        bh=nZ+rhucHjfZ5qUxINywK+hynvejPhBJ35eVjtPq6reg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Bt3Ydt+R55oqZtA7yQhnqCKgdj8ipZTt3OjNLU2xX3y62AM3i2hRzCXRsrJ2GD6d
         E8RYY1BBfe3621icqMEIxgJW5aiC9iW5PcEfw38gjX9sFRkiPoWCFzcXMGOaFctFfm
         Yej/GHBrm3M3e5BbgoocVvuBcee9hAcVPI3f+vJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 019/251] pinctrl: sh-pfc: r8a7794: Remove bogus IPSR9 field
Date:   Thu, 16 Jan 2020 12:30:53 -0500
Message-Id: <20200116173445.21385-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173445.21385-1-sashal@kernel.org>
References: <20200116173445.21385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6a6c195d98a1a5e70faa87f594d7564af1dd1bed ]

The Peripheral Function Select Register 9 contains 12 fields, but the
variable field descriptor contains a 13th bogus field of 3 bits.

Fixes: 43c4436e2f1890a7 ("pinctrl: sh-pfc: add R8A7794 PFC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index ef093ac0cf2f..fe8c9c24634d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4826,7 +4826,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_AVB_MDC, FN_SSI_SDATA6_B, 0, 0, }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
-			     1, 3, 3, 3, 3, 2, 2, 3, 3, 3, 3, 3, 3) {
+			     1, 3, 3, 3, 3, 2, 2, 3, 3, 3, 3, 3) {
 		/* IP9_31 [1] */
 		0, 0,
 		/* IP9_30_28 [3] */
-- 
2.20.1

