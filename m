Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DAFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A28207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594934146;
	bh=h/em9K6MxDXMOHjxGdY99yuk+p+fQPMn9vwXzhhReP4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MToxN0iCFWHRDQwNbuDl83gGLSzfms9bnhC6osowr56ry0h6B5gIMuJ8X3DM/nekz
	 TXzF4xhX2+KelGo8XVnyTqXT1SMAjMmWkdMya24UuczQ5jbmBcJvhvat8GtojOGTRK
	 HErQ79V28s53YA6S97spBzjJMLmPQ13GPCHEmdmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGPVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgGPVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:15:44 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D661420760;
        Thu, 16 Jul 2020 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594934144;
        bh=h/em9K6MxDXMOHjxGdY99yuk+p+fQPMn9vwXzhhReP4=;
        h=Date:From:To:Cc:Subject:From;
        b=AlcV9UiXn76wQ5TPlMxwklxSfCcqzNCOttJ2E9/1K3oFP9+Fzbtg6x6fSy0sgK44A
         hCax+kzlshEXMUscFumly+UKFmFSUzCc/ojX610pDXbonABJwcSbMfln0jgAMyTB0Q
         W35XVUF/UweKiN/zSpsbxfLfLWR+SLS12SDCDyLA=
Date:   Thu, 16 Jul 2020 16:21:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] pinctrl: lpc18xx: Use fallthrough pseudo-keyword
Message-ID: <20200716212109.GA17525@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pinctrl/pinctrl-lpc18xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index e4677546aec4..7b2f885e68bd 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -838,11 +838,11 @@ static int lpc18xx_pconf_get_pin(struct pinctrl_dev *pctldev, unsigned param,
 		*arg = (reg & LPC18XX_SCU_PIN_EHD_MASK) >> LPC18XX_SCU_PIN_EHD_POS;
 		switch (*arg) {
 		case 3: *arg += 5;
-			/* fall through */
+			fallthrough;
 		case 2: *arg += 5;
-			/* fall through */
+			fallthrough;
 		case 1: *arg += 3;
-			/* fall through */
+			fallthrough;
 		case 0: *arg += 4;
 		}
 		break;
@@ -1057,11 +1057,11 @@ static int lpc18xx_pconf_set_pin(struct pinctrl_dev *pctldev, unsigned param,
 
 		switch (param_val) {
 		case 20: param_val -= 5;
-			 /* fall through */
+			fallthrough;
 		case 14: param_val -= 5;
-			 /* fall through */
+			fallthrough;
 		case  8: param_val -= 3;
-			 /* fall through */
+			fallthrough;
 		case  4: param_val -= 4;
 			 break;
 		default:
-- 
2.27.0

