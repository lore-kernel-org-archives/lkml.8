Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8631C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD702467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686666;
	bh=MRAv4DjXurDeigszhhQyqJaSn3RD9dJlhVII68vR4vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qo4kBi6QiK8btHvV9p8y7OREYy9UZi5A5TemjRElFXxQ2HRXYzERTnF3MtreGYwv7
	 1UAmvPe57k0YkEsNA3nzG+cz7gWWwK/jzbArtvDFM0jpmFOkJuqUlW6e8GRgKdSddp
	 lxRmplQNZLub1VaFs+BEbTQqaPgzJQo554IMiizs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgAVJvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbgAVJha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5F92467E;
        Wed, 22 Jan 2020 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685850;
        bh=MRAv4DjXurDeigszhhQyqJaSn3RD9dJlhVII68vR4vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLPmnUyWj7o9Z98HLXfpsdtgKPZ2ufi7LY366c3SZg3tRhnOuiFp9LauoG/aw/reZ
         m9EUS8NNQX7ickDkHcSn7p6HoTia/9TYIQUcX+Bc2LVAQDOesIK2TGPvepucrHwKx2
         zzJk07PXjffoDiZPLVVlaDr70e2sLOCwenvxYQU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com,
        syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 89/97] cfg80211: check for set_wiphy_params
Date:   Wed, 22 Jan 2020 10:29:33 +0100
Message-Id: <20200122092810.521430774@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
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
@@ -525,6 +525,10 @@ static inline int
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


