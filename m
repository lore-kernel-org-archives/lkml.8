Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BC720CC7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNMaDET+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGEOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 10:21:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726848AbgGEOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593958868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x1Iud6K4rDmN/FDvTgcgeFfvkXG/zP8SYWAjvE24riE=;
        b=SNMaDET+UdmQPgH2dUS1uuUuewyuiEcJYBunNy4j4WrBwhwgfivxKU96BJ/RZDYw+gg9yr
        pA3a2kxKTQamQo/9beGMAk91LtQIPDbHI+80naO3CUC36O8VCX3djAdoqw/PxzbAoGqec4
        F/OysolibrvPcfRQdCcFUUG+wQAiihU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-gRLlFLtjOwSIpVGArXnPYw-1; Sun, 05 Jul 2020 10:21:06 -0400
X-MC-Unique: gRLlFLtjOwSIpVGArXnPYw-1
Received: by mail-qt1-f197.google.com with SMTP id g6so26268545qtr.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x1Iud6K4rDmN/FDvTgcgeFfvkXG/zP8SYWAjvE24riE=;
        b=AK2F7/vdK72FFvBFJOrHyDLRML2sqsYUVhtBtO8Lvx4wZXM5bo6smuN4mK8/saW/sZ
         xhV16SRwKlNZAkZALwS+OhqRUy/2ujVhp7MNoCEk1+pU6Aiv6lnbXqsgx80cRdgQFCgI
         x5CuSYP1aToJw1CXd9sDhIp6W75PzQeoU4ctpcLJWUlTLlCy5yR0+wFvqfGbNNwke1Mc
         nNgv09I8ahPCXHLKHT8Hdi/5rhzhlbUN/TNP8UfJA/QXeuHHcx+c8rJsqHZliGK7j4RU
         jKu+XLzUfptBiq8Fhguzxve3tHZH8PFi7ZxMA9Vfe2y5pFwWElhK7gLxwIjD6apfVApE
         Q9Eg==
X-Gm-Message-State: AOAM531DSwQPjKM9Lxas5qutfp2VSpili1wgq2MhN7X+258vhXr0Ho6A
        +U71CUw0E8vArddLvEPg+snfpxzYSlatyIMZ6v7BsiJSz9c2qErdsCAzrBFMsc2nhpgkU7VyrJ6
        sbGGC/KUHmT7+IgzRNgXLag/s
X-Received: by 2002:aed:3386:: with SMTP id v6mr46763993qtd.187.1593958866372;
        Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqLT8l+X8+IIDTGgRATWGOoMqAoWnwXKY1M0zgzdVJt+57plmmrH1oECkWQan9yUcfCkA7wQ==
X-Received: by 2002:aed:3386:: with SMTP id v6mr46763977qtd.187.1593958866161;
        Sun, 05 Jul 2020 07:21:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d53sm16474232qtc.47.2020.07.05.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 07:21:05 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btfrs: initialize return of btrfs_extent_same
Date:   Sun,  5 Jul 2020 07:20:58 -0700
Message-Id: <20200705142058.28305-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags a garbage return

fs/btrfs/reflink.c:611:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~
ret will not be set when olen is 0
When olen is 0, this function does no work.

So initialize ret to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/reflink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 040009d1cc31..200a80fcbecb 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -572,7 +572,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 			     struct inode *dst, u64 dst_loff)
 {
-	int ret;
+	int ret = 0;
 	u64 i, tail_len, chunk_count;
 	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
 
-- 
2.18.1

