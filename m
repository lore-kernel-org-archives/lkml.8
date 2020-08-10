Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A3DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2B820773
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="oTIc9IhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgHJEdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:33:36 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:55860 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJEdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:33:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQ34Y4vDpzVB;
        Mon, 10 Aug 2020 06:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597034013; bh=zVFn/Y4z9FM8y/cTp3a/grRU3ZsRgI3atpsALDR10a0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=oTIc9IhPP5pd342iu6hd3itgPl1BwZ5cjQwbP9Ya+ylo4OXd4OQTMe0r0uOri/P1E
         PH8qLOEMSmkPdcgeLsZ0U+m8t9ocLb9gtQqCKLQ1BpFQGhmQKs9nVTYHaPaMSUTqa3
         4B8HD48Ohp7pbOjrDYyA1Yan0TQgixtbQZ5CFwdMlxsZkUH1AA3pKXSx16mdaZfr4l
         iKibejT/p5qtklkn8mTqxH6DeJFxaJ6lK9J2ePzZWTsXUkR4No6sU52CKMfb2ekv6I
         3ETigVU37gZMHriMM6b84z2o72bLnUJZjJaBO1ayGMTZsIVJLunmQIMdaFOoNo/zKJ
         DXei608Lsb0bw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 06:33:33 +0200
Message-Id: <090775a675cf8ea644c4b65903f18b314acbc504.1597032945.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/3] regulator: unexport regulator_lock/unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_lock/unlock() was used only to guard
regulator_notifier_call_chain(). As no users remain, make the functions
internal.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 6 ++----
 include/linux/regulator/driver.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f4035167e7ba..0a32c3da0e26 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -170,11 +170,10 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
  * than the one, which initially locked the mutex, it will
  * wait on mutex.
  */
-void regulator_lock(struct regulator_dev *rdev)
+static void regulator_lock(struct regulator_dev *rdev)
 {
 	regulator_lock_nested(rdev, NULL);
 }
-EXPORT_SYMBOL_GPL(regulator_lock);
 
 /**
  * regulator_unlock - unlock a single regulator
@@ -183,7 +182,7 @@ EXPORT_SYMBOL_GPL(regulator_lock);
  * This function unlocks the mutex when the
  * reference counter reaches 0.
  */
-void regulator_unlock(struct regulator_dev *rdev)
+static void regulator_unlock(struct regulator_dev *rdev)
 {
 	if (WARN_ON_ONCE(rdev->ref_cnt <= 0))
 		return;
@@ -191,7 +190,6 @@ void regulator_unlock(struct regulator_dev *rdev)
 	if (--rdev->ref_cnt == 0)
 		ww_mutex_unlock(&rdev->mutex);
 }
-EXPORT_SYMBOL_GPL(regulator_unlock);
 
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 2fe5b1bcbe2f..9c5a74cdebfe 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -532,9 +532,6 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 
-void regulator_lock(struct regulator_dev *rdev);
-void regulator_unlock(struct regulator_dev *rdev);
-
 /*
  * Helper functions intended to be used by regulator drivers prior registering
  * their regulators.
-- 
2.20.1

