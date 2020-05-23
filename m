Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9330C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FE4206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Bfj3quPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgEWEgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:36:00 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33232 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387446AbgEWEgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:36:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49TVsp6Rhtz9vC7q
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 04:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C2A8xUhVViGp for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 23:35:58 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49TVsp4mjVz9vC7g
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 23:35:58 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49TVsp4mjVz9vC7g
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49TVsp4mjVz9vC7g
Received: by mail-il1-f200.google.com with SMTP id x20so10341454ilj.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=59IOA4EHTXG/cQ1Qz1x8tvuW9fOfgyA7murXaOMTCPA=;
        b=Bfj3quPug5YHNnQQoDT4a2v0aT8bz3GYeJ49kwBLUQUFFmIu1z8Pl7ObqgvasBQQu9
         YrGIIA8Pe2jIvj2/QdtyH85jKcMszGf1xnv5GULcH+PHxkjJTSkGED0IGWbsAhrbEE4i
         aQgSQ4LL1xFhx7M4Ab2iSZ5choNhwidJb8ka+asHEhduKiLcGpZsjHAluttZBHvx4zXv
         vpGirclw9czwrfOk6gLRpTQ3zyNQlB8qvjHoL/xWVYqg8GgYBHuYcUHQn6H/Lxv/4f3S
         EoSiNHtxpbfxqAZ34/x1qlBgcNHyL4cRieOdn6BP35EEffekh/CcWcWO0nSNKkN9ZQHl
         P15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=59IOA4EHTXG/cQ1Qz1x8tvuW9fOfgyA7murXaOMTCPA=;
        b=Eb+UPnDlRbqZHQkYEjJnNPhrFi/LtFRSx+pRZxLsEzq7Wcd1XrpVRUfcbvakxLaDhz
         Os0vdqulLjQd8tMpfZSz5v3+ZE0VEJlmyfp6jixkBZxXojF/DxrXDTFdqWKji8zXfcSp
         oTtWXqWQT2jWWUSrUVOpLZJGYget7TYrg6ZEyLo/x6lAHxOwgxbEGTrpQEm+3B5cupVF
         g8zmC5ithaYSw2w9CeZ1quukZQz0lfMrmtzK3i/Cz41N5kFuT/AHyi1oPAN0tbRxASiR
         lYxA/vE43puZ7aWmOLgho9UjD7Kiqwrrh84yWdMSYczTCfSX3b+wZXdtSuqIaoeI0nyB
         OQXQ==
X-Gm-Message-State: AOAM531Ijf/rZ3zD4pP2yUki+jYymi5tW8jvCqkGd1EgXQ6ViMfx/tzt
        /aTGBRnDkiRVh2YWC/UhPIqbTD70g+HdsFIK09AzKH0cQ8qJ4fCQn2jXqn2SARcl+Bg86Sz1nXk
        +EPNEtwgB6nk0Uho6p/h2q64fuhlb
X-Received: by 2002:a05:6638:84:: with SMTP id v4mr11569847jao.110.1590208557927;
        Fri, 22 May 2020 21:35:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAk0KKZbfeysdmNhrkQCvxdZEb8FAAlHbkBFifbcu8Y9DHAHk7/AZ+SpXK7lsQ4gSGDLV+1Q==
X-Received: by 2002:a05:6638:84:: with SMTP id v4mr11569828jao.110.1590208557695;
        Fri, 22 May 2020 21:35:57 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id e13sm5446798ils.27.2020.05.22.21.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 21:35:56 -0700 (PDT)
From:   wu000273@umn.edu
To:     hubcap@omnibond.com
Cc:     martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH 2/2] orangefs: fix double-unlock issue in service_operation().
Date:   Fri, 22 May 2020 23:35:51 -0500
Message-Id: <20200523043551.9756-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

spin_unlock(&op->lock) is called before calling wake_up_interruptible().
But spin_unlock() was called again after a call of the function
"wait_for_matching_downcall" failed. Fix this issue by remove
the second spin_unlock().

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/orangefs/waitqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/orangefs/waitqueue.c b/fs/orangefs/waitqueue.c
index beafc33d57be..3981507ad920 100644
--- a/fs/orangefs/waitqueue.c
+++ b/fs/orangefs/waitqueue.c
@@ -152,7 +152,6 @@ int service_operation(struct orangefs_kernel_op_s *op,
 
 	/* got matching downcall; make sure status is in errno format */
 	if (!ret) {
-		spin_unlock(&op->lock);
 		op->downcall.status =
 		    orangefs_normalize_to_errno(op->downcall.status);
 		ret = op->downcall.status;
-- 
2.17.1

