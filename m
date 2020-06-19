Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0809B217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584148;
	bh=5nAVtwoFHCoPigIxGOY2qWRJl5r7Z7evVNEqTcc2Ow8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOlt1tVQOB1+nSps+4rcWhcsXhxwsziJ+7/J8ndJUjDhwoP4ZJKa1xIj8SmNf7MrD
	 kcnwRaE/cEciEyJMSKxu8BGycll+XugsMHhdlrp54ZLUe9dWVpdQC22VCyF3ySwS4d
	 +NRcl7O6tq4/ZDV/8B+XjCrPBkgJTryYCeA2Bz8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394957AbgFSQ3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388632AbgFSOym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:54:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5324421852;
        Fri, 19 Jun 2020 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578481;
        bh=5nAVtwoFHCoPigIxGOY2qWRJl5r7Z7evVNEqTcc2Ow8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Furgnt3ScEvgLiYqQE+mTgCqrep1uSdIHe/ePtjOaxtJv7m39NXpcI1K2isflhvUx
         Zgk6SWWWmRNRI42uBonmFvtPKkhB60b/5Jj0PGvEsTYGmn8gzqUQrbLK9GiUu3VWor
         a43XTvch8qegvP1NIZFgwh9rUnMYCHPzTiPf9S88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis <pro.denis@protonmail.com>,
        Masashi Honma <masashi.honma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/267] ath9k_htc: Silence undersized packet warnings
Date:   Fri, 19 Jun 2020 16:30:06 +0200
Message-Id: <20200619141649.900623413@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
index b5d7ef4da17f..f19393e584dc 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -999,9 +999,9 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
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



