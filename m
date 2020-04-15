Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78183C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D202076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586957055;
	bh=cBk92c6nBULUxUTVafmDFD/ihP1iNDRokzEmXGn7xkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oPmcLRObEebI1/8tl5knns0TgxWOuzJIltQiYW9ld7eT8pPtuNGirXl43tI7zc44k
	 fv3fUSQVghdsJVUH1MBEk7BAEIVb2brJflYzSEQ+6y9GFPjhIowUlITZ6+5gx756+u
	 E+T0DT0KBjMIbp409mQeQC/pZzYymcdzeZ2+AB3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636069AbgDONYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408864AbgDOLev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:34:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F287D20768;
        Wed, 15 Apr 2020 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950490;
        bh=cBk92c6nBULUxUTVafmDFD/ihP1iNDRokzEmXGn7xkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDoUCdS4L2RiHtyR3f8jKeRDOaH2fWsBFLyCY44blbQvXqCKraDyzha+1vdwnb/a2
         YkoRhM0Wc7GDFQwJpwPNYHDR5xwoczytqyf7xxSPn8V9SR3Jl6DwFXR6uq7mMbNC/S
         S3kTgEwazXT08Y6e7BSC+hYfQEpkMbEwUtA5R9Es=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 004/129] clk: at91: usb: continue if clk_hw_round_rate() return zero
Date:   Wed, 15 Apr 2020 07:32:39 -0400
Message-Id: <20200415113445.11881-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit b0ecf1c6c6e82da4847900fad0272abfd014666d ]

clk_hw_round_rate() may call round rate function of its parents. In case
of SAM9X60 two of USB parrents are PLLA and UPLL. These clocks are
controlled by clk-sam9x60-pll.c driver. The round rate function for this
driver is sam9x60_pll_round_rate() which call in turn
sam9x60_pll_get_best_div_mul(). In case the requested rate is not in the
proper range (rate < characteristics->output[0].min &&
rate > characteristics->output[0].max) the sam9x60_pll_round_rate() will
return a negative number to its caller (called by
clk_core_round_rate_nolock()). clk_hw_round_rate() will return zero in
case a negative number is returned by clk_core_round_rate_nolock(). With
this, the USB clock will continue its rate computation even caller of
clk_hw_round_rate() returned an error. With this, the USB clock on SAM9X60
may not chose the best parent. I detected this after a suspend/resume
cycle on SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lkml.kernel.org/r/1579261009-4573-2-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/clk-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 22aede42a3362..3c0bd7e51b09d 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -75,6 +75,9 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 			tmp_parent_rate = req->rate * div;
 			tmp_parent_rate = clk_hw_round_rate(parent,
 							   tmp_parent_rate);
+			if (!tmp_parent_rate)
+				continue;
+
 			tmp_rate = DIV_ROUND_CLOSEST(tmp_parent_rate, div);
 			if (tmp_rate < req->rate)
 				tmp_diff = req->rate - tmp_rate;
-- 
2.20.1

