Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403572074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9AZkUF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHZQtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgHZQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF597C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a8so940010plm.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCF/a0xKIWqbt7wIUY8AEgGbHy28w20HVJLneFBKefA=;
        b=f9AZkUF8HwjIrp6vPGOuGK5/BZQ33xA15gaimxyXyvQqbYPMj/aTBZyE79upHJXcyx
         g0QJuEEu5J6Y1FHXlnQhPuuAeC0D40IYRf81gM2IaC7kqLRVpFie8Eft3ETUodKI4Clk
         fRWIkJmznBpF/DtjU6iC04NjhKCfy5PL4vbyxzu7KGSFFTf45esVto7O31wAJ1QzCFxa
         /XgqHeg+eK0QHle+WRUMi9uCgz70vNlJh3foE2Ey/zxfILokqIfynvcBv4K3fwOIaWFq
         g0+3JbAgzeAoP34ux82szDlXvf3kv6Cp7FfXZBQtWFPAL8uOb7k8zLrJo3hPsaj2QDTA
         MTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCF/a0xKIWqbt7wIUY8AEgGbHy28w20HVJLneFBKefA=;
        b=MF3na+JKHkxCI9ANY8qpK4l5bEuwYqXRTlvXNIjO2sR/juGd0wED5tR2WjwofIi+fA
         MQMz7M7iZG7Iz2KfXCAXn30vQn4lyIz9ogNYcFaYHxXokJ+cRNg1PQHPQHC5OIrAt+dY
         j4AbzoY2rVp+vw9S5133Tbn69+CiteRWLlkjJqzlF4vlU0x2hpEXRIONm2hDSUV5IlGU
         aIW+pHnLU/qKih/GPHiifTKyaKaRCMeAyYaqBga8aDq6xBLxphR0G4nxXKPlL503pZW5
         ii8g5Ei7pzj38kZyOCMHN0R4tTDmfdRmBCiejGZg63rynK3G9hIhHuvDhqk2Sh5RWpBQ
         SLeg==
X-Gm-Message-State: AOAM5301STz0GRYhCpTgORGGVZvCkh7noajuGLbY+I4z8Vlpx+iw4ocp
        s+enZd9yYB/k6lbbTCEwWkMfwg==
X-Google-Smtp-Source: ABdhPJxEUc2ptVXTNpO+YXWFtlc9/9RA87PwcwkcXOQDJRawbIyXYC5dSKq0dPbyN6OxLL9jL1icBQ==
X-Received: by 2002:a17:902:b28b:: with SMTP id u11mr3741410plr.117.1598460332525;
        Wed, 26 Aug 2020 09:45:32 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] remoteproc: Re-check state in rproc_shutdown()
Date:   Wed, 26 Aug 2020 10:45:17 -0600
Message-Id: <20200826164529.224476-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of the remote processor may have changed between the
time a call to rproc_shutdown() was made and the time it is
executed.  To avoid moving forward with an operation that may
have been cancelled, recheck while holding the mutex.

Cc: <stable@vger.kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7f90eeea67e2..fb2632cbd2df 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1834,6 +1834,9 @@ void rproc_shutdown(struct rproc *rproc)
 		return;
 	}
 
+	if (rproc->state != RPROC_RUNNING)
+		goto out;
+
 	/* if the remote proc is still needed, bail out */
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
-- 
2.25.1

