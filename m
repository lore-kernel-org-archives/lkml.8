Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E3DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA8921D90
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfZ/Kz3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGNLQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNLPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:15:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFDBC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so20871367wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5xJlzZ+5aNa1GB1o6zmShj2PdHMF5lWE0KYZLpqibo=;
        b=RfZ/Kz3I91qMv/2m0Zf4ivjprRznfDKxRo5ZqPfQhhX9PSZaThHJo6P+kCgKU3rr8P
         ch5dX9+quX9ibe+sKu0v+Q+oiCV4mvt9tXT+dOpTZlx3dlk3pFSFYEBV9GrqzAU5e/qZ
         2wuJ02QboJI8XWG+i9e/liAXGaPAVnPv3+356DXkW9YOG6Yu1G48GvrBl69d/svmIOHf
         M7goBeDf5RKNAnR9LAsrJsJn/VUl7itgVGaOdoTZU7JX7at3D701oJQUMpkJOWv5dSvN
         Vqzrln1AVz6HaXiepPBW+suT8kz9j6tWg2CRXWblQOSODD48YjXUIjfkxnM1sVlC2Ha0
         P9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5xJlzZ+5aNa1GB1o6zmShj2PdHMF5lWE0KYZLpqibo=;
        b=bJLqGiNuTQqi23huz/cH5wUdTD4H9SeZ7RditDdNb5JbroQv1bt+NHLM4VovnHwEcD
         2Rfm2asAT6ix6XrgoNCumTcdMrlC+Td6eyaXOUnW+DLdC581jcKvvNT38BJx6Apuc7K4
         AXbKmbap2YmdsZjpMddK7IqpgFj7fltaphIMX2dGvFATZ6LjAR59Ui/xdnbXhXELU1VY
         dZAYL0J4WhZKXp40AM3UFPq8E1Vxu8mqq2WcNnH7lAhjVP8Z942l/PJiIZtB7/hlEbxx
         tl3Gq6pUYsZSr0LaRSuSnd5Qn+ngT7Qd6/wn37UPev/qYfXyS9YS8s2V8hd5sCt1iDll
         kV/Q==
X-Gm-Message-State: AOAM532GLM/LJEqf4coqyXKHIBKqtEzPbKzb0rcd0T5bwnZw4/CobXVG
        DVQLRs7Kbw0uiH6mLX9sVEe6fg==
X-Google-Smtp-Source: ABdhPJy+IpSkDvt0gKhCLe7N/pHcRPdSZRSy6u7pwrYXAu5aBo0g8In969/7Eo5zqi8LjXxj6Yj/1w==
X-Received: by 2002:adf:f388:: with SMTP id m8mr4799959wro.338.1594725350794;
        Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/17] dma: mediatek: mtk-hsdma: Fix formatting in 'struct mtk_hsdma_pdesc' doc block
Date:   Tue, 14 Jul 2020 12:15:30 +0100
Message-Id: <20200714111546.1755231-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct attribute names must be an exact match or the kerneldoc checker
gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc1' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc2' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc3' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc4' not described in 'mtk_hsdma_pdesc'

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/mediatek/mtk-hsdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 4c58da7421432..f133ae8dece16 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -107,10 +107,10 @@ enum mtk_hsdma_vdesc_flag {
  * struct mtk_hsdma_pdesc - This is the struct holding info describing physical
  *			    descriptor (PD) and its placement must be kept at
  *			    4-bytes alignment in little endian order.
- * @desc[1-4]:		    The control pad used to indicate hardware how to
- *			    deal with the descriptor such as source and
- *			    destination address and data length. The maximum
- *			    data length each pdesc can handle is 0x3f80 bytes
+ * @desc1:		    | The control pad used to indicate hardware how to
+ * @desc2:		    | deal with the descriptor such as source and
+ * @desc3:		    | destination address and data length. The maximum
+ * @desc4:		    | data length each pdesc can handle is 0x3f80 bytes
  */
 struct mtk_hsdma_pdesc {
 	__le32 desc1;
-- 
2.25.1

