Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197AC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD85B20809
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594934291;
	bh=fl1M7KHJ6l6iSD5rSUZXrn1j+ZTdSGkBJT8qw0W0aV8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sUV4EdTdiJiJSUwSop6hBMSLOAegR5HLfB61BHSBVmJP7CXNRDlAyVVxm6q11+NwU
	 dwt9TmU0fzU5TRC1pkUw4k+AWw3GIy79Q2798QPeDBjURBYhucRobqd0MrKsXBP0Yt
	 lNLMHe8mPYDopvMuknUBT9I1igs6xLrFNrHAZTl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGPVR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgGPVRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:17:53 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4451720760;
        Thu, 16 Jul 2020 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594934273;
        bh=fl1M7KHJ6l6iSD5rSUZXrn1j+ZTdSGkBJT8qw0W0aV8=;
        h=Date:From:To:Cc:Subject:From;
        b=QzHl1kwGgmnLUBfSLRD17xkzonCsUImNvS+Y6vY0WCWOfENLRZgMbl4EjNdoheJwF
         /zgVdBHiRfOq9OHpLBfUou8VouyIvV8uIHuAv2NT6WBE9gQ574IH2MK8TkXcf2blHv
         7L8OZIyW1cuQoTCj4I2k1AO5iJcdrEKAsnE/NTzg=
Date:   Thu, 16 Jul 2020 16:23:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] pinctrl: single: Use fallthrough pseudo-keyword
Message-ID: <20200716212317.GA17754@embeddedor>
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
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e6d1cf25782c..132b36ef5d83 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -560,7 +560,7 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 			case PIN_CONFIG_BIAS_PULL_UP:
 				if (arg)
 					pcs_pinconf_clear_bias(pctldev, pin);
-				/* fall through */
+				fallthrough;
 			case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 				data &= ~func->conf[i].mask;
 				if (arg)
-- 
2.27.0

