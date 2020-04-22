Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4B0C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2156420784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549858;
	bh=70sshmZhpMOa6RzSciMULOyD97YfrviAHmZFEkUa1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JTGPk9nMEglP066ZL62Xxa7UQc1+dQJ3E4KmvEqrBIyzupXj2DCax2PKp3zY3ewXZ
	 tjdEUWdgR9EmDzeKnHYEFzqyWF2mgif6NBdT79XQKRz8gkvGeIbqhk0tTXWyxCgDPz
	 hVs1ALU5sgTVs1PaKUhlmU7XVLckOaNbKlWjt4bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgDVKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgDVKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:04:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A02520776;
        Wed, 22 Apr 2020 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549851;
        bh=70sshmZhpMOa6RzSciMULOyD97YfrviAHmZFEkUa1LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKo5ZEU2srqkZCojpL7SuyQTSwAhsfQAtEhTinN47ssW+CGe+sCFU9JTewdmqwnk0
         1004qT979SR4/ePmBXwexp6sF0hMuPxRXOe2q8ynA/UY+k0IThY6N0eHf7e4RiykDf
         j4T0nbQQ/XLwmbqImtxsb1zQ7hB8ddYWzOtMKUKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 032/125] ath9k: Handle txpower changes even when TPC is disabled
Date:   Wed, 22 Apr 2020 11:55:49 +0200
Message-Id: <20200422095038.593160809@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

commit 968ae2caad0782db5dbbabb560d3cdefd2945d38 upstream.

When TPC is disabled IEEE80211_CONF_CHANGE_POWER event can be handled to
reconfigure HW's maximum txpower.

This fixes 0dBm txpower setting when user attaches to an interface for
the first time with the following scenario:

ieee80211_do_open()
    ath9k_add_interface()
        ath9k_set_txpower() /* Set TX power with not yet initialized
                               sc->hw->conf.power_level */

    ieee80211_hw_config() /* Iniatilize sc->hw->conf.power_level and
                             raise IEEE80211_CONF_CHANGE_POWER */

    ath9k_config() /* IEEE80211_CONF_CHANGE_POWER is ignored */

This issue can be reproduced with the following:

  $ modprobe -r ath9k
  $ modprobe ath9k
  $ wpa_supplicant -i wlan0 -c /tmp/wpa.conf &
  $ iw dev /* Here TX power is either 0 or 3 depending on RF chain */
  $ killall wpa_supplicant
  $ iw dev /* TX power goes back to calibrated value and subsequent
              calls will be fine */

Fixes: 283dd11994cde ("ath9k: add per-vif TX power capability")
Cc: stable@vger.kernel.org
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1455,6 +1455,9 @@ static int ath9k_config(struct ieee80211
 		ath_chanctx_set_channel(sc, ctx, &hw->conf.chandef);
 	}
 
+	if (changed & IEEE80211_CONF_CHANGE_POWER)
+		ath9k_set_txpower(sc, NULL);
+
 	mutex_unlock(&sc->mutex);
 	ath9k_ps_restore(sc);
 


