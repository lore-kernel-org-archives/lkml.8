Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A8C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CB820720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiY+ovWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgGOJc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbgGOJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985BC08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so4873419wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8U06NLcMENL/oYfcJzreTwouhkL9v7k29Tx6r8ox8+8=;
        b=aiY+ovWUMb8mZ9RQ8izdZPW2TqncCoThpGN6EUuolCrmTshY+liAvzgbIZT9H70/Qt
         CXLaIJsHhX4rZIfgAemVCIHPettcFED06oqVrq9g2I1DINMPdqWOPqTeQvYP1gyzhd21
         uac3QqaBoTvc4AqlqerJImwCaqBy0hDdtf2f9NMJktRs0ZbfBM9rK2EtUEI+LMwRC7Ae
         brrBADWqEhBR8u3u18co8QNw07W3lWqMxL3ilnvvHo94FHFs7PsjZVU7LnS2yH9R+IMU
         W0w0ZIjY5oxH8JJHjc4cGq/M+3mvKO3eVYbBC5iBH6NPwEWrBEUUY5rkJQ6sBIFmL2k3
         wmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8U06NLcMENL/oYfcJzreTwouhkL9v7k29Tx6r8ox8+8=;
        b=otCAjEWad+MInk5hYxawWGyguLYdfMxIpFesyl1HjsQWvWOfU25vOyJ8p+aRTARchW
         5H//APDTCgwfRzUnFvampxU5EhZWFu1kzC3slhzC9g3Jq8WbsKw0QrIwRXRYLdxwGZDC
         CEwMvxoycYZz5t/XJQJbOnarUROZO9vQUJdOkzH3Gu64xAoBAlpjc6fH1OhUuUdIl1m+
         krqvyaSjU0IxjlduMJhH9HQSRHhlsYHNHlyu3FFGL+A90YbHSiN0gTKB7r+jzs7i2Ztl
         X1d4/4b1Ipvw6XgzXZzn1NxQIKfotAbv7gjMyk9TYnF9ZBccMgJn/bnbNTegjQ3YNBt8
         yEyw==
X-Gm-Message-State: AOAM532TWt9GHtkheeHyVEUiE3I64L39eFUDd/40XqdFE1He54CrluFI
        FFMy7gjr4DbCUa+ixw6s6045nQ==
X-Google-Smtp-Source: ABdhPJzTD7bi5/tJ+vHl+ML+4jkKggUyRiqyxba601y5XT1IDUPpQoi7sZAllE+VaX8AYsP/xye2kA==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr7496480wmg.153.1594805541691;
        Wed, 15 Jul 2020 02:32:21 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 7/8] usb: misc: sisusbvga: sisusb_init: Remove genunine unused static const arrays
Date:   Wed, 15 Jul 2020 10:32:08 +0100
Message-Id: <20200715093209.3165641-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715093209.3165641-1-lee.jones@linaro.org>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are not referenced anywhere in the kernel.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:170:29: warning: ‘ModeIndex_1280x768’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:169:29: warning: ‘ModeIndex_1280x720’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:168:29: warning: ‘ModeIndex_1152x864’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:167:29: warning: ‘ModeIndex_1024x576’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:166:29: warning: ‘ModeIndex_1024x768’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:165:29: warning: ‘ModeIndex_960x600’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:164:29: warning: ‘ModeIndex_960x540’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:163:29: warning: ‘ModeIndex_856x480’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:162:29: warning: ‘ModeIndex_848x480’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:161:29: warning: ‘ModeIndex_800x600’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:160:29: warning: ‘ModeIndex_800x480’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:159:29: warning: ‘ModeIndex_768x576’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:158:29: warning: ‘ModeIndex_720x576’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:157:29: warning: ‘ModeIndex_720x480’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:156:29: warning: ‘ModeIndex_640x480’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:155:29: warning: ‘ModeIndex_640x400’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:154:29: warning: ‘ModeIndex_512x384’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:153:29: warning: ‘ModeIndex_400x300’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:152:29: warning: ‘ModeIndex_320x240’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:151:29: warning: ‘ModeIndex_320x200’ defined but not used [-Wunused-const-variable=]
 drivers/usb/misc/sisusbvga/sisusb_init.h:232:37: warning: ‘SiSUSB_ModeResInfo’ defined but not used [-Wunused-const-variable=]

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog

