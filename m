Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80024C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B332173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220035;
	bh=TWHetQeApuPwWwnFAnNwR4s/mLNZZaOaZdJP3JYknWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mBCYQvOrgM+O+4tFlnRxZRRygUVgYc/Tis+10u5SAF1OktKSsr9s6yClS9IANNyc
	 WOy21vqwuXBQrCNANlfy9XbLAWYDCZjF1LSM4x+c6NUtww4KtOArj4uzRbcAydsDFr
	 Dr/W7PkhLN9JF2NK0vRqBD292RdEy9ZMtQC1+zyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgA1OAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgA1OAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7EC2468A;
        Tue, 28 Jan 2020 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220009;
        bh=TWHetQeApuPwWwnFAnNwR4s/mLNZZaOaZdJP3JYknWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3LgxbHns+4Nw2wK0uMOD7HlllTF2hB68Ie+LukC2/bQ+pZFVlWt8Vpr50NeP532a
         rORpn4gt5Y2lEop/Tu7a7MFcVlJuz05EL4sZuafpA1XNJjlwTV3vn+V88+gnwsvHjP
         PVW54M9RaYsiZwMkQgkdEtB9STFIQnwcwsKVBPnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 32/46] Input: sun4i-ts - add a check for devm_thermal_zone_of_sensor_register
Date:   Tue, 28 Jan 2020 14:58:06 +0100
Message-Id: <20200128135754.144302291@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 97e24b095348a15ec08c476423c3b3b939186ad7 upstream.

The driver misses a check for devm_thermal_zone_of_sensor_register().
Add a check to fix it.

Fixes: e28d0c9cd381 ("input: convert sun4i-ts to use devm_thermal_zone_of_sensor_register")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/sun4i-ts.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -246,6 +246,7 @@ static int sun4i_ts_probe(struct platfor
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device *hwmon;
+	struct thermal_zone_device *thermal;
 	int error;
 	u32 reg;
 	bool ts_attached;
@@ -365,7 +366,10 @@ static int sun4i_ts_probe(struct platfor
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	devm_thermal_zone_of_sensor_register(ts->dev, 0, ts, &sun4i_ts_tz_ops);
+	thermal = devm_thermal_zone_of_sensor_register(ts->dev, 0, ts,
+						       &sun4i_ts_tz_ops);
+	if (IS_ERR(thermal))
+		return PTR_ERR(thermal);
 
 	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
 


