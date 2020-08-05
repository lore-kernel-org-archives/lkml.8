Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021D322CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgHER53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:57:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgHERzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:55:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3GtV-0004yR-8Y; Wed, 05 Aug 2020 10:43:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wolfram Sang <wsa@kernel.org>, colin.king@canonical.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: windfarm: fix spelling mistake "detatch" -> "detach"
Date:   Wed,  5 Aug 2020 11:43:37 +0100
Message-Id: <20200805104337.16104-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in DBG messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/macintosh/windfarm_lm75_sensor.c | 2 +-
 drivers/macintosh/windfarm_lm87_sensor.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 1e5fa09845e7..a88f73af4d5e 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -152,7 +152,7 @@ static int wf_lm75_remove(struct i2c_client *client)
 {
 	struct wf_lm75_sensor *lm = i2c_get_clientdata(client);
 
-	DBG("wf_lm75: i2c detatch called for %s\n", lm->sens.name);
+	DBG("wf_lm75: i2c detach called for %s\n", lm->sens.name);
 
 	/* Mark client detached */
 	lm->i2c = NULL;
diff --git a/drivers/macintosh/windfarm_lm87_sensor.c b/drivers/macintosh/windfarm_lm87_sensor.c
index d011899c0a8a..de8ef76a0ac8 100644
--- a/drivers/macintosh/windfarm_lm87_sensor.c
+++ b/drivers/macintosh/windfarm_lm87_sensor.c
@@ -149,7 +149,7 @@ static int wf_lm87_remove(struct i2c_client *client)
 {
 	struct wf_lm87_sensor *lm = i2c_get_clientdata(client);
 
-	DBG("wf_lm87: i2c detatch called for %s\n", lm->sens.name);
+	DBG("wf_lm87: i2c detach called for %s\n", lm->sens.name);
 
 	/* Mark client detached */
 	lm->i2c = NULL;
-- 
2.27.0

