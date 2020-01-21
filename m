Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A53C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0B24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kvcb/h3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAUKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:14:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbgAUKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:14:20 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LA7mnA015236;
        Tue, 21 Jan 2020 11:14:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=fDNwiFZy5CZXyHgGGVM3ojrT2gDVM3TeYsu274+e8sk=;
 b=kvcb/h3lu7vWmL9lvSxH0sm7BiUsG94BYCNDhj1TbPVhaT1jq9iL0Pixr+riZJXA30H1
 HKpYFQKiAaSXqgURAQAdjXBsN2PRQwcHbNHFH0QY/n/FxECQS3RYHSK1+dwxU44m0e23
 6xUYuLO0jNgmaqs2rZMpfXrpyJchzeWzb7TZG3Dn8SefPmJcC+rSOVA+jO454IqSKwKq
 xC8Efn4kXkCDewkVMtMWpqc+9O77kHuX29CH/5DGsJ/HaCU2fZIgZ9MvKJ+4vIRZWkqy
 CBZn+HE9EthdiJF2iaduoCbjGYq8MyR5BHJU2L0zaI3EwFQXXXmXXYcxVqkuSLC6aZGO rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1dx2q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 11:14:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA87110002A;
        Tue, 21 Jan 2020 11:14:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BAC9F2B1872;
        Tue, 21 Jan 2020 11:14:12 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan 2020 11:14:11
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
Subject: [PATCH] drm/stm: ltdc: check crtc state before enabling LIE
Date:   Tue, 21 Jan 2020 11:14:10 +0100
Message-ID: <1579601650-7055-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-21,2020-01-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following investigations of a hardware bug, the LIE interrupt
can occur while the display controller is not activated.
LIE interrupt (vblank) don't have to be set if the CRTC is not
enabled.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index c2815e8..ea654c7 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -648,9 +648,14 @@ static const struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
 static int ltdc_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct drm_crtc_state *state = crtc->state;
 
 	DRM_DEBUG_DRIVER("\n");
-	reg_set(ldev->regs, LTDC_IER, IER_LIE);
+
+	if (state->enable)
+		reg_set(ldev->regs, LTDC_IER, IER_LIE);
+	else
+		return -EPERM;
 
 	return 0;
 }
-- 
2.7.4

