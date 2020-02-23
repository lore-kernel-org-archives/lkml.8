Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15056C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B1821741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424743;
	bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4/X8EmRhBxeKQ270381O66HxFMD0XiUYg2wA/p5utnEOvFPXsEIkdmJqiuQ6nnwf
	 gVGyQCLYQTuuMwkTH6SVVWlA6g6+ndISn9f25XzBkYt4VopYseLjb2sdMTHVTpVjBO
	 NGRGMPYcbMG4V9v15Pt/9AceXdbIG3xFE6x731C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBWCZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgBWCZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:25:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC0A20707;
        Sun, 23 Feb 2020 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424703;
        bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXr7l+E3z4uLI3JGpkGRVleInL5h1rAS255tu78jH+YRorOOalJ66gjcurmG40CBZ
         dzVtiFqNBbKSd1LisbpAWbeJE5NhGMY0VWpdDURWm49Zdiv9sIt2Q6p/6Yw/YzxJit
         ppPl+oCPMsuxh1NK82gobZ5uD5LjZg392O/wEDVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 3/7] cfg80211: check wiphy driver existence for drvinfo report
Date:   Sat, 22 Feb 2020 21:24:55 -0500
Message-Id: <20200223022459.2594-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022459.2594-1-sashal@kernel.org>
References: <20200223022459.2594-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

