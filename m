Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6876C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A72073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271751;
	bh=ArAV1wIJAw8GbPbESMsY8CMZNSZCkxxKmAv4655zdek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dsAY267gIIROmyj9lkzqMBtOkNv7/d8KD56qrDlF+zuX9YpzmUcho0eyfrSoGBmbc
	 NRkKbCjgoOEvylzezsyN9BW0Y+qUX6NubQP4xIc4mizw0tbmkWPe4pa87OXNBNExei
	 N/YSFbCrjPwTv2SUDoZ2iq4WqQcEe182bFERofTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBUHzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgBUHzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:55:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33332073A;
        Fri, 21 Feb 2020 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271747;
        bh=ArAV1wIJAw8GbPbESMsY8CMZNSZCkxxKmAv4655zdek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHZH6Egog3B3RtnNOslSxlvVVySrKSEZR7iuGCjxw1k/Pxf4M4zC7XpQytCHGK5XD
         EvduGEvcDRZ8rjfz/vV9MkeqxE3uNlVvGeAh2+u+FudWPuPC+iJAgzpbZvSikmSoXg
         akWdGcCeuaaZQrMFaATMqkjiqVBDvLUEGM36DZYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 284/399] staging: wfx: fix possible overflow on jiffies comparaison
Date:   Fri, 21 Feb 2020 08:40:09 +0100
Message-Id: <20200221072429.526807691@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



