Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CEC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A1D21D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753719;
	bh=dxJSDkA1CY1HRGex+Bg/lyoogytrSC1qPBDs39Lk+fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JC/XsUOKh/WPni9sKVyv4IOD4/L02nmUtM889NchzQsg7X2AAoLRvVktZopcedZd7
	 N1hGIAcvq5T9HpzRQU+5yJKJd8suMaMJNyNYKcDHJGLOS5W/JP84jdSQofx1Gx9oqz
	 CetqMY1qTFYwQfM2xLZWfqRPRl+AGJbr+EgPH6rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgGNSuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbgGNSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280D622AAA;
        Tue, 14 Jul 2020 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752598;
        bh=dxJSDkA1CY1HRGex+Bg/lyoogytrSC1qPBDs39Lk+fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEnp6mgUdJl1eH9OvU1/z1wbw5nBTfR9iDhBcZbCb+nDoTVb4gqb8vHMKUuWRBUed
         mfEuvTiknGqo1IuuidLpRPZHf8tbMG49Oqfp0dHN0G9tEpiScL6GItA6sSSsFpzgX0
         FjE9diknqxdiwOzPkowWCqDmCG6BK4aV9nK4uG5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/109] nl80211: dont return err unconditionally in nl80211_start_ap()
Date:   Tue, 14 Jul 2020 20:43:41 +0200
Message-Id: <20200714184107.345661678@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit bc7a39b4272b9672d806d422b6850e8c1a09914c ]

When a memory leak was fixed, a return err was changed to goto err,
but, accidentally, the if (err) was removed, so now we always exit at
this point.

Fix it by adding if (err) back.

Fixes: 9951ebfcdf2b ("nl80211: fix potential leak in AP start")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20200626124931.871ba5b31eee.I97340172d92164ee92f3c803fe20a8a6e97714e1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b65180e874fb9..a34bbca80f498 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4798,7 +4798,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_he_obss_pd(
 					info->attrs[NL80211_ATTR_HE_OBSS_PD],
 					&params.he_obss_pd);
-		goto out;
+		if (err)
+			goto out;
 	}
 
 	nl80211_calculate_ap_params(&params);
-- 
2.25.1



