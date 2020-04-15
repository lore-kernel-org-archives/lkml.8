Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F340C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654EF2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwCYJ9CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442173AbgDOUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438553AbgDOUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:49:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE4C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 188so492427pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6Z/2U1uSaMVZIS1zrhX5ycxTde0oQImP1UUauJl94M=;
        b=SwCYJ9CQNtNrDxPo10KzPwy/ANvNIUyE6IU+PI/Y+XyS4RgwDVTs1XDSRenCRHcku3
         Oi60l1cNkELSfLeIKpssWjCQVNCvhzvgfn6oJ+fbDWK+j3YtHqyqmr7tg7YtSKyh4eAK
         Z8aPM7rIsVFLNioM2ldcrEmsmhrJ6xBk9rqzl8MNtmMONDQkv+F5ufxs6HxAWS6BjjXh
         +B9KnfjStoKp/m+c+xFBSyN8z19xirInrN7y/vAARQZPvphs3ZI7cR9DjMqfvWVfQFpi
         aL/YU2rLmGdPwYAUYRebovMZFb69mIbA+Xuyb2Qffj5fBGY/gL9DH7AGR8+ftf3nzOs4
         qBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6Z/2U1uSaMVZIS1zrhX5ycxTde0oQImP1UUauJl94M=;
        b=Alf8VMT6YrvGtVHp8RufPUoXFb0oVguzPRv20/7Q2gBRDmGuZ6vNV8lCIJY/GSodLn
         M1jbS+1AF4FlxW9yGyv/3TYUefdNxc8JE3kcHLl17Vz2Y/zYCWUezq/2yc+eXnmvjzrd
         e+dHZAF1EliqAj5rQU1F6xG07aCkta5GIvvw8RJm9EClMwz26H0HuIvJir3blgm8LDmc
         hASAyp+fKzfjMzbdMz6I3rOWiLAfb/LtGk2W7uyKmQNA2HEZdHfsrPD0x2Yq4A9AljFU
         YOFES3Pq62BiwNHzOlJoWeU9iVTgfvEi741He+gzGnzaa7dG/YNxU9NaU8jjgG/GQKOf
         9eXg==
X-Gm-Message-State: AGi0PuZbJO2DSTtkY8Ok2Z74HaED3Gqsza5aDSIZflZmyXWPuUDj0hSM
        z8pPP2P80u9OEjY7aTFBPZ0j6A==
X-Google-Smtp-Source: APiQypIFhtjeAMS9QbnUxPjJwRI1p5Xcbg5ltSm/cXWA2dMBCmxFwFxeAotaA6qLGbnm5f4z9vfiww==
X-Received: by 2002:a62:58c6:: with SMTP id m189mr16314763pfb.161.1586983748099;
        Wed, 15 Apr 2020 13:49:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i13sm14461861pfa.113.2020.04.15.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:49:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] remoteproc: Restructure firmware name allocation
Date:   Wed, 15 Apr 2020 14:48:56 -0600
Message-Id: <20200415204858.2448-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415204858.2448-1-mathieu.poirier@linaro.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the readability of function rproc_alloc_firmware() by using
a non-negated condition.

Suggested-by: Alex Elder <elder@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ebaff496ef81..0bfa6998705d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1984,14 +1984,14 @@ static int rproc_alloc_firmware(struct rproc *rproc,
 {
 	const char *p;
 
-	if (!firmware)
+	if (firmware)
+		p = kstrdup_const(firmware, GFP_KERNEL);
+	else
 		/*
 		 * If the caller didn't pass in a firmware name then
 		 * construct a default name.
 		 */
 		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
-	else
-		p = kstrdup_const(firmware, GFP_KERNEL);
 
 	if (!p)
 		return -ENOMEM;
-- 
2.20.1

