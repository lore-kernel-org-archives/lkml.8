Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73702206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZS0ErfU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEUBV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgEUBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:21:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60609C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t8so101801pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLzO6AaZGCnFvcbXowTQDfE+AbORO1+b/Wmhk6/yp2A=;
        b=ZS0ErfU6kx+877Epd4gWCUdtSOC9Ag/zganMQ5XVu32aGc6GZ4s1ni+hdhO4TjMO6H
         PQvaQoZ29a3Dj8ya3Rzw0QZkTKyAjFoaCH1kZP8hT+bV2DrCJGfXFJUrBjLr/scB+vCO
         brMBW2GfBIkfnfuBSLSlLj/MaO3GDvtQvyvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLzO6AaZGCnFvcbXowTQDfE+AbORO1+b/Wmhk6/yp2A=;
        b=clarWybjPFue0x0XNvKoIXnSbVuxw1cvbGl9xC+u09HBrpYL8oeMyrsjZK8y4zUKkr
         1YxJybR5kZ0DFnvRieuamuIl9Nv51d5NtBg0WEItKiYv2fqHgFmmOKZ2xYmr0aSG1Xth
         h+Xl3VHXX8nRlkC7h0Zu7gJNERUVu9x13hiqZRAlC0l1+kpzCnT8an5QUkbpDL4Tu8tF
         Y+vDk/9krCR8ptPtI/Dp76bauKOeIeQnrZtf7nmR3Wyq+cjz/hpLv6r1E7el2Z8e1P5q
         GgwaZ3q5t77ViYbGSObhX40imysPWVKpIsep5ZogdQ115sSe+J5+Xq7fXvuSlZB/JGVH
         rMgw==
X-Gm-Message-State: AOAM531/YLS+C0RZl6IohyRgaSDfBJJn4t/aki7aaOIkiVyYQE1R16oZ
        TKDal/OFeYlaxR+qygRemflF9PPlr/I=
X-Google-Smtp-Source: ABdhPJw/iL6S/cy7kyL/0B/RFw+kFCr2k+xdzWEz3c9VxuoyNzn7xLMe8gLfuMLZnWNbC31bcEluHg==
X-Received: by 2002:a17:90b:1218:: with SMTP id gl24mr8180411pjb.215.1590024084571;
        Wed, 20 May 2020 18:21:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm3081020pfa.111.2020.05.20.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 18:21:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 3/3] soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
Date:   Wed, 20 May 2020 18:21:19 -0700
Message-Id: <20200521012119.238270-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521012119.238270-1-swboyd@chromium.org>
References: <20200521012119.238270-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

