Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B35C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1D20848
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWV9IUgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCJPvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:51:01 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54522 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCJPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:51:00 -0400
Received: by mail-pj1-f67.google.com with SMTP id np16so577724pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puatEVJhmuKOgt9Q8cu9iqdOLjjoYq+qMGRTWKKIk0c=;
        b=CWV9IUgYBgF3JDQa0TiG4+8dJO/gigk00+RUPGah+A3JbXSZMEMXm9jvWhov6pQtdG
         2jjdssJH3zGk8ONCj6SUdV6lblbZLI+1OeMEUMBokuMg7Z8KCNX6xRo/Pn/hWo/f6edZ
         eBoSs5XYzgZVa28ZdGspawgb3/StS/qnrPsJyRD6i6xxjjwgF7lcLWN9DLPlHBmcPSlT
         sPL8H+zqfR++rXXQlJXvK7yjB8OOAcC4XG5ypoRz7SKKm1vr6tGnNzE2wTwntUxDXfGQ
         aU5wl67mA+eZGb0lB3qQ5nZZoIQZtZo+TQJrdU/DpbAIaVNtpdnEzZUPFIxbjvKt3Egz
         3TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puatEVJhmuKOgt9Q8cu9iqdOLjjoYq+qMGRTWKKIk0c=;
        b=G0j/n24qWHocPSNIdFjeC7HqzCEen725mUFbKlTQVrX/JR3lBfbZ2fraTvwYyM18hK
         5+Xtk2hprumFnAx4uDV17nw3Yq5Yl6Vefmr5qNGQL3Sewxg078CaiB3pLDdj8cbzsfnb
         pPB9AW3dsuDiaHLJ++P8d8AEou/FvRZKUTtAuMH9vhFk+HnI5yujHgWAkfVG+MMbz50d
         5Hb4542K/vF4gJBZqiT0JW4GqFMOs2iMMXRpnJJSxPGx2fVkne90nbAibh4fgJjpnRp7
         vFansifez3mL8k3SPU36s0c1VEvO9wUf8B8TJfvVYGMc8j4HcpeC4WftseCA2XLyRy5d
         Egkw==
X-Gm-Message-State: ANhLgQ2Y6l/kFhZaCh44BMCt0OxlFYlgRVRJZvCXTCila/XeUqcsbNjI
        oghuZ5FrWwn5Cyz9GHHMnrbPcw==
X-Google-Smtp-Source: ADFU+vvPzJ71s775gNA98xJ5cDRr+8TkKbn/z5xOf4wkucvse+76g071RrAOnuiFhWH8XSA3OeMTaw==
X-Received: by 2002:a17:902:ec02:: with SMTP id l2mr20982861pld.184.1583855459807;
        Tue, 10 Mar 2020 08:50:59 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d22sm2807841pja.14.2020.03.10.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:50:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rpmsg: core: Add wildcard match for name service
Date:   Tue, 10 Mar 2020 09:50:58 -0600
Message-Id: <20200310155058.1607-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
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
---
Changes for V2:
- Added Arnaud's Acked-by.
- Rebased to latest rproc-next.

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

