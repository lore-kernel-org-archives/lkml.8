Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57E724688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699571;
	bh=YZYxwVcxrm8qa1ZwVhg+IGCl5KG1S5MxBogZBbNJm8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CokA1ONtIZCCTMOIoeWd+W0gBvE5CWYBLTAxk9SbIt2G/MuBF2HtjTiDtdWH/NdBZ
	 a9G/ET8g12AxHjeQMwcemZl/MGuGzO0RsLJtFqvYBTLQ/X4dKD8nK5o1mtPOIqPpS6
	 G5iqMw8byvBJOP/Qf1/d01xlrKvStdot8Xy46tG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgAVN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgAVN0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:26:08 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1822467B;
        Wed, 22 Jan 2020 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699567;
        bh=YZYxwVcxrm8qa1ZwVhg+IGCl5KG1S5MxBogZBbNJm8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkbX01drtCdiFB4UFar8G+zq2YmGuofHeG3ZixqUbjn0wdbBt6BTJE/w7oE0JUxj7
         AjzKnUF0xvEbdXska6OP7iD7hCtXO/NQ7LSbqctetOiB5/qqdww6jrSB/W9Tt8wEpV
         gGCVWLQltdl09hBZysTJ9hyuQHRk5wsr5/zM0rew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e8a797964a4180eb57d5@syzkaller.appspotmail.com,
        syzbot+34b582cf32c1db008f8e@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 181/222] cfg80211: check for set_wiphy_params
Date:   Wed, 22 Jan 2020 10:29:27 +0100
Message-Id: <20200122092846.650947415@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -538,6 +538,10 @@ static inline int
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


