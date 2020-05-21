Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3692070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d46jY1Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEUGEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgEUGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:04:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r10so2674478pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLzO6AaZGCnFvcbXowTQDfE+AbORO1+b/Wmhk6/yp2A=;
        b=d46jY1WiNtT+TTR21OXzy5EmRyieh4DSvvJyo4Pt9onu1LVvN5WX7HqqGHlVtCkYiM
         qpTUN6CWnGDj/SSaJU9fR9nH1q/oXTrWJ5pDLU48kVqqgxIrvWSp2QHDecMw2dMXOpvm
         mdUOyOiOa2uvTJ7Dd3pD3CR4rAxxOLpxPPcMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLzO6AaZGCnFvcbXowTQDfE+AbORO1+b/Wmhk6/yp2A=;
        b=i/7N+yYNOrgdM/xHIQalVRXJUU42Sa5Uy1+pJGScE3gW6O+p46W9gsfsCRbH1JtsWu
         8jht23jgWQA2QF7LKznvJLTImxzMx9aK/CjWz23CX2sGunOHZGSh/fNt9M9gD+Zq93h3
         Mb9p0CauJG8ywhajHBe3KTw27d62aPJ2vqzL1AqQPWs3JIABH4n70HpUpv9zmhKqMFi5
         Rks41DHfytBOt3RvbxY6HRAB/YetoOzcmEJq5rtrkkDkvJQmUdsMAKlMVhV5mIlif7+G
         GoRn7FUrAWgKOMpu7Vuee3XhrDuzLJEQhfX9WM2jg/jpsKZDuy02BN8wXizeQC0mehzj
         Wg/A==
X-Gm-Message-State: AOAM531tFYf8H6tT6DU4fodYQYzSTZpPYgoXKGWV6Etq8vVaGm82QtuJ
        y3tlxYrRQaKrASEGLjc0H5mpAQ==
X-Google-Smtp-Source: ABdhPJwf9qox/9THRWrVH/q8CLC1R6TYC7rokcoVy4IkUl256gHyoo6tmtWgxWBt79QrqAYoEf1Fhg==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr7693039pfa.15.1590041071392;
        Wed, 20 May 2020 23:04:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k18sm3590146pfg.217.2020.05.20.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:04:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCHv3/RESEND 3/3] soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
Date:   Wed, 20 May 2020 23:04:25 -0700
Message-Id: <20200521060425.24285-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521060425.24285-1-swboyd@chromium.org>
References: <20200521060425.24285-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the WARN_ON() into the if condition so the compiler can see that
the branch is unlikely() and possibly optimize it better.

Cc: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index ce725d4ff097..8381bd012de4 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -385,10 +385,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
-		if (!req) {
-			WARN_ON(1);
+		if (WARN_ON(!req))
 			goto skip;
-		}
 
 		err = 0;
 		for (j = 0; j < req->num_cmds; j++) {
-- 
Sent by a computer, using git, on the internet

