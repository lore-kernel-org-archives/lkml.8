Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6432253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="R+13RLUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgAUKZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:25:13 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42917 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbgAUKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:12 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LAOGnd001924;
        Tue, 21 Jan 2020 11:25:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=8VtkAU/3/Eya8/Y2tSkFqLBiFUUFksXVES1B9OIae6E=;
 b=R+13RLUCi0WA0J+MwaQz1rN31hUF2xJIEkt8p0Q0lbqR9Uas0yl1tqrwCWRWSQ1mdTeO
 w7ib7QOab0PbqOQQXLa9O/uVRuqsy7wO0UEGmJTuI2jgXPzV/1t5SC0x69bopFmuq2dU
 pOE8oYpo5ZhgKeLLOxJMm4QiJkrVytEiIp+gR7SzPxScZaG02bVKwNCBKJKRCQn4Kw1m
 qswpbPooQIX/Di+tlKiME5apbrrIvpgslHAFnisUqnW2fQ+DeFP2WgnRE36NEGfHpslR
 HOvoR62+EYh3gm9TO3mA444a2pyorUkWfDp83I5sUbKTdKWSHEHQyOnEPL59pswMJotw 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrp263dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 11:25:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E14C9100034;
        Tue, 21 Jan 2020 11:24:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0EDA2B1886;
        Tue, 21 Jan 2020 11:24:59 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan 2020 11:24:59
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/synopsys: dsi: missing post disable
Date:   Tue, 21 Jan 2020 11:24:56 +0100
Message-ID: <1579602296-7683-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-21,2020-01-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Sometime the post_disable function is missing (not registered).

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index b18351b..12823ae 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -824,7 +824,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
 	 * This needs to be fixed in the drm_bridge framework and the API
 	 * needs to be updated to manage our own call chains...
 	 */
-	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
+	if (dsi->panel_bridge->funcs->post_disable)
+		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
 
 	if (phy_ops->power_off)
 		phy_ops->power_off(dsi->plat_data->priv_data);
-- 
2.7.4

