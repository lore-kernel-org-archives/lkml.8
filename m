Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B30208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846489;
	bh=m65JZ9mK93qhBxdLSAzmYWdLfohdHHV76K5hV4I/JvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Sj358XA3Xc+WcntyMTP58hDpQ6W4A3Y/cJkzajWyAD+wU55TQuNFxkfqtX559f5L
	 j8DI1X/oJwK3RB8GdO8brIkrPA5O/6OK7UAQSvBfq2BDiXNKoC6Th20rSBcE7QMawl
	 HBjo6BiADndTwmqeYY6vX+FmHaxKfCl/rs2YBlHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgCJNV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbgCJNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B14424692;
        Tue, 10 Mar 2020 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845569;
        bh=m65JZ9mK93qhBxdLSAzmYWdLfohdHHV76K5hV4I/JvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv+EDDl81zj/Tf0EA8XWR0Bh2PZJqXmtms8L80DZ9nQNyz/PU+qvlqNeJzinUSQwH
         eF08WppkLV8b9nR1B/cYLsyrGvzKG0GFozjoZrU83xdgmYp4Q69koapNwHWTCmLFSO
         TcSjIxrZFz6khgqEA6RygfTERagtuCbNtJ4QN21Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 023/126] cfg80211: add missing policy for NL80211_ATTR_STATUS_CODE
Date:   Tue, 10 Mar 2020 13:40:44 +0100
Message-Id: <20200310124205.972893839@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit ea75080110a4c1fa011b0a73cb8f42227143ee3e ]

The nl80211_policy is missing for NL80211_ATTR_STATUS_CODE attribute.
As a result, for strictly validated commands, it's assumed to not be
supported.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Link: https://lore.kernel.org/r/20200213131608.10541-2-sergey.matyukevich.os@quantenna.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index df8c5312f26ad..b248578aeb7bc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -321,6 +321,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_ETHERTYPE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PRIVACY] = { .type = NLA_FLAG },
+	[NL80211_ATTR_STATUS_CODE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CIPHER_SUITE_GROUP] = { .type = NLA_U32 },
 	[NL80211_ATTR_WPA_VERSIONS] = { .type = NLA_U32 },
 	[NL80211_ATTR_PID] = { .type = NLA_U32 },
-- 
2.20.1



