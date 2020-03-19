Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF40C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1C20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624729;
	bh=N/kmiG6KBAOmtJ7wU3x/0toCaw9RCRADRZ2syxHQ07k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7Vt6PZgNHErjbgEGzi2ZmM0HbDYvJgF4QpNB6tFFkVAiBfL1hyHtluNXe3m53FG/
	 fMHjnQexy8XePf11LLrfyK4fSI102HiiZugAoPJ8+C/546Sob/czvbOXgoDcQWCak3
	 uYRzzl4Pe6JpAZ88G9eQdPEYFHXqbqrWeL5t6MD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgCSNcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgCSNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:16:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F1A20724;
        Thu, 19 Mar 2020 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623798;
        bh=N/kmiG6KBAOmtJ7wU3x/0toCaw9RCRADRZ2syxHQ07k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vlvz9ZVWLom9bVGlSrQTiHX0+0aaEBpe/qAyzZ6qen5LSrBjVs0dsky6WSz25tL9R
         onlAJg+rZLaKSwo+HOMBqdef709JUaXfdDhOhqOoOd64zWhTnZ08fCWLrMhQiXxSN7
         aVqde+4TbvuYhwwitcyVgL+c73+nQc8XtZTVBXsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 57/99] nl80211: add missing attribute validation for beacon report scanning
Date:   Thu, 19 Mar 2020 14:03:35 +0100
Message-Id: <20200319123959.097578454@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit 056e9375e1f3c4bf2fd49b70258c7daf788ecd9d upstream.

Add missing attribute validation for beacon report scanning
to the netlink policy.

Fixes: 1d76250bd34a ("nl80211: support beacon report scanning")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20200303051058.4089398-3-kuba@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -347,6 +347,8 @@ static const struct nla_policy nl80211_p
 	[NL80211_ATTR_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_ATTR_WOWLAN_TRIGGERS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_STA_PLINK_STATE] = { .type = NLA_U8 },
+	[NL80211_ATTR_MEASUREMENT_DURATION] = { .type = NLA_U16 },
+	[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY] = { .type = NLA_FLAG },
 	[NL80211_ATTR_SCHED_SCAN_INTERVAL] = { .type = NLA_U32 },
 	[NL80211_ATTR_REKEY_DATA] = { .type = NLA_NESTED },
 	[NL80211_ATTR_SCAN_SUPP_RATES] = { .type = NLA_NESTED },


