Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9817C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B3206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942122;
	bh=gkpBvoONpiwZyG0eIJDZj+HgoJlMvPCz1mgxWiTdj9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IjXOtVybiBLB7Pclu3b0ASOsqinNPz+vYvipY3rTXxya8vkECFRSWDUnkilZvTis8
	 tI3bFL+TuDymX01Y5/4O+BabB8JdTsjvmb0IgdviFrpJRbvknWxSc59f0YtDxxJG40
	 Tk9Sea8rWMepV+YX2LlocXGJDtRLMg9MtAZve2yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgEHMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgEHMsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24213206D6;
        Fri,  8 May 2020 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942118;
        bh=gkpBvoONpiwZyG0eIJDZj+HgoJlMvPCz1mgxWiTdj9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nznlKpTiljrCIb07RBWvzbz5YegkwHxLgSzVCvdQ3EPB3fVJX9xQTRlt5b6oYi9GP
         ItIwTUFOr0Ws/BveJaG7SxOzge+4vDQ8ryo4PKbMJX1MkpIYJCnlwGCWf6gkHMRdUi
         U9V3t1jWjmuhrvFrcdeaWNkzCXzC90/Gzj7qCg90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaap Jan Meijer <jjmeijer88@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 303/312] brcmfmac: add fallback for devices that do not report per-chain values
Date:   Fri,  8 May 2020 14:34:54 +0200
Message-Id: <20200508123145.763718643@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaap Jan Meijer <jjmeijer88@gmail.com>

commit 94abd778a7bb00ed5d00f56d9fbfcbf5b7c02a5c upstream.

If brcmf_cfg80211_get_station fails to determine the RSSI from the
per-chain values get the value individually as a fallback.

Fixes: 1f0dc59a6de9 ("brcmfmac: rework .get_station() callback")
Signed-off-by: Jaap Jan Meijer <jjmeijer88@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
@@ -2419,12 +2419,14 @@ brcmf_cfg80211_get_station(struct wiphy
 			   const u8 *mac, struct station_info *sinfo)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_scb_val_le scb_val;
 	s32 err = 0;
 	struct brcmf_sta_info_le sta_info_le;
 	u32 sta_flags;
 	u32 is_tdls_peer;
 	s32 total_rssi;
 	s32 count_rssi;
+	int rssi;
 	u32 i;
 
 	brcmf_dbg(TRACE, "Enter, MAC %pM\n", mac);
@@ -2505,6 +2507,20 @@ brcmf_cfg80211_get_station(struct wiphy
 			sinfo->filled |= BIT(NL80211_STA_INFO_SIGNAL);
 			total_rssi /= count_rssi;
 			sinfo->signal = total_rssi;
+		} else if (test_bit(BRCMF_VIF_STATUS_CONNECTED,
+			&ifp->vif->sme_state)) {
+			memset(&scb_val, 0, sizeof(scb_val));
+			err = brcmf_fil_cmd_data_get(ifp, BRCMF_C_GET_RSSI,
+						     &scb_val, sizeof(scb_val));
+			if (err) {
+				brcmf_err("Could not get rssi (%d)\n", err);
+				goto done;
+			} else {
+				rssi = le32_to_cpu(scb_val.val);
+				sinfo->filled |= BIT(NL80211_STA_INFO_SIGNAL);
+				sinfo->signal = rssi;
+				brcmf_dbg(CONN, "RSSI %d dBm\n", rssi);
+			}
 		}
 	}
 done:


