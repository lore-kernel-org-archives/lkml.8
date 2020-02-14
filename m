Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F2AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFB22168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702941;
	bh=ArAV1wIJAw8GbPbESMsY8CMZNSZCkxxKmAv4655zdek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UegvB/m9Z42hQhN2Pox2fxdmkrYrmGmuulT0qU4Q1MMCoHURjSiqOVBpXekbRzSjH
	 vfIHFxqRZsGy7Hf3wDmDdIIqskB8TeRlUphh9VBbRbcJuBqACwtZ9E+t7KmWb7kbxZ
	 sRMK+Isxa8qF3fvm2E3TfJdklVW6e4/N6OA901ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgBNP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388200AbgBNP5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DDE2467B;
        Fri, 14 Feb 2020 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695841;
        bh=ArAV1wIJAw8GbPbESMsY8CMZNSZCkxxKmAv4655zdek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eG3K5O1QRb9LqtiWA11UlTkIId5VdxfRm3NlQf4F1h9UlGCduSWrM7qYZLiHpJB63
         gvbpa2fC9+HgO0ZB5oQX3Yn97vU+6OhEhxKRQB+jyaEPIH7TDMP3eBS0cMhq2vcL5U
         88k004Z4CpjXCLCVu9aTNjzt0A3IVMUsR6lIBj/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.5 392/542] staging: wfx: fix possible overflow on jiffies comparaison
Date:   Fri, 14 Feb 2020 10:46:24 -0500
Message-Id: <20200214154854.6746-392-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit def39be019b6494acd3570ce6f3f11ba1c3203a3 ]

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is recommended to use function time_*() to compare jiffies.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200115135338.14374-45-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/data_tx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index b13d7341f8bba..0c6a3a1a1ddfd 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -282,8 +282,7 @@ void wfx_tx_policy_init(struct wfx_vif *wvif)
 static int wfx_alloc_link_id(struct wfx_vif *wvif, const u8 *mac)
 {
 	int i, ret = 0;
-	unsigned long max_inactivity = 0;
-	unsigned long now = jiffies;
+	unsigned long oldest;
 
 	spin_lock_bh(&wvif->ps_state_lock);
 	for (i = 0; i < WFX_MAX_STA_IN_AP_MODE; ++i) {
@@ -292,13 +291,10 @@ static int wfx_alloc_link_id(struct wfx_vif *wvif, const u8 *mac)
 			break;
 		} else if (wvif->link_id_db[i].status != WFX_LINK_HARD &&
 			   !wvif->wdev->tx_queue_stats.link_map_cache[i + 1]) {
-			unsigned long inactivity =
-				now - wvif->link_id_db[i].timestamp;
-
-			if (inactivity < max_inactivity)
-				continue;
-			max_inactivity = inactivity;
-			ret = i + 1;
+			if (!ret || time_after(oldest, wvif->link_id_db[i].timestamp)) {
+				oldest = wvif->link_id_db[i].timestamp;
+				ret = i + 1;
+			}
 		}
 	}
 
-- 
2.20.1

