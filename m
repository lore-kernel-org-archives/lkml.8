Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB8EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713D12071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442835;
	bh=8b0ZBgMgQJ6qDLoGvfDUyJ1jvRvYX3DhahpXDQTgdk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYtflZLkJJpa+LN4an2/Iam+lOVHgKkEgl8Gj/73u12XDtQML/dICBw5B8zu1cwV0
	 5tCV2+JOxadPQifW5JKAuJacscoMRH2OnF6poKVZ6clPBodsskHhFKxcan+jTFeu5j
	 K3lSfjVsKOtZGo2R6eivbnIlYSHQcuSi/NKw0Nio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCQLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCQLAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDBA205ED;
        Tue, 17 Mar 2020 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442831;
        bh=8b0ZBgMgQJ6qDLoGvfDUyJ1jvRvYX3DhahpXDQTgdk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jW6hPiR7D4+7M5M57kZDp3INEJXHrmdiIpC2clKiHgDUNhPrAHWLXSzn3Z2j4fsm
         4fZDYKxVQUfUDgH+cAX6GbOXYsABH+cxe/sFa4eCVeYn3+TtI13W1Z4fsARCDcqBpR
         iZwotPgWDkxTPKsuU33ysWBewCXAnBgZL5LMqUhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 77/89] nl80211: add missing attribute validation for channel switch
Date:   Tue, 17 Mar 2020 11:55:26 +0100
Message-Id: <20200317103308.974836577@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit 5cde05c61cbe13cbb3fa66d52b9ae84f7975e5e6 upstream.

Add missing attribute validation for NL80211_ATTR_OPER_CLASS
to the netlink policy.

Fixes: 1057d35ede5d ("cfg80211: introduce TDLS channel switch commands")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20200303051058.4089398-4-kuba@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -426,6 +426,7 @@ static const struct nla_policy nl80211_p
 	[NL80211_ATTR_USER_PRIO] = { .type = NLA_U8 },
 	[NL80211_ATTR_ADMITTED_TIME] = { .type = NLA_U16 },
 	[NL80211_ATTR_SMPS_MODE] = { .type = NLA_U8 },
+	[NL80211_ATTR_OPER_CLASS] = { .type = NLA_U8 },
 	[NL80211_ATTR_MAC_MASK] = { .len = ETH_ALEN },
 	[NL80211_ATTR_WIPHY_SELF_MANAGED_REG] = { .type = NLA_FLAG },
 	[NL80211_ATTR_NETNS_FD] = { .type = NLA_U32 },


