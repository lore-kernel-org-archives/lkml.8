Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD3C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830D2206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099517;
	bh=ExIeKVIBCllYZPlgW/gNTszh5U04l/ufvIf5CDobjKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMl8zFsiNf0RvgUqRV0CaJOgfbfCr/9ah6emwseaah8WNlx43mf9nfQnS8QfVph9w
	 1BFmduZQWGWZ/J3bLnAEVNpsmhnwUhGHVYsfdil+u0U7KJarMTeYgVxjuduLzB8yTW
	 iO+uZhkdjoEeFn/FTLmFP8DJxpx5qZT6dQlhuNZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgD1Sop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbgD1Soj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:44:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A034D20575;
        Tue, 28 Apr 2020 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099479;
        bh=ExIeKVIBCllYZPlgW/gNTszh5U04l/ufvIf5CDobjKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qejpZDH7wDt/BFdFEIo1ilTU3iFfw0yhwfN3y63JcsNTaowsYESAkY12hxf9RBwHM
         Lgw/VePrqgJV+SC1DRuiPrScMeOuU9Eg8u0xS6HBPCiU8mViEW83SQbWFtxFBOIvor
         s3FDzJ8w4CT8N1nfJzAmlTqkp6uf5SeFiHLUF7R0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.4 140/168] staging: vt6656: Dont set RCR_MULTICAST or RCR_BROADCAST by default.
Date:   Tue, 28 Apr 2020 20:25:14 +0200
Message-Id: <20200428182249.480721869@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 0f8240bfc070033a4823b19883efd3d38c7735cc upstream.

mac80211/users control whether multicast is on or off don't enable it by default.

Fixes an issue when multicast/broadcast is always on allowing other beacons through
in power save.

Fixes: db8f37fa3355 ("staging: vt6656: mac80211 conversion: main_usb add functions...")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/2c24c33d-68c4-f343-bd62-105422418eac@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/main_usb.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -818,15 +818,11 @@ static void vnt_configure(struct ieee802
 {
 	struct vnt_private *priv = hw->priv;
 	u8 rx_mode = 0;
-	int rc;
 
 	*total_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_BCN_PRBRESP_PROMISC;
 
-	rc = vnt_control_in(priv, MESSAGE_TYPE_READ, MAC_REG_RCR,
-			    MESSAGE_REQUEST_MACREG, sizeof(u8), &rx_mode);
-
-	if (!rc)
-		rx_mode = RCR_MULTICAST | RCR_BROADCAST;
+	vnt_control_in(priv, MESSAGE_TYPE_READ, MAC_REG_RCR,
+		       MESSAGE_REQUEST_MACREG, sizeof(u8), &rx_mode);
 
 	dev_dbg(&priv->usb->dev, "rx mode in = %x\n", rx_mode);
 


