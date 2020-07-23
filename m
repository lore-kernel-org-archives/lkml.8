Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C147C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFED42080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xpie9hxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGWIhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgGWIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:37:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10CC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:37:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so4321036wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/yM4jsYCAifUDfs6hudfcj/emQNOmj9c2iS2RlrIxw=;
        b=Xpie9hxHzBq4jxqHPSf9F7wibwb3a9HP3clbkUc00eoy8pjV/W4Mf0LSEbRjtqH3bP
         dqPWckK3wfcmpHLj9Zw7KsVNCOWjFzwvairARL4+0e1ygnFpI7pNK/izhnUhBYEC2IYC
         HDgmGON72x4lKUZYVIferkCFvxag4hPQDBnJeXuFLjKJkJLOmHxi2MqnnPCcD4AbDdVP
         akwbkWbNQq0UeQtVH2kRjdzcRFBbGU3SGXGwopU3tp94lDumwBCLk4+zKOhqTwrTeBPH
         4Nx6D0VvaN8qHKyrcz1kCfel3ZNl5mMRqMx/ML11FX0CmmSjpSzYceyucs6iBKTYVO7K
         JA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/yM4jsYCAifUDfs6hudfcj/emQNOmj9c2iS2RlrIxw=;
        b=jYOGtIneRjh4NCik8HBhMzrW6C3DQv7dcDAh/+v3RoGNSqj5swVmO+7IEEfTrGUfZv
         1j1AZrGNF8JVrHWGlGbxw5W+e4ikj5hF2ZOB0KVSX/FvaiZAAI4ih8WKgL8wLTcryTYe
         9OIkMa2n2WNynoQvKPbiJe7x3cEBuvsvzGEItkAjisM12Kk2rNw5wjVWe5CTGEW4ANX/
         ceoPhYEs3q7UxEtTVqVk37QgjpirTRbCrLARhEqy5lDfMl/nkN0vKd1WYrW8aLOOaHlx
         wWJ8jL/bS1o6fWgl9/+eaRd+h2QQmQKOtBZ8h7JnPPuyArSf5J+oavQByClg1DGIZmAh
         v0jw==
X-Gm-Message-State: AOAM533MgRGMBfNHqfpYoInwF2lc+zkwalsEefEoVHLjI7rYsNCVh31x
        ByiXjO+4F1JTrG5hAe1d7/pMMA==
X-Google-Smtp-Source: ABdhPJz5TYIUOxOdMwwJ3R4WMNEjfODtAaiBr6SLeg0J5aER+9hW7ruo9M0zHJkynOvH+TQpUGelig==
X-Received: by 2002:adf:d1b2:: with SMTP id w18mr8808wrc.235.1595493457671;
        Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h11sm3105039wrb.68.2020.07.23.01.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 01:37:37 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Atul Dhudase <adhudase@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/2] interconnect: Do not skip aggregation for disabled paths
Date:   Thu, 23 Jul 2020 11:37:34 +0300
Message-Id: <20200723083735.5616-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723083735.5616-1-georgi.djakov@linaro.org>
References: <20200723083735.5616-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interconnect path is being disabled, currently we don't aggregate
the requests for it afterwards. But the re-aggregation step shouldn't be
skipped, as it may leave the nodes with outdated bandwidth data. This
outdated data may actually keep the path still enabled and prevent the
device from going into lower power states.

Reported-by: Atul Dhudase <adhudase@codeaurora.org>
Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling a path")
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Atul Dhudase <adhudase@codeaurora.org>
Reviewed-by: Atul Dhudase <adhudase@codeaurora.org>
Link: https://lore.kernel.org/r/20200721120740.3436-1-georgi.djakov@linaro.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e5f998744501..9e1ab701785c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -243,6 +243,7 @@ static int aggregate_requests(struct icc_node *node)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
+	u32 avg_bw, peak_bw;
 
 	node->avg_bw = 0;
 	node->peak_bw = 0;
@@ -251,9 +252,14 @@ static int aggregate_requests(struct icc_node *node)
 		p->pre_aggregate(node);
 
 	hlist_for_each_entry(r, &node->req_list, req_node) {
-		if (!r->enabled)
-			continue;
-		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
+		if (r->enabled) {
+			avg_bw = r->avg_bw;
+			peak_bw = r->peak_bw;
+		} else {
+			avg_bw = 0;
+			peak_bw = 0;
+		}
+		p->aggregate(node, r->tag, avg_bw, peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 	}
 
