Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA328246A3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844321;
	bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIF+MDOb8iXdk4bbt8ee0OxmRfjjyumqOsPGZssd3Qeqar0N7liM5bmm/wIbDE0gU
	 uh0OG5/9e6Vir7MkfjCEK0tp7zkKFQdsODHeKh8unIrOrly+O2WECYNsR8iRd9Q7Qu
	 0s0l2tlF/BH7I4AR9uGWXC+x3eFm8reD+PmxcJTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCJMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgCJMpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:45:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018F924695;
        Tue, 10 Mar 2020 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844315;
        bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KE8DgQRHYQKwxTe/EpiuGNS91x90dypivuunomquMdoKdKrA6XxXt4CALu03G4E1u
         uiT8dWxWj+gljhFXleSDA5IlUx9F+U00oCXBHwHcq3oVACezbHp1hS8JS/XBvxGxA5
         tK91eYtxU8tgV7vyBzRFpt9FbHo6sSDDoO52QJ1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/88] cfg80211: check wiphy driver existence for drvinfo report
Date:   Tue, 10 Mar 2020 13:38:16 +0100
Message-Id: <20200310123608.616366893@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
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
index e9e91298c70de..3cedf2c2b60bd 100644
--- a/net/wireless/ethtool.c
+++ b/net/wireless/ethtool.c
@@ -6,9 +6,13 @@
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



