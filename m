Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88202C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A29207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PO9xeJHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHUKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:43:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C938C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:43:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so645333pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Smgq9QH6ITzHlCEaZ2WTs0u1Siiq62bIHo++TvYO2wI=;
        b=PO9xeJHQO7yLNU8dB9gYFketKbmGbaTVwy0JqZ+egtpPrGV2TEa/iMZH+q74dNy5PE
         hUrZuMl2I6rXb63S2QnflUFCtaFA2tdYb1lUsbRRngHIVVegWNcUf1Ev3lAPwP2B2+qn
         VLkTWMSL1Tx+1HkcFIuvWfIanNGOfz64jVTys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Smgq9QH6ITzHlCEaZ2WTs0u1Siiq62bIHo++TvYO2wI=;
        b=Tg0K8jBOlTPUerbinB8DNQ+S6LSOxDsTZTrubrOUV4wiN5zj8A/FVTURIdrrWakeWc
         ZRaqKTi484Y3/HW5vhlozXShiywm5xiVa5NmMukZoc+sr7FSVIG2y1vI0RmhDfqFtJZ/
         dY5BGZUmVAEzfn9yuTACrCenD13wvr4KYBs4ClE0hE5Vqa9s4jAzn7M6w8WWpohL16Ed
         7oSG3TMn8cNEGwALaHfoNbqOeQh947uO1NwM1b6vd0XnUmJF1ppiyC723UTHNS+ygoA3
         5p1giGxNwuLJ9UTwxIfv7v4A098Ai0wgnWDAVu72CrfdIuikFgj8VAMMbSQqOmg33u/p
         99ng==
X-Gm-Message-State: AOAM533DXc850lARdwnVOGCC1vxsjI17icdwjXMCbY+3gUJUUadEqAZA
        cr5/hYyNPihD7jOLbnCUpY2kgQ==
X-Google-Smtp-Source: ABdhPJzIRnaiX5NahGrBHc0yJTbDeE30V8e1QerUQtKubjzLl+plnuf20VRhxSPT2BLWVwvuuXipJA==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr1898723plo.129.1598006598991;
        Fri, 21 Aug 2020 03:43:18 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id t19sm2149536pfc.5.2020.08.21.03.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:43:18 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] media: mtk-vcodec: fix Kconfig help text
Date:   Fri, 21 Aug 2020 19:43:05 +0900
Message-Id: <20200821104305.2315218-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig help text for VIDEO_MEDIATEK_VCODEC was referring to a
single module named mtk-vcodec, while this driver produces two modules
named mtk-vcodec-dec and mtk-vcodec-enc. Fix that.

Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c57ee78fa99d..bbf32086b607 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -261,8 +261,8 @@ config VIDEO_MEDIATEK_VCODEC
 	    encode and decode in a range of video formats
 	    This driver rely on VPU driver to communicate with VPU.
 
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-vcodec
+	    To compile this driver as modules, choose M here: the
+	    modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
 
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
-- 
2.28.0.297.g1956fa8f8d-goog

