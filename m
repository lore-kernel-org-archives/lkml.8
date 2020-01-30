Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1851C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433B205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410205;
	bh=PcYjAsbCfzF+5dESTDBeoAdBwesnGNr/0H4djHcVYs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwBHC1AZcekJmz+dJOGVGyb9U3DICMAFNumTt33NnDtKq4tgcSqwsPxR93rH8PAk5
	 9P/flBIp5JEkFDr/yEa/vw9uyy5RqjSDasKRxOEKRytg29mWS6OTIAR4tKYSQuaNj2
	 OGUy4LLwxlDhQAGs1HLKvo7kQzl+Eceq7BQDPueg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgA3SuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbgA3Srd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E924420674;
        Thu, 30 Jan 2020 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410052;
        bh=PcYjAsbCfzF+5dESTDBeoAdBwesnGNr/0H4djHcVYs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GESOKA0KLqgLICKY0MWH13Wr+U52VvYfxRlVG49dd0zeMWDwZvhAd4PqrynRXA04j
         XK0jB3WIA3bHEtIrT+2Y/xY0N2eU1Ckyd6/r4QUeyyMMItuMfa23BJXNCiXxiSBCuF
         0QeH+ATbYV6DvzKGuw4QulMCsGWC02l9grgoiu/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.19 10/55] staging: vt6656: correct packet types for CTS protect, mode.
Date:   Thu, 30 Jan 2020 19:38:51 +0100
Message-Id: <20200130183610.637745300@linuxfoundation.org>
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

commit d971fdd3412f8342747778fb59b8803720ed82b1 upstream.

It appears that the driver still transmits in CTS protect mode even
though it is not enabled in mac80211.

That is both packet types PK_TYPE_11GA and PK_TYPE_11GB both use CTS protect.
The only difference between them GA does not use B rates.

Find if only B rate in GB or GA in protect mode otherwise transmit packets
as PK_TYPE_11A.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/9c1323ff-dbb3-0eaa-43e1-9453f7390dc0@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/device.h |    2 ++
 drivers/staging/vt6656/rxtx.c   |   12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -52,6 +52,8 @@
 #define RATE_AUTO	12
 
 #define MAX_RATE			12
+#define VNT_B_RATES	(BIT(RATE_1M) | BIT(RATE_2M) |\
+			BIT(RATE_5M) | BIT(RATE_11M))
 
 /*
  * device specific
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -815,10 +815,14 @@ int vnt_tx_packet(struct vnt_private *pr
 		if (info->band == NL80211_BAND_5GHZ) {
 			pkt_type = PK_TYPE_11A;
 		} else {
-			if (tx_rate->flags & IEEE80211_TX_RC_USE_CTS_PROTECT)
-				pkt_type = PK_TYPE_11GB;
-			else
-				pkt_type = PK_TYPE_11GA;
+			if (tx_rate->flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
+				if (priv->basic_rates & VNT_B_RATES)
+					pkt_type = PK_TYPE_11GB;
+				else
+					pkt_type = PK_TYPE_11GA;
+			} else {
+				pkt_type = PK_TYPE_11A;
+			}
 		}
 	} else {
 		pkt_type = PK_TYPE_11B;


