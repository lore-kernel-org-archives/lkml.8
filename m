Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4A2068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5noqC2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgHYKNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgHYKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498BC061574;
        Tue, 25 Aug 2020 03:13:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so6506702pgf.0;
        Tue, 25 Aug 2020 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4G4DuKErvOyDuzxBJkBN29qvlat6IqEju9q8dYOb154=;
        b=o5noqC2/wdN1xiBxyxbPmMEjlCjMi2LVdAcXbGV02KjTYzA7QlI5btsfY7Vb0a1s0Y
         X05BYoDoABwRV7phcc92WGFbjkYZD2bF+KPjwdtQGv5Hv3i3v3b0Yim6b8eJeYcXNNhg
         nORyo0zORlpYi9GIAGtRaURoh7ezcIQq2GCmCE1avYr3xOvCAKNpIYERrFuCm3X3FKjT
         Wjl/q0W6fDG8kTW9i5Xy+xl/Ut1doF/nzfrG16Z7mBrOHyye4aoooKZIwxeLvRK06c7X
         VUWa4fWnVcbHYNdJ3zdXnL/HDP9MGcwHOnpCsAah19IbVkE+OtB7AF5odr2nTiJ3LOdK
         DFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4G4DuKErvOyDuzxBJkBN29qvlat6IqEju9q8dYOb154=;
        b=bbmhaA7Imx9PhfaFeZDTTrPgeB04F+rH8UkQdy5qb2R5kMTykmuUd9gopaobyCSXF9
         BNKpep66rlzEwyhuA1fu0fUN+0QBWhLe2J4Q0WHKTZKBt+Uo/ZW92+tUzmiI+bOcxXcm
         0Q5NBWkEclRyA7QjV8LRfZ4+3fFnsKESuZNwlUY5/M6UgNBOlFsopTs3+0wUIUQdL9Vr
         Oneen3s4Z5J7pnDZ4XDxN1DfiX6kOIQwBmPgc8BeOn/vwTk+DFeQd6aiZ7lSsAcmIG2g
         xCiMBxeo1Qd/5p78Kjo9YBKmnCNpOtjWq2WCxXqs+gnCdHRauWVq2I/2ACly13whZfNV
         LZKA==
X-Gm-Message-State: AOAM533xLsJ78UX0b48W6KY9rQdRKKWnZSNrqfbsCugG+HoCaoDWCZSv
        uGYm3pjdjX3W9BlPJqaLf5tGuLniYC/okA==
X-Google-Smtp-Source: ABdhPJykSPKR3ufOXUEpAP3gSyIGOrl5nn7vYRLrcu4IoV+QqvdYqm0nFNVOUdXrptMslOlcieLiCQ==
X-Received: by 2002:a65:498f:: with SMTP id r15mr6391268pgs.410.1598350427484;
        Tue, 25 Aug 2020 03:13:47 -0700 (PDT)
Received: from panther.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id y1sm14303925pfl.136.2020.08.25.03.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 03:13:46 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH] panasonic-laptop: take over maintainership
Date:   Tue, 25 Aug 2020 18:13:41 +0800
Message-Id: <20200825101341.5699-1-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.17.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take over maintaniership of panasonic-laptop from Harald Welte.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b186ade3597..3815ba053136 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13039,7 +13039,7 @@ F:	include/net/page_pool.h
 F:	net/core/page_pool.c
 
 PANASONIC LAPTOP ACPI EXTRAS DRIVER
-M:	Harald Welte <laforge@gnumonks.org>
+M:	Kenneth Chan <kenneth.t.chan@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c

base-commit: 6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a
-- 
2.17.5

