Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235FBC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8AD207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsb82YiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHUHRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgHUHQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:16:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF832C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:16:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so813912wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hmu7eebnVLf+96DkNkuKqCpbKAzUinX5DGlufPTCB0k=;
        b=gsb82YiYQKyiCSN6cR4D5iRKbQ2Kyz/Qdq6HNzNcfckP/jNbjJvYELTaNz00TZZ9sL
         55v4iPqLYSJfy81oJpurNyJTKzoz5CvI6An1+dTUEEGRK4Zcw4FawDAaCirmrYCxMr+F
         y20gSRf6XfSa43Ik5qFiY+MYp/XTHnKRpPsadqeeq9wUN+a/G0q2y0Vi72zA3o4lWTV4
         +w0WhPb+LHZ7900S+Slf40k8Vuh7twqAQ0NlWX2UVxUeOe/QGw938k2Qi36BWftVAT+Q
         YR6JqABHiU9IJRxw82AgZrLYt0szMwUy4ndEA7CMMFrAYmfz6LAgTRzor07gYkMj9C1T
         2j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hmu7eebnVLf+96DkNkuKqCpbKAzUinX5DGlufPTCB0k=;
        b=EU9v5imP72ZWr37h2XuwP/ZVAx0LvF96U+WKMPne5h6AqbQcw75ZOn+CdwzA8DfCnf
         xiacjYWPJiA+5YHGg7Yk5JZAu+F8ZYwAVLMY08bH/Rxqsnr1TFDGwQSAInx01OqOYWRh
         VKAow0YfNEKtr06HGVeZ5gT+Ft2LP6tCNjsu6+egG1Dt2br+CRLHbRfqyyryK7CvUwxg
         sP6LwdihiYEgU423Sz9ipOrLmqwvoOXSuF94qGEmMB7GSw6sva06ufJ7O97uBfzlCnF8
         ctygTwLIB1EoS4v43bdZt8xRnbwFvVgAs+w3M6LglPh9uQeglR4p0Rp8FOn4ideZY4SX
         C/dw==
X-Gm-Message-State: AOAM533Xwe/TWS0L+xM2pxnafXFU4MOa12scrLQY6h2eiIb/l8Ab1rWm
        u6hwgYB5IiRfgUiw7fN3jQcZ9g==
X-Google-Smtp-Source: ABdhPJxyIrCUEFdB5pQvSe1V5F6WSkOzb5K3eG9bgIeNA4VN8z5+mNW0IsDm6qn/dgWIEJzOtBfusQ==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr1669266wmk.110.1597994213400;
        Fri, 21 Aug 2020 00:16:53 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:16:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 04/32] wireless: broadcom: brcm80211: brcmsmac: ampdu: Remove a bunch of unused variables
Date:   Fri, 21 Aug 2020 08:16:16 +0100
Message-Id: <20200821071644.109970-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:18:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function ‘brcms_c_ampdu_finalize’:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:648:25: warning: variable ‘sgi’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function ‘brcms_c_ampdu_dotxstatus_complete’:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:856:18: warning: variable ‘rr_retry_limit’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:855:5: warning: variable ‘antselid’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:853:41: warning: variable ‘tx_error’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:853:7: warning: variable ‘update_rate’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function ‘brcms_c_ampdu_dotxstatus’:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1037:28: warning: variable ‘tx_info’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1035:28: warning: variable ‘ini’ set but not used [-Wunused-but-set-variable]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmsmac/ampdu.c       | 28 ++++++-------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index fa391e4eb0989..cbad1a11673ae 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -645,7 +645,7 @@ void brcms_c_ampdu_finalize(struct brcms_ampdu_session *session)
 	u16 mimo_ctlchbw = PHY_TXC1_BW_20MHZ;
 	u32 rspec = 0, rspec_fallback = 0;
 	u32 rts_rspec = 0, rts_rspec_fallback = 0;
-	u8 plcp0, plcp3, is40, sgi, mcs;
+	u8 plcp0, is40, mcs;
 	u16 mch;
 	u8 preamble_type = BRCMS_GF_PREAMBLE;
 	u8 fbr_preamble_type = BRCMS_GF_PREAMBLE;
