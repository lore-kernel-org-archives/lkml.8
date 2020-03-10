Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9061A222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cou9tdhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJGkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:40:02 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37786 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCJGjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:39:55 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so10879pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wth+YSNI1ILDm//Nc9zfzczmIG6U29YhiobOLaMSS5A=;
        b=cou9tdhqsO28ChyfRFJ7LAFEH7FzhzZXKctfzMAgZPf9ZJ7qnB3p8YQqC6t/EuUjMz
         DZH65hjX3Cf9bDvbpVqsCNo0/TyUN/cb7+OS3ZJ9VY7sUqUunwMpOI0DB8BfsrDDQiZk
         Ytoqf2sZyzfR3PfaT51X3gsass7Jt4kmIzi/VXr0Kw45Wj4Jte6ITaX99scuWBXpOEBl
         hRz5J3rKjjGlgn8H9nvs9IauWfg+HCpoHkFfwsL+eEDtNTiq0rEmffkf/UhfGvESO6mq
         zFSW5Jiy7850L9GZ7CWQLVb2NZLmJVIqPj8xP7wPHjsOLMYWl3qN0HqdEQ5NylMyyLMr
         sWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wth+YSNI1ILDm//Nc9zfzczmIG6U29YhiobOLaMSS5A=;
        b=JfNg+elyOdsbmsYfJ9DhLgOZjYJK6NSqCKonR+MxTDeR8/c1w2IvCGZvPYVMtsWs0v
         TLYbwPRl4AVUjCrhra+CphT/KQTNNWc4Ss4o7Ru+xPn0EE6YXSrhPi3jGTzqnlYgOTaN
         XF/Xik0U1NRN8uxC4KF1RjKkWjAfuI8WakeMKdtYABgqTvWWX2ggFwp+tZ/4Wfv3jKqY
         vY7l7bFCl2206pGuILgYjC0iJ0tTSurHA1MsLVgFP0110gMl0SYZYrnhVxo1zDwGqUhy
         zmpjiQTu37vT3U07nn1+QK9/rEOl/LJU2gZnwtJxzOI/CFTEG1xEkYc7ZiAYeoduFEG2
         rRHg==
X-Gm-Message-State: ANhLgQ0XwRP9zQ3eNx24dBgH9cIOD9s3k+1OlCZw2BS/cPw6GlToZMNB
        iHaJXBiJEiam2kIxRejMdygqfQ==
X-Google-Smtp-Source: ADFU+vtAtJ+mkEcjXYud1PcBTJ+GOJyqExwers6az7Navv2+vZIm0KfBsjEdIR2qpJfCeoWagqXYvQ==
X-Received: by 2002:a17:90a:a617:: with SMTP id c23mr236519pjq.32.1583822394882;
        Mon, 09 Mar 2020 23:39:54 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j38sm42398468pgi.51.2020.03.09.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:39:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v4 4/4] remoteproc: qcom: Introduce panic handler for PAS and ADSP
Date:   Mon,  9 Mar 2020 23:38:17 -0700
Message-Id: <20200310063817.3344712-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
References: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the PAS and ADSP/CDSP remoteproc drivers implement the panic
handler that will invoke a stop to prepare the remoteprocs for post
mortem debugging.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Change since v3:
 - Change return type to unsigned long

 drivers/remoteproc/qcom_q6v5_adsp.c | 8 ++++++++
 drivers/remoteproc/qcom_q6v5_pas.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index d5cdff942535..8f1044e8ea3b 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -292,12 +292,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
 	return adsp->mem_region + offset;
 }
 
+static unsigned long adsp_panic(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+
+	return qcom_q6v5_panic(&adsp->q6v5);
+}
+
 static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
 	.load = adsp_load,
+	.panic = adsp_panic,
 };
 
 static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index e64c268e6113..678c0ddfce96 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -243,12 +243,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
 	return adsp->mem_region + offset;
 }
 
+static unsigned long adsp_panic(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+
+	return qcom_q6v5_panic(&adsp->q6v5);
+}
+
 static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
 	.load = adsp_load,
+	.panic = adsp_panic,
 };
 
 static int adsp_init_clock(struct qcom_adsp *adsp)
-- 
2.24.0

