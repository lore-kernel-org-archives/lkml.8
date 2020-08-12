Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C85C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEBC2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247955;
	bh=vSP7pIbG/+aRsdn4TNYZedyhxbsUK7SK7J98dK9mzvw=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=x45UYTS8gm1w/Je7SGvpIgtPtv83AAGbTZUfk9RFlzwBDD2iDsNthcio3hZhFs+9u
	 B+9YD4z8pPJHg30vQ5bRAzEZ+1Bi99gbcPadkeWn7W7CzwZs+ytf65t7WYJ9VOJqvs
	 vdHdZA5ZQhuEnQzPu6Pm1OLvZSOKLf1Ksvf4v3jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHLP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgHLP5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCB822D6F;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=vSP7pIbG/+aRsdn4TNYZedyhxbsUK7SK7J98dK9mzvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/w6zL/dEREjNNCIV0pjmuEL9jAFqISYpsB2RIWi+2uBxzItOyBG4gmknM5dI0CqW
         FxdhzBGxtMNWlUErKvsjESe8iwlqzmzDiEonAxO2/KYtz2s1ZFdgxYSRS+ueCaxd8E
         A/BqB5nkxCkwUveyaWtmB21o4srE24ibcy9f+3NM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6j-Lg; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 25/44] staging: regulator: hi6421v600-regulator: port it to upstream
Date:   Wed, 12 Aug 2020 17:56:35 +0200
Message-Id: <7af371daea3cbfa27dec63304a7ff8dca7168c56.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was originally written for Kernel 4.9. It needs to
be ported to upstream:

	- Got rid of timeval;
	- Removed a bogus dependency;
	- Did cleanups at the header file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 34 +++----------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 7bc0ae27b110..904cb64b1dcd 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -49,7 +49,6 @@ struct hisi_regulator_register_info {
 struct hisi_regulator {
 	const char *name;
 	struct hisi_regulator_register_info register_info;
-	struct timeval last_off_time;
 	u32 off_on_delay;
 	u32 eco_uA;
 	struct regulator_desc rdesc;
@@ -57,8 +56,6 @@ struct hisi_regulator {
 };
 
 static DEFINE_MUTEX(enable_mutex);
-struct timeval last_enabled;
-
 
 static inline struct hisi_pmic *rdev_to_pmic(struct regulator_dev *dev)
 {
@@ -72,27 +69,6 @@ static inline struct hisi_pmic *rdev_to_pmic(struct regulator_dev *dev)
 /* helper function to ensure when it returns it is at least 'delay_us'
  * microseconds after 'since'.
  */
-static void ensured_time_after(struct timeval since, u32 delay_us)
-{
-	struct timeval now;
-	u64 elapsed_ns64, delay_ns64;
-	u32 actual_us32;
-
-	delay_ns64 = delay_us * NSEC_PER_USEC;
-	do_gettimeofday(&now);
-	elapsed_ns64 = timeval_to_ns(&now) - timeval_to_ns(&since);
-	if (delay_ns64 > elapsed_ns64) {
-		actual_us32 = ((u32)(delay_ns64 - elapsed_ns64) /
-							NSEC_PER_USEC);
-		if (actual_us32 >= 1000) {
-			mdelay(actual_us32 / 1000); /*lint !e647 */
-			udelay(actual_us32 % 1000);
-		} else if (actual_us32 > 0) {
-			udelay(actual_us32);
-		}
-	}
-	return;
-}
 
 static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 {
@@ -113,13 +89,16 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
 
 	/* keep a distance of off_on_delay from last time disabled */
-	ensured_time_after(sreg->last_off_time, sreg->off_on_delay);
+	usleep_range(sreg->off_on_delay, sreg->off_on_delay + 1000);
 
 	pr_debug("<[%s]: off_on_delay=%dus>\n", __func__, sreg->off_on_delay);
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&enable_mutex);
-	ensured_time_after(last_enabled, HISI_REGS_ENA_PROTECT_TIME);
+	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
+		     HISI_REGS_ENA_PROTECT_TIME + 1000);
+
+
 
 	/* set enable register */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
@@ -128,7 +107,6 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	pr_debug("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n", __func__, sreg->register_info.ctrl_reg,\
 			sreg->register_info.enable_mask);
 
-	do_gettimeofday(&last_enabled);
 	mutex_unlock(&enable_mutex);
 
 	return 0;
@@ -143,8 +121,6 @@ static int hisi_regulator_disable(struct regulator_dev *dev)
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
 				sreg->register_info.enable_mask, 0);
 
-	do_gettimeofday(&sreg->last_off_time);
-
 	return 0;
 }
 
-- 
2.26.2

