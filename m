Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5972075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9dS+ATy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgG2TWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2TWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:22:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D7C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so2816522plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTfRT4phhdas5zdx8jEfLY3dRt6rlChKS+9tag1reXc=;
        b=E9dS+ATytfXElcxg+e+K9iLMzz6NrScMZb92j0C0xssYcABiBDIc8XQki7okuTry8R
         NMq1b68VROGXHtrFyMnIK/BK7F+zm/iwbP8gJKcARvbPiZM7jEvFva+9jt837mesG7Xp
         /34Fez/3qwa5yZ9srz8byOV0BjKnl+5RyEpRkZ2jC6FSyBOW41a8mfEQDdKLxx77caOP
         POXNA2mwtIcZvQh94nmIXarDEB3wagRVYARUX8mRpIolP4KnNeNVTfNJwyHbhjR2SGda
         lwprWss+MbutJJpMqJRmeJig/aF4rFq4aVPVkYZO2xJ4fyCscFXPz65fLJWvqCNI8TMK
         imtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTfRT4phhdas5zdx8jEfLY3dRt6rlChKS+9tag1reXc=;
        b=A/xGao5XxtsNzPln6ltDI3xQAw52Qbt2MDBwWxE7RVMX5IUGTSSlewnTmNyvGsHqcB
         0/fCgPUdeljvXyeXbvOWGhen9iOUkcyS2Dr3Gl/nNnEfy6Mu2aHbGKO1IkpJjiKS62/p
         6pvW4E6TKvHW+30A7G6KNyCMxOBREQppuIT7khk8w62jZzl93iqmKVWEAxW27Xpb0qNN
         aBQFWvfVwV84a/q0JQ+pAtIv19wxtXcy35sc5crV7cwyjCmOJMVXFIouKPGMadjoLko5
         2iAurroP/poIxrTgp6Kn1bZTwWcAp3K+Du39eZkKLoGBLLYdY6GgJDsP3VJrPSasHqQa
         yogw==
X-Gm-Message-State: AOAM531Q9+1u/izPATWtC9HOhUBJPKW0nPhIm64w5elWd7UxMKz6ig63
        AOsZTgoeMP0qwKMZ3Sen+dNGjsMVf1h87G6Z
X-Google-Smtp-Source: ABdhPJwbCUxpmkSWu34mAItPZC9nXt6mtoVH6tJtlH5pUWs1f2JlE91th79Lqvmhb67JwRNse/CC0g==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr28576752plv.90.1596050528639;
        Wed, 29 Jul 2020 12:22:08 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id hg7sm599431pjb.24.2020.07.29.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:22:08 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, joe@perches.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v4 3/3] staging: rtl8723bs: Align macro definitions
Date:   Thu, 30 Jul 2020 00:51:36 +0530
Message-Id: <20200729192136.23828-4-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729192136.23828-1-aditya.jainadityajain.jain@gmail.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
 <20200729192136.23828-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust spacing in macro definitions to align them and improve
readbility

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 0eb3e57f4082..ed3488a09d79 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -8,11 +8,11 @@
 #define __INC_HAL8723BPHYCFG_H__
 
 /*--------------------------Define Parameters-------------------------------*/
-#define LOOP_LIMIT				5
-#define MAX_STALL_TIME			50		/* us */
+#define LOOP_LIMIT		5
+#define MAX_STALL_TIME		50	/* us */
 #define AntennaDiversityValue	0x80	/* Adapter->bSoftwareAntennaDiversity ? 0x00:0x80) */
 #define MAX_TXPWR_IDX_NMODE_92S	63
-#define Reset_Cnt_Limit			3
+#define Reset_Cnt_Limit		3
 
 #define MAX_AGGR_NUM	0x07
 
-- 
2.25.1

