Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34576C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26E520737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWyLYlFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgCZRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:25:05 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48641 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:25:04 -0400
Received: by mail-pl1-f202.google.com with SMTP id w3so4745515plz.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ORmUSUtMfRthZSgIgNleni10jnUu0xs0YPL13mNZ/NE=;
        b=KWyLYlFq8o7jxlgnH34j8OJCRRgm9gRtqNBxsed6Sny4C9RwfW3BeeY9a6m4u6EprZ
         51jFmyCOmO6jdJbz9Gojk0W0yqxaGHiKuvfw+PMMx9Dn94DfxOJOqANHt1sRzrgPOcKS
         onFTQsuLpVi0OMF5J+uMwUOevghKQ/8nossTFzpxr6Rd6j3r/Rxzl3AQl7LCVckSdOea
         XNzOSeHEasDpxzI/PNifOa1bD8eBbuRyR8F5B8soLWsGmZIvWFX1OSjiWRZbr9fYRkhI
         zNn3CDOHn7Nd/ylM0m6dVLoOCxlfUgvUu0nhrkxxXt/MICG2+GHIdtNmoeBL/DG/k0Fq
         jaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ORmUSUtMfRthZSgIgNleni10jnUu0xs0YPL13mNZ/NE=;
        b=VbvJzybkrYlk5Q7zR9RPVpLrwGs9dAwI8lVNBSAIPWtMkVsDScWM85rtKDPlgRIMfZ
         6n/OJU1GIHT+2aFL6/UtP3Dcn6ZM4VdCnyKGbMy6KzYfGRgLxuZcNHXOxkSqfV/Gvs/D
         3J2wWtFQIEGU87kJtuhXEV+1x3pGefCcDAxUK9OwgwUN4xR9MQpBFEqwd9Wnu2AXN/ch
         OMp6l4zUB1TMa5rj0cn+qAgXc5o+4YwBFVTM/vZTc995/y73UPnT/1sXgUXxNUqH1+bL
         cJ8mXYci3qG2u/BsBdGug7ZHWsYceagnC8/fuao6SE0+gXTji6N4PsP7AGJuLnv0SDUk
         RODw==
X-Gm-Message-State: ANhLgQ2Qq/Bbj8xezTr/SaZ+yrqJrDmIJDjhuOSD9P1kp0LT0GSGvLxk
        E1wSJkvKL/k1bA5S5OlMvBKX25mV8GqTLmM=
X-Google-Smtp-Source: ADFU+vvCdNOQiMzb+fr/gId1WBu7XP5LxEcHieyQODvhu5d5p5y0gwZ285rhR8riYbkBhrsbX5Li/GnKFW5lkPs=
X-Received: by 2002:a63:844a:: with SMTP id k71mr9541565pgd.79.1585243503414;
 Thu, 26 Mar 2020 10:25:03 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:24:57 -0700
Message-Id: <20200326172457.205493-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] slimbus: core: Set fwnode for a device when setting of_node
From:   Saravana Kannan <saravanak@google.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the of_node for a newly created device, also set the
fwnode. This allows fw_devlink feature to work for slimbus devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 526e3215d8fe..44228a5b246d 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
 
-	if (node)
+	if (node) {
 		sbdev->dev.of_node = of_node_get(node);
+		sbdev->dev.fwnode = of_fwnode_handle(node);
+	}
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
-- 
2.25.1.696.g5e7596f4ac-goog

