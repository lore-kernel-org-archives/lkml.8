Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E4AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5463C214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258399;
	bh=9O5ymUWpNt3jhqdPiucuIYgwSShPohd5ByDTUrD1C6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/vyvZbedt188FHQP2shI7jKiKqCMXy3k+TrNwU3m+Y/BcwDh5vto7q1IKPDxzgmc
	 gNTt8cedLkTaa6wEecqBkV1vednJXFDLwjAFXwfH96kqm9HVHKXg+r9lvAX1OJjqP2
	 z7HGLF6FS00E7LEAwfYRY3x3FKd2q++wWhqbRI30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgCCR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbgCCR7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:59:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6AF20656;
        Tue,  3 Mar 2020 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258387;
        bh=9O5ymUWpNt3jhqdPiucuIYgwSShPohd5ByDTUrD1C6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pti5NW1ZFAK/AvhYEXfhq8sdF/qwXJVxxBhdO7Z44+Hj3KLgQlE7miar8bzJ8mHRR
         jAGUTuUGVANWCKYOE5gEsgRbBEIRvYdR+le8qiokLoHrom8Ofqtv+6oWXC2e5FFo9l
         zNGLatVZASkTE8jPZN6I42I//PXh7iskdTyQYAwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/87] cfg80211: check wiphy driver existence for drvinfo report
Date:   Tue,  3 Mar 2020 18:42:59 +0100
Message-Id: <20200303174349.718650585@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit bfb7bac3a8f47100ebe7961bd14e924c96e21ca7 ]

When preparing ethtool drvinfo, check if wiphy driver is defined
before dereferencing it. Driver may not exist, e.g. if wiphy is
attached to a virtual platform device.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Link: https://lore.kernel.org/r/20200203105644.28875-1-sergey.matyukevich.os@quantenna.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
index a9c0f368db5d2..24e18405cdb48 100644
--- a/net/wireless/ethtool.c
+++ b/net/wireless/ethtool.c
@@ -7,9 +7,13 @@
 void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct device *pdev = wiphy_dev(wdev->wiphy);
 
-	strlcpy(info->driver, wiphy_dev(wdev->wiphy)->driver->name,
-		sizeof(info->driver));
+	if (pdev->driver)
+		strlcpy(info->driver, pdev->driver->name,
+			sizeof(info->driver));
+	else
+		strlcpy(info->driver, "N/A", sizeof(info->driver));
 
 	strlcpy(info->version, init_utsname()->release, sizeof(info->version));
 
-- 
2.20.1



