Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72968C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512D1207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kI33MLAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgETI2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgETI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:28:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB2C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so917320pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ll8NxVtMtfVOyEZFFQDfClPq5aIFoMbY7TDtR4kV3zQ=;
        b=kI33MLAoCd0TxRti1KqGfffMmFCe7Qu+9zJ9GzgvLmIhvWroMh2PK76BMUA9xvXNN3
         BeTyj3uDBE9zEEC9mrGi7btmBWv1HKDYmi4AFLoegQbxFbzAiNC0xk//stOr6yOaHvmJ
         RFZ60+RwMPuvjP3Y2vhaAM16aSKaOTZXVNebc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ll8NxVtMtfVOyEZFFQDfClPq5aIFoMbY7TDtR4kV3zQ=;
        b=U9sTXT6ru6y3pZWQfL4S7tAiGIRi1srbag9a+A/wLl7jKimavNVu9jac/vuq4bicc/
         duYrfpd20e7duQSgjIAgWOmdaFHAhpeP7UyUXBBjjpbe7XxdSyo/Fot2cHKA7c5n3D+2
         +K78gy9pWtZCiT4GVCUDdnKcpCJo6PMrRltXplfNSW32YWv17foUa50KKmn1Vdet/3es
         TqXaUSsWDTvTYWIo32GtG0Vn6DsHqKsYx50tZ6uw32nMCCnAm6OVk7XI7SNfFnso2oC5
         MFT63udYQmoHCvOgT26vjXVsMYzf0EGbNybeZubc+9jZ8hhaFfKxjxaOjnma2LDTT++A
         oPbg==
X-Gm-Message-State: AOAM530uNq31zMz9Wc8sknrWeVcQt7thxg+LDoI1nmsYF2UdzQ76YD/p
        4Qw9MFys3oKd2y1eZCAd5msZKQ==
X-Google-Smtp-Source: ABdhPJyLQteFuXuVc69SpcsEFfMjArlHWm8lgkG4Ws0al46mciJZZn5XJ5qdF3eWNGJdzMi89qu6gw==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr3434302pls.240.1589963292039;
        Wed, 20 May 2020 01:28:12 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id gg8sm1447775pjb.39.2020.05.20.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:28:11 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 09/10] media: dt-bindings: mtk-vcodec: specify SCP node
Date:   Wed, 20 May 2020 17:27:22 +0900
Message-Id: <20200520082723.96136-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200520082723.96136-1-acourbot@chromium.org>
References: <20200520082723.96136-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek codecs can use either the VPU or the SCP as their interface
to firmware. Reflect this in the DT bindings.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index b6b5dde6abd8..7aef0a4fe207 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -19,7 +19,9 @@ Required properties:
 - iommus : should point to the respective IOMMU block with master port as
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
-- mediatek,vpu : the node of video processor unit
+One of the two following nodes:
+- mediatek,vpu : the node of the video processor unit, if using VPU.
+- mediatek,scp : the noode of the SCP unit, if using SCP.
 
 
 Example:
-- 
2.26.2.761.g0e0b3e54be-goog

