Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE31C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D6A20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="Wy+lY5pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgIGQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgIGQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:23:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A56C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:23:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so4400925plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SDxUUQ+8c+YEIDDJur8rYrh3CcLj60cM5IrQcltAbJU=;
        b=Wy+lY5pi2y0MXKbzHqJ4nxyLK8FkoENJ+OWduamenQCm/MHiU+zeaS9LOSSiSk7TmX
         OQwBenpNoA2RRwW+bDYWYnuPBVvGkPeIZJXm0ZMBz4gBd2pC5Kw5z5E0N3ZbM34nAw+k
         OdteM1Ed8drJUGv6ZCa9m6kJPpuG9BZzrYu+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SDxUUQ+8c+YEIDDJur8rYrh3CcLj60cM5IrQcltAbJU=;
        b=AROd8RDtjE2wbvSdl9L3reFR+b3fngfKYBd/gtW+Q1CBeSsdHCQ7pEJ3rI0ywLU24M
         Co2N5w6BK6+UHLb17VHaMWIth4AdmmlabkHkYgonpxqauWbUr66gjqoLgVYVK74FloAm
         Fbp1Axgy+Zx9cTqnlAWhwMZzEUsApyjamHr/MppgJHYdIPIO0ZvsnjFZY/TRL2IOsCSk
         lztWKrh/dHcyl1eP7zXLST9xGHN643Mt3a6IDvgFeYIy2QQ0B+Cfwu8l5MkHzi8IqFMw
         iBQD4n2gIORqqP0YBXFWM2C7oMUPdH67MjaS6QmwMX5zGpWFEpOvxFW15eIrdq593H6s
         pGjw==
X-Gm-Message-State: AOAM530vWUQDyR3TW/KE4ju3p1Ktq0PZcDY1xcds0TNEx0E4HbHj3B+V
        3hGscfD/byTTL2USulgG7ly8Dw==
X-Google-Smtp-Source: ABdhPJyt1f1puArMGZEw7H7IWnsOdW3BtYIeDECpZMGG2uhioAhtb/hu+XxvwnoXRKkOXMIXD2nqUQ==
X-Received: by 2002:a17:902:d353:: with SMTP id l19mr9227410plk.220.1599495818901;
        Mon, 07 Sep 2020 09:23:38 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id v1sm3229622pjn.1.2020.09.07.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:23:38 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list@cypress.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] brcmsmac: fix potential memory leak in wlc_phy_attach_lcnphy
Date:   Mon,  7 Sep 2020 16:22:43 +0000
Message-Id: <20200907162245.17997-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
freed in the caller function.

Fix this by calling wlc_phy_detach_lcnphy in the error handler of
wlc_phy_txpwr_srom_read_lcnphy before returning.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 7ef36234a25d..6d70f51b2ddf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -5065,8 +5065,10 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
 	pi->pi_fptr.radioloftget = wlc_lcnphy_get_radio_loft;
 	pi->pi_fptr.detach = wlc_phy_detach_lcnphy;
 
-	if (!wlc_phy_txpwr_srom_read_lcnphy(pi))
+	if (!wlc_phy_txpwr_srom_read_lcnphy(pi)) {
+		wlc_phy_detach_lcnphy(pi);
 		return false;
+	}
 
 	if (LCNREV_IS(pi->pubpi.phy_rev, 1)) {
 		if (pi_lcn->lcnphy_tempsense_option == 3) {
-- 
2.17.1

