Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8502EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554FC2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197909;
	bh=f8DagKr6Vvh8oDgpnA79+Y7PwQqyCOeo5+FcDw+FMew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GT4tzHZij78U4SCwl5ZI2FUI4aCmEpix8VURo/7NvnFclYq4ARopwEMS1XhoUL9X1
	 lL9Jr98dr/wOoAGXqkswvFz57ipRO5AXZFoXo0+wbJVtT6A/9sL9YL6n2I5+jnFFWA
	 asE5ZD0sQzAsd2iXVhoCul4f0C153MjBtD+LYPyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406966AbgAPSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390948AbgAPRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D6F2471C;
        Thu, 16 Jan 2020 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196413;
        bh=f8DagKr6Vvh8oDgpnA79+Y7PwQqyCOeo5+FcDw+FMew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xCGjQt4f1cXMi2hmRwAmoAt8UGxpV8RsCCiMhPad/3u2xMBXXN/KoEDf8VLtbT+MV
         ji0NObjcrREkJo1WcDWtGqp2GPA5ephc5MGFdiJcoBnczYfHfmPovdBSQt8MRcsVmS
         H7TI9prbIClCGnOZpw7IiT9ToKaamjeHy/2T5PA4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 186/251] mac80211: minstrel_ht: fix per-group max throughput rate initialization
Date:   Thu, 16 Jan 2020 12:35:35 -0500
Message-Id: <20200116173641.22137-146-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 56dd918ff06e3ee24d8067e93ed12b2a39e71394 ]

The group number needs to be multiplied by the number of rates per group
to get the full rate index

Fixes: 5935839ad735 ("mac80211: improve minstrel_ht rate sorting by throughput & probability")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20190820095449.45255-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 593184d14b3e..e1b0e26c1f17 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -547,7 +547,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 
 		/* (re)Initialize group rate indexes */
 		for(j = 0; j < MAX_THR_RATES; j++)
-			tmp_group_tp_rate[j] = group;
+			tmp_group_tp_rate[j] = MCS_GROUP_RATES * group;
 
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			if (!(mg->supported & BIT(i)))
-- 
2.20.1

