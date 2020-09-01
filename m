Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C37C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4F214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974287;
	bh=ZS5koshl9P5XnEP6E1J+YO76VIZh7Oth6V8mWrNQ9Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VnrXwZ0Jendd0SRvnB+chXOXYa28BYTST8OEmnIdBLTND5VA2c1cGmizLcMI2Yscv
	 FbYuiAyal8DNZc2Bi1GF8Vjqh+vOFrxdsj0fTpRK35hOHpeqjZyzP6AWQAuwMIVCXk
	 +GfUSHuxaxKeWvVLj6JsDbkS2xw7uaw4sxWmr0kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgIAPbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbgIAP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA9C20BED;
        Tue,  1 Sep 2020 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974094;
        bh=ZS5koshl9P5XnEP6E1J+YO76VIZh7Oth6V8mWrNQ9Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/5K12ljBw5iUPDm07CNqEF/GeHGqpM0a5chqRzZtCir/DVPbWTQk6nQCT1jLmI6x
         Rloj8nLMJtFjlKWNNOd1boqe2iHw7b/KHCrk4UdFw6oHbLY0M7Vr3GD9//UFQnvJZO
         yyQzpl8kTjCRnXZ4lj9RfJA0Go2W+yJgG3jkBgPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Reto Schneider <code@reto-schneider.ch>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 042/214] rtlwifi: rtl8192cu: Prevent leaking urb
Date:   Tue,  1 Sep 2020 17:08:42 +0200
Message-Id: <20200901150954.980915852@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
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
index c66c6dc003783..bad06939a247c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -718,8 +718,11 @@ static int _rtl_usb_receive(struct ieee80211_hw *hw)
 
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



