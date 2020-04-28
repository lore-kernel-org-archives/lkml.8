Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DAAC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD52820730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099492;
	bh=HismTpftZbTTseuPOg1wFaWyhkCqgxY5WYnDdX5zamg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIQ6bZEDdoTlPWcBVWD5y5B6+4kyox09z+fwVsJco8+sG5VH1Uovndo/sFy4YOh6P
	 xV+/LHxFnT0R9eVpnTuoysYv8MFUQ+mf3uXzpbdeCbtgi+Jh2o6DlS7MPykh9EZ45j
	 MeCfreKSf6yFuqVTHavYL3HLf8kfsW2e33HJKxRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgD1Sov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731533AbgD1Sor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:44:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E791820730;
        Tue, 28 Apr 2020 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099486;
        bh=HismTpftZbTTseuPOg1wFaWyhkCqgxY5WYnDdX5zamg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYAcFI+fG/EthGJoQrR4eVXKS2fY6iz2HeJXPZd+mhU4VgLq5w+UtEfR7oBidJcNp
         mdDPJY9Y+7EwiSkv0GOHO8w4JeN/LqP8PST8OZubKkYDT5xtO2w5Tyku5iVBWDpvuf
         usS8ZOHKsDQjNwzGXpjeEOQxR84UXRPbAtxvYDn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.4 141/168] staging: vt6656: Fix calling conditions of vnt_set_bss_mode
Date:   Tue, 28 Apr 2020 20:25:15 +0200
Message-Id: <20200428182249.587987795@linuxfoundation.org>
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

commit 664ba5180234593b4b8517530e8198bf2f7359e2 upstream.

vnt_set_bss_mode needs to be called on all changes to BSS_CHANGED_BASIC_RATES,
BSS_CHANGED_ERP_PREAMBLE and BSS_CHANGED_ERP_SLOT

Remove all other calls and vnt_update_ifs which is called in vnt_set_bss_mode.

Fixes an issue that preamble mode is not being updated correctly.

Fixes: c12603576e06 ("staging: vt6656: Only call vnt_set_bss_mode on basic rates change.")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/44110801-6234-50d8-c583-9388f04b486c@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/main_usb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -633,8 +633,6 @@ static int vnt_add_interface(struct ieee
 
 	priv->op_mode = vif->type;
 
-	vnt_set_bss_mode(priv);
-
 	/* LED blink on TX */
 	vnt_mac_set_led(priv, LEDSTS_STS, LEDSTS_INTER);
 
@@ -721,7 +719,6 @@ static void vnt_bss_info_changed(struct
 		priv->basic_rates = conf->basic_rates;
 
 		vnt_update_top_rates(priv);
-		vnt_set_bss_mode(priv);
 
 		dev_dbg(&priv->usb->dev, "basic rates %x\n", conf->basic_rates);
 	}
@@ -750,11 +747,14 @@ static void vnt_bss_info_changed(struct
 			priv->short_slot_time = false;
 
 		vnt_set_short_slot_time(priv);
-		vnt_update_ifs(priv);
 		vnt_set_vga_gain_offset(priv, priv->bb_vga[0]);
 		vnt_update_pre_ed_threshold(priv, false);
 	}
 
+	if (changed & (BSS_CHANGED_BASIC_RATES | BSS_CHANGED_ERP_PREAMBLE |
+		       BSS_CHANGED_ERP_SLOT))
+		vnt_set_bss_mode(priv);
+
 	if (changed & BSS_CHANGED_TXPOWER)
 		vnt_rf_setpower(priv, priv->current_rate,
 				conf->chandef.chan->hw_value);


