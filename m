Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B72022B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFC5+L6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgGWMZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgGWMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347CC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so4997026wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuXFDEYVsnsDfXIKt9wKPHYtC5k1C4IDk7HQmnmIHX4=;
        b=xFC5+L6qTksxCecGRt3nk4ZWSrIfiJ5KB8fRopA2KjkpV8FmkuJa0jtIZRe/PclS1a
         /4M87SpuupjQwVaqi01RBVgXJOs5dZDHD7Uuik52ZLmXYonwu+Hr2hgN20b8+D66Bqxh
         2Zesy56tksWGu5NWopASjeu6yF+zoGxk0PRr5O6eYmqqGpl0i02ozM/sLvikCsSdKJ3K
         SNtVxe9K8vzqtiJRA595fYK+tDZ5N95wcXGNptCKciO7aSs34z5mGknLQAKaJ/T33nr+
         QYSatN0QX3DXlIcbKV+D/IeXyMfxhJCd0e30ZyyDCJJu/v/tyMvmpnW706QoSu9E1XSu
         823A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuXFDEYVsnsDfXIKt9wKPHYtC5k1C4IDk7HQmnmIHX4=;
        b=acaxVO0nhtlPqsewne3h/PF5jhJ8pLNK9/c10Q8I3W7ljVUcs49pcCiNQk75qzUBsi
         rgUhXXfrMTKa4YuPvxa75XLeGmLM/hhlG+VZEYzOhFFi6uft5l9/slMsMkZsRKsxq0m3
         Ia9tStBC8xTZ446NzaHdNTnm5Wj0ANjA0AZ4vM1Zhmjg1Ol1maaD0sNYykN2CcbzFwQs
         LOiH/t9zKvxnrj8LvAnxT/VebFttVwkPyUu2UjioTkWl3ZihReHNgCvMq1agAt1N6iEA
         rrzXTJibffJ1CLQyUldNGglaRK0kxImpB9NHd2frlZnv02t6JctRjomxCpmYL5+vbrER
         fbnQ==
X-Gm-Message-State: AOAM533k1W/LZp/L4wbxULscBJLKf2m589C21i7F9DMyoBHOTbrxK7sf
        wrQCfZNCGQLdU/WYn8yzyO7Mvg==
X-Google-Smtp-Source: ABdhPJxCnxCGnN7MmoQVRH8Z3jCjXBAJHu7Hl1DfZ7kT2ofsa6YfNX2BVf1YuitsN9T7DAfEI8Gn7w==
X-Received: by 2002:adf:df06:: with SMTP id y6mr3706057wrl.89.1595507115674;
        Thu, 23 Jul 2020 05:25:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 22/40] scsi: csiostor: csio_hw_t5: Remove 2 unused variables {mc,edc}_bist_status_rdata_reg
Date:   Thu, 23 Jul 2020 13:24:28 +0100
Message-Id: <20200723122446.1329773-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/csiostor/csio_hw_t5.c: In function ‘csio_t5_mc_read’:
 drivers/scsi/csiostor/csio_hw_t5.c:151:11: warning: variable ‘mc_bist_status_rdata_reg’ set but not used [-Wunused-but-set-variable]
 151 | uint32_t mc_bist_status_rdata_reg, mc_bist_data_pattern_reg;
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 drivers/scsi/csiostor/csio_hw_t5.c: In function ‘csio_t5_edc_read’:
 drivers/scsi/csiostor/csio_hw_t5.c:199:38: warning: variable ‘edc_bist_status_rdata_reg’ set but not used [-Wunused-but-set-variable]
 199 | uint32_t edc_bist_cmd_data_pattern, edc_bist_status_rdata_reg;
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/csiostor/csio_hw_t5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_hw_t5.c b/drivers/scsi/csiostor/csio_hw_t5.c
index f24def6c6fd1e..1df8891d37251 100644
--- a/drivers/scsi/csiostor/csio_hw_t5.c
+++ b/drivers/scsi/csiostor/csio_hw_t5.c
@@ -148,12 +148,11 @@ csio_t5_mc_read(struct csio_hw *hw, int idx, uint32_t addr, __be32 *data,
 {
 	int i;
 	uint32_t mc_bist_cmd_reg, mc_bist_cmd_addr_reg, mc_bist_cmd_len_reg;
-	uint32_t mc_bist_status_rdata_reg, mc_bist_data_pattern_reg;
+	uint32_t mc_bist_data_pattern_reg;
 
 	mc_bist_cmd_reg = MC_REG(MC_P_BIST_CMD_A, idx);
 	mc_bist_cmd_addr_reg = MC_REG(MC_P_BIST_CMD_ADDR_A, idx);
 	mc_bist_cmd_len_reg = MC_REG(MC_P_BIST_CMD_LEN_A, idx);
-	mc_bist_status_rdata_reg = MC_REG(MC_P_BIST_STATUS_RDATA_A, idx);
 	mc_bist_data_pattern_reg = MC_REG(MC_P_BIST_DATA_PATTERN_A, idx);
 
 	if (csio_rd_reg32(hw, mc_bist_cmd_reg) & START_BIST_F)
@@ -196,7 +195,7 @@ csio_t5_edc_read(struct csio_hw *hw, int idx, uint32_t addr, __be32 *data,
 {
 	int i;
 	uint32_t edc_bist_cmd_reg, edc_bist_cmd_addr_reg, edc_bist_cmd_len_reg;
-	uint32_t edc_bist_cmd_data_pattern, edc_bist_status_rdata_reg;
+	uint32_t edc_bist_cmd_data_pattern;
 
 /*
  * These macro are missing in t4_regs.h file.
@@ -208,7 +207,6 @@ csio_t5_edc_read(struct csio_hw *hw, int idx, uint32_t addr, __be32 *data,
 	edc_bist_cmd_addr_reg = EDC_REG_T5(EDC_H_BIST_CMD_ADDR_A, idx);
 	edc_bist_cmd_len_reg = EDC_REG_T5(EDC_H_BIST_CMD_LEN_A, idx);
 	edc_bist_cmd_data_pattern = EDC_REG_T5(EDC_H_BIST_DATA_PATTERN_A, idx);
-	edc_bist_status_rdata_reg = EDC_REG_T5(EDC_H_BIST_STATUS_RDATA_A, idx);
 #undef EDC_REG_T5
 #undef EDC_STRIDE_T5
 
-- 
2.25.1

