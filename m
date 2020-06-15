Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E883CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BA52071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icMWvMbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgFOVjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFOVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:39:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0DC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so343164pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyRhxXlSJbKSK/jr6YPy3HeQq4PdeBC9vguPA+3WUyI=;
        b=icMWvMbiSqJrPnrfYMv+Lor6G9QXAlC+u0lRJ44xpWskpBzTEY00E0jUphWPJ5513Y
         NCXchGnjLxzZwwOJXmqNJu1TKuw4t0DStYw7E4YsN1g/5J/slaY5u2DEcAgewtRhNpxw
         g/DMruG14/zk7/0U2NfZmfiAMIpwG7waTSMPM49Lyz5t8kSXecTDGoNhkwxw5vftqjO9
         pU2JgL2stBOrzNjqku/4WPz4ZPwiNFYI2jaMXtOLkALq27JXYzpc3h9KH8WMzVdAw7t5
         8jZqmUD9azVQEkY/sqScFT8a+DQLerE2Fp/J0RFHVfEahfYkD/oGJjJ5bLVedumUtlbN
         QFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyRhxXlSJbKSK/jr6YPy3HeQq4PdeBC9vguPA+3WUyI=;
        b=aSuSpzwFyNbdIy1M+I2qz/g4J8ksnuXZWEhfMjU/NYALZzYRQntz9cApHvrJk12+wo
         /0jG5QiynMgm+FHgwA6tYCzSDT6G4bIPDt/q1DwGV+0a2suYckyInUH25LtSajHfPmPg
         fZN+bAU+ixCdsj/POe7vQ8M9sozuuTtSbxPzTRSzrrTKdMEYcoVGpynMTkvQ2P0Bmvpm
         9qrkkaAU3Nq0GqwtvRvBGzO0t9zlETVsu4j5Yk6Rumh9/7/X8NIffWe9u5FhaONFAq8p
         EWSgnLWrky5bzH5bcjFdPAGJP4DyIghdF8yb0GS+WgnZ4EhxXs2t7357IwwJ+Xvn7mFE
         CjlA==
X-Gm-Message-State: AOAM531gjlvx/2uym1aflCqB++qf4jJTgolh/sP0iC+OrcCWcE7uGNPO
        kRO7qWBCVn0QJwdYiFBrz3YPfg==
X-Google-Smtp-Source: ABdhPJznJNn8sjKPbAHG0ZIgIQ+QDCC5XbXar3eahwar9jK6C6gr2OXePVVMNhzbCs+V8JhHfEpLNA==
X-Received: by 2002:a17:90a:d803:: with SMTP id a3mr1263993pjv.125.1592257142004;
        Mon, 15 Jun 2020 14:39:02 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o186sm8708227pgo.65.2020.06.15.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:39:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] rpmsg: core: Add wildcard match for name service
Date:   Mon, 15 Jun 2020 15:38:57 -0600
Message-Id: <20200615213859.443152-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615213859.443152-1-mathieu.poirier@linaro.org>
References: <20200615213859.443152-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the capability to supplement the base definition published
by an rpmsg_driver with a postfix description so that it is possible
for several entity to use the same service.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a6361cad608b..5e01e8dede6b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
 static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
 				  const struct rpmsg_device_id *id)
 {
-	return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
+	size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
+
+	/*
+	 * Allow for wildcard matches.  For example if rpmsg_driver::id_table
+	 * is:
+	 *
+	 * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
+	 *      { .name = "rpmsg-client-sample" },
+	 *      { },
+	 * }
+	 *
+	 * Then it is possible to support "rpmsg-client-sample*", i.e:
+	 *	rpmsg-client-sample
+	 *	rpmsg-client-sample_instance0
+	 *	rpmsg-client-sample_instance1
+	 *	...
+	 *	rpmsg-client-sample_instanceX
+	 */
+	return strncmp(id->name, rpdev->id.name, len) == 0;
 }
 
 /* match rpmsg channel and rpmsg driver */
-- 
2.25.1

