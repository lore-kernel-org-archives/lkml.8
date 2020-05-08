Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1FEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B36D2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942651;
	bh=zI9U96ifGGqZbsvmYhIvux+kaVFx/2j17snz9G3CqCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqHaYl3hiOSYHjhh0UFA6zT5lbqqEDRPDYnxUEVw43h/YVaXNiC9fV0Y3ddmOOA45
	 K4AwGqUyhSPrvXqLXhI/M3jcFuYR3BxF3qcWcUg72aax+u+vnLejlVlpe9CoyB8QHb
	 p52pydLyaO0IUgw7YOVSuN8ooQ1pxH1nAxJkXXmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgEHM5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbgEHMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9B02495A;
        Fri,  8 May 2020 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942542;
        bh=zI9U96ifGGqZbsvmYhIvux+kaVFx/2j17snz9G3CqCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Cjljkh1sFfjOnPXoNWr2Xt6ayclEv26I3FUauNJ6OQUXl1YNh9PL5vcDEzJedWoU
         l7MomthTNwDPtFxH6nVcihBZZ6JgcNe4omG/ca0TsyP5ypR61iZEMnUD5kfiGDZdGW
         OdDIkfMzIE7kjfr034P9Mvi+MUHJnVBmbbnfRmM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 37/49] mac80211: sta_info: Add lockdep condition for RCU list usage
Date:   Fri,  8 May 2020 14:35:54 +0200
Message-Id: <20200508123048.222492047@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 8ca47eb9f9e4e10e7e7fa695731a88941732c38d ]

The function sta_info_get_by_idx() uses RCU list primitive.
It is called with  local->sta_mtx held from mac80211/cfg.c.
Add lockdep expression to avoid any false positive RCU list warnings.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Link: https://lore.kernel.org/r/20200409082906.27427-1-madhuparnabhowmik10@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e3572be307d6c..149ed0510778d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -231,7 +231,8 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	int i = 0;
 
-	list_for_each_entry_rcu(sta, &local->sta_list, list) {
+	list_for_each_entry_rcu(sta, &local->sta_list, list,
+				lockdep_is_held(&local->sta_mtx)) {
 		if (sdata != sta->sdata)
 			continue;
 		if (i < idx) {
-- 
2.20.1



