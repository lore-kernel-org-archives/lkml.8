Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81160C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDD218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943814;
	bh=+paItO5s4jfSbClbx7dPMpQsd3fzWtEyPMi442+bDpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/Pk7DgQnTvmsBIQDFMGL32c/drIMGnYNQIpjVSvj1fwaGfJFFIlb4rOoVFpt0c+g
	 5MpywSsxtv1dhB18Pv3qm+WoVCuTwmBDgHXNtFWhP0IiWGX23+2R/bGJoZfA8FzknR
	 8p3DH4DALRaM7RF2uuDsy0F8Dvxll+/97kZYH6GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgEHMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgEHMod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436CF208D6;
        Fri,  8 May 2020 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941872;
        bh=+paItO5s4jfSbClbx7dPMpQsd3fzWtEyPMi442+bDpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZzPISnW6X4f6KLTFqW+lrBBrXNlhMj/hFX96CKGffTVAJLifduGvxr5RI2TzPgAX
         QqEh8i1hg6ceXsS2lYLxZ5FR5wG0vbE0uCvc+JFgSAkqvK2ydlhKOv4geqFv4MI0Od
         /sHTkevuJX3MNAzc+74OZodJngKxsvn/Uf2Hcesg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.4 206/312] clk: imx: clk-pllv3: fix incorrect handle of enet powerdown bit
Date:   Fri,  8 May 2020 14:33:17 +0200
Message-Id: <20200508123138.910534395@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

commit b3e76bdc0b2190e67427d31cd740debd01c03631 upstream.

After commit f53947456f98 ("ARM: clk: imx: update pllv3 to support imx7"),
the former used BM_PLL_POWER bit is not correct anymore for IMX7 ENET.
Instead, pll->powerdown holds the correct bit, so using powerdown bit
in clk_pllv3_{prepare | unprepare} functions.

Fixes: f53947456f98 ("ARM: clk: imx: update pllv3 to support imx7")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-pllv3.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -76,9 +76,9 @@ static int clk_pllv3_prepare(struct clk_
 
 	val = readl_relaxed(pll->base);
 	if (pll->powerup_set)
-		val |= BM_PLL_POWER;
+		val |= pll->powerdown;
 	else
-		val &= ~BM_PLL_POWER;
+		val &= ~pll->powerdown;
 	writel_relaxed(val, pll->base);
 
 	return clk_pllv3_wait_lock(pll);
@@ -91,9 +91,9 @@ static void clk_pllv3_unprepare(struct c
 
 	val = readl_relaxed(pll->base);
 	if (pll->powerup_set)
-		val &= ~BM_PLL_POWER;
+		val &= ~pll->powerdown;
 	else
-		val |= BM_PLL_POWER;
+		val |= pll->powerdown;
 	writel_relaxed(val, pll->base);
 }
 


