Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8617FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A20320767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979357;
	bh=jLrsiqJFchZqsU3JqhX9Hjb//ucy/rBP5Iv1hlCWZl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYZWZYFWykssUYU6u+iTZg+5oK5h0J/dUzgnFc0T5B2pTmUlDx4uu+jJKL8ZChjVG
	 /uwxlKm+BpMYUy18CBZeHyF8FSOdZTY2nwNiM8f936pMvEWTLtFPUvbVGKUq+4dcvU
	 FeyLxWuYxibyrwwoSjhbGvVITyDEUlrPhOsjv4kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgIAQzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgIAPXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228192078B;
        Tue,  1 Sep 2020 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973829;
        bh=jLrsiqJFchZqsU3JqhX9Hjb//ucy/rBP5Iv1hlCWZl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6wzTfm/p8/Cn7Y9IjjpaEmEtLS7ekeJrYR+oLYsspegFpP7gUCabVqnN517rNYJE
         YSo9mfGHHd+kivDK6kl67ZvCd1EvD3kbSGeLuM+KF/9oet308VtgcTgY19ledL/9b9
         v6hh5A0Rxx506xN4JyLG9AQ5WAifH/9SlSoFgD4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Reto Schneider <code@reto-schneider.ch>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/125] rtlwifi: rtl8192cu: Prevent leaking urb
Date:   Tue,  1 Sep 2020 17:09:48 +0200
Message-Id: <20200901150936.185344758@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reto Schneider <code@reto-schneider.ch>

[ Upstream commit 03128643eb5453a798db5770952c73dc64fcaf00 ]

If usb_submit_urb fails the allocated urb should be unanchored and
released.

Signed-off-by: Reto Schneider <code@reto-schneider.ch>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200622132113.14508-3-code@reto-schneider.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 1893640555c1e..3d6c0d8c71d7e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -739,8 +739,11 @@ static int _rtl_usb_receive(struct ieee80211_hw *hw)
 
 		usb_anchor_urb(urb, &rtlusb->rx_submitted);
 		err = usb_submit_urb(urb, GFP_KERNEL);
-		if (err)
+		if (err) {
+			usb_unanchor_urb(urb);
+			usb_free_urb(urb);
 			goto err_out;
+		}
 		usb_free_urb(urb);
 	}
 	return 0;
-- 
2.25.1



