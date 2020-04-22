Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677D9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B84E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550467;
	bh=S6wAKXdXmDJgv7u1+X6ARKowSlSQupWIYsmGHU1DPC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q72KQfCArg+iHaEWFtCtvi5GtO6uwo2KsZ3ZsyLmqsGMRsk6Td7OrRy14dJpEfR6D
	 kcPxxfMO5K8hZmShTWztBD8XKrk897JkftSwfxKPMx6+zP8TmmMxwOPtPomY8BZx/O
	 iJXkiZIbJ2n+DpPjbmCoCI3qeNSH3BwHS/4egyt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgDVKOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgDVKOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:14:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75BF2071E;
        Wed, 22 Apr 2020 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550460;
        bh=S6wAKXdXmDJgv7u1+X6ARKowSlSQupWIYsmGHU1DPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXd4ViGOuBcau4MOwRzC1ytBcp5jo1wXO78JBWTqVgM7N+3dtUQBmLjUnu4uwU1JD
         xPX0ZwPOdR7SZRM9t64cl1oVQxtdsNE8XWpre3SE/YGhyJN/GGw53YlYMH9LIfLT10
         EWs6Zao53Mo+2y50NGVJdZigyqDNhDb2w2hUM3u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/64] clk: at91: usb: continue if clk_hw_round_rate() return zero
Date:   Wed, 22 Apr 2020 11:57:10 +0200
Message-Id: <20200422095017.682191538@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 791770a563fcc..6fac6383d024e 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -78,6 +78,9 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
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



