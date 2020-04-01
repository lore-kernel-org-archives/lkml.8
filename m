Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02714C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948C620719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759270;
	bh=JritSytOa17n9A8eCr1IfHZFbdBPS/YBgudn9Ph3Q20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6KzSpkBS4vYl/tkhdTCASxSsj2QeH23bnkHHh5iPHtPt/twk7JSyG/gx506CuwGp
	 xfLyIAzqgOVzkqUQCMIg+LeVXSTWiQOgVvte8erW5v7ZpczCL0QDuty5z1R8Bxm5mF
	 Sp/p9EpRXATaYZYtSLxwJDk1Bu8WqqDCqXqujyTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbgDAQlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389215AbgDAQlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:41:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E6A20658;
        Wed,  1 Apr 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759266;
        bh=JritSytOa17n9A8eCr1IfHZFbdBPS/YBgudn9Ph3Q20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNx+xDIa2HCv2FytIHtmmQjy6FAUVSHetkv3zPi1O05RM/HBrPwTFJfokX2tRaAAU
         vEbfd/sgaX7xsY+Wc0nu9v3duHLut48FDTRe7zqOiNvUJ1+NazL3iUkwd5cwPnGlxa
         YR+QlVZIU6c4fDtde9YT1Py7lQi0z+oyakQEvJik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 026/148] iio: trigger: stm32-timer: disable master mode when stopping
Date:   Wed,  1 Apr 2020 18:16:58 +0200
Message-Id: <20200401161555.014527689@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 29e8c8253d7d5265f58122c0a7902e26df6c6f61 upstream.

Master mode should be disabled when stopping. This mainly impacts
possible other use-case after timer has been stopped. Currently,
master mode remains set (from start routine).

Fixes: 6fb34812c2a2 ("iio: stm32 trigger: Add support for TRGO2 triggers")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/trigger/stm32-timer-trigger.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -161,7 +161,8 @@ static int stm32_timer_start(struct stm3
 	return 0;
 }
 
-static void stm32_timer_stop(struct stm32_timer_trigger *priv)
+static void stm32_timer_stop(struct stm32_timer_trigger *priv,
+			     struct iio_trigger *trig)
 {
 	u32 ccer, cr1;
 
@@ -179,6 +180,12 @@ static void stm32_timer_stop(struct stm3
 	regmap_write(priv->regmap, TIM_PSC, 0);
 	regmap_write(priv->regmap, TIM_ARR, 0);
 
+	/* Force disable master mode */
+	if (stm32_timer_is_trgo2_name(trig->name))
+		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
+	else
+		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0);
+
 	/* Make sure that registers are updated */
 	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
 }
@@ -197,7 +204,7 @@ static ssize_t stm32_tt_store_frequency(
 		return ret;
 
 	if (freq == 0) {
-		stm32_timer_stop(priv);
+		stm32_timer_stop(priv, trig);
 	} else {
 		ret = stm32_timer_start(priv, trig, freq);
 		if (ret)


