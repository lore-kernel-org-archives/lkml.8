Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD205C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA587214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh2v5zI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgDXUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3575C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so4123860pfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2iTWW4nO5SL6In2uagzPcw9ivsY9NbY9ua5sw1Z8YY=;
        b=Xh2v5zI/BaXOCyJfw0q7LclyWcz17VcHHRAtRtzAcWv4MREiZiUr1J57Qh4LJD8BbF
         xVMrr3t30yanDFyJWCs1QAlhVVOPRQE1Ayy8l+zkS5hsvfZBhqo64LotHv+13vShH52s
         wv70aHtI8AK4YzwCCPu1bRvf4t3gI0y3Gg+gu0cfcOukzcvEoZvDZK3qlFeucEIz5Xoa
         p9UPO8xv7uLv96Kr6yUS5T/DFvplz/q3gISrhvhd2RZMX+4ccKZkW0qJpKovw4Wfxlaq
         OsHB6DdRPFDTnyMA+I0y/d1mIUtmQUeUj9fgAF7r7U7fJfvPQXzbE8lz7nSADY6zUtDu
         insA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2iTWW4nO5SL6In2uagzPcw9ivsY9NbY9ua5sw1Z8YY=;
        b=oGGjp/qucXBHeF07fgdHW9C6VA85BiI137h4Hw+A3THIM2vsfrsbiJmlDbf91AiA1b
         OsjHEmmthRurEx+roALAqnaJuViMp8XZLuGPb/Camh4LgBn7XmfloGb4vXG9xs5amhbe
         Fq4I24d0uRwH/eNSkN4spZL2ukZKR0D4rl87bhJQjrsfPWeC2xzVPgMRzXxS5FQcm2PO
         6uzJ5ekeM9x+MVfM8ELSJ+waUsdycwWivS+nDX7uSXvzfbl3p8lVTGbb/OSBb6d0CaXJ
         SMO1SdqT5V6hC7/1rFHBIogQ07fsatjNIVTw+uk2kEsZLGVcCbqfj+Sjn/ezMcVKLEMC
         c8JA==
X-Gm-Message-State: AGi0PubhThu0EEQaKatj3PlWk2j28DZ/Wv/VU2ijeUoC0tttgwHRXGyQ
        rEncnALdjvTUzkQZQyBYNYIIjQ==
X-Google-Smtp-Source: APiQypJDYCDbHcowl3s80XHCz3TTRatT6q2ZhtMCaPAqLRA3rMW4yZfkqAlnuY7yy/eBSoya9iCBlw==
X-Received: by 2002:a63:5a50:: with SMTP id k16mr9509922pgm.171.1587759908429;
        Fri, 24 Apr 2020 13:25:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] remoteproc: stm32: Decouple rproc from memory translation
Date:   Fri, 24 Apr 2020 14:24:54 -0600
Message-Id: <20200424202505.29562-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the remote processor from the process of parsing the memory
ranges since there is no correlation between them.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 0f9d02ca4f5a..91fd59af0ffe 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -127,10 +127,10 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 	return 0;
 }
 
-static int stm32_rproc_of_memory_translations(struct rproc *rproc)
+static int stm32_rproc_of_memory_translations(struct platform_device *pdev,
+					      struct stm32_rproc *ddata)
 {
-	struct device *parent, *dev = rproc->dev.parent;
-	struct stm32_rproc *ddata = rproc->priv;
+	struct device *parent, *dev = &pdev->dev;
 	struct device_node *np;
 	struct stm32_rproc_mem *p_mems;
 	struct stm32_rproc_mem_ranges *mem_range;
@@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(rproc);
+	return stm32_rproc_of_memory_translations(pdev, ddata);
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
-- 
2.20.1

