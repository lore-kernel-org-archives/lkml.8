Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D43C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2BD20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8CRbDzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGPEVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgGPEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:21:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB2C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x184so5692579ybx.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dp4LrpIaEXPK3grrQFqkkFHbhE4yFcxhV5cX5RaoGbs=;
        b=K8CRbDzkJFUr6QGieCuY8Ik70dNyKIdDyC5d0182rJMie3Ah0O5oO8c6B6w4tS+D9T
         lFheIT2WxdLq9KjH3ApwtU6NK48f+go/3r79NZHB3O9ImpuhtgfnofkQWCbRYJzrtYYV
         sQBHNrzmoN+wP6mHoXjct7NY3orl84qVBgvVQJoEFSHYRV/2gmEWyk0nPSZfYOpxi+ZY
         V/TdeJvg2Tz4kcVe60Wntu/srva4ESCLzIOQKaj8d1SIti9WRIuAqIurWJLYpT4X6GCt
         SuyVXUnTVjIt7s6xPKIq8LRptthfBGZVsTDUw2Yw0Sp9n+mwytIf0tmRk0NCIOEUpXYD
         OhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dp4LrpIaEXPK3grrQFqkkFHbhE4yFcxhV5cX5RaoGbs=;
        b=WjTzkX8pFZNM2xZhYvO11gjyqagfm+in6HcrssIQyl7uY3+fsbM3zmcVcBLmzV60Xj
         3ml0I43DACCI5PM0qwLRcBlH6r09nZAAPTzoV7YMrt2JXyagSXqtUJfwTW8lZSCzFLhC
         6Sx+WLNAaiy0rB70CkozALsdeTCSUowNdPd/JW969lVzvdOuTL5FojkdSfGamwumB27v
         POe2fUx+Z/LG1o+8K76yemJLt2V1onrTYHnrF0Atm+wNHcX9tT9C3PgXG8TTmEM0ay3a
         v3b+GlNMIeJSCLkpzS9+tFGQ6giBY/jnMrKxXFZvvuANRuyxz3mz2BlZ0ila1SHQmglg
         2SIw==
X-Gm-Message-State: AOAM533cYMLfbd3skvBlyfUFUfva84Q68GutxbmlWbaL+pHkoriVAyLg
        9zHGDeKWtcVDQ/XPZjgvBblO/y+9SnwrtOI=
X-Google-Smtp-Source: ABdhPJx4twDYAoS1G4/KyXT5EinLnEGKlmestqbbgXigGgwYilmUyA9nkd26YJN4dVMCKS4iooNffqXlC+Z3Ntk=
X-Received: by 2002:a25:9c06:: with SMTP id c6mr3674722ybo.403.1594873261224;
 Wed, 15 Jul 2020 21:21:01 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:20:51 -0700
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
Message-Id: <20200716042053.1927676-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 2/4] regulator: core: Add destroy_regulator()
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the regulator_get() code is already factored out into
create_regulator(). This patch factors out some of the regulator_put()
code into destroy_regulator() so that create_regulator() has a
corresponding unwind function. Subsequent patches will use this
function.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03154f5b939f..c9615d3530c7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,7 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
+static void destroy_regulator(struct regulator *regulator);
 static void _regulator_put(struct regulator *regulator);
 
 const char *rdev_get_name(struct regulator_dev *rdev)
@@ -2034,20 +2035,9 @@ struct regulator *regulator_get_optional(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(regulator_get_optional);
 
-/* regulator_list_mutex lock held by regulator_put() */
-static void _regulator_put(struct regulator *regulator)
+static void destroy_regulator(struct regulator *regulator)
 {
-	struct regulator_dev *rdev;
-
-	if (IS_ERR_OR_NULL(regulator))
-		return;
-
-	lockdep_assert_held_once(&regulator_list_mutex);
-
-	/* Docs say you must disable before calling regulator_put() */
-	WARN_ON(regulator->enable_count);
-
-	rdev = regulator->rdev;
+	struct regulator_dev *rdev = regulator->rdev;
 
 	debugfs_remove_recursive(regulator->debugfs);
 
@@ -2068,6 +2058,24 @@ static void _regulator_put(struct regulator *regulator)
 
 	kfree_const(regulator->supply_name);
 	kfree(regulator);
+}
+
+/* regulator_list_mutex lock held by regulator_put() */
+static void _regulator_put(struct regulator *regulator)
+{
+	struct regulator_dev *rdev;
+
+	if (IS_ERR_OR_NULL(regulator))
+		return;
+
+	lockdep_assert_held_once(&regulator_list_mutex);
+
+	/* Docs say you must disable before calling regulator_put() */
+	WARN_ON(regulator->enable_count);
+
+	rdev = regulator->rdev;
+
+	destroy_regulator(regulator);
 
 	module_put(rdev->owner);
 	put_device(&rdev->dev);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

