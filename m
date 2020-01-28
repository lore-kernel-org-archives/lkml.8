Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EDBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0EC2468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220467;
	bh=GL5zsgFLS6wIHDT5TeR4iGhWZt2dGFmQ/KsltslEhIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GFNlssZ2XpXclqY603S8khOp626C6Wk9qzoDDydFdCAMzbkubqNY6cD8Y+rEu8kde
	 EGkyFFYQlng0NoB0c3+q2jc4KUl3jS0up5T6m0rmWXWcfPQHJy2ZWTgTGm+DW282zd
	 4MwXgDI3XZV+fy8h8zTzzFuZIdBgpM8M32WU/y3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgA1OHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgA1OHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:07:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A563622522;
        Tue, 28 Jan 2020 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220462;
        bh=GL5zsgFLS6wIHDT5TeR4iGhWZt2dGFmQ/KsltslEhIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dn56+JAfXJoWToqbWnEXaDhx3zze0ZTCAI6pOepRaemIFNJmOY/XjszGcuYx4nXKN
         SoMf9ZY8Q366XotgwW70zVxkYTmF8g5dP5/bOxgA6iFUHgy7CTL425S+uaEphy4Wos
         9AMoOSm3dpbnhDdpYSu8UsgjWJkir84zCRT4kmC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/183] pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
Date:   Tue, 28 Jan 2020 15:03:56 +0100
Message-Id: <20200128135831.562718469@linuxfoundation.org>
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

[ Upstream commit 94482af7055e1ffa211c1135256b85590ebcac99 ]

The Peripheral Function Select Register 11 contains 3 reserved bits and
15 variable-width fields, but the variable field descriptor does not
contain the 3-bit field IP11[25:23].

Fixes: 856cb4bb337ee504 ("sh: Add support pinmux for SH7734")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index ab09d385f95d1..a0835306f76eb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2242,7 +2242,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD_DATA15_B, 0, 0, 0 }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xFFFC0048, 32,
-			3, 1, 2, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
+			3, 1, 2, 3, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
 	    /* IP11_31_29 [3] */
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    /* IP11_28 [1] */
-- 
2.20.1



