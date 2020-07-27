Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B1C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E320663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860095;
	bh=qR3qR1P8zCZPBL7I5aiHn7cQAkCbUrhl/7b8QvE1Xlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/9yMId68ioDu2NIkHkiXT7Mr0x+k5ZW2tufA66i4YInQ/MRZpyNWU+OhyelBylIE
	 lyDnTbQc6Do0nD/ueIVNED0w8r7+maOvOoGFmB2DkdETCGe/JhEfUz3O48P5Ju1OrE
	 17+B5/AX4QaNlkkIYJkYAWsOa8pRaVv3fVhAaB7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgG0O2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgG0OYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE99E2075A;
        Mon, 27 Jul 2020 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859892;
        bh=qR3qR1P8zCZPBL7I5aiHn7cQAkCbUrhl/7b8QvE1Xlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRYnqueRcJF8vRC1yL9uF4spC10xtdBFN+876DhC3HE9bKuczX85ZsNJH4Smos52k
         u2OfBRBgHZvNM64dS3eAb9rIqU34mFzJZQyyxM8pE6poruv+Kjb/+RUkvTsNkTZuVt
         96qRYxTTR2yWmX7bFcA351fbkcPimxdplPwrD3+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 118/179] Input: elan_i2c - only increment wakeup count on touch
Date:   Mon, 27 Jul 2020 16:04:53 +0200
Message-Id: <20200727134938.403057177@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

[ Upstream commit 966334dfc472bdfa67bed864842943b19755d192 ]

This moves the wakeup increment for elan devices to the touch report.
This prevents the drivers from incorrectly reporting a wakeup when the
resume callback resets then device, which causes an interrupt to
occur.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Link: https://lore.kernel.org/r/20200706235046.1984283-1-dbasehore@chromium.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elan_i2c_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 8719da5403834..196e8505dd8d7 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -951,6 +951,8 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	u8 hover_info = packet[ETP_HOVER_INFO_OFFSET];
 	bool contact_valid, hover_event;
 
+	pm_wakeup_event(&data->client->dev, 0);
+
 	hover_event = hover_info & 0x40;
 	for (i = 0; i < ETP_MAX_FINGERS; i++) {
 		contact_valid = tp_info & (1U << (3 + i));
@@ -974,6 +976,8 @@ static void elan_report_trackpoint(struct elan_tp_data *data, u8 *report)
 	u8 *packet = &report[ETP_REPORT_ID_OFFSET + 1];
 	int x, y;
 
+	pm_wakeup_event(&data->client->dev, 0);
+
 	if (!data->tp_input) {
 		dev_warn_once(&data->client->dev,
 			      "received a trackpoint report while no trackpoint device has been created. Please report upstream.\n");
@@ -998,7 +1002,6 @@ static void elan_report_trackpoint(struct elan_tp_data *data, u8 *report)
 static irqreturn_t elan_isr(int irq, void *dev_id)
 {
 	struct elan_tp_data *data = dev_id;
-	struct device *dev = &data->client->dev;
 	int error;
 	u8 report[ETP_MAX_REPORT_LEN];
 
@@ -1016,8 +1019,6 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	if (error)
 		goto out;
 
-	pm_wakeup_event(dev, 0);
-
 	switch (report[ETP_REPORT_ID_OFFSET]) {
 	case ETP_REPORT_ID:
 		elan_report_absolute(data, report);
@@ -1026,7 +1027,7 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 		elan_report_trackpoint(data, report);
 		break;
 	default:
-		dev_err(dev, "invalid report id data (%x)\n",
+		dev_err(&data->client->dev, "invalid report id data (%x)\n",
 			report[ETP_REPORT_ID_OFFSET]);
 	}
 
-- 
2.25.1



