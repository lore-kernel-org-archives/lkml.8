Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECD120578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690375;
	bh=IVjjFA0DYsoC7bTosHCMh3WCsr8pULJgQQr7kWsxjpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dj/4rCsCeHHS/zvX33MXmcUEd/fnTa5mFnVjiCKKOCH+T3RCp2NUXcwgAL57cmeN2
	 2ozRlVPBvqEOyPRwIOof6CpPeJ9yYMOZu/ScGRnKvX4yFwk9X5Mo3hFoRJAfGi/66W
	 uu0iZvZRIap8Xj8N6oA6DhLmGy3g6xbaInL7jn7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbgHQSwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbgHQPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C8720729;
        Mon, 17 Aug 2020 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679528;
        bh=IVjjFA0DYsoC7bTosHCMh3WCsr8pULJgQQr7kWsxjpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWWoYwNj+9xvAiG1cu+65I8x0woui9/coGj3npHOf7xtRBnTcDAskxJODi8234U/D
         N9BtX1QRMp+cttOw1q1ydGcTGce72zN2cxDPTdg2QAUk/4L9Vp+CIwxLhctpKGnzM8
         qdRyC3OCeGhjZ17tI9pfgHbwc6uihaWI1ITXHMeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 243/393] thermal: int340x: processor_thermal: fix: update Jasper Lake PCI id
Date:   Mon, 17 Aug 2020 17:14:53 +0200
Message-Id: <20200817143831.406811888@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

[ Upstream commit 287d959558357e155c889bc35579eb35691a8fcb ]

Update PCI device id for Jasper Lake processor thermal device.
With this proc_thermal driver is getting loaded and processor
thermal functionality works on Jasper Lake system.

Fixes: f64a6583d3f5 ("thermal: int340x: processor_thermal: Add Jasper Lake support")
Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1595577146-1221-1-git-send-email-sumeet.r.pawnikar@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 297db1d2d960c..81e8b15ef405d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -43,7 +43,7 @@
 #define PCI_DEVICE_ID_PROC_ICL_THERMAL	0x8a03
 
 /* JasperLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
+#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4E03
 
 /* TigerLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_TGL_THERMAL	0x9A03
-- 
2.25.1



