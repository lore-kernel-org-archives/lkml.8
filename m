Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194D72473E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196603;
	bh=gnYA85kEZLHbdN2eow52QotnrLQTfl4ilnRJYkvJBRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgNDxXDUJ4eCjmFjcsl68xRlnXGq5wfDdeUvetY72DVaVP9w2TdWqzrnA7NFty9pJ
	 yvtHHTVgIrwQhzHSjBwPmOo2rcjOdqpO88FOf82NCKYdnhnBt84PNe8Cz9n4ajmGid
	 zHsWNNK2YZjmeBf09GWYOh7FACgzzTDDLku+DCUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405875AbgAPRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405870AbgAPRnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF512469C;
        Thu, 16 Jan 2020 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196590;
        bh=gnYA85kEZLHbdN2eow52QotnrLQTfl4ilnRJYkvJBRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3DaNa6y0smWn8e9dvToAmKNVMytfPTZDhxZPePUsocobS1Yab0HSfKznuJMFxkXC
         Ee1OgzcJAyUdbLMfJ0rUyVZ9TuAMVZtmPfOqdkv/1Fs5glUmNd+wVrr5tJI5vFlDmm
         6TRfE67StUEtjBee8Xh0zVyeiOYFY+VF/CwMEJX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 014/174] pinctrl: sh-pfc: r8a7794: Remove bogus IPSR9 field
Date:   Thu, 16 Jan 2020 12:40:11 -0500
Message-Id: <20200116174251.24326-14-sashal@kernel.org>
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
index 086f6798b129..3b79e893b5ed 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4046,7 +4046,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
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

