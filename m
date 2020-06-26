Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B768C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7479220836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHg9Dgp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgFZIF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgFZIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5CFC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:05:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so4618813pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNwEzWipSSz2vd4pkUc1DMaHvpQvQj+NbszKHo/2YLs=;
        b=RHg9Dgp1ggVhlqYSJDRUT2dau1OUPfz/FXjf2pt27uOy/W6ONc7WnGbc/0XGJbOcyd
         SWY/owF6lII0qNEXDIqNVkda5D09wHn8vUWjUc/O1NKTb94LaeBEbqyr4NzLubmAkK5V
         1n7jgw+DidjDUHHAZFLU21HT2TII00JvGgS8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNwEzWipSSz2vd4pkUc1DMaHvpQvQj+NbszKHo/2YLs=;
        b=C4sljrFUfUnrhXrGTZk7I8Bw54T5LwhOVkggnH63LudU5q/6KTZbXXE4hip97nMu5R
         sqtw+RZRl27XOUXNmRuWB8U1Tek3jYa2IOPRzGiLM4sg379omSWfcbm+aUb25SizR2rx
         JDWNloAkknCkMUOYmWHxQgXxMGL453cty63mieyNdCQWugVy0bW93N3orDdP9L0HO0Hv
         vKeGO58svMAovJQYSCEKhTHgMqRkUu2UhshyT0+7DEttImFnvSIbatBH0bJt8RDfbmi9
         CCtcbEuw4Imw+Ie/1NxEtNogxhUtiSeGopWwDVwt+u6EEfg5Y/TQorW11JV1j6/M/V3Y
         ndOQ==
X-Gm-Message-State: AOAM5333TeN9PLyMSFQJu3CR9dkJv2gPslFkDcGHJdDiGKxsna17bd2z
        sJN0/XrnN9Sbip2tDxylOCCHLQ==
X-Google-Smtp-Source: ABdhPJxVxy+TcRiUnQ2Y6bbJtc+2IY2rhhdtmkNKrhVuoI5PJYt+s5qOfWmaSqZKimV2x8zZ4qzRhA==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr1608943pgr.89.1593158756043;
        Fri, 26 Jun 2020 01:05:56 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:05:55 -0700 (PDT)
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
Subject: [PATCH v2 08/18] media: dt-bindings: mtk-vcodec: specify SCP node
Date:   Fri, 26 Jun 2020 17:04:32 +0900
Message-Id: <20200626080442.292309-9-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek codecs can use either the VPU or the SCP as their interface
to firmware. Reflect this in the DT bindings.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
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
2.27.0.212.ge8ba1cc988-goog

