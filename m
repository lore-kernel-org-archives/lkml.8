Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76706C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D192076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFVUn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:43:56 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41703 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgFVUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:43:50 -0400
Received: from [37.163.98.205] (port=42634 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jnTIA-00062o-Uu; Mon, 22 Jun 2020 22:43:47 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v3 4/4] mfd: lp87565: add LP87524-Q1 variant
Date:   Mon, 22 Jun 2020 22:43:29 +0200
Message-Id: <20200622204329.11147-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622204329.11147-1-luca@lucaceresoli.net>
References: <20200622204329.11147-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LP87524B/J/P-Q1 Four 4-MHz Buck Converter. This is a
variant of the LP87565 having 4 single-phase outputs and up to 10 A of
total output current.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

---

Changes in v3: none

Changes in v2:
 - replace "regulator" -> "mfd" in subject line (Lee Jones)
 - add Acked-for-MFD-by: from Lee Jones
---
 drivers/mfd/lp87565.c       | 4 ++++
 include/linux/mfd/lp87565.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 4a5c8ade4ae0..cc1072927f6d 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -26,6 +26,10 @@ static const struct mfd_cell lp87565_cells[] = {
 
 static const struct of_device_id of_lp87565_match_table[] = {
 	{ .compatible = "ti,lp87565", },
+	{
+		.compatible = "ti,lp87524-q1",
+		.data = (void *)LP87565_DEVICE_TYPE_LP87524_Q1,
+	},
 	{
 		.compatible = "ti,lp87565-q1",
 		.data = (void *)LP87565_DEVICE_TYPE_LP87565_Q1,
diff --git a/include/linux/mfd/lp87565.h b/include/linux/mfd/lp87565.h
index ce965354bbad..ad240f2d0d3f 100644
--- a/include/linux/mfd/lp87565.h
+++ b/include/linux/mfd/lp87565.h
@@ -14,6 +14,7 @@
 
 enum lp87565_device_type {
 	LP87565_DEVICE_TYPE_UNKNOWN	= 0,
+	LP87565_DEVICE_TYPE_LP87524_Q1,
 	LP87565_DEVICE_TYPE_LP87561_Q1,
 	LP87565_DEVICE_TYPE_LP87565_Q1,
 };
-- 
2.27.0

