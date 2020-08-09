Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F52C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DB1206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="gkAmEj+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHIVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 17:16:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:46410 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgHIVQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 17:16:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BPsNm4rQzz8y;
        Sun,  9 Aug 2020 23:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597007817; bh=FGArzQHPDlg14jyAN9XMnsdCLbXsrN+ddGAJOjuKbns=;
        h=Date:From:Subject:To:Cc:From;
        b=gkAmEj+CedVDWJbR7xk/YxWSoq0UT/RpHe72jiC+y65pO/VC16m0wwu5o1zTT/A0i
         aGJcRwcQcmOdtV+fr0VEbgRE5DN3+8/ADqipGqCEiNmbp3nF3F8YCA/7mwGupI3Ee5
         2+eHTIXNp0rjcdHp+APWzmSake4RLXU1htMFzo0nh3O04dlWfg34J7NMJebRtUi5Jf
         CRcVjKLhJgezGD78zk75OoxrMXgeIU1vIQ7SIsCc0ob3fb29ZU76rPqSVu8mDi6CmJ
         e7qasE4PjOmp9k6DzVNdkJqTa4oR+5Ai+hQF+D48TZ2psIfixy9yMi0gKKulqHBNqL
         MWc0kMcy5QNXw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 09 Aug 2020 23:16:53 +0200
Message-Id: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: simplify locking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify regulator locking by removing locking around locking. rdev->ref
is now accessed only when the lock is taken. The code still smells fishy,
but now its obvious why.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 37 ++++++--------------------------
 include/linux/regulator/driver.h |  1 -
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9e18997777d3..b0662927487c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -45,7 +45,6 @@
 	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
 
 static DEFINE_WW_CLASS(regulator_ww_class);
-static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
@@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
 static inline int regulator_lock_nested(struct regulator_dev *rdev,
 					struct ww_acquire_ctx *ww_ctx)
 {
-	bool lock = false;
 	int ret = 0;
 
-	mutex_lock(&regulator_nesting_mutex);
+	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
+		ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
 
-	if (ww_ctx || !ww_mutex_trylock(&rdev->mutex)) {
-		if (rdev->mutex_owner == current)
-			rdev->ref_cnt++;
-		else
-			lock = true;
-
-		if (lock) {
-			mutex_unlock(&regulator_nesting_mutex);
-			ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
-			mutex_lock(&regulator_nesting_mutex);
-		}
-	} else {
-		lock = true;
-	}
-
-	if (lock && ret != -EDEADLK) {
+	if (ret != -EDEADLK)
 		rdev->ref_cnt++;
-		rdev->mutex_owner = current;
-	}
-
-	mutex_unlock(&regulator_nesting_mutex);
 
 	return ret;
 }
@@ -205,16 +185,11 @@ EXPORT_SYMBOL_GPL(regulator_lock);
  */
 void regulator_unlock(struct regulator_dev *rdev)
 {
-	mutex_lock(&regulator_nesting_mutex);
+	if (WARN_ON_ONCE(rdev->ref_cnt <= 0))
+		return;
 
-	if (--rdev->ref_cnt == 0) {
-		rdev->mutex_owner = NULL;
+	if (--rdev->ref_cnt == 0)
 		ww_mutex_unlock(&rdev->mutex);
-	}
-
-	WARN_ON_ONCE(rdev->ref_cnt < 0);
-
-	mutex_unlock(&regulator_nesting_mutex);
 }
 EXPORT_SYMBOL_GPL(regulator_unlock);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 8539f34ae42b..2fe5b1bcbe2f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -448,7 +448,6 @@ struct regulator_dev {
 
 	struct blocking_notifier_head notifier;
 	struct ww_mutex mutex; /* consumer lock */
-	struct task_struct *mutex_owner;
 	int ref_cnt;
 	struct module *owner;
 	struct device dev;
-- 
2.20.1

