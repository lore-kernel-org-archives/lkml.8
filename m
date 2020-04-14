Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA77A20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n2G/G4Bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgDNDIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404437AbgDNDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:08:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEDC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:08:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g32so5391733pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zRLvY/lFyVA8CmcHxoztfhLeB6Hcp8Rb9myeLFGE2Y=;
        b=n2G/G4BdsXylPAXJFcQRTVHOuqsJKdpWbXtgpE0vRfTZ6zqn5UOIvHQK/E6B09RbBb
         LDa0XYcYzYD5v7gjcGLOmaVvkxWAgoIi8UKyC9Xpli+XMHphDtBdltPVBndKpUx5BNVR
         iPSvizo2wr2JHDiXX3MwqKvyQJlQ25Ua8hL7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zRLvY/lFyVA8CmcHxoztfhLeB6Hcp8Rb9myeLFGE2Y=;
        b=Gv5DanaiCozg8FDYSABZPe1zSb6Ye2r5lKC0wvEeKn7Jcu9ykm0w2tr1C62IYCxVfp
         G/eUHsjiXleAlNvCu9V7clVR9AxJfGMNcFQqY6DjPP7WYPBO7FYKcR/hieUc8v1QWCJ7
         VApey1u302OEtLlgpbhT0qRcHvXQrY8mev1+M9fXuJ1GWjBuR7T5Z2wrpYMu3OAl4AGn
         U4bdOw2yl2FlASY2TtjwemMbwwgcemcFTpTAN9cCy9cUrPENUAcqXjlR+rbaXRNnMSPn
         8qVbFCKG1nvFm38yD/y/VM1NXLxGtm2A9UURySrqiJCV+ldaWJeBu4wSA5y0kvNM/Qmi
         Pa6A==
X-Gm-Message-State: AGi0PuYsKCd1UIfF/nT6gm/5SU9iY5YeoQkla0Rbz0gH+Ej8ms2DvuuM
        UNY+pM5ZAiT2iVtpU3nR/U4f9Q==
X-Google-Smtp-Source: APiQypLDqSi+uJwrfXUjYacymxQYaq/+/Ey0TiNm/1+jCiQfoIEMLFJm77pkr/oXOdsSGluRuYv5UA==
X-Received: by 2002:a62:1a4e:: with SMTP id a75mr8921678pfa.235.1586833706151;
        Mon, 13 Apr 2020 20:08:26 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z23sm3610897pfr.136.2020.04.13.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:08:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] media: mtk-mdp: Use correct aliases name
Date:   Tue, 14 Apr 2020 11:08:15 +0800
Message-Id: <20200414030815.192104-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200414030815.192104-1-hsinyi@chromium.org>
References: <20200414030815.192104-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aliases property name must include only lowercase and '-'. Fix in dts
and driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 14991685adb7..58abfbdfb82d 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -15,10 +15,10 @@
 
 
 static const char * const mtk_mdp_comp_stem[MTK_MDP_COMP_TYPE_MAX] = {
-	"mdp_rdma",
-	"mdp_rsz",
-	"mdp_wdma",
-	"mdp_wrot",
+	"mdp-rdma",
+	"mdp-rsz",
+	"mdp-wdma",
+	"mdp-wrot",
 };
 
 struct mtk_mdp_comp_match {
-- 
2.26.0.110.g2183baf09c-goog

