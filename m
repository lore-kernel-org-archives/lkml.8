Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AA020786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585660;
	bh=x3VIhFR9XLrzX8mIuUYpAdyJJhQHze81tFY+AcmDMk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvqtXnpF9oTuGJKfYkpUlEK/2yHVv2uwoiBFq97D/y9JR3/RDH2Oe3iINy6KEjMu9
	 KAy41aizgU25Om+5KtVV3i8tWG5tPxgztUIFDGwAZqsZedmswpMJD+PoUC5gh6wR7k
	 JdzNGqyiJB+0W/KM73A9apvVJl1bYaUnHMhA335E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436568AbgFSQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbgFSOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8E321548;
        Fri, 19 Jun 2020 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577405;
        bh=x3VIhFR9XLrzX8mIuUYpAdyJJhQHze81tFY+AcmDMk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM1w25jJXv81tqj8eoaIOk46p1h5+YQTjp8awjQ5EQ7YnnLZPi57bXcVqIBbnRI/k
         pjIJ1QFl7yHIETdtKUk4U9NtU09nMV2UKvMxHeRpV151oau1qTqWDjauP/5+1lzk/m
         fURNWIqAK4BrsUWXCnjvz3SiYZqk1WncS54vccR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis <pro.denis@protonmail.com>,
        Masashi Honma <masashi.honma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 009/101] ath9k_htc: Silence undersized packet warnings
Date:   Fri, 19 Jun 2020 16:31:58 +0200
Message-Id: <20200619141614.491362701@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit 450edd2805982d14ed79733a82927d2857b27cac ]

Some devices like TP-Link TL-WN722N produces this kind of messages
frequently.

kernel: ath: phy0: Short RX data len, dropping (dlen: 4)

This warning is useful for developers to recognize that the device
(Wi-Fi dongle or USB hub etc) is noisy but not for general users. So
this patch make this warning to debug message.

Reported-By: Denis <pro.denis@protonmail.com>
Ref: https://bugzilla.kernel.org/show_bug.cgi?id=207539
Fixes: cd486e627e67 ("ath9k_htc: Discard undersized packets")
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200504214443.4485-1-masashi.honma@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 0d757ced49ba..91d199481a37 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -998,9 +998,9 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	 * which are not PHY_ERROR (short radar pulses have a length of 3)
 	 */
 	if (unlikely(!rs_datalen || (rs_datalen < 10 && !is_phyerr))) {
-		ath_warn(common,
-			 "Short RX data len, dropping (dlen: %d)\n",
-			 rs_datalen);
+		ath_dbg(common, ANY,
+			"Short RX data len, dropping (dlen: %d)\n",
+			rs_datalen);
 		goto rx_next;
 	}
 
-- 
2.25.1



