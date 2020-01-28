Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A450C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14EF24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220738;
	bh=IwdRdXE+mG0CktYQBEUB09NnRQJI+kcwKpJ/qRDoAew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdiM4QHRmx3gO2gG8mbQln8tKdF40ShCFCwZlbwwLhBL8Aec0Y2yJ/b4vk26vzxOX
	 zEV3iBPqZvQdDBkLBMnD1CinUWII79EjuUNknY3c9ZDYrsA9KdS0MU0qXm9TIDj9Mx
	 KrMy6RYBNvMpLK0XtamVk/0h0JNfbXw7qET/HbKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgA1OMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgA1OML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B1520678;
        Tue, 28 Jan 2020 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220731;
        bh=IwdRdXE+mG0CktYQBEUB09NnRQJI+kcwKpJ/qRDoAew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdISrLxNRE/YM4l1PbMZYOetCyTRFl/0GN9+Cnz7Cs+JcpY0jUQdnMU7wNCFACWr1
         vJmqpgtxX8Iotazm24yH5TZ2IWBu2a/UD6mpb9qM8IaKuFNrNo8uFwdCtw9InEy8AI
         H1SJe2Tdfe7iccknhYzy9pE4JLOrr08lJBZOhs4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 125/183] mac80211: minstrel_ht: fix per-group max throughput rate initialization
Date:   Tue, 28 Jan 2020 15:05:44 +0100
Message-Id: <20200128135842.375604429@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ff3b28e7dbce8..fb44f0107da1b 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -546,7 +546,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 
 		/* (re)Initialize group rate indexes */
 		for(j = 0; j < MAX_THR_RATES; j++)
-			tmp_group_tp_rate[j] = group;
+			tmp_group_tp_rate[j] = MCS_GROUP_RATES * group;
 
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			if (!(mg->supported & BIT(i)))
-- 
2.20.1



