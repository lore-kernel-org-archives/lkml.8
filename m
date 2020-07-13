Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA2C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647FD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvAw4mHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGMHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgGMHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:46:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so12170822wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOdYD3KnvBuwlGzK8Lnx8We5QJ0C1TZDV+3j7uFLFto=;
        b=CvAw4mHHnyN5jjBhp6RQGxrb+maMJ6ZDQ1eJ3mgsEN2vBPxmivpVl38bnnNVF3gUxh
         aq7hpGf11YFf6yrT9j0Js373rTmIVI0APKLJTcTojkwKQgOto9q5b6MAMGW/3t5OqpfU
         mzyMKyA3Ftn4CTh5G+cONiLeNkZJKawrPB745hJtkrWPBiW5KQ6RdJjIi0EkQIEChoRk
         Bm0aR19MwH/6/Kvp3zFDFsaBCJ/WNffWNDn0KXm2KdXH9tSp9mCNvG+QOP/M91cUO3TY
         SlA95eudbVN1h0ErLiJbG3MWY1HlJ+uK7itidzpAr+xugFT0mA6gMYSxPmN2B3p3ridv
         ZB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOdYD3KnvBuwlGzK8Lnx8We5QJ0C1TZDV+3j7uFLFto=;
        b=nsa+wJNZUUSWQvCmzdO4gNOM8NXqD1GSyntUVYljR1eqQD7OcFf2iEKkvlWfHNKORS
         wwXYX2luJDSX2TzqLwMYx2eU2uzUuIe2fZZLLS7acJTfyWjNs69SlIe2Cv3R31bT8mPZ
         nd/qNl8dxawemj/TfEZ0h++9NmRFLUFM4yHhxxjXRZV8o/cmWwfU6k1Rr35sHLizcSdX
         n/1CjAOhzclQ82gA0z0ApdNdlCmLUJoRLGHpGbaFUzA2lh/iuDXPk4sxP0YjXOMXBNky
         VVV3a2mE1zudN29efMr5Z29WDgnL5wIlzX0zFfZtjj5oszicbQv4e/H1L3lmW+A309Pb
         PPaw==
X-Gm-Message-State: AOAM5326RoXgLrrCvCz+OuGHnL1bY0IyEIs69bh2FdMQKxXPlpZZzwwK
        7tc6pubFm/kg0Qi5ngs/MhVgFg==
X-Google-Smtp-Source: ABdhPJzEBTT5tgmh5wv6qUmVafx/By6p8FMFhAgeRm6C79E8IhosmAhv3jhPdWnQdUdyhlWfpMI0bg==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr18917076wml.185.1594626413124;
        Mon, 13 Jul 2020 00:46:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:46:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 05/29] scsi: fcoe: fcoe_ctlr: Fix a myriad of documentation issues
