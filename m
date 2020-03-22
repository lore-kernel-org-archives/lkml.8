Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF57C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0458F2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 14:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG6B+FaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVOjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:39:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:39:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so11505330wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GvYI8WaQRSbAIkEp+Up6kURcpv9g50Aym6muvhz7xBk=;
        b=MG6B+FaJToH/hEbijjzGNT+dZCOT/OH2l1ug1yhxI1tRY+Kx4h7Qcx5wgTBXnNsXIk
         bdAe1IQHfJidPmlO5cXDKtzLuQGBXjYHAVZHMIcreusk55CAapRHO74hiaM69z4xEn3u
         D2KYNOMnAbfj/K5e180nZnqjQt5utjMEkOP+0BIIB1wxJeCEOjX7/jP76TOFVPRhuNrO
         UAA5ZYU+Kq7uij8PQ3l0ezbGoSCjwoJPuFwCoFGbuLfzSe7ERPpNJxTAalEP52Wwge0B
         fogqV4IwV6+G0CqyCOQHqAC8vfi8whjRENquE4UzwKFsEU2KkBjUOSQvv9aWLlj5rxsG
         qXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GvYI8WaQRSbAIkEp+Up6kURcpv9g50Aym6muvhz7xBk=;
        b=SLONTA6XBLlsEG+omxna3AEU8FyCq+f4kvetsKW+386c7b7mcFLx3RSifQdFRaEq+/
         /IVpz9eP3LG3STZ2Fsyx2tBCsqgdND+HjqYTNFkJNMmYWHo6Y5YCMGJGY0GVBwjHGHu3
         slBg88VMRf16cOX5UwpCMMUUziYwGZeiOHTDkPMMyizip7mv646wUMb40zQOg9ZHbOhX
         BF6HPdmm4eGe2UvohjJrOeCRJoKijO46tfMe7yWUIn99MxV7NukvqA9WLKLtir6xfQuc
         D/QDBEiH4kgVdSPTffw0wOD75GBGzkSX94lL+BFhrJCshDCQvVeTlbWbUELZifkCXnlc
         7rpg==
X-Gm-Message-State: ANhLgQ1Al7oJp9K6qy1vbggNNS8qd3u8LhK7f8kl54Bzq4j2304aLzyl
        /qEzOX1BtTHz0ESMwBTFK3njXdky
X-Google-Smtp-Source: ADFU+vup5qzK9YYNoPmyhRsWYhSMMd02Kja055juOR71uh7IvlkYt4Y0Ovpn4xCJZjN8m2UoDR+ACg==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr21990439wms.18.1584887945061;
        Sun, 22 Mar 2020 07:39:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i8sm18204993wrw.55.2020.03.22.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 07:39:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: fix pm manual->auto in GOYA
Date:   Sun, 22 Mar 2020 16:39:04 +0200
Message-Id: <20200322143904.2305-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving from manual to automatic power management mode in GOYA, the
driver didn't correctly place the device in LOW power mode. As a result, if
an application was run immediately after the move, it would have run with
low frequencies.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index b2ebc01e27f4..cdd4903e48fa 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -298,8 +298,8 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 		/* Make sure we are in LOW PLL when changing modes */
 		if (hdev->pm_mng_profile == PM_MANUAL) {
 			hdev->curr_pll_profile = PLL_HIGH;
-			hl_device_set_frequency(hdev, PLL_LOW);
 			hdev->pm_mng_profile = PM_AUTO;
+			hl_device_set_frequency(hdev, PLL_LOW);
 		}
 	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
 		if (hdev->pm_mng_profile == PM_AUTO) {
-- 
2.17.1

