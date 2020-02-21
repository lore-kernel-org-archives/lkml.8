Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C3C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203324650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpD0YIFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgBUIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:45:47 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44657 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgBUHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:51 -0500
Received: by mail-pj1-f74.google.com with SMTP id c31so512631pje.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kdc4/GnqQPZSDbeLZD4M7jzkDGk/HjdnvHVdHj4Ph1s=;
        b=PpD0YIFQSiCN6/cJEmqaMhNsOaqoM1d0SGbkSAwumb3ksIASRK5XXky8vX5TIdhpm4
         /bDdgSmB6qTiSar/CGLibKdbb+lUsbwPazA+iQqEzHUxBeBQBUBfP/6dIevtAtvuHvkL
         CZd1RWIuD/dJpBwNl5IY6vZXWeaWdIFV90y6B1Q3JF+zZ7k962WuaixETt4WnZU1Aduz
         RAMFYRIosDRR6ChxzXE+DrNutlEbV2ju2ya+KW3PcJpetbQSHW3ze1pi5CdclE5autEB
         YncQn+IIRKcF/mj6RyAxriVHOW6gmVKxMvcZXjg2ti/9g1KGaB0YmHnbdQ00KDKDIx9i
         QbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kdc4/GnqQPZSDbeLZD4M7jzkDGk/HjdnvHVdHj4Ph1s=;
        b=jhHUKtfEhQKWRVHsBcO/AI8sZyl3MIY3juHvdDk7vaHn4s+ZhXY3rPUk7fz6Q9uQXO
         /iG7nZcCXt9D/JJcqAHoAS711XiJNQWRT52Q5JA2JAxG3nqc3vFs3AqIultAJ0KyD9S2
         NYEctVBuJq2R6XzzAkk9puu86Y1c7/cFxjJHXZkFX5gb/RiJcmvi69sFW0KKf2X1LNdg
         QVDfDzSw660xe0MyhYK3eLscudSRd0ViPnJ/CQjBS/ilb9sDsc9wzUzYu8K7FawWLp+u
         yccxHAPrC35LJxFfKEzGrckSe+hYbtJdwp5fAJQwDG1Hda1fFIPHql/lY1sJWLP0sHVu
         ePNA==
X-Gm-Message-State: APjAAAW0joZ7wtiUW7M3L/KqMn0GHebW3Gtm13UEN4GZrMrHWHHHjyhq
        /kWe5kp9LQlvFRUVComvZaeIKXQGY3xsPRY=
X-Google-Smtp-Source: APXvYqzX1iAQ0imJq9JjSnyOkJDF3o4y8ej3cF2kW91EygZYqxE5N1B5FAuwvLiwaHz9hDTaJ1N6Yn2H1pJK6nI=
X-Received: by 2002:a63:505b:: with SMTP id q27mr37081699pgl.39.1582271449861;
 Thu, 20 Feb 2020 23:50:49 -0800 (PST)
Date:   Thu, 20 Feb 2020 23:50:36 -0800
In-Reply-To: <20200221075036.181885-1-saravanak@google.com>
Message-Id: <20200221075036.181885-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200221075036.181885-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 3/3] driver core: Skip unnecessary work when device doesn't
 have sync_state()
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

A bunch of busy work is done for devices that don't have sync_state()
support. Stop doing the busy work.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3306d5ae92a6..1ecd69d26837 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -718,6 +718,8 @@ static void __device_links_queue_sync_state(struct device *dev,
 {
 	struct device_link *link;
 
+	if (!dev_has_sync_state(dev))
+		return;
 	if (dev->state_synced)
 		return;
 
@@ -819,7 +821,7 @@ late_initcall(sync_state_resume_initcall);
 
 static void __device_links_supplier_defer_sync(struct device *sup)
 {
-	if (list_empty(&sup->links.defer_sync))
+	if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(dev))
 		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

