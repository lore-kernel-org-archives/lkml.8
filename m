Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE62CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DB2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=leaflabs-com.20150623.gappssmtp.com header.i=@leaflabs-com.20150623.gappssmtp.com header.b="mJipiPmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESApv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgESApu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:45:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:45:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p4so5695096qvr.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leaflabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SpKrU1LZHPDz7aM+ZRqKdIZt+rjg7Am2w59IOfBqqwA=;
        b=mJipiPmcY8YsiwBF7viBGc6FPfNozTL9S6e1V2gzodnopOOTOJ+uNbxF7ncPoo5r9R
         +hyfgU6U39JjKrZcg+XoLcEKYRQwnQq1GpJOCv4ZrtdzI0mGmsd+63/2DUF2MPheWuWC
         zrjjNsAHzA2M/ye9HNdKSCG3+X1q0sB2PjgdjGAID48Aj3zWJyHold9UG2QykiuUzXzK
         I13mriaXSN/c1yr4+3LIh8m3DxvZvpW8BUWI4xJs0gxWKikSSeCHPAFdoz59+aOLuarv
         vQo6eoN75WUaSFpoU7jrY0VSE3AIZGo7LdwrleAajQe5iaUJiLpeGgFzj9BcoIo7nLih
         ZWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SpKrU1LZHPDz7aM+ZRqKdIZt+rjg7Am2w59IOfBqqwA=;
        b=FXXj2pc979TxIAnGKKUXjpm69qFeyHjkT++1XlohfkHlQIOkLLf6XeLFUNYsWQVfA7
         4NFN2Grox+YvT9SyAbGlkZp8Du8Qmyyy2t+AMsoUKwj3pzEXRLRUTwHkmKqMn2wv+wo4
         AAWvUKqWkzJeDUMQ/9FbTNld7tG59JrpQBsOVBg2Fw+k8jm6JKN8aB1EWuLf3BBCfWF3
         /tvd9j+tlnhckllJUaV5MGry95fVd1/iT+RHgRJskqjRe7Pi4OZAV0SdTYa/tv55Igdl
         bc8vWtf0OC9iKcv8hEZApRVUECCWmxp1udAWCaqY/rsF9dsytlQaNgI0t67ZEfbTKCef
         zglw==
X-Gm-Message-State: AOAM530XiOzSHPY2p7wYaMV8YCmnkLhJEscpJa0A/FcQa3XB9JGVrZzr
        pBg65Mw3+mbpJqGlkDnkLVRjCQ==
X-Google-Smtp-Source: ABdhPJxJS7CthGaemy5vzNrIYxqUmcnmeIw1PYxtinAkRj5eHPysxhWhVtbrl4ENMVaMV5AI8t/yXg==
X-Received: by 2002:ad4:4f87:: with SMTP id em7mr9708469qvb.192.1589849149349;
        Mon, 18 May 2020 17:45:49 -0700 (PDT)
Received: from ubuntu-virtualbox.localdomain (209-6-156-57.s56.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [209.6.156.57])
        by smtp.gmail.com with ESMTPSA id l22sm9312392qki.45.2020.05.18.17.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:45:48 -0700 (PDT)
From:   Mitchell Tasman <tasman@leaflabs.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Mitchell Tasman <tasman@leaflabs.com>
Subject: [PATCH] staging: vchiq_arm: cast with __force as needed
Date:   Mon, 18 May 2020 20:45:31 -0400
Message-Id: <20200519004531.33158-1-tasman@leaflabs.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several cases where a pointer marked as __user is
(intentionally) assigned or passed to a non-marked target,
cast to the target pointer type with a __force directive
to quiet warnings from sparse.

Signed-off-by: Mitchell Tasman <tasman@leaflabs.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c     | 7 ++++---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index c18c6ca0b6c0..38a13e4618a8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -371,14 +371,15 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
 	pagelistinfo->scatterlist = scatterlist;
 	pagelistinfo->scatterlist_mapped = 0;
 
-	if (is_vmalloc_addr(buf)) {
+	if (is_vmalloc_addr((void __force *)buf)) {
 		unsigned long length = count;
 		unsigned int off = offset;
 
 		for (actual_pages = 0; actual_pages < num_pages;
 		     actual_pages++) {
-			struct page *pg = vmalloc_to_page(buf + (actual_pages *
-								 PAGE_SIZE));
+			struct page *pg =
+				vmalloc_to_page((void __force *)(buf +
+						 (actual_pages * PAGE_SIZE)));
 			size_t bytes = PAGE_SIZE - off;
 
 			if (!pg) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 2d3e114f4a66..28ea8c3a4cba 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1209,7 +1209,9 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 					/* The completion must point to the
 					** msgbuf. */
-					completion->header = msgbuf;
+					completion->header =
+						(struct vchiq_header __force *)
+						msgbuf;
 				}
 
 				if ((completion->reason ==
-- 
2.17.1

