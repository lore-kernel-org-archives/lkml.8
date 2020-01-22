Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D37C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F9524685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685967;
	bh=yUzz3pdxXKQpwQTWqhRKVlEnaLWaycXtq8Of/BB7q7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMtKCQH28y4eOisX8z2haMjwm3jYH57fHY/e/gP5ALfIWZwQLtTQ3Hi98BTnIyuJ6
	 nwCtEWDGfCoTaD/bBbq0Dyr76J6KAnPTfRwXeqNzwCu8V4ZaR8fyUlvourh2HZUYZy
	 FhlZqJ57p5/lkVYWiuQSPYtaUMxTJJwfZArFAjf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgAVJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733200AbgAVJjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBEB24684;
        Wed, 22 Jan 2020 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685963;
        bh=yUzz3pdxXKQpwQTWqhRKVlEnaLWaycXtq8Of/BB7q7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeE8ann9pnb/ugWsMyBO9Me7Dunhhhiub6i2VOB+qKn6eEDX83xGutxXJiHSb/sSk
         Wr7fCkt3FilK9Nq8Vj8deV8WTBxOzuuitrf8+obP0wlPbbFI5H+iSwQOUJhaVnCapY
         wZzj1Xv+U14HDS5yW2pGRDSA8QOi9zco4zCXXVwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com,
        syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 53/65] cfg80211: check for set_wiphy_params
Date:   Wed, 22 Jan 2020 10:29:38 +0100
Message-Id: <20200122092759.031820409@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 24953de0a5e31dcca7e82c8a3c79abc2dfe8fb6e upstream.

Check if set_wiphy_params is assigned and return an error if not,
some drivers (e.g. virt_wifi where syzbot reported it) don't have
it.

Reported-by: syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com
Reported-by: syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20200113125358.ac07f276efff.Ibd85ee1b12e47b9efb00a2adc5cd3fac50da791a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/rdev-ops.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -537,6 +537,10 @@ static inline int
 rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
 {
 	int ret;
+
+	if (!rdev->ops->set_wiphy_params)
+		return -EOPNOTSUPP;
+
 	trace_rdev_set_wiphy_params(&rdev->wiphy, changed);
 	ret = rdev->ops->set_wiphy_params(&rdev->wiphy, changed);
 	trace_rdev_return_int(&rdev->wiphy, ret);