@@ -704,15 +704,12 @@ void brcms_c_ampdu_finalize(struct brcms_ampdu_session *session)
 	txh->MacTxControlLow = cpu_to_le16(mcl);
 
 	fbr = txrate[1].count > 0;
-	if (!fbr) {
+	if (!fbr)
 		plcp0 = plcp[0];
-		plcp3 = plcp[3];
-	} else {
+	else
 		plcp0 = txh->FragPLCPFallback[0];
-		plcp3 = txh->FragPLCPFallback[3];
-	}
+
 	is40 = (plcp0 & MIMO_PLCP_40MHZ) ? 1 : 0;
-	sgi = plcp3_issgi(plcp3) ? 1 : 0;
 	mcs = plcp0 & ~MIMO_PLCP_40MHZ;
 
 	if (is40) {
@@ -850,10 +847,9 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 	bool ba_recd = false, ack_recd = false;
 	u8 suc_mpdu = 0, tot_mpdu = 0;
 	uint supr_status;
-	bool update_rate = true, retry = true, tx_error = false;
+	bool update_rate = true, retry = true;
 	u16 mimoantsel = 0;
-	u8 antselid = 0;
-	u8 retry_limit, rr_retry_limit;
+	u8 retry_limit;
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(p);
 
 #ifdef DEBUG
@@ -866,7 +862,6 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 
 	ini = &scb_ampdu->ini[tid];
 	retry_limit = ampdu->retry_limit_tid[tid];
-	rr_retry_limit = ampdu->rr_retry_limit_tid[tid];
 	memset(bitmap, 0, sizeof(bitmap));
 	queue = txs->frameid & TXFID_QUEUE_MASK;
 	supr_status = txs->status & TX_STATUS_SUPR_MASK;
@@ -923,8 +918,7 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 				 * if there were underflows, but pre-loading
 				 * is not active, notify rate adaptation.
 				 */
-				if (brcms_c_ffpld_check_txfunfl(wlc, queue) > 0)
-					tx_error = true;
+				brcms_c_ffpld_check_txfunfl(wlc, queue);
 			}
 		} else if (txs->phyerr) {
 			update_rate = false;
@@ -1023,7 +1017,7 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 	}
 
 	/* update rate state */
-	antselid = brcms_c_antsel_antsel2id(wlc->asi, mimoantsel);
+	brcms_c_antsel_antsel2id(wlc->asi, mimoantsel);
 }
 
 void
@@ -1032,11 +1026,7 @@ brcms_c_ampdu_dotxstatus(struct ampdu_info *ampdu, struct scb *scb,
 {
 	struct scb_ampdu *scb_ampdu;
 	struct brcms_c_info *wlc = ampdu->wlc;
-	struct scb_ampdu_tid_ini *ini;
 	u32 s1 = 0, s2 = 0;
-	struct ieee80211_tx_info *tx_info;
-
-	tx_info = IEEE80211_SKB_CB(p);
 
 	/* BMAC_NOTE: For the split driver, second level txstatus comes later
 	 * So if the ACK was received then wait for the second level else just
@@ -1061,7 +1051,6 @@ brcms_c_ampdu_dotxstatus(struct ampdu_info *ampdu, struct scb *scb,
 
 	if (scb) {
 		scb_ampdu = &scb->scb_ampdu;
-		ini = &scb_ampdu->ini[p->priority];
 		brcms_c_ampdu_dotxstatus_complete(ampdu, scb, p, txs, s1, s2);
 	} else {
 		/* loop through all pkts and free */
@@ -1069,7 +1058,6 @@ brcms_c_ampdu_dotxstatus(struct ampdu_info *ampdu, struct scb *scb,
 		struct d11txh *txh;
 		u16 mcl;
 		while (p) {
-			tx_info = IEEE80211_SKB_CB(p);
 			txh = (struct d11txh *) p->data;
 			trace_brcms_txdesc(&wlc->hw->d11core->dev, txh,
 					   sizeof(*txh));
-- 
2.25.1

