Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE60CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E8920897
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7S6Pkng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgHZJfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgHZJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88DC06179A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so1066321wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sh6GJ0mJWJb3ICmo91l9UDo6bvtBy9zVj1QpKnJ7Ig=;
        b=E7S6Pkng7Y0zFItSSiJ6u4PAD6CRFndCXBLJmIKAADhgYzB7tAwnaOstq39x7K8YiA
         aYOiEa6IQ9pL2hp7r4/h6gkkN38ntfPXaVOzMazdJu+zmREhsaSzSyEHFJRalsGXtdGq
         RH0GewQfte2wlRM98ENsZ362ARQtgwlM1+Sverg5BwZw6BS9GhUr+h+OwQTC+WD+R5LD
         xP6mO7vA/v8yQcC0oB3mckaIE4cr9uwDkWUMvsQSMjSzBT8BmE3dJhUPo5k9PsJ3dL4n
         7i40Rog29DFzVrx7zYzM4LzRshP1DRoEa6cMkG1OOmgevWJPDDV//yehqKjWH3ay8Sb8
         WoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sh6GJ0mJWJb3ICmo91l9UDo6bvtBy9zVj1QpKnJ7Ig=;
        b=GATM/IBCQPWSfDhQADnwzCf3+HB3TcYjndUKYx07sUk1hGvA/OyXF/XDHmKXOeHUEa
         DP/+8S6ogOkGpxZxJoPodm9TwRoUeDGDlUEXBD1CIu//GSM8/wbVljTNE5E9MYZu2kGf
         s2VdAfHCvdKrGeoTjtEVMilzZX+31Mc24ya309FPUEsXyfXxNIpxJN7fR/+zq+WjfrAU
         afDp2TEmvYaTjU6ycg276Fs7kvKbQBc0szMeHV1LsSpd6GthRs7OxYHk7whMng8pGcIl
         iiktMUE7JTFVNoHZvmyBFQfoE1pV3W3OoSDf4Ay1xlGEyJM4mxsdfTWsc8ITquMDOHxV
         THfQ==
X-Gm-Message-State: AOAM530O7eENy7hMCEQinpjtl8F7U//qrVxIKYK4ORKcdolSVDHBHLof
        4ysHaWRv+tWSijqGXgb6J2h17g==
X-Google-Smtp-Source: ABdhPJzKS5OctiAZPFx3Qk+kjCmzI82WamC6hYGDP51dNtvT2E3Ogaz8sYsUpYWCXWko3lNaCQH5Og==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr6221723wmh.56.1598434465884;
        Wed, 26 Aug 2020 02:34:25 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 17/30] wireless: ath: ath9k: ar9002_initvals: Remove unused array 'ar9280PciePhy_clkreq_off_L1_9280'
Date:   Wed, 26 Aug 2020 10:33:48 +0100
Message-Id: <20200826093401.1458456-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9002_initvals.h:900:18: warning: ‘ar9280PciePhy_clkreq_off_L1_9280’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9002_initvals.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_initvals.h b/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
index 4d18c66a67903..e01b5c3728b86 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
@@ -897,20 +897,6 @@ static const u32 ar9280Modes_original_tx_gain_9280_2[][5] = {
 	{0x00007844, 0x92592480, 0x92592480, 0x92592480, 0x92592480},
 };
 
-static const u32 ar9280PciePhy_clkreq_off_L1_9280[][2] = {
-	/* Addr      allmodes  */
-	{0x00004040, 0x9248fd00},
-	{0x00004040, 0x24924924},
-	{0x00004040, 0xa8000019},
-	{0x00004040, 0x13160820},
-	{0x00004040, 0xe5980560},
-	{0x00004040, 0xc01dcffc},
-	{0x00004040, 0x1aaabe41},
-	{0x00004040, 0xbe105554},
-	{0x00004040, 0x00043007},
-	{0x00004044, 0x00000000},
-};
-
 static const u32 ar9280PciePhy_clkreq_always_on_L1_9280[][2] = {
 	/* Addr      allmodes  */
 	{0x00004040, 0x9248fd00},
-- 
2.25.1

