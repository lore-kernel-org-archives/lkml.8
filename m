Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB649C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7298B22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220457;
	bh=DpCe9HucovYhSWsBD1zsub9erCe8PIdYbLkyporGqsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hnyd2MHbcC3i10c4NHurUqXpscwmzs2DXVi3yNyfxTWJkBs8ouqdWLdV2FwY8WN5O
	 laFzdgwVdptMtWTnU4RTw+QO3rexeyGE2v3LYI3ZNzpBszr8N8bsysGvhZFUEX6JxG
	 Uux0luOFOY4JAIiXd9y9QO48hKDPRElhXLf1kgt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgA1OHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgA1OHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:07:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A7C22522;
        Tue, 28 Jan 2020 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220454;
        bh=DpCe9HucovYhSWsBD1zsub9erCe8PIdYbLkyporGqsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+imTDGG9ivE5iyyZ3DsxIMWvdiA3s1Mr7MMDnpwWGYDAlInYILdGuRjCgb5AT8Bo
         krzRFVAK/rKEyagd7YSXETlQ3pb7X7wApOMbqL9XRIKNYFrXr4LQDKvcTuLXOH9cdv
         Eshzhj8nKGk1A2/AMhXTe0V5P5w59hRgAlep1i54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 014/183] pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
Date:   Tue, 28 Jan 2020 15:03:53 +0100
Message-Id: <20200128135831.197265589@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4fbd6d8067196..f94e34e7f0b01 100644
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



