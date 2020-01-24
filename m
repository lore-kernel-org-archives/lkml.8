Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B9620704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579866231;
	bh=8SstP88sVbDvinBmAl97JPTxSgO6mrA6hEdHJmhpsiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yd2+jRcAkl8Jnig+d+qoGTiai36O+Y2wa9iwwPn2W4VWkWzckB1q9bzB3FmNHhMlx
	 cNpEoPQEJ4+nxn1IA0kHY4QUoHBX5BwxJmYsDR7ECsTIZWfbIoAIecYYECd09Fcr79
	 tcoItob6cZCL+xNhwkZKkAQF+O6jMfSbLcBajSd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbgAXLDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732311AbgAXLDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:03:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16CC2071A;
        Fri, 24 Jan 2020 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863804;
        bh=8SstP88sVbDvinBmAl97JPTxSgO6mrA6hEdHJmhpsiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UISt19xzQkvcJV8mX6jpxfmVjcCDiMX6224MUWnyY1ePTYicb4ejjOq7kNqnKjZE
         zNS+EbkiQ4PVIaQvBKIfhzkvij65QP8huHOdYBDo1dumdW16LXW9XMAEIbaBWzobI+
         zwunMNGEypzz9mIfj7xEvJyo7cFAIwMTiT1HDusM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/639] pinctrl: sh-pfc: r8a77980: Add missing MOD_SEL0 field
Date:   Fri, 24 Jan 2020 10:24:22 +0100
Message-Id: <20200124093058.855289030@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit b0f77269f6bba385f1f4dce44e7756cf8fbc0176 ]

The Module Select Register 0 contains 20 (= 5 x 4) reserved bits, and 12
single-bit fields, but the variable field descriptor lacks a field of 4
reserved bits.

Fixes: f59125248a691dfe ("pinctrl: sh-pfc: Add R8A77980 PFC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 3f6967331f646..81a710bb8555e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -2751,7 +2751,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     4, 4, 4, 4,
+			     4, 4, 4, 4, 4,
 			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) {
 		/* RESERVED 31, 30, 29, 28 */
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
-- 
2.20.1



