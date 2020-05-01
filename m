Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F70FC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061CF208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340087;
	bh=0w8PVJr8+NNOQecU/YV1JfnyPX2mTWZey+/TOljFZWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lKYclqgCw5JebMAQIOo0lu+Jwq+vt92MR7/UtOty1pow7zSxEAv/xVYgnXI0ZxM/O
	 mN5NZb4Ov80GzjjZVJ/ZWWuMTlHUxy/KhDByERt5rgD8ZeiMP1G3UwMmm5lUaJ1DER
	 1cZKCOFr19TAmgA4xSS0pSoHSzOPTmu6ld6BDbso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgEANeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgEANef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:34:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA991208DB;
        Fri,  1 May 2020 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340075;
        bh=0w8PVJr8+NNOQecU/YV1JfnyPX2mTWZey+/TOljFZWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOEVemgXgug0Ss0jABInf1wW57JSh4Uz/2O7ubJRBK9CGxd61ThhUvKC9ORFjsrQ5
         Fl0Sr+ZCHqouAxBMDGgb7M6HUhPbq2AYlheIamjpXbrcb0VJcnvP4E3k3p/xwedOiL
         6Ccl7hhORXaCXZ6JXyo9zjzkfNEM+wbZ/UMXFBUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.14 074/117] staging: vt6656: Fix drivers TBTT timing counter.
Date:   Fri,  1 May 2020 15:21:50 +0200
Message-Id: <20200501131553.808718905@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 09057742af98a39ebffa27fac4f889dc873132de upstream.

The drivers TBTT counter is not synchronized with mac80211 timestamp.

Reorder the functions and use vnt_update_next_tbtt to do the final
synchronize.

Fixes: c15158797df6 ("staging: vt6656: implement TSF counter")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/375d0b25-e8bc-c8f7-9b10-6cc705d486ee@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/main_usb.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -739,12 +739,15 @@ static void vnt_bss_info_changed(struct
 			vnt_mac_reg_bits_on(priv, MAC_REG_TFTCTL,
 					    TFTCTL_TSFCNTREN);
 
-			vnt_adjust_tsf(priv, conf->beacon_rate->hw_value,
-				       conf->sync_tsf, priv->current_tsf);
-
 			vnt_mac_set_beacon_interval(priv, conf->beacon_int);
 
 			vnt_reset_next_tbtt(priv, conf->beacon_int);
+
+			vnt_adjust_tsf(priv, conf->beacon_rate->hw_value,
+				       conf->sync_tsf, priv->current_tsf);
+
+			vnt_update_next_tbtt(priv,
+					     conf->sync_tsf, conf->beacon_int);
 		} else {
 			vnt_clear_current_tsf(priv);
 


