Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A3C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A2324656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814538;
	bh=VG8bprn6FtRu7UbsBisMvMt6H54Pw6Et/zMJ75c5l9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WHT7PrymJBPKeKHYaqLYqR+jQf402I8teapCxvFYYe+LwjVromttQlae0nzcLA5pT
	 2uq9FoT478SWT/g/+sYrSb18xVZVb9U3yjFxmEXxga3GOag9UALhynqk1aoPl0OqLD
	 ym4md/ISUBPCORi4ypz2Psa72DVRLX14OZ6OB9Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgB0NuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbgB0NuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3949B21D7E;
        Thu, 27 Feb 2020 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811414;
        bh=VG8bprn6FtRu7UbsBisMvMt6H54Pw6Et/zMJ75c5l9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOxccv3oSVpBouxBhY0gXmJZtV/kp4dkC1l84XGAwJ1WpZOaH/pt5UWYYvQD2Ndeh
         cWGOpCkAlXivjuZZdD8nu8k+tNHtzoLHKypMepj64YVP2PyFu/AmiULXDyC8zgNTwM
         Nu7g4f1pAdCizmAr/t7uDpsKts5UXn2p4rKJ4PZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.9 122/165] staging: vt6656: fix sign of rx_dbm to bb_pre_ed_rssi.
Date:   Thu, 27 Feb 2020 14:36:36 +0100
Message-Id: <20200227132248.939381568@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 93134df520f23f4e9998c425b8987edca7016817 upstream.

bb_pre_ed_rssi is an u8 rx_dm always returns negative signed
values add minus operator to always yield positive.

fixes issue where rx sensitivity is always set to maximum because
the unsigned numbers were always greater then 100.

Fixes: 63b9907f58f1 ("staging: vt6656: mac80211 conversion: create rx function.")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/aceac98c-6e69-3ce1-dfec-2bf27b980221@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/dpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/vt6656/dpc.c
+++ b/drivers/staging/vt6656/dpc.c
@@ -140,7 +140,7 @@ int vnt_rx_data(struct vnt_private *priv
 
 	vnt_rf_rssi_to_dbm(priv, *rssi, &rx_dbm);
 
-	priv->bb_pre_ed_rssi = (u8)rx_dbm + 1;
+	priv->bb_pre_ed_rssi = (u8)-rx_dbm + 1;
 	priv->current_rssi = priv->bb_pre_ed_rssi;
 
 	frame = skb_data + 8;


