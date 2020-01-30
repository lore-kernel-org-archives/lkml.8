Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BCCC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1A215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410179;
	bh=VCEHbHeOb25vItQmcOqdlf5+SeUhC0e+lxaC6DddWZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqHJ63zEL78SHm9sxJM4xFqI2E/sGQ7b44rINONUDXDxZC7JUW5hGOnc25enVSHCR
	 swAHOG0ziEthG2xAhXj/agIUwRXoRGS9OAMCD8M4XG9FymfoyOR6Rux9r3njS6vyrQ
	 F15nCG026+xW83EO4iMWQg1pLKjl0xUvql4wwmpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgA3SsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgA3SsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523E422522;
        Thu, 30 Jan 2020 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410079;
        bh=VCEHbHeOb25vItQmcOqdlf5+SeUhC0e+lxaC6DddWZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6qVhIKJTeoc8P0Qqv0ChnKjco38B86Tv1FItej6ZW8yFW6wMvpitoNahcTm1FxGc
         B5grDqEtLMLRoYBI44fj1TjA5ZvHxoucuUstgACOk7tjin5aJnohyvkfoBmaho8xpt
         CHnO3sMuKFxTlhfeKWJ554eCUvWeMdBoXCMLFz6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.19 11/55] staging: vt6656: use NULLFUCTION stack on mac80211
Date:   Thu, 30 Jan 2020 19:38:52 +0100
Message-Id: <20200130183610.869343596@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit d579c43c82f093e63639151625b2139166c730fd upstream.

It appears that the drivers does not go into power save correctly the
NULL data packets are not being transmitted because it not enabled
in mac80211.

The driver needs to capture ieee80211_is_nullfunc headers and
copy the duration_id to it's own duration data header.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/610971ae-555b-a6c3-61b3-444a0c1e35b4@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/main_usb.c |    1 +
 drivers/staging/vt6656/rxtx.c     |   14 +++++---------
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -978,6 +978,7 @@ vt6656_probe(struct usb_interface *intf,
 	ieee80211_hw_set(priv->hw, RX_INCLUDES_FCS);
 	ieee80211_hw_set(priv->hw, REPORTS_TX_ACK_STATUS);
 	ieee80211_hw_set(priv->hw, SUPPORTS_PS);
+	ieee80211_hw_set(priv->hw, PS_NULLFUNC_STACK);
 
 	priv->hw->max_signal = 100;
 
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -278,11 +278,9 @@ static u16 vnt_rxtx_datahead_g(struct vn
 			  PK_TYPE_11B, &buf->b);
 
 	/* Get Duration and TimeStamp */
-	if (ieee80211_is_pspoll(hdr->frame_control)) {
-		__le16 dur = cpu_to_le16(priv->current_aid | BIT(14) | BIT(15));
-
-		buf->duration_a = dur;
-		buf->duration_b = dur;
+	if (ieee80211_is_nullfunc(hdr->frame_control)) {
+		buf->duration_a = hdr->duration_id;
+		buf->duration_b = hdr->duration_id;
 	} else {
 		buf->duration_a = vnt_get_duration_le(priv,
 						tx_context->pkt_type, need_ack);
@@ -371,10 +369,8 @@ static u16 vnt_rxtx_datahead_ab(struct v
 			  tx_context->pkt_type, &buf->ab);
 
 	/* Get Duration and TimeStampOff */
-	if (ieee80211_is_pspoll(hdr->frame_control)) {
-		__le16 dur = cpu_to_le16(priv->current_aid | BIT(14) | BIT(15));
-
-		buf->duration = dur;
+	if (ieee80211_is_nullfunc(hdr->frame_control)) {
+		buf->duration = hdr->duration_id;
 	} else {
 		buf->duration = vnt_get_duration_le(priv, tx_context->pkt_type,
 						    need_ack);


