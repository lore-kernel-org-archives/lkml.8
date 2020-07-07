Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E2A20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNmHdT5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgGGKSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45404C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so44501003wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
        b=VNmHdT5aOvG5QcaUjgLr53ubScedW6+ksFA4XxzupsIrEYDcgzzUzddsvpTVB9+XBd
         Ry1c1rkjcL2OrFOHVSR5WsUH1Zte6YIqm83zgl4a8K4ORxMhKnyNnv+a+uocR+ceVe7d
         xSvPRKPxzLXNAG8kwS1XjuRA68zvHf8U6dL/SIXIee0ZAa7JMk85f5nO7LCsI2Nw0k0P
         Yrd5NXh0wSnDfPpx4/l6Q9a4OlDOxl6oJ1wrFcS002d6H5/bblBAdZvP2iJbJ1PiCx3s
         5HiwZQ/XzuOK93xWUiz73N1/WL6mKyRf1RVnJD+SfQcACuO9YfuphgOAaSE3clIFgaah
         BH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceIee8YBFX9kzqJWoK/1iqOS7aaLJ7GoK8i5sFpusg4=;
        b=ED8TyBF/zELalpvWn2NY7gIbxqUdusOhsD/MFXeQNuKMg46O12MDodic2LQrlaDMyh
         L4QElE0jcl71SE135urUzm+2tSRrVTHdVodqFoMs/iv1+0VSVdaiddvm25pTxD7llExW
         /YMXwqiNt8tXOtRIoh42DftLlYDyuWf6Bz+7fiOKMDXYd84Kc3vCD+JjOQrQYNXN8G3V
         4PWSjrQC55YQPzSnleCrpDUShYDDI6cVH1DLLKk29fTzh/45kXUH5bPQ4EfhXtD6sT5p
         vMphV81IPjAGYjQz57wqkkizMPDIxd7zNizXy4Ju3bjliQVX8t/T8gbLsRXH+n8xgw4q
         P/wg==
X-Gm-Message-State: AOAM532gdIagr0qeC5DSP0eKQ3l7nk14gBoyRVZQjITKPcp3jlb1s9Mq
        yXUWU/LVG6R5S6PkwQTf65qM/w==
X-Google-Smtp-Source: ABdhPJwX2C88MDS9oCo6CUBN9iE8kRApkiJqgBaHVMS9ZR3zrmhkp/rOi+eiD5PYlCH7fNBq+FuNpQ==
X-Received: by 2002:adf:c441:: with SMTP id a1mr52516736wrg.130.1594117020948;
        Tue, 07 Jul 2020 03:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/28] ASoC: fsl: fsl_esai: Add descriptions for 'tx_mask' and 'rx_mask' to 'fsl_esai'
Date:   Tue,  7 Jul 2020 11:16:24 +0100
Message-Id: <20200707101642.1747944-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'tx_mask' not described in 'fsl_esai'
 sound/soc/fsl/fsl_esai.c:86: warning: Function parameter or member 'rx_mask' not described in 'fsl_esai'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_esai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index bb3c405df623c..3f67f4a465780 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -49,6 +49,8 @@ struct fsl_esai_soc_data {
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
+ * @tx_mask: tx register mask
+ * @rx_mask: rx register mask
  * @channels: channel num for tx or rx
  * @hck_rate: clock rate of desired HCKx clock
  * @sck_rate: clock rate of desired SCKx clock
-- 
2.25.1

