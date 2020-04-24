Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA82C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B47421775
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBm+YaG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgDXUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgDXUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70BC09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so4153044pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zs8zqxSLmCFU6lZYzSjBYa2nEV+/JbKTSnr0oNB1H9M=;
        b=OBm+YaG5e7Hf79gRnIDBZNaKsh8b7ZMTm3+BICnzVBFchzziucaX2vdz1Hv2U4wWWp
         EcT/3bMOuXUFNAWq5WKuengPx+5y2fcGvHKhTvEZzrMcAp9+kNgx8ULtRQaj1VsNvOpQ
         qj2Yrg8Vn3xU5CSUU+C/M0KviqQ0YKH++EEcCiL3V5CUSo5gfl6Zuwp+cdPpX1BkMt1+
         BCTEf18ioZntEnAvgClbjfDXsHKPgGNrXVRhyrUUGe3RotINDtjIgWezMoHtIKkprwEm
         52k/IRykm18cYzv6tyXkxGpk0acftWHy4zSTQ2/lKYv3MiF+lIksGYegWWlFFILFYXqk
         pNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zs8zqxSLmCFU6lZYzSjBYa2nEV+/JbKTSnr0oNB1H9M=;
        b=OeC8Angcro9PWjdizbCoTq9YGOfVO8bs+3RVOkyw+Cb0kL/oJ5E8SQxr+9tugVvFPn
         3d2YNa5QBZuhkIEEPUmM+K942z+9cm8m68I5Ltj40slDrJPF0TQ2Kh92PKb7QPkByQ8Z
         mo0+4H9qvrvZQHPCpdYKlG++IRHOS0nlhINoNBpm3P76D2T9ip4EiUTEqssh0T10YHhd
         X6gKq1tbHeDAqSVot2BgEvwNhpp/XccrvxTHG53u+D0CNE0PxCEe8aVQ28STjsNl+DQl
         X9ttlwWY5Lw5tnBjk2f7xlpZNe//f9nas5i74OzajN6KD8AB1byUS+JVDAkxwmp8yJEY
         nLww==
X-Gm-Message-State: AGi0PuYeKOvzJunxdtQ++TzG9YjJr00yqu7lzs45wcMy7iZRC5Ox42NK
        IUADwwIQmyB9H2ufvi6j4jrX/A==
X-Google-Smtp-Source: APiQypJU8nTXTveTpL95Js1RKNrdGMPxwTFKK6UCZMwcjKNmAhFJgR4kBO2M3JrCnfwpW1TsGUDwwg==
X-Received: by 2002:a17:90a:82:: with SMTP id a2mr8752961pja.47.1587759920159;
        Fri, 24 Apr 2020 13:25:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] remoteproc: stm32: Introduce new loaded rsc ops for synchronisation
Date:   Fri, 24 Apr 2020 14:25:04 -0600
Message-Id: <20200424202505.29562-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new elf find loaded resource table rproc_ops functions to be
used when synchonising with an MCU.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index b8ae8aed5585..dcae6103e3df 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -319,6 +319,15 @@ static int stm32_rproc_sync_parse_fw(struct rproc *rproc,
 	return stm32_rproc_sync_elf_load_rsc_table(rproc, fw);
 }
 
+static struct resource_table *
+stm32_rproc_sync_elf_find_loaded_rsc_table(struct rproc *rproc,
+					   const struct firmware *fw)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+
+	return (struct resource_table *)ddata->rsc_va;
+}
+
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
 	struct platform_device *pdev = data;
@@ -593,6 +602,7 @@ static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
 	.start		= stm32_rproc_sync_start,
 	.stop		= stm32_rproc_stop,
 	.parse_fw       = stm32_rproc_sync_parse_fw,
+	.find_loaded_rsc_table = stm32_rproc_sync_elf_find_loaded_rsc_table,
 };
 
 static const struct of_device_id stm32_rproc_match[] = {
-- 
2.20.1

