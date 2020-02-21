Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED5C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAE206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnA22rj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgBUHuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:50:52 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43938 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgBUHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:47 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so786302pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TmMGk/2HBR1UCtTSik3KGPjlUzxkj3b3kzWXZC6WT9Q=;
        b=HnA22rj1dxnIqlA9T0G3M9hI7Ol0tPKBHB3zgMhpLpfKsZh8/7rGFL+VpJhCzde6Nu
         KcE1Q8zAzVUc/5Pm34mVfvY0+9krjUAjkpmGtkonB048819Z48M+YWQacJJ340JKu+ue
         x7jFulnQWyRBstsM4STMH8HFqMQwRJgZGycic6yiIPk4zOOgqYt0OF7JY3fIDkeE9ay/
         vBGfyigOc4ICKdyI0inEGExZ9v733oWf1prfVUKJKrLGnDN1LlbIQUr/hv2jbk7vkLpX
         cpO/cJXDixOMfE035fqyXvCsGbWDCU/ZBudmXUOPchl1J32YneGL6Hynb3WxV2w1p7ZF
         amcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TmMGk/2HBR1UCtTSik3KGPjlUzxkj3b3kzWXZC6WT9Q=;
        b=bDIC5icCd1ipu6RIDQfFSNw1S/+AbTLlvYCALJTTbXeNxfCPVfkqb4MqVB55fEWCCJ
         AAGFwqdwXf9OjOWAKhP4cYNniBeCLzvIpzEXulbdw2HQyGF1FRKYHpOhZcL+TfXvcnVq
         K/1Jn8UB16o9qFNqSNDrjFQREo81Ys2Q4Ri54Jtw4Meih/PaapIzRg/PRVacBQO9pncT
         TjGDxhGGsSGQcOriPpS8cWhUWTfW88OIFaCbiKQwUh0okrusww1D3ituHv9bQkKQ5sEF
         Ke8jKzXte8baU8bqc1ZpCSBsQeZLSaMBWOEDKSqZI+/STjdzix3BbXSW8vzyt+ha+Tsk
         Cynw==
X-Gm-Message-State: APjAAAWzr7nIR2U51aU/kQHBmF4mpK4FvffK3gsP8D3Q+x4FzA6G4lEY
        +2zjXy5Q1Hq0taLaiPv5G1BYMbAOflDF7Fo=
X-Google-Smtp-Source: APXvYqwt26QxPKqFuPdNRe/xB5a2LF+NSPwWWlHVhdOULpbO8o8NeieDv3STiJzdiNCnYZDbmc/xqiEqVNxQlLQ=
X-Received: by 2002:a63:5a11:: with SMTP id o17mr37742004pgb.60.1582271446721;
 Thu, 20 Feb 2020 23:50:46 -0800 (PST)
Date:   Thu, 20 Feb 2020 23:50:35 -0800
In-Reply-To: <20200221075036.181885-1-saravanak@google.com>
Message-Id: <20200221075036.181885-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200221075036.181885-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 2/3] driver core: Add dev_has_sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API to check if a device has sync_state support in its driver or
bus.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0cd7c647c16c..fa04dfd22bbc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -798,6 +798,17 @@ static inline struct device_node *dev_of_node(struct device *dev)
 	return dev->of_node;
 }
 
+static inline bool dev_has_sync_state(struct device *dev)
+{
+	if (!dev)
+		return false;
+	if (dev->driver && dev->driver->sync_state)
+		return true;
+	if (dev->bus && dev->bus->sync_state)
+		return true;
+	return false;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
-- 
2.25.0.265.gbab2e86ba0-goog

