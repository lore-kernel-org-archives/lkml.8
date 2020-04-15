Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA496206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmJsR3vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442148AbgDOUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438421AbgDOUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:49:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51ECC061A41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so562799pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7xQkJUM4QmV6qWTvIaQsCBAO/ir+/c43EdRMlg0Sws=;
        b=pmJsR3vMADCiEuC3ZKRoEyvjBq1QZzx97rLn6fPaWryt3MHuayJKUFwHlbhn+r8AOD
         asA55ORUfRTr3uD7Q8z5p/QyDbS08f1zy+UqpNFmm0Z3Z2mTsv4lxEG9RcsMpX3HwB+W
         yGRd3o+f6FGE+AfWv93DKCskICeFWSVVkACz3I6GXLhAuWf7SA6qS+F3kBGN0iZUl6fT
         K3nvktHz9RuwTFri9hLNzEvNvsKE44ncHhAOSUuUI/OYE2a53l+EK4nYw5oAspI/6Jri
         VNQJHC/lEOsTzMPMsNv9CdwmyoHA4fVuurHkJ+CIrwKnGKenxFE0KxZu+PeQbcOJMxuX
         tPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7xQkJUM4QmV6qWTvIaQsCBAO/ir+/c43EdRMlg0Sws=;
        b=roGHnzXKvUj1nP2uGI51wxe0ZO0rfnB/mJTWeXCjGCb3j60nzscH1m0/3T2brWJYHR
         Cz9YsJp7cFzSMB0UUFmCYrbeLZRhO/3KIo61rlplOflpr+d16QUjK3TB9DRAqcRbKpM5
         pIpVRzhjRbLLnNvx0c14Pkkn/RkCynjsLEVbvLUkzFmqUbRj2K5Jh9A8r+iZxr+f2yln
         wwLHHrXsLtaMp1S3JzbdvaQqp3wIODHDQeTAmqyTpvYAhb5zBVZVeQp7QhPuyVYNChdN
         89dGxQLrlK85AriAzzAw9dMIp47q8NvOYvIQJCFDrX36awBIQdvLMm+/9mlcpvdjzf0v
         u6qg==
X-Gm-Message-State: AGi0PuatPvmKPL4OK6vPP/uq+Bl5OUXI+sB7po1MJ3JopLXyE7b+HFWW
        3zuYpR9kMhVnrg+1UvTASxSk9g==
X-Google-Smtp-Source: APiQypIxyHNKa0iKE7i1LVCf7LxJgykFFNIGEKKj5IapE5xxqMj1NRd3bFf0osSuuOi8WmOUMH0hcw==
X-Received: by 2002:a63:2686:: with SMTP id m128mr16210074pgm.283.1586983745414;
        Wed, 15 Apr 2020 13:49:05 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i13sm14461861pfa.113.2020.04.15.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:49:05 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] remoteproc: Simplify default name allocation
Date:   Wed, 15 Apr 2020 14:48:54 -0600
Message-Id: <20200415204858.2448-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415204858.2448-1-mathieu.poirier@linaro.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to cleanup firmware name allocation, replace the
cumbersome mechanic used to allocate a default firmware name with
function kasprintf().

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 4dee63f319ba..9899467fa1cf 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1982,24 +1982,19 @@ static const struct device_type rproc_type = {
 static int rproc_alloc_firmware(struct rproc *rproc,
 				const char *name, const char *firmware)
 {
-	char *p, *template = "rproc-%s-fw";
-	int name_len;
+	char *p;
 
-	if (!firmware) {
+	if (!firmware)
 		/*
 		 * If the caller didn't pass in a firmware name then
 		 * construct a default name.
 		 */
-		name_len = strlen(name) + strlen(template) - 2 + 1;
-		p = kmalloc(name_len, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-		snprintf(p, name_len, template, name);
-	} else {
+		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
+	else
 		p = kstrdup(firmware, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-	}
+
+	if (!p)
+		return -ENOMEM;
 
 	rproc->firmware = p;
 
-- 
2.20.1

