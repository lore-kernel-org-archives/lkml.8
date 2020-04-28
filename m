Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22291C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1132085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098372;
	bh=e50X4MmtkJexI4QRd79cP3skCvlBuDS3y6zV+tBhyIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jSAJXK//wBkkr2ZEoiA+9DDV0y6NV0omkJF90WernFB0o714XmUg5tYmyWZ+0q916
	 b9RgHWYqhmBLFI+6RURlXKU2dOqaDfHo5fXNwaXD4gdVhd66LpDRbrJ/pzflHTV27o
	 3Ua9Ud5WBvfE2Q/dG+Gvr8epqGyj2CETIv+yT5Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgD1S0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgD1S0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:26:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4D120730;
        Tue, 28 Apr 2020 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098366;
        bh=e50X4MmtkJexI4QRd79cP3skCvlBuDS3y6zV+tBhyIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtSXGZoLFane33lkPVPiseMKhAVeyJQb2zsYoSxDA4rhus1xhipMh4JQoPcnRMZdj
         rpzp3MGr2QaNvm3WppA1etca5uFEtfeWSSLYjuJcBK1VQBU6lTspkbAaNS/O73kYZ4
         SsZsSWEA16DfGfJVjCuasXSdrfxvIv+IERUegA5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 011/167] pwm: imx27: Fix clock handling in pwm_imx27_apply()
Date:   Tue, 28 Apr 2020 20:23:07 +0200
Message-Id: <20200428182226.639247102@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 15d4dbd601591858611184f9ddeb5bf21569159c ]

pwm_imx27_apply() enables the clocks if the previous PWM state was
disabled. Given that the clocks are supposed to be left on iff the PWM
is running, the decision to disable the clocks at the end of the
function must not depend on the previous state.

Without this fix the enable count of the two affected clocks increases
by one whenever ->apply() changes from one disabled state to another.

Fixes: bd88d319abe9 ("pwm: imx27: Unconditionally write state to hardware")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 35a7ac42269c2..7e5ed01529773 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
-	if (!state->enabled && cstate.enabled)
+	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(chip);
 
 	return 0;
-- 
2.20.1



