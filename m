Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0B24695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844267;
	bh=A2foWvc9jrT5bSCjJRdsWFm8MIww1d4V6xIALYzfqq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sX3UCe54Xck+zMwFDrA/fGn8/H6B96AtC4cW6xpMbktwGcTB0iyWjiWe+6SHN5jVs
	 L1zM5/8JTQnWo50qGPekeAfCpj0nopmB0f0FMmIZjJCbYB5U9jZDRJSocU1Bb2HsSc
	 F+L7FvTnxBznX1QMjmK+4NjhpSfXi+0Xv4/OlyQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCJMo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgCJMoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:44:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5ED24695;
        Tue, 10 Mar 2020 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844262;
        bh=A2foWvc9jrT5bSCjJRdsWFm8MIww1d4V6xIALYzfqq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b51urLQXTq1/y5BjF4HSU07ePckFstOVd3Mp2UUjtVTBXlkiqYIvt3q4p4EwAnNS9
         PxIEqbloEi9gGzPWFqbgdF7SFCv4w8L+9HD7E9W1zsQBeEAmUM38ejtvaKRz+hPq/k
         vi+2Oifr+ntl5ytHimhSCgdaMxOGeUXn6QtQj5Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/88] cfg80211: add missing policy for NL80211_ATTR_STATUS_CODE
Date:   Tue, 10 Mar 2020 13:38:26 +0100
Message-Id: <20200310123610.726142764@linuxfoundation.org>
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
index bb19be78aed70..9823bef65e5ec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -333,6 +333,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_ETHERTYPE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PRIVACY] = { .type = NLA_FLAG },
+	[NL80211_ATTR_STATUS_CODE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CIPHER_SUITE_GROUP] = { .type = NLA_U32 },
 	[NL80211_ATTR_WPA_VERSIONS] = { .type = NLA_U32 },
 	[NL80211_ATTR_PID] = { .type = NLA_U32 },
-- 
2.20.1



