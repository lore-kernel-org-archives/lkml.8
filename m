Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22ED2469A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197562;
	bh=SVw0ObCnLl4OAQavnwGenLfit+59tPYtH11edjeOHYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DM7m76o6KLfhffm+VS+ukLfRcESK0hbr8eGJ2M9qSyMDr7ozhbo9AeUeBGpeZxUWA
	 Bc49Ckhs3E8DQYBwfENw2EqqrYJ/xpgUIU3Gf9/aXO+pBN4r3S0aRerzixn98RSVfl
	 jdB8QOUpn3YcVeKZtPHIxrhee4CITgOY+DEvRAwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAPR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393874AbgAPRnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE0524736;
        Thu, 16 Jan 2020 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196588;
        bh=SVw0ObCnLl4OAQavnwGenLfit+59tPYtH11edjeOHYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5xCe77mPnOkjUviZVScaKfJ4IEp6Gu2PdQgg5Wp/gElbtH70bJkZPH92rsTIxLCg
         aJlKLOWI3NC3YCO/zb3w+bNvKuNS4hCn3YebpcGaGbknxQsJx/3GlOURuktwcf7nr8
         raUPaeSTQKVvLCNNZXhaTMWxUOrNJXjt/1CjCh9M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 012/174] pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
Date:   Thu, 16 Jan 2020 12:40:09 -0500
Message-Id: <20200116174251.24326-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0d6256cb880166a4111bebce35790019e56b6e1b ]

The vin1_b_data18_mux[] arrays contains pin marks for the 2 LSB bits of
the color components.  The vin1_b_data18_pins[] array rightfully does
not include the corresponding pin numbers, as RGB18 is subset of RGB24,
containing only the 6 MSB bits of each component.

Fixes: 8e32c9671f84acd8 ("pinctrl: sh-pfc: r8a7791: Add VIN pins")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 4fbd6d806719..f94e34e7f0b0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4170,17 +4170,14 @@ static const unsigned int vin1_b_data18_pins[] = {
 };
 static const unsigned int vin1_b_data18_mux[] = {
 	/* B */
-	VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
 	VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
 	VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
 	VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
 	/* G */
-	VI1_G0_B_MARK, VI1_G1_B_MARK,
 	VI1_G2_B_MARK, VI1_G3_B_MARK,
 	VI1_G4_B_MARK, VI1_G5_B_MARK,
 	VI1_G6_B_MARK, VI1_G7_B_MARK,
 	/* R */
-	VI1_R0_B_MARK, VI1_R1_B_MARK,
 	VI1_R2_B_MARK, VI1_R3_B_MARK,
 	VI1_R4_B_MARK, VI1_R5_B_MARK,
 	VI1_R6_B_MARK, VI1_R7_B_MARK,
-- 
2.20.1

