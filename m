Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EDAC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CF20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442829;
	bh=SuOEPHGuI6jYXfzfT8vNcHYigmvpDgAWQIGJS4LDmMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bM5VekPmBaXDxRzoSLupmTUr1kha7idwkTF0/44OD0dKSxdy2NbCfOnNx09+7m2eb
	 zsq6ikcp7Rw0xahVP6siOfp/I05tiiZZC6x7kXRMunNgjM88WdC7adLKL0BFnMV7im
	 TUZcBO06dw/x+SPzznsafpIA60uQsKeXxOuE0jNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCQLA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbgCQLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C8820658;
        Tue, 17 Mar 2020 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442825;
        bh=SuOEPHGuI6jYXfzfT8vNcHYigmvpDgAWQIGJS4LDmMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elJXiEpOd2CVjaloVYTJ5pbBqbG0LkFRfEM/1UPTSFHNf4TyzIoTl/FHa/DK+EVKq
         y83eQHM3HxFpXKQihgZbdxds3X4lzFJsTfPyGJwA28h3Ktjng4emHkJb+Es0aDj0Q+
         YKcxJ2VhmeEWnBTvBojjC7l6VsOwS8ANlCk01sXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 75/89] nl80211: add missing attribute validation for critical protocol indication
Date:   Tue, 17 Mar 2020 11:55:24 +0100
Message-Id: <20200317103308.572991842@linuxfoundation.org>
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

commit 0e1a1d853ecedc99da9d27f9f5c376935547a0e2 upstream.

Add missing attribute validation for critical protocol fields
to the netlink policy.

Fixes: 5de17984898c ("cfg80211: introduce critical protocol indication from user-space")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20200303051058.4089398-2-kuba@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -397,6 +397,8 @@ static const struct nla_policy nl80211_p
 	[NL80211_ATTR_MDID] = { .type = NLA_U16 },
 	[NL80211_ATTR_IE_RIC] = { .type = NLA_BINARY,
 				  .len = IEEE80211_MAX_DATA_LEN },
+	[NL80211_ATTR_CRIT_PROT_ID] = { .type = NLA_U16 },
+	[NL80211_ATTR_MAX_CRIT_PROT_DURATION] = { .type = NLA_U16 },
 	[NL80211_ATTR_PEER_AID] = { .type = NLA_U16 },
 	[NL80211_ATTR_CH_SWITCH_COUNT] = { .type = NLA_U32 },
 	[NL80211_ATTR_CH_SWITCH_BLOCK_TX] = { .type = NLA_FLAG },


