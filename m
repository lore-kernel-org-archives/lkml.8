Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EE520748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030441;
	bh=K7rQBmF2o/HDSQ0ZPX0Bc+/MKqPqW6lr/a49UeaCeTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgB13ekq1qtPMEHrqNXGYTxY+XVrAnO77IVqaJXtHIjM5JjGJam2JoaCkWGCzdJt4
	 linJSMWqSYeXygzQNha+tICa01yiGxVF3083HIKuqj2alZBq83VAR+T/3Xs1s2dczg
	 y4Il6rMvlUPSGHCU88MDNTWQrbBOfXo9lfhExPwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHURUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgHUQQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6891C22BF5;
        Fri, 21 Aug 2020 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026570;
        bh=K7rQBmF2o/HDSQ0ZPX0Bc+/MKqPqW6lr/a49UeaCeTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHpY3aFDaWDy1sbclSa6Klf5IBITPQ/e0fPv+I4rabfBQHZXXQKBBINjtbXCeDYIi
         6M1QfIuoV22lscq+sBicMltYjkfeQeOt6YFWXWA2CVUlNWd/1w6iyH5dB/OtuCNUTk
         sWHWBEAK/G5eJ+AlhBb7RKUI2EU4xaMQ8GORP0G8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 20/61] platform/chrome: cros_ec_sensorhub: Fix EC timestamp overflow
Date:   Fri, 21 Aug 2020 12:15:04 -0400
Message-Id: <20200821161545.347622-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

[ Upstream commit e48bc01ed5adec203676c735365373b31c3c7600 ]

EC is using 32 bit timestamps (us), and before converting it to 64bit
they were not casted, so it would overflow every 4s.
Regular overflow every ~70 minutes was not taken into account either.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 24e48d96ed766..b1c641c72f515 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -419,9 +419,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 			 * Disable filtering since we might add more jitter
 			 * if b is in a random point in time.
 			 */
-			new_timestamp = fifo_timestamp -
-					fifo_info->timestamp  * 1000 +
-					in->timestamp * 1000;
+			new_timestamp = c - b * 1000 + a * 1000;
 			/*
 			 * The timestamp can be stale if we had to use the fifo
 			 * info timestamp.
-- 
2.25.1

