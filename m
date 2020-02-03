Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E80C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B5F20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj3T4ug+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBCKlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBCKlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so17309190wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=Aj3T4ug+aflZfA/nndr2kZEys0nIS/FJXZ8B6qlk35IFcTzljTYx6rmI5QEEhLD+Gd
         z+2z2Yb2mvCpr6Dn0wLKBte7hgXAKtBEv82KTJAtWF1yJ04mOmDAxNx4lxS+pnRQXNgV
         9gmWmIqGPY2SGzr/8QdcBBZ2QzDFBDZIvEI1S3S3oV0rPj3cXeI+aJUf/knug3VO2LEl
         NeqO0tTCRjLcPuZTNl2ddKgY9z8jP7Lact1HeVd5XqAmlgS4qW8GmRq6iY89BJZDEp46
         QmjlXmGSvXMAudYWe2CC7+rtIfO/eMvwij1zB042iFmRS9mruEPACM93nWtlJnyCxy7/
         f2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=QbO4FXBtIDw/HkxG5yfSBZbo7qHRSLfzXZtPm1U+e/K9l/M7NQSLNeNUU4d1CaL3mB
         fozd+Emh5t0H+AU4VqxIGPbECVlYmhXCt/Y2miHhnWxM5c4KBiL/QIlMl36CTslqOQfj
         A6q6pERfkfSUnmdbPGy8krYEuGm6g25sv7HdRN/jWEMuIWkNPSahqMpUKZVM9Gl+qXtE
         L/ODAac63jobbPBWgQ/b6bQ/6mh7CE6jGL0+Hv2Xgg1UGHmwyxbuN4T9mQSoafr8V0RH
         0+2Ec0azVKTRJRiuc2OtHKsJ/YyObcLqvItSZs0nnRsxsU7/UbvyJClgBmxMz1pH3iTN
         HG0w==
X-Gm-Message-State: APjAAAXpSFqadcGb50PnljK1tfanpMOjH6b1HMSP4taMfvcC9EKkknNC
        MXXzUS5nU1Ww46hOActwo3Wirw==
X-Google-Smtp-Source: APXvYqwIl74eQZRgLB7TI/l05Ru0I7oZFprd4/KtPiEfF8w3nM7Yw7E+rPva3hmYBIIB+ZBpL9YVuQ==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr14690299wrc.14.1580726477470;
        Mon, 03 Feb 2020 02:41:17 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 2/7] block, bfq: do not insert oom queue into position tree
Date:   Mon,  3 Feb 2020 11:40:55 +0100
Message-Id: <20200203104100.16965-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ maintains an ordered list, implemented with an RB tree, of
head-request positions of non-empty bfq_queues. This position tree,
inherited from CFQ, is used to find bfq_queues that contain I/O close
to each other. BFQ merges these bfq_queues into a single shared queue,
if this boosts throughput on the device at hand.

There is however a special-purpose bfq_queue that does not participate
in queue merging, the oom bfq_queue. Yet, also this bfq_queue could be
wrongly added to the position tree. So bfqq_find_close() could return
the oom bfq_queue, which is a source of further troubles in an
out-of-memory situation. This commit prevents the oom bfq_queue from
being inserted into the position tree.

Tested-by: Patrick Dung <patdung100@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 55d4328e7c12..15dfb0844644 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -613,6 +613,10 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfqq->pos_root = NULL;
 	}
 
+	/* oom_bfqq does not participate in queue merging */
+	if (bfqq == &bfqd->oom_bfqq)
+		return;
+
 	/*
 	 * bfqq cannot be merged any longer (see comments in
 	 * bfq_setup_cooperator): no point in adding bfqq into the
-- 
2.20.1