Date:   Mon, 13 Jul 2020 08:46:21 +0100
Message-Id: <20200713074645.126138-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly missing or incorrect (bitrotted) function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fcoe/fcoe_ctlr.c:139: warning: Function parameter or member 'mode' not described in 'fcoe_ctlr_init'
 drivers/scsi/fcoe/fcoe_ctlr.c:604: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_encaps'
 drivers/scsi/fcoe/fcoe_ctlr.c:1312: warning: Function parameter or member 'skb' not described in 'fcoe_ctlr_recv_clr_vlink'
 drivers/scsi/fcoe/fcoe_ctlr.c:1312: warning: Excess function parameter 'fh' description in 'fcoe_ctlr_recv_clr_vlink'
 drivers/scsi/fcoe/fcoe_ctlr.c:1781: warning: Function parameter or member 't' not described in 'fcoe_ctlr_timeout'
 drivers/scsi/fcoe/fcoe_ctlr.c:1781: warning: Excess function parameter 'arg' description in 'fcoe_ctlr_timeout'
 drivers/scsi/fcoe/fcoe_ctlr.c:1904: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_recv_flogi'
 drivers/scsi/fcoe/fcoe_ctlr.c:2166: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_disc_stop_locked'
 drivers/scsi/fcoe/fcoe_ctlr.c:2166: warning: Excess function parameter 'fip' description in 'fcoe_ctlr_disc_stop_locked'
 drivers/scsi/fcoe/fcoe_ctlr.c:2188: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_disc_stop'
 drivers/scsi/fcoe/fcoe_ctlr.c:2188: warning: Excess function parameter 'fip' description in 'fcoe_ctlr_disc_stop'
 drivers/scsi/fcoe/fcoe_ctlr.c:2204: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_disc_stop_final'
 drivers/scsi/fcoe/fcoe_ctlr.c:2204: warning: Excess function parameter 'fip' description in 'fcoe_ctlr_disc_stop_final'
 drivers/scsi/fcoe/fcoe_ctlr.c:2273: warning: Function parameter or member 'frport' not described in 'fcoe_ctlr_vn_parse'
 drivers/scsi/fcoe/fcoe_ctlr.c:2273: warning: Excess function parameter 'rdata' description in 'fcoe_ctlr_vn_parse'
 drivers/scsi/fcoe/fcoe_ctlr.c:2804: warning: Function parameter or member 'frport' not described in 'fcoe_ctlr_vlan_parse'
 drivers/scsi/fcoe/fcoe_ctlr.c:2804: warning: Excess function parameter 'rdata' description in 'fcoe_ctlr_vlan_parse'
 drivers/scsi/fcoe/fcoe_ctlr.c:2900: warning: Excess function parameter 'min_len' description in 'fcoe_ctlr_vlan_send'
 drivers/scsi/fcoe/fcoe_ctlr.c:2977: warning: Function parameter or member 'fip' not described in 'fcoe_ctlr_vlan_recv'
 drivers/scsi/fcoe/fcoe_ctlr.c:2977: warning: Function parameter or member 'skb' not described in 'fcoe_ctlr_vlan_recv'
 drivers/scsi/fcoe/fcoe_ctlr.c:2977: warning: Excess function parameter 'lport' description in 'fcoe_ctlr_vlan_recv'
 drivers/scsi/fcoe/fcoe_ctlr.c:2977: warning: Excess function parameter 'fp' description in 'fcoe_ctlr_vlan_recv'
 drivers/scsi/fcoe/fcoe_ctlr.c:3033: warning: Function parameter or member 'callback' not described in 'fcoe_ctlr_disc_start'
 drivers/scsi/fcoe/fcoe_ctlr.c:3033: warning: Function parameter or member 'lport' not described in 'fcoe_ctlr_disc_start'
 drivers/scsi/fcoe/fcoe_ctlr.c:3033: warning: Excess function parameter 'fip' description in 'fcoe_ctlr_disc_start'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 1791a393795da..99242f9856708 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -134,6 +134,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
 /**
  * fcoe_ctlr_init() - Initialize the FCoE Controller instance
  * @fip: The FCoE controller to initialize
+ * @mode: FIP mode to set
  */
 void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
 {
@@ -587,6 +588,7 @@ static void fcoe_ctlr_send_keep_alive(struct fcoe_ctlr *fip,
 /**
  * fcoe_ctlr_encaps() - Encapsulate an ELS frame for FIP, without sending it
  * @fip:   The FCoE controller for the ELS frame
+ * @lport: The local port
  * @dtype: The FIP descriptor type for the frame
  * @skb:   The FCoE ELS frame including FC header but no FCoE headers
  * @d_id:  The destination port ID.
@@ -1302,7 +1304,7 @@ static void fcoe_ctlr_recv_els(struct fcoe_ctlr *fip, struct sk_buff *skb)
 /**
  * fcoe_ctlr_recv_els() - Handle an incoming link reset frame
  * @fip: The FCoE controller that received the frame
- * @fh:	 The received FIP header
+ * @skb: The received FIP packet
  *
  * There may be multiple VN_Port descriptors.
  * The overall length has already been checked.
@@ -1775,7 +1777,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 
 /**
  * fcoe_ctlr_timeout() - FIP timeout handler
- * @arg: The FCoE controller that timed out
+ * @t: Timer context use to obtain the controller reference
  */
 static void fcoe_ctlr_timeout(struct timer_list *t)
 {
@@ -1887,6 +1889,7 @@ static void fcoe_ctlr_recv_work(struct work_struct *recv_work)
 /**
  * fcoe_ctlr_recv_flogi() - Snoop pre-FIP receipt of FLOGI response
  * @fip: The FCoE controller
+ * @lport: The local port
  * @fp:	 The FC frame to snoop
  *
  * Snoop potential response to FLOGI or even incoming FLOGI.
@@ -2158,7 +2161,7 @@ static struct fc_rport_operations fcoe_ctlr_vn_rport_ops = {
 
 /**
  * fcoe_ctlr_disc_stop_locked() - stop discovery in VN2VN mode
- * @fip: The FCoE controller
+ * @lport: The local port
  *
  * Called with ctlr_mutex held.
  */
@@ -2179,7 +2182,7 @@ static void fcoe_ctlr_disc_stop_locked(struct fc_lport *lport)
 
 /**
  * fcoe_ctlr_disc_stop() - stop discovery in VN2VN mode
- * @fip: The FCoE controller
+ * @lport: The local port
  *
  * Called through the local port template for discovery.
  * Called without the ctlr_mutex held.
@@ -2195,7 +2198,7 @@ static void fcoe_ctlr_disc_stop(struct fc_lport *lport)
 
 /**
  * fcoe_ctlr_disc_stop_final() - stop discovery for shutdown in VN2VN mode
- * @fip: The FCoE controller
+ * @lport: The local port
  *
  * Called through the local port template for discovery.
  * Called without the ctlr_mutex held.
@@ -2262,7 +2265,7 @@ static void fcoe_ctlr_vn_start(struct fcoe_ctlr *fip)
  * fcoe_ctlr_vn_parse - parse probe request or response
  * @fip: The FCoE controller
  * @skb: incoming packet
- * @rdata: buffer for resulting parsed VN entry plus fcoe_rport
+ * @frport: parsed FCoE rport from the probe request
  *
  * Returns non-zero error number on error.
  * Does not consume the packet.
@@ -2793,7 +2796,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
  * fcoe_ctlr_vlan_parse - parse vlan discovery request or response
  * @fip: The FCoE controller
  * @skb: incoming packet
- * @rdata: buffer for resulting parsed VLAN entry plus fcoe_rport
+ * @frport: parsed FCoE rport from the probe request
  *
  * Returns non-zero error number on error.
  * Does not consume the packet.
@@ -2892,7 +2895,6 @@ static int fcoe_ctlr_vlan_parse(struct fcoe_ctlr *fip,
  * @fip: The FCoE controller
  * @sub: sub-opcode for vlan notification or vn2vn vlan notification
  * @dest: The destination Ethernet MAC address
- * @min_len: minimum size of the Ethernet payload to be sent
  */
 static void fcoe_ctlr_vlan_send(struct fcoe_ctlr *fip,
 			      enum fip_vlan_subcode sub,
@@ -2969,9 +2971,8 @@ static void fcoe_ctlr_vlan_disc_reply(struct fcoe_ctlr *fip,
 
 /**
  * fcoe_ctlr_vlan_recv - vlan request receive handler for VN2VN mode.
- * @lport: The local port
- * @fp: The received frame
- *
+ * @fip: The FCoE controller
+ * @skb: The received FIP packet
  */
 static int fcoe_ctlr_vlan_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
 {
@@ -3015,9 +3016,8 @@ static void fcoe_ctlr_disc_recv(struct fc_lport *lport, struct fc_frame *fp)
 	fc_frame_free(fp);
 }
 
-/**
+/*
  * fcoe_ctlr_disc_recv - start discovery for VN2VN mode.
- * @fip: The FCoE controller
  *
  * This sets a flag indicating that remote ports should be created
  * and started for the peers we discover.  We use the disc_callback
-- 
2.25.1

