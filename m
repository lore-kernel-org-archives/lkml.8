Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0628220760
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA7geEuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgFFVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 17:03:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728686AbgFFVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 17:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591477375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EhPcZ8ZKsOGQJhM7Y4SG5KeIBZOSBJJrvqPyygwuVxE=;
        b=eA7geEujKYkZ18qb1V8UGD3yX9daeOn8lNq2BA2c3OTTjiZzp7b2vIB4GFy/4aGd/MWOxX
        XRFRF0BC3B7tvI4SfbHDR8y8jkvCZU46TK6/XpSwyy0GjQpSbWq3J5nmgzuSgKeu1HJJl0
        +rU0qCPoCjPEI4ORkQZJnphpsE8sKKw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-zrItblCxPj-n0ocVHaT3EQ-1; Sat, 06 Jun 2020 17:02:53 -0400
X-MC-Unique: zrItblCxPj-n0ocVHaT3EQ-1
Received: by mail-qk1-f199.google.com with SMTP id w14so10830156qkb.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 14:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EhPcZ8ZKsOGQJhM7Y4SG5KeIBZOSBJJrvqPyygwuVxE=;
        b=U5JUViS6+yIr6bsa1GdpEnRDqPQmAoYC5Il3NoqmJnOy5Hp5Y+VpqnnehWDTpB1FO5
         gQrHSMg2YJueptrdcWLvS8mJynHIBtT0/58885Dm2egHuueewz5pWYkZfCk4arDlHAO1
         wosXiUZEC6ii3SRRe0pZkzOGfSAV2mZNFNlWsjo9SWOkKg5FwFbkuwtxqy3hH2lpadXo
         uu29+i5sAhYSOqnMraliTQaYmDL+RnbcVp5wTF+sxKCWNPwTKThHRzJTWyvGYymFtaSq
         KY70xK5saec7tSV0Cc6JLe0Ruv3GWHiAFVB4quXO210ynmEKbLJU+/qy5DjwjpS6QOLD
         7fcA==
X-Gm-Message-State: AOAM530r5xsEWsyDUMONNTUVFUmZL4bOD8/XuWpwHuy5UJFLmliSjTl7
        20Jn1JmCAYOMqUTgysRPCtDDu1snJdIiasOuXxLNcGXlhcrdyB+Qb4TL6MaeWQt3Dhal4bZJFhw
        lgpfoK26SUZ7a1tyYGjZL08G+
X-Received: by 2002:a37:9586:: with SMTP id x128mr15600406qkd.312.1591477372798;
        Sat, 06 Jun 2020 14:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYQc7ymCPetr6UGIR95AVlYji722MSUFRWkqI3a0x/xyB9N/48Flho6ybhZRR4Y2xAEwQyIA==
X-Received: by 2002:a37:9586:: with SMTP id x128mr15600393qkd.312.1591477372591;
        Sat, 06 Jun 2020 14:02:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm3025299qkg.25.2020.06.06.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 14:02:51 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] fpga: dfl: Fix dead store
Date:   Sat,  6 Jun 2020 14:02:41 -0700
Message-Id: <20200606210241.7459-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200606210241.7459-1-trix@redhat.com>
References: <20200606210241.7459-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

A similar issue was flagged in fpga-bridge.

So remove the unused stores.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4bab9028940a..2deccacc3aa7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 				       void *priv)
 {
 	struct fpga_bridge *bridge;
-	int id, ret = 0;
+	int id, ret;
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
@@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e05104f5e40c..f38bab01432e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&mgr->ref_mutex);
 
-- 
2.26.0

