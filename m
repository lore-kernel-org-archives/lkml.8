Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D449C20878
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDpwCbFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgFAR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AEC08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so245303plv.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4RFNd9FFVlTeJLx02SSeMMgnm0C5Ocm0tA+r0cHo1Y=;
        b=jDpwCbFHHHOdFSOjq6a7d0+Jeda1zij/0s2YyarOhbL1q9jo+DgjNl/BLDo6Qai070
         2WLbe7LDYhcsR6Al9tIXcUq1hjSNSkJ5b37HvFu9BL8DAe3zZ4z6jWGtsBOh2laDL+VM
         IgVYA3Iv8FKeM1mbOVzl5grl6P2IqcPgjEioI8VvPUiDEJQ+s5y90Ie9Llm9B/aJnsaU
         1hJvyLWdtmO4dmDCoEE3OeIZsDrXfT+6CtGYWf0Ggvlf2vTy+KrKvrZ8VY1hoTFyQSkm
         rHd7p4AW41iHcMeRgg5GQN+kpaRrhnsrW+1K29gPT5lgGZ3DvVXMWW5RjsknN+xU8GPN
         uZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4RFNd9FFVlTeJLx02SSeMMgnm0C5Ocm0tA+r0cHo1Y=;
        b=sKq3tJ5A41m7mSfiRjYBXn/4tr0l16F/K+tEUQ+mkk2y/D6sKkR9bt2gSIukqqwfWK
         Fq8A2ZcikI1uCuytMbvkT6Hp5qhwRyC8nrTM0QR/35NtD8BfdkhU8mtX/JU6krdT5F+H
         vFBKdH5S3Dzg5WInm1Fqx6NUw+Vk//ayusa5L6t2p9MbnV6mxhts+fjDt7NzRB6OOAIJ
         z3kn483Gz4uYXTffMZIssx2CE5yVvnW1SM/ydloeNRgDjlhJj3uioI6+MaaaJoQncPkp
         P4EN4XggnkIsUshprRf8PmuZein9ll4j2Ki5ssbcGwu5wTeId3FrdUzw/ec27MSun49D
         rXag==
X-Gm-Message-State: AOAM532yMTh1tCd4OEY8WBZuo4ghqg+znMBkvwzxrPdlvV3YEUxxhsor
        UwUM4BRCAqXlZ84o8HG7qV6M3g==
X-Google-Smtp-Source: ABdhPJyPL4cWZZg61WZPJde8LyrsdhiEW14iaC+dVSSpI6qDWDL94WZSK2PfRnxce1jBtWI4z5ay6w==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr4455323plo.27.1591034168449;
        Mon, 01 Jun 2020 10:56:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 11/11] remoteproc: stm32: Update M4 state in stm32_rproc_stop()
Date:   Mon,  1 Jun 2020 11:55:52 -0600
Message-Id: <20200601175552.22286-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the co-processor state in function stm32_rproc_stop() so that
it can be used in scenarios where the remoteproc core is attaching
to the M4.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 77a20a638e0c..ad0307aaf3d5 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -503,6 +503,18 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		}
 	}
 
+	/* update coprocessor state to OFF if available */
+	if (ddata->m4_state.map) {
+		err = regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.20.1

