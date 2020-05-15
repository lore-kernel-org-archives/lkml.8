Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D05C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BFF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOovWDSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgEOFfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgEOFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:35:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB2FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u38so1260093qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EZoy6w7ha0DNuHCPHtXM/SP1BLypAsOupCZ9P6v8cMM=;
        b=rOovWDSJYXWE5Bmy7IlspRdZnHrW3vC8hO0zRosezAonLPXvCkp4SGejQLIRYpLSlv
         QfdRJ92IBQkIQW188k9n/iXvg4qHBBRuydnWHU1LlPDJfpnfaDdF2WcN96jNPK3XknVN
         ClYXIl7QaaHGPmUiYUPJZOqBCncHbos5xkyX+i68aMXwhfkmGKjGQ1HyjlobIvmNmhna
         4+6OZLy3n/1ROIjmOYDG2XgMTFSaARz1ChwsCyhnPfL96S1evSHhST4tjA9s2RapQXna
         wBgOw9417hZKdE4zXjSNPWBk88p7+sdHK6Q7yRi2pmCfb0iyD/O0jUiI8GPItZDnZFzY
         aIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EZoy6w7ha0DNuHCPHtXM/SP1BLypAsOupCZ9P6v8cMM=;
        b=uYrPyt6Lag0wCNqYmWFM5m1N8GfOUqkMSJekOwHdFLfUngIbBBTH82nukOKjOEtw4q
         svyQ58wlLk9TU84xsGjRGoVHHcZsp2IldB7PGd7R1tGkU4BVMbxBJITxiLHbBjc5sbfg
         pN2iaE7yX03ZSctk589MuQBNtsM2lSBLr4Jttj9OSaUyK4hYkEm9CwINNkxhQSR+kq+C
         ypjdAndYUHSTDCw+5CImj9SqUVyw0uJ0y9G7sC+7XhxbRU/zpgh1MPe/luFKquTuApfL
         xWRP3yg1QKjjnycWgmat4tQII3npO7CR7ainusoMLnbHH5EtdurFSfHDugZjljc6DInK
         A5JQ==
X-Gm-Message-State: AOAM530wKAV7hRqeb1Ugv/TCW4NqYVg331hoJA4ZvT2J/3jyj86todtP
        2a5ybxjunYq0Is0IW1fmECIW8qIqXcnAN0Y=
X-Google-Smtp-Source: ABdhPJwaE6/0XCEsVs67aBW7TEyiScvmgrKOX5Hlong/h0NOfDzB7vfDCEcF3sKLCbo5eLpiZQ6wtkRsTF4+GrQ=
X-Received: by 2002:a05:6214:70a:: with SMTP id b10mr1910835qvz.186.1589520906395;
 Thu, 14 May 2020 22:35:06 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:57 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 1/4] driver core: Move code to the right part of the file
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit just moves around code to match the general organization of
the file.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index c9045521596f..2b454aae64b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1143,6 +1143,36 @@ static void device_links_purge(struct device *dev)
 	device_links_write_unlock();
 }
 
+static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+static int __init fw_devlink_setup(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "off") == 0) {
+		fw_devlink_flags = 0;
+	} else if (strcmp(arg, "permissive") == 0) {
+		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+	} else if (strcmp(arg, "on") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	} else if (strcmp(arg, "rpm") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
+				   DL_FLAG_PM_RUNTIME;
+	}
+	return 0;
+}
+early_param("fw_devlink", fw_devlink_setup);
+
+u32 fw_devlink_get_flags(void)
+{
+	return fw_devlink_flags;
+}
+
+static bool fw_devlink_is_permissive(void)
+{
+	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
+}
+
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
@@ -2345,36 +2375,6 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
-static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
-static int __init fw_devlink_setup(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (strcmp(arg, "off") == 0) {
-		fw_devlink_flags = 0;
-	} else if (strcmp(arg, "permissive") == 0) {
-		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
-	} else if (strcmp(arg, "on") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
-	} else if (strcmp(arg, "rpm") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
-				   DL_FLAG_PM_RUNTIME;
-	}
-	return 0;
-}
-early_param("fw_devlink", fw_devlink_setup);
-
-u32 fw_devlink_get_flags(void)
-{
-	return fw_devlink_flags;
-}
-
-static bool fw_devlink_is_permissive(void)
-{
-	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
-}
-
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
-- 
2.26.2.761.g0e0b3e54be-goog

