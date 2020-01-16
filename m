Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2370C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F3D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBXELpEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgAPFMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:12:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34574 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgAPFM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:12:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so2692165pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MM1sOWvjZw+h8vu3/j7lHMVOWjzrQOXMF1caDGRlxsM=;
        b=UBXELpEYZaaovPgS/erHW4L62w2arbooU5yS5QXYpMZPV450e4HZL/du/YMmlC6OLO
         /XOUACrb2ABoUT2CMcudFe11l3pAT61IALWqFw3HUIklgU8z0Xd0g/41KFS0viVkqyMs
         IgNoJGvtOKJrLR1cbo75xinWsCQAaZ9JOY3Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MM1sOWvjZw+h8vu3/j7lHMVOWjzrQOXMF1caDGRlxsM=;
        b=uleN//4aALE8JQ2PYxaGo/M34cO5hzwE7Ca+VwgyxIpD4VBG7mRHD6GDnGpmJA2Xg8
         kAkyMNVjErIdv4L6j7gp/tQYmkfOi8dMsW1D9qtQ7lAH9cABCSa1/oon3sSNizKDpB2X
         3xulOIjvu8vFECpaDyCctZMgP1Hh5SSeahDG+VJp2asWaGqBvQBBOaiss+jLwCMDn4eZ
         YwfQmOmP8sqntPtIQvcnTUC7JD5TMiJL1Z0LFhwRItRrdsoYvVbeWsNQpy2CyG+gnFPI
         RciZLhCObOU6soQeTWJZ0lD3FdExEQE4fXEWGs6or4duorh/lGmPqoq1NFVp8V7sfRwT
         IO2g==
X-Gm-Message-State: APjAAAUc1o7D8qyTanF9wJ7eVbhOVnCBpFpEkvU9b0E2S8t0f+c5V4nd
        8NW5NCDI9I8WIw5Cdd3hhJdjIw==
X-Google-Smtp-Source: APXvYqz32hz+yU4Y2H7zyCA3RkeQAxrxGXqJ6o3lX0NPhyzrcMIWxMdF0Zmy/WCAcPiOdzOAA0SxTQ==
X-Received: by 2002:a17:90a:fa88:: with SMTP id cu8mr4181651pjb.141.1579151548899;
        Wed, 15 Jan 2020 21:12:28 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id l9sm21540217pgh.34.2020.01.15.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 21:12:28 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v3 2/3] arm64: dts: mt8173: add uart aliases
Date:   Thu, 16 Jan 2020 13:12:08 +0800
Message-Id: <20200116051209.37970-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200116051209.37970-1-hsinyi@chromium.org>
References: <20200116051209.37970-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add serial as uart aliases in mt8173.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8b4e806d5119..790cd64aa447 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -50,6 +50,10 @@ aliases {
 		mdp_wdma0 = &mdp_wdma0;
 		mdp_wrot0 = &mdp_wrot0;
 		mdp_wrot1 = &mdp_wrot1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cluster0_opp: opp_table0 {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

