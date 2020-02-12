Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A67C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39974206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azqcd8cX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgBLVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:12:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45367 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:12:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so1414525pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IJZJYEelASi8ZQCkdIcLDnnIutfG7b5nGAbr7QUKNQ=;
        b=azqcd8cXw/wi/gh9wa6Ax4h1CZTAj5vm4mi3yCaJwLM15gWZCni5qjGj8emJtZPhnu
         UgrVTQgxozVXwdWmAIegaw087OBM1ojSCoe02ehql+NPdzCGu573rs61OCyfN2/RJv4U
         EZpBdv+9iMFYaZCkI0z/f9HY+Igmf0Mx9KdLpYQNBZzoxmDUYjQkPtXPVfQ1rbQ6Pjh/
         Zg+v7UUi93wOLeMoA84RfzaL8wu6e4mvfJq9FohqMN5pN83PiUwATRXX/mvvho0Q7Y3O
         YExVodLuAJrSEeo5y9KEa1H5Kp8d7fBV0lZu7k4Cjx9YccvvUadMm0TmMRwP1DGstWsQ
         tp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IJZJYEelASi8ZQCkdIcLDnnIutfG7b5nGAbr7QUKNQ=;
        b=SyYvzwh8K/QBR43O0lxy5tQi/KJ/Gb54AWqiSjV1CzC0+wY6MmO8xCMWcV3J+5WGTJ
         7hV46cgMBZy4kMHuGDAFeCaWI6FzHqpiCYvLCxcKdqpJMwxCq259nqCokMP5ffIfY/5z
         vacCcTg7wMgJBKQDikd0t6vA+FXtP83OSH1gI24fr44eU93zWo3LHMxEyAEpaJYPcjUS
         zVfVEcx4lHS8bS4Xlj37O7+2HBb3MD+SHWAGL9nGZRYKOoTBI7VXMz/YaehA6qfqQM10
         U8qguQiO1svXIFUh/gr+yumkaQ/oOJXimuMDrKShntNdoDYz0Fn4T3gh2J6bs6uAn22J
         b14w==
X-Gm-Message-State: APjAAAWWs5dlZzSEv6r2lcvinFNsR5RaMABrtqYdzXnxfqU81vl35wOG
        2Y3QSKGtBIrc/hRtGOt8W32UOQ==
X-Google-Smtp-Source: APXvYqwxk9TfdMx67X+S3KL1wab9T32loeJ74vF3SfkjOLkK0QpGbJA015F09VCX8lP8Zo84SQDeVw==
X-Received: by 2002:a17:90b:14e:: with SMTP id em14mr1061865pjb.112.1581541975312;
        Wed, 12 Feb 2020 13:12:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h11sm48295pgk.48.2020.02.12.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:12:54 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, s-anna@ti.com, xiaoxiang@xiaomi.com,
        t-kristo@ti.com, loic.pallardy@st.com, remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rpmsg: core: Add wildcard match for name service
Date:   Wed, 12 Feb 2020 14:12:51 -0700
Message-Id: <20200212211251.32091-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212211251.32091-1-mathieu.poirier@linaro.org>
References: <20200212211251.32091-1-mathieu.poirier@linaro.org>
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
---
 drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index e330ec4dfc33..bfd25978fa35 100644
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
2.20.1

