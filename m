Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6662D2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ey7CtPdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgGGVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgGGVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DFC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so228979pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHRO/0KjGNxIcLdu4Nprxq06C5XRM7DNFyiZUQDkaSQ=;
        b=ey7CtPdAXBygQ5ue7SuxHQa8Oatdp7d/GiJ6UliPUKy1Vxnu6d7REZvKf42X4XJrc+
         gY9p8DUab2i02whZGWnlgg7cj4kHgZ8572tSvVo7eqlourW1R7v6EL3PcWDYQKgR1WsV
         PvV3BudNIq71bKku0JFVw6kjNUGKaPlzT3x5F5M6xzYnU8fOV1EXn36ARjOxE9dC2uQH
         sCxFKe0sfIs03HaokbWOaXYGsIJDDGoRVZgufD3TwVZQNJxzIMdprZmjndWJsKqx7wyg
         aDqN8xfSO50Kml6C3gTqgdIBucz3N9b4iQB8NeNk14+i+PTtMBYpaKkY0k5yoclOjuRM
         jDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHRO/0KjGNxIcLdu4Nprxq06C5XRM7DNFyiZUQDkaSQ=;
        b=UQzMX4TUiC9R3awhHJwijEjcDgy3ioEtPLoipyjuFmaI6g7PVexixYPn7aU/m+UXYP
         j74oOjbGrpcM5mC++Eba0GMfIBA3FKc1BtrQ3ZUIdsWEIklXVjOW0kR2Eh5gSr8gDhEt
         iUGAFs2ffxWaNwrZjOOAc2zmYMUDqR0emkd+g66Hqabi5MlCkFZlfK+ATUCjuHDakXWt
         punxjcrM3Px6JkdojhhyqpqNzN7I/DT3WB5tLz2BzHYvlUnZ0+835uvbAOlAc0QnId4P
         qOmPEU4fElsC75d2SDvx0ZyCz5Ul0YSNXpIMBfI5k+H+0gnLllVsF+zhtarp3uQdTxYu
         5ZPA==
X-Gm-Message-State: AOAM532gha7NEWSrM/x8uVTBM8Ya+3qbdok9lNwbkfQJ6a053lsWIwfV
        HP0Txsyg47Xuqn+xPzZRBWhkxg==
X-Google-Smtp-Source: ABdhPJwYd2Jg2XN/sDXvOil97+lxOhcMuirGZInRZuWanbK+jPdSPTrtzm7fd4Zhai9XJwwp1UAigA==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr46010520plf.186.1594157487779;
        Tue, 07 Jul 2020 14:31:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 11/11] remoteproc: stm32: Update M4 state in stm32_rproc_stop()
Date:   Tue,  7 Jul 2020 15:31:12 -0600
Message-Id: <20200707213112.928383-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
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
index 7145cd49616e..f4da42fc0eeb 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -504,6 +504,18 @@ static int stm32_rproc_stop(struct rproc *rproc)
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
2.25.1

