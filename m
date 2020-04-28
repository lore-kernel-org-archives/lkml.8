Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0603C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9068C2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098982;
	bh=ZmOfeivkIXb17qiYjjxiPmR8T/uT3cuFiTpx9/kW6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lO+EGpG7QVE/nxIOqvjjVyFU8QI1osTwvT2MwNrGOgOGKknVxIei9b4ngI6i9WPmr
	 v3+UHCCaDE8f+Qr6YkF3oUf6ofV6j3BYE8R87P/D9HSjeDpcl+SK+WP3JCsGP7y6xl
	 WjXtrsp7Awrng2g/k4r6cSeyrd1/CNq/jgJEUhmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgD1SgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbgD1SgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:36:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768E520575;
        Tue, 28 Apr 2020 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098973;
        bh=ZmOfeivkIXb17qiYjjxiPmR8T/uT3cuFiTpx9/kW6I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKLgUeDQC9Yo88FycM1eat/iTwJhNq9rPU1nR8acrxKfRYIN42LAMbN873XWBhV/m
         eSi6ctf4im9lxjjSRiOpRhGs0kbHzlajIBSX+vOiwnNZpW7B17DH5nYOXtkwyR6DTP
         Yko61op9KuqCQ0y9923oNkOOIvBN8mFk1ZMW3mYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.6 139/167] staging: vt6656: Fix calling conditions of vnt_set_bss_mode
Date:   Tue, 28 Apr 2020 20:25:15 +0200
Message-Id: <20200428182243.143495792@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
@@ -632,8 +632,6 @@ static int vnt_add_interface(struct ieee
 
 	priv->op_mode = vif->type;
 
-	vnt_set_bss_mode(priv);
-
 	/* LED blink on TX */
 	vnt_mac_set_led(priv, LEDSTS_STS, LEDSTS_INTER);
 
@@ -720,7 +718,6 @@ static void vnt_bss_info_changed(struct
 		priv->basic_rates = conf->basic_rates;
 
 		vnt_update_top_rates(priv);
-		vnt_set_bss_mode(priv);
 
 		dev_dbg(&priv->usb->dev, "basic rates %x\n", conf->basic_rates);
 	}
@@ -749,11 +746,14 @@ static void vnt_bss_info_changed(struct
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