v2: New patch

 drivers/usb/misc/sisusbvga/sisusb_init.h | 31 ------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_init.h b/drivers/usb/misc/sisusbvga/sisusb_init.h
index b79bdf989933f..80ba458f28cb0 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_init.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.h
@@ -147,29 +147,6 @@
 #define SIS_VIDEO_PLAYBACK	0x02 - 0x30
 #define SIS_CRT2_PORT_04	0x04 - 0x30
 
-/* Mode numbers */
-static const unsigned short ModeIndex_320x200[] = { 0x59, 0x41, 0x00, 0x4f };
-static const unsigned short ModeIndex_320x240[] = { 0x50, 0x56, 0x00, 0x53 };
-static const unsigned short ModeIndex_400x300[] = { 0x51, 0x57, 0x00, 0x54 };
-static const unsigned short ModeIndex_512x384[] = { 0x52, 0x58, 0x00, 0x5c };
-static const unsigned short ModeIndex_640x400[] = { 0x2f, 0x5d, 0x00, 0x5e };
-static const unsigned short ModeIndex_640x480[] = { 0x2e, 0x44, 0x00, 0x62 };
-static const unsigned short ModeIndex_720x480[] = { 0x31, 0x33, 0x00, 0x35 };
-static const unsigned short ModeIndex_720x576[] = { 0x32, 0x34, 0x00, 0x36 };
-static const unsigned short ModeIndex_768x576[] = { 0x5f, 0x60, 0x00, 0x61 };
-static const unsigned short ModeIndex_800x480[] = { 0x70, 0x7a, 0x00, 0x76 };
-static const unsigned short ModeIndex_800x600[] = { 0x30, 0x47, 0x00, 0x63 };
-static const unsigned short ModeIndex_848x480[] = { 0x39, 0x3b, 0x00, 0x3e };
-static const unsigned short ModeIndex_856x480[] = { 0x3f, 0x42, 0x00, 0x45 };
-static const unsigned short ModeIndex_960x540[] = { 0x1d, 0x1e, 0x00, 0x1f };
-static const unsigned short ModeIndex_960x600[] = { 0x20, 0x21, 0x00, 0x22 };
-static const unsigned short ModeIndex_1024x768[] = { 0x38, 0x4a, 0x00, 0x64 };
-static const unsigned short ModeIndex_1024x576[] = { 0x71, 0x74, 0x00, 0x77 };
-static const unsigned short ModeIndex_1152x864[] = { 0x29, 0x2a, 0x00, 0x2b };
-static const unsigned short ModeIndex_1280x720[] = { 0x79, 0x75, 0x00, 0x78 };
-static const unsigned short ModeIndex_1280x768[] = { 0x23, 0x24, 0x00, 0x25 };
-static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
-
 static const unsigned char SiS_MDA_DAC[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x15, 0x15, 0x15, 0x15, 0x15, 0x15, 0x15, 0x15,
@@ -221,14 +198,6 @@ static const struct SiS_St SiSUSB_SModeIDTable[] = {
 	{0xff, 0x0000, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
 };
 
-static const struct SiS_StResInfo_S SiSUSB_StResInfo[] = {
-	{640, 400},
-	{640, 350},
-	{720, 400},
-	{720, 350},
-	{640, 480}
-};
-
 static const struct SiS_ModeResInfo SiSUSB_ModeResInfo[] = {
 	{320, 200, 8, 8},	/* 0x00 */
 	{320, 240, 8, 8},	/* 0x01 */
-- 
2.25.1

