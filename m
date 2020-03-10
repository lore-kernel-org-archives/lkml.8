Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535BC2BB58
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C464C246A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844065;
	bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pjuw5QXkeSCw2m1MDaf1qKRJtQPx8ActSlKFnWJkebqYY3YJlFG74r6B+AInvX1Vl
	 aWT5L0/SUqf2c3E2QKwd4NVI77ZaRuDPXvCFMr+I7njzKBly0SAvGDWFFnEA0adYQJ
	 3Nua2ju7oIsu1PK0AP4/iEdTDQcX6f5yc3AMm4z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCJMlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgCJMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:41:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673C824686;
        Tue, 10 Mar 2020 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844061;
        bh=cy7SP9sbTFkiqIp2R+EgdcYVzesuD6fYlrZu3pfgR18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDBCrOK1Zx+WTLTtB8tiUWYFFrpdJvH6mvcDDdrIaM+/FL/6Hs2ZIwLU+5U3Pf/73
         u/Hzkv7B68yoq+XwxchQ86McKboSkSn1h4MiPi7QG/3Y/KThQF1+ezuIN6Yh9uqhxg
         GH032tlL53C+maQqEFUGccZ6bMQh3yCmBIbSEDPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/72] cfg80211: check wiphy driver existence for drvinfo report
Date:   Tue, 10 Mar 2020 13:38:20 +0100
Message-Id: <20200310123603.291415271@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
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



