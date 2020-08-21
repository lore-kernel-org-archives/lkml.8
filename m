Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B073C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3F820FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i6Rv+XXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgHUKh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgHUKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA52C061345
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so813320pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBKM3WA3cxwbZdd9vidSjpRU6jIZw5t/CObNuc//DI8=;
        b=i6Rv+XXnjNjy27SQXI/HnMTwHPPjsN5K9vvKj/YydK3hJUlen91zcGd1BJAGH71wKl
         9ETzlShNPCuGpWfHgkbCuo3ip124aauRX0kUD+Mmy94bYAQQ/nGc2jW2U41kgwzLU/4p
         t94XMN4WljNjgGAeyPTqBVlHygh9JVAtZaOGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBKM3WA3cxwbZdd9vidSjpRU6jIZw5t/CObNuc//DI8=;
        b=sorpIOGSXY/DTEOMhT75cepP/TNqpqOiJ5nQ2oE1cMa+UBiYP3vYhW0q4ixxSwkaLn
         I9h6SfMg54j43IAp0vQ//XfF4V6dVZbSpKWVEtubQUY9JySLhGhXv9C52HQ3gXZVOoQI
         7VLsG7JdOFPGtibnAB3gVX9GR7cgqhIqQ0MpGWTbTCcahVOcOatgL5owndOn+vyMQMXh
         30O+y8oXXezRYMdHOauOcN8MQOS8yhG7MdISMbM9yx1PQjcztBfHlRibzRNQC6TUMIEq
         XHR8Q1AmALALvaJF2IaKVfNdfsMRGxWYeKPVg6s9iMQZzZOty14p2rbG02w2T34Opewt
         qv9A==
X-Gm-Message-State: AOAM5330ZiBbcdSGhJDG4gmYesHcEEcAO4eWXODco6OT9bzNK8Yhkpav
        lGOUs/jP7AglD0ro7tzQlZzJwg==
X-Google-Smtp-Source: ABdhPJy2dZG1ArmjW2HfNTswI284X9+chI109neRtlOF7ZLdH/tGkTT3NlNsQdVnT+PR4Ees3+cN7Q==
X-Received: by 2002:aa7:8f3a:: with SMTP id y26mr1981877pfr.54.1598006229685;
        Fri, 21 Aug 2020 03:37:09 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:37:08 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 11/17] Revert "media: mtk-vcodec: Remove extra area allocation in an input buffer on encoding"
Date:   Fri, 21 Aug 2020 19:36:02 +0900
Message-Id: <20200821103608.2310097-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 81735ecb62f882853a37a8c157407ec4aed44fd0.

The hardware needs data to follow the previous alignment, so this extra
space was not superfluous after all. Besides, this also made
v4l2-compliance's G_FMT and S_FMT tests regress.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 05743a745a11..f2ba19c32400 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -299,12 +299,14 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 
 		pix_fmt_mp->num_planes = fmt->num_planes;
 		pix_fmt_mp->plane_fmt[0].sizeimage =
-			pix_fmt_mp->width * pix_fmt_mp->height;
+				pix_fmt_mp->width * pix_fmt_mp->height +
+				((ALIGN(pix_fmt_mp->width, 16) * 2) * 16);
 		pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
 
 		if (pix_fmt_mp->num_planes == 2) {
 			pix_fmt_mp->plane_fmt[1].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
+				(pix_fmt_mp->width * pix_fmt_mp->height) / 2 +
+				(ALIGN(pix_fmt_mp->width, 16) * 16);
 			pix_fmt_mp->plane_fmt[2].sizeimage = 0;
 			pix_fmt_mp->plane_fmt[1].bytesperline =
 							pix_fmt_mp->width;
@@ -312,7 +314,8 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 		} else if (pix_fmt_mp->num_planes == 3) {
 			pix_fmt_mp->plane_fmt[1].sizeimage =
 			pix_fmt_mp->plane_fmt[2].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 4;
+				(pix_fmt_mp->width * pix_fmt_mp->height) / 4 +
+				((ALIGN(pix_fmt_mp->width, 16) / 2) * 16);
 			pix_fmt_mp->plane_fmt[1].bytesperline =
 				pix_fmt_mp->plane_fmt[2].bytesperline =
 				pix_fmt_mp->width / 2;
-- 
2.28.0.297.g1956fa8f8d-goog

