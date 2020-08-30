Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55953208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="gvzb+apb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgH3IMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgH3IMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:12:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0912C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 01:12:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e33so176913pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAgUhU0xjT1+DLGdJJ9Io2w7gWNW2HWrdKE+ZGxRNCs=;
        b=gvzb+apblsXdy+1M5TBqxV7Twl+YcfSKwwo5mYxlykEA/w8PJVptt7yTiBK/QpELJ7
         zs8/CRbvBgFQ8SjKuUOEAbI6LpTIppHS+1Wm2dpE7HJQdLTRBt/oQMkMH50MSvsrlsrI
         nroNg8ebIVNt6vg/Gzi3De2tVlu6QDKyO5n5srYMA8vZujTlMQpJ/SSBQPcAZ3L/SD69
         YbRE0qioz+siivYxt0Psh1zQZhtZ+k1PuLVANuOS31lvlSGsJlu5KdfqJ21PLv5JGw//
         WxaWAYz9UtvhDc3r51R53lzcPYZq1DDKaIcrbYRnKt1YmhD8l2veQE4swsXioCcinIzc
         Ndnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAgUhU0xjT1+DLGdJJ9Io2w7gWNW2HWrdKE+ZGxRNCs=;
        b=BkxaBqo5XlyW860pQ0H6xLRlbo64q2b+T5EV7ETn7K3KQMpG9Yx6a37zLctVRcrvKL
         MN7cOiw+zItfawJ/YGINnIe5GSdYT2BK7SZH2egcpZXbF9dYjuFvMp5zDVPK95pyhWHW
         VPSN1nVvO6MakhmG0E5W2PfXK8/eX5dq2RXhri0AzmfFJ+gIiMUbW831L/QeGcg5q5/m
         FW43mblA8MPthsOfI+a2OVRR0XWiNxpbtCKgOE0qhyb0gj+vvwl5h6yceW86rqGZvPNx
         cCafzLefwSo7JyONyUdYaCoiV4BC31MHc2amTc62+iZpgetZuOy9RC/L1VXCwpINq5xC
         UlBg==
X-Gm-Message-State: AOAM531O1cUl5sth8CtzhpyBMerI2nYa7GeqIfd7qBcQAmgGDpwJf0Aa
        3ycY1nmJvJCOm0/zdpJQeFZ1Dw==
X-Google-Smtp-Source: ABdhPJypoJjBgCqz9e10W3z+JWUgVWhMpjZgA07gs54eevc1BVzaC4eWnjTMPayn0eBWw/mmU+w47A==
X-Received: by 2002:aa7:918d:: with SMTP id x13mr5150473pfa.292.1598775138444;
        Sun, 30 Aug 2020 01:12:18 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id g75sm4455669pfb.57.2020.08.30.01.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 01:12:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     naoya.horiguchi@nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/memory-failure: Fix return wrong value when isolate page fail
Date:   Sun, 30 Aug 2020 16:10:53 +0800
Message-Id: <20200830081053.64981-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we isolate page fail, we should not return 0, because we do not
set page HWPoison on any page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory-failure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 696505f56910..4eb3c42ffe35 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1850,6 +1850,7 @@ static int __soft_offline_page(struct page *page)
 	} else {
 		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
 			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
+		ret = -EBUSY;
 	}
 	return ret;
 }
-- 
2.11.0

