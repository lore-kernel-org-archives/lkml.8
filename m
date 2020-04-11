Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F51C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DEC206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648384;
	bh=MMe46zjI134depEk5VBUTl2isnIxc2CPpdG4qs8lO78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P56w0ZjWNiD6bVsiyBnaKzD6Dc95I7rYMV9yXbyb0wF7I9TaqFEEsXcHfClI6VIMt
	 ELN4xb6UT5vWOD8iQVxd6dOw4XByi+Zylq62lBe+cfbQdzHa52KIo2LnDwBJyWNubY
	 nEHY6+H3StTVtj2okcjkDyH+rW8vD6Fkrz8/mFDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgDKXjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbgDKXHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227C3217D8;
        Sat, 11 Apr 2020 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646455;
        bh=MMe46zjI134depEk5VBUTl2isnIxc2CPpdG4qs8lO78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahFpr0dYlsj6F+e8z9o9fTph3ek3olVA8V4X+F3SIRrhZHFT5jHYytYtQMdfTyDPr
         yqNZv8rpcDnQE7YymdN9sjIl7+E0t+CdWjFTJYtJwS7v3ABxeVHgRFQTOYOOHgUv/w
         XAubIh6nmemZ5Csh0unWdlvex1QJ3m7OsA4MsN0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Ganapathi Bhat <ganapathi.gbhat@nxp.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 024/121] mwifiex: set needed_headroom, not hard_header_len
Date:   Sat, 11 Apr 2020 19:05:29 -0400
Message-Id: <20200411230706.23855-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 9454f7a895b822dd8fb4588fc55fda7c96728869 ]

hard_header_len provides limitations for things like AF_PACKET, such
that we don't allow transmitting packets smaller than this.

needed_headroom provides a suggested minimum headroom for SKBs, so that
we can trivally add our headers to the front.

The latter is the correct field to use in this case, while the former
mostly just prevents sending small AF_PACKET frames.

In any case, mwifiex already does its own bounce buffering [1] if we
don't have enough headroom, so hints (not hard limits) are all that are
needed.

This is the essentially the same bug (and fix) that brcmfmac had, fixed
in commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
additional header space").

[1] mwifiex_hard_start_xmit():
	if (skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN) {
	[...]
		/* Insufficient skb headroom - allocate a new skb */

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Ganapathi Bhat <ganapathi.gbhat@nxp.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d896841685008..e63bc15c6e305 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3052,7 +3052,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 	dev->flags |= IFF_BROADCAST | IFF_MULTICAST;
 	dev->watchdog_timeo = MWIFIEX_DEFAULT_WATCHDOG_TIMEOUT;
-	dev->hard_header_len += MWIFIEX_MIN_DATA_HEADER_LEN;
+	dev->needed_headroom = MWIFIEX_MIN_DATA_HEADER_LEN;
 	dev->ethtool_ops = &mwifiex_ethtool_ops;
 
 	mdev_priv = netdev_priv(dev);
-- 
2.20.1

