Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2CC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D6220809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHsNrbag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIJHxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbgIJHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:52:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006D8C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:52:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so7328987ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CHubz0brBEwmMQnBM1waB6q/QSDzur+5k9FicpsHZg0=;
        b=aHsNrbagatWzrrMT0MBF+MbTsTOmc1ArzI9UDkz88DfgcLqmHf6s7zGTOW5A4C7w2i
         YnYc4KvQar7G4t+dc6b1b1uLf6Go0zwyYE2foDHddnsQbDcOoYeEZgJJarVuhpd+7vfD
         2jjQTkLlW7SDX37fyMcwmhDixkAz+dXU61b/ZxX0xaVB31hulBFQBV1FOIgwmGKDRMub
         ix1gf+9WyZmV8f6PMcrgd57D92Bgf8fHCYLZ0tALl6qbYuc6vqNucmqAifDOvDMHmt1N
         XpVPBHokDRR86Twufzn9/VcOpMe6qvCSquvHLfLOhsjKYM76lefY/MqQU9BnUH4ULEiV
         DrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CHubz0brBEwmMQnBM1waB6q/QSDzur+5k9FicpsHZg0=;
        b=EJqWiY4ZEMuHBe80KVulUZHV24GERxXcF7D6BYWVEGucmM1DhBpGoO56g0kI11MwFR
         fbM1pzKBZGHcWOxbC1abF4guaYHR6LUcwBX7XkDiSW+kbiRmHv/lXE0/hA6kvQ/g8iG5
         +n7SUkJkNkSeo2MUVXmzaaiQJNlf+aw1O+JG17lTMVVKSrrnOMpRRfeRjKVTUCnslqAo
         deSK1OQEbJ1Xf42JuhcBb/D/NGh0EE4vLU+2GwF9HgBe7sIz+0ydx4W9mXX4CpBTkciQ
         u2NlaKpm/99BgEBWTx4DnF9l1ngCKkY/AEgzcJhsMGDIOGMa7SLLI7IDy533CAGgSVJW
         VXUQ==
X-Gm-Message-State: AOAM533Rv7ky91W/PdlUvk0yZPHvu0+U2ptvCHxZQEHslmCNLHJm7hBe
        2BmHQwaS9t6GtdVINibRjXN4vw==
X-Google-Smtp-Source: ABdhPJyTNGdJmZ+F1nuO7GU6l9mvdr10Ys+qkFxvXMKLWrsqoABTLY1BZXS47xdGrG3pqQvzK49NiA==
X-Received: by 2002:a17:906:bc98:: with SMTP id lv24mr7812319ejb.411.1599724376600;
        Thu, 10 Sep 2020 00:52:56 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id q26sm5742838ejr.97.2020.09.10.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:52:56 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 1/2] firmware: qcom_scm: Add memory protect virtual address ranges
Date:   Thu, 10 Sep 2020 10:52:26 +0300
Message-Id: <20200910075227.950-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910075227.950-1-stanimir.varbanov@linaro.org>
References: <20200910075227.950-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new SCM memprotect command to set virtual address ranges.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Elliot Berman <eberman@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/firmware/qcom_scm.c | 24 ++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  1 +
 include/linux/qcom_scm.h    |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e8bbf2d38ae7..7be48c1bec96 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -756,6 +756,30 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 }
 EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
 
+int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
+				   u32 cp_nonpixel_start,
+				   u32 cp_nonpixel_size)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_VIDEO_VAR,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
+					 QCOM_SCM_VAL, QCOM_SCM_VAL),
+		.args[0] = cp_start,
+		.args[1] = cp_size,
+		.args[2] = cp_nonpixel_start,
+		.args[3] = cp_nonpixel_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
+
 static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				 size_t mem_sz, phys_addr_t src, size_t src_sz,
 				 phys_addr_t dest, size_t dest_sz)
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 38ea614d29fe..95cd1ac30ab0 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -97,6 +97,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
 #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
 #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
+#define QCOM_SCM_MP_VIDEO_VAR			0x08
 #define QCOM_SCM_MP_ASSIGN			0x16
 
 #define QCOM_SCM_SVC_OCMEM		0x0f
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 2e1193a3fb5f..0165824c5128 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -84,6 +84,9 @@ extern bool qcom_scm_restore_sec_cfg_available(void);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
+extern int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
+					  u32 cp_nonpixel_start,
+					  u32 cp_nonpixel_size);
 extern int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 			       unsigned int *src,
 			       const struct qcom_scm_vmperm *newvm,
@@ -141,6 +144,10 @@ static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 		{ return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 		{ return -ENODEV; }
+extern inline int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
+						 u32 cp_nonpixel_start,
+						 u32 cp_nonpixel_size)
+		{ return -ENODEV; }
 static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 		unsigned int *src, const struct qcom_scm_vmperm *newvm,
 		unsigned int dest_cnt) { return -ENODEV; }
-- 
2.17.1

