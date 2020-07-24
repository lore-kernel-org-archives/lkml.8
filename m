Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971E20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3qls0VA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXSF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:05:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F440C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:05:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t7so11552310ybk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ia77NFPvG9e51YaeuOHOcuj/rUgKd+hMh/cRttjO8EU=;
        b=D3qls0VAA57VpCl3DF2jThwVOlPsGXZ7tj/8pUVerGrE0ikIX03cXU9qXzeSpK9IT0
         qBQI5IjrPb9YdPkoWchLu6c11nRNKS4sSaAdeii83r2eHEOPjZp/mioxDbrTI3TGA3U9
         3k0LLGz42ur6nKKjghnH52aHhFmryEh/hBlrb4oVHhj/PC16oGnJLpDgyNBap90yw4zZ
         D6rY69qXjfFLHZRaKtw6jxnHUnlCS+I8pozNQCFR0xdxhUsIOCu0tvf6gPDJ3Tx9oKhj
         jYuixGzh7zvXkLarizdWBMNB6kek3UuzFb5bhfatjCIqOkdcChHe2iOBPp9S4qHC8Wqe
         kCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ia77NFPvG9e51YaeuOHOcuj/rUgKd+hMh/cRttjO8EU=;
        b=Wz1hcC6SgLWTYWRE3YBnOpUNHLnOhJFJv5kpdId52VqTRyiyJMcc+EuQyr4XuKxPro
         fd2jxgT10B43UBK4H39Tpnwl8IXHTKaC5WPzpvwUxHo/gB4pEFsxOGN4uiCTshUjoyfw
         SUY+RcN67WdZk0bvk/U2GgBXcKzU8j+OQQalNVDokQM++CGORiy4LcNtgILEPGHKbiaR
         niDoiu8labzyDhWdXxkL8SLvuj7+BgkIjeJwUDqkyM7yGhlHEem1ka7WRV0DtnHg1KdZ
         TQAQdei4gHPnLDjrGuwaQf/DLNeKIiGlI9d98sktwMZG4fiPqjcSuCWZY4Ou1uO2MKpW
         AL2Q==
X-Gm-Message-State: AOAM533pTnyfC4otvVuNXW+8sfkf/ALF5y7JpL8NawubWY4KN+bpaFNU
        A+9pcJp30qaWBEsPtRbt/wTJGFxWaEkuRNg=
X-Google-Smtp-Source: ABdhPJxt2BYi3xwy9X38eLC3nzVD6+hNcHGHlN9a0yrHA19gT87d1ByWJ3uMaCd6Q81c1MbeoZoyk+jEIx0Bw5Q=
X-Received: by 2002:a25:1f55:: with SMTP id f82mr16867670ybf.103.1595613926670;
 Fri, 24 Jul 2020 11:05:26 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:05:22 -0700
Message-Id: <20200724180523.1393383-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v1] driver core: Change delimiter in devlink device's name to "--"
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

The devlink device name is of the form "supplier:consumer". But ":" is
fairly common in device names and makes it visually hard to distinguish
supplier and consumer. So, replace it with "--" to make it easier.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/ABI/testing/sysfs-class-devlink | 2 +-
 drivers/base/core.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devlink b/Documentation/ABI/testing/sysfs-class-devlink
index 3a24973abb83..64791b65c9a3 100644
--- a/Documentation/ABI/testing/sysfs-class-devlink
+++ b/Documentation/ABI/testing/sysfs-class-devlink
@@ -4,7 +4,7 @@ Contact:	Saravana Kannan <saravanak@google.com>
 Description:
 		Provide a place in sysfs for the device link objects in the
 		kernel at any given time.  The name of a device link directory,
-		denoted as ... above, is of the form <supplier>:<consumer>
+		denoted as ... above, is of the form <supplier>--<consumer>
 		where <supplier> is the supplier device name and <consumer> is
 		the consumer device name.
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b6e8b0bb76e4..4d05868d9356 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -623,7 +623,7 @@ struct device_link *device_link_add(struct device *consumer,
 
 	link->link_dev.class = &devlink_class;
 	device_set_pm_not_required(&link->link_dev);
-	dev_set_name(&link->link_dev, "%s:%s",
+	dev_set_name(&link->link_dev, "%s--%s",
 		     dev_name(supplier), dev_name(consumer));
 	if (device_register(&link->link_dev)) {
 		put_device(consumer);
-- 
2.28.0.rc0.142.g3c755180ce-goog

