Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE5C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22720663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMrML+KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCXF3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:29:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41319 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgCXF3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:29:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so8715679pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWBRcEyMTW+WEEQt5SQF5x0ROI7z/m3lM/vgJNL3hXc=;
        b=iMrML+KBB5l6Ri6XlYTp/N4rYhFdoHCnP7QF50uxsXOpRFiKMrfs0dVaox9kc0xcpk
         hDjTamvLPXs8Upj4Txl/ZHG7p5o0uh/h4CBrV7yV+cqh9b2XxArrbKrfNKS7mThX4n87
         lh8OPKocwkJvWLbmZX6QAE0HQHdUs3bpdkUs/OgRPxtXRRP9LCE32J1PWeMPGXIhfLO3
         fbLOb+gkZJEbUiZtlW1cDNsxO/3I7cck8/8NDOeazkFQSG+hVXlbBRhsRG4hIBNxfSBd
         WF/XUlVoJlJVU4w5XTa67bZLj16R7bdlhJiwPTYveSpjX/bQIMr8cOg1aIx8hJF/Edc6
         nD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWBRcEyMTW+WEEQt5SQF5x0ROI7z/m3lM/vgJNL3hXc=;
        b=p+U3rZDr+KdH03VlTBYo/6Cvj18uARHGPkqUnOhrVW+IBbdNb+tJly4juYSbDghbT7
         It3Dx0FdO5yOV0yGLFhYH/ZBHAgyjxYRbrUqdTWNx20JPw7e5DXqi7rXl+uh+Sf2uEUU
         fyDZRtfnhveN2BvabpCqS+O8y08RPBsEFn3E+V1wN05SguoBtXEi5tDOScdqIOGBSdD9
         XihxSE0XjcEczUXKn2UvX5V78Q6QOra/U/AZNUCABPNuXpfc4UhAN0GfztfgzgaEnGPd
         KOO/aRMN1ZJ1qZ+zkIDPuI+S2AhKkKFjf/Khd4jVTxwV81ToNSAIAYHeCy9Xt+38rCLH
         LczQ==
X-Gm-Message-State: ANhLgQ3zKI7fuEuqWts1IcU8zQeoHK+CRi+E1EKAgiSiRP8pqUc6k3QX
        A7VoJ4rfOmKpHgBLINwxTwBY2A==
X-Google-Smtp-Source: ADFU+vtOqgoS3fw1vbaf1mdZpAWooFoKkJLbDx+LEZkLb5acpopnw2DgJmwSlrkhIO+GwxuRyZ3Fww==
X-Received: by 2002:a63:6a4a:: with SMTP id f71mr26576969pgc.365.1585027753896;
        Mon, 23 Mar 2020 22:29:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j14sm2795413pgk.74.2020.03.23.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 22:29:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5 4/4] remoteproc: qcom: Introduce panic handler for PAS and ADSP
Date:   Mon, 23 Mar 2020 22:29:04 -0700
Message-Id: <20200324052904.738594-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200324052904.738594-1-bjorn.andersson@linaro.org>
References: <20200324052904.738594-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the PAS and ADSP/CDSP remoteproc drivers implement the panic
handler that will invoke a stop to prepare the remoteprocs for post
mortem debugging.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Picked up Mathieu's r-b

 drivers/remoteproc/qcom_q6v5_adsp.c | 8 ++++++++
 drivers/remoteproc/qcom_q6v5_pas.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 2b01f2282062..24a3db961d5e 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -282,12 +282,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len)
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
index a41860d2243a..7a63efb85405 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -234,12 +234,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len)
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

