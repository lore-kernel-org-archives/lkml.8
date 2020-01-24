Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACBC35243
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B794720718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859897;
	bh=9KSIgLDHVRjgSoKPtmIG72EjgQ0WND4hEZJpGFPXWF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KfW9iyRXfpqfIRv4YdloJRDzluGqS1WDc3+DVOew4t6LYTl9cixOt6uAKdiBbdz/+
	 WdPaJcqd+YO8sk7kr9buaxx05a+q30Xy2kwNHxpkMRC0sVwBtjEVBpjWbp6CRuMCqC
	 s/nqaGPcElRsyPVxjO0OCckK38vZV2yuZOuLvMPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgAXJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAXJ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:58:15 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175B320709;
        Fri, 24 Jan 2020 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859895;
        bh=9KSIgLDHVRjgSoKPtmIG72EjgQ0WND4hEZJpGFPXWF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2vmN3MhgfGILzW5/3HNlIl6OFRjuE/Uns0gagcDpSx9CBtenLClrVgAESP4PzahK
         yQSuw2KoJlT0tWvj5b7DN9CKHsR7VIckoVvTlDBzG/uWJb4i90cTQL7TU98IzO/lGD
         K372qzSJYEKXbN34ojbStPJ6bXHTzB9Vek1cayLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 204/343] pwm: meson: Consider 128 a valid pre-divider
Date:   Fri, 24 Jan 2020 10:30:22 +0100
Message-Id: <20200124092946.863136485@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 51496e4446875726d50a5617a6e0e0dabbc2e6da ]

The pre-divider allows configuring longer PWM periods compared to using
the input clock directly. The pre-divider is 7 bit wide, meaning it's
maximum value is 128 (the register value is off-by-one: 0x7f or 127).

Change the loop to also allow for the maximum possible value to be
considered valid.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9b79cbc7a7152..9551f896dd6f3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	do_div(fin_ps, fin_freq);
 
 	/* Calc pre_div with the period */
-	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
+	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
 		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
 					    fin_ps * (pre_div + 1));
 		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
@@ -197,7 +197,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 			break;
 	}
 
-	if (pre_div == MISC_CLK_DIV_MASK) {
+	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
-- 
2.20.1



