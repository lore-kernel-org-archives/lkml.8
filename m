Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E74208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859068;
	bh=E/8xhE6QPAyyQHcwmoY/esolwnEGad1QlWTZldq+8ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWDHmiXO2SdeIcBiCwp3PmmAsczartruCKgmrjoUQa2oMiQjg3SmCbwLN2lQDa4GR
	 pXbagtpoO6pPw54DHPBgfSIaoJzsoGL6M+6+toI/zqTWkL1kG8LrCBK+HQ1I/gmQjg
	 thBhw2MaIlcWH/+efMzAbiNNoYwxbMnrRBmzy9lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgAXJo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbgAXJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:44:25 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073F221569;
        Fri, 24 Jan 2020 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859064;
        bh=E/8xhE6QPAyyQHcwmoY/esolwnEGad1QlWTZldq+8ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/ueDT5uc6Bwmbu+hy+Aggzsuru0TNVSXomWDeLdEVJhnrFDaQNxj+I0+08GRanpK
         NFkZwD9ES5iGI5tGUfj73I3AJn0vvWDT27lW0WwlCzgs3K6fKqwss8MkTR8XfLZ01n
         W6WElH/7WvpWdUNozXsGx1ufx87fu4YiarbEpcpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 034/343] pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
Date:   Fri, 24 Jan 2020 10:27:32 +0100
Message-Id: <20200124092924.314354426@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index 8600ba82f59c3..d34982ea66bf1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4348,17 +4348,14 @@ static const unsigned int vin1_b_data18_pins[] = {
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



