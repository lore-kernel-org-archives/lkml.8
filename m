Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A49C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197CC224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIYV1sGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgGNTvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgGNTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B0C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so2021239pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eSFoQYSsQoruZlP/q9EyfnIvN17R/2xMrjfEYAqKSc=;
        b=OIYV1sGpRaUJnQHs4p5xLWMtcQ0LMXsAemN/mCLTJYSrJXjDLa1S8w7T5pa+tMnG2o
         QcGEy1br+ZbTZKstyr1NFF+pcRceFNvpzRGulNo2kE0qR+fThh/q3WOm18VDCUOykfL8
         p+pwtwlT0Cp6xGXbC3Qo1R8L/6k3qcTqXuja+YMEnS9wGvzQlYkiznI4PPmhpSKMLskY
         v4Ul70uaEcTT+0oes4nmD3YbRw0XTlx1XSvQsB8KtSmmEKe/oBhB/Y5Melc8Hwf2Al6g
         Ts4wa4yXMm/KajIsYNizGjV+jTmm2Gg+6/jCjhpttQf8ipBhC0YpdyFE6klrq+HGnNZ+
         C2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eSFoQYSsQoruZlP/q9EyfnIvN17R/2xMrjfEYAqKSc=;
        b=bXhJkuDYLO+09Fc4H3YIjfgFAmrje/k74sV07K4yDci9AEkGiAhM05Zajmb/PyfueM
         Jmsmo5Zn+ANUE1g7LF/SrP6sJf+RPHW9zGq2+uEAvspPckfmMDJ+QZBJe/XKs1mWt9n8
         sbfAsm0PdFWKLquhszmPMoJyQgpEDlK9dV2HRUeFSIdc/fbTGxYrPCO1TilRtqRU6xO9
         kY7bFn5i0C0+TZO1L6TjslFkHM97W3wVjOadkRk1qc/h1uAVgCEadJXqBaxRXArxRftP
         tQjPo6HH+xDPSo0czKxrhoYH1OsQpDGMItiPiP8n7smXF/Mj1D61wymhhPik/waDKgNj
         jF9g==
X-Gm-Message-State: AOAM5309mE6cVQ9ZVbqFTqVrw3dGAnqdvGKdPT9sQpyrg9R1J+yBd/aG
        s8E2fsoVysK2iGHd0i/SZvpUQQ==
X-Google-Smtp-Source: ABdhPJxBIN/ITlJK7W/GQE+x08lHLk5JUHk1qGfUrTa/pLV1ZtTdDit6+V4NHpzRRK8/epSQq9dUtw==
X-Received: by 2002:a17:90b:300d:: with SMTP id hg13mr6668739pjb.212.1594756243122;
        Tue, 14 Jul 2020 12:50:43 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] remoteproc: Introducing function rproc_validate()
Date:   Tue, 14 Jul 2020 13:50:31 -0600
Message-Id: <20200714195035.1426873-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to assert the general health of the remote
processor before handing it to the remoteproc core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fd424662801f..ad500c291d5f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2040,6 +2040,43 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 #endif
 EXPORT_SYMBOL(rproc_get_by_phandle);
 
+static int rproc_validate(struct rproc *rproc)
+{
+	switch (rproc->state) {
+	case RPROC_OFFLINE:
+		/*
+		 * An offline processor without a start()
+		 * function makes no sense.
+		 */
+		if (!rproc->ops->start)
+			return -EINVAL;
+		break;
+	case RPROC_DETACHED:
+		/*
+		 * A remote processor in a detached state without an
+		 * attach() function makes not sense.
+		 */
+		if (!rproc->ops->attach)
+			return -EINVAL;
+		/*
+		 * When attaching to a remote processor the device memory
+		 * is already available and as such there is no need to have a
+		 * cached table.
+		 */
+		if (rproc->cached_table)
+			return -EINVAL;
+		break;
+	default:
+		/*
+		 * When adding a remote processor, the state of the device
+		 * can be offline or detached, nothing else.
+		 */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * rproc_add() - register a remote processor
  * @rproc: the remote processor handle to register
@@ -2069,6 +2106,10 @@ int rproc_add(struct rproc *rproc)
 	if (ret < 0)
 		return ret;
 
+	ret = rproc_validate(rproc);
+	if (ret < 0)
+		return ret;
+
 	dev_info(dev, "%s is available\n", rproc->name);
 
 	/* create debugfs entries */
-- 
2.25.1

