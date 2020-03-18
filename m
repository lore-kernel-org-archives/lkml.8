Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B304CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8570020753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixZQfe2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCRRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:46:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:46:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id s13so28073084ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iGcvkcUngLNOfO6036cGPDGn51b4oPN22Ez00N6emqg=;
        b=ixZQfe2g+voe5aqc0HJY6gYLwCGURYPDWDwqHu4C9pXXBBJNn+sRQvB9xkB6TS6MOc
         lknr5rj/D2hqFqNeZYcjQM20BCUD8/WxS+1YBp64qPsadk1+NWdIF5koBZs2Q/LZWSJR
         zH69TpN7nnmMLPNdBggY7PhCz9o8eQ9Z3eDWmyE1LlUQyr2gdnzFhh6AtOx6dLnsP1Ur
         9bOtIJwe3eQYcJUWswcVzI6P49yHDcBkZeVcCyCY5v4gcYnUMB6Kvr46zrhU0Kh/8Kdy
         nCYVad+ahAg9+TvrPb3OXUi3P7X6EiFnukY6yCJLViRvil7OSPFU39emsXCEr1QPLnVf
         jD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iGcvkcUngLNOfO6036cGPDGn51b4oPN22Ez00N6emqg=;
        b=oEd8fprrL7HQeyXqNtst+BRC1il/hYLpQdxCw8Lh3dAz6tsyGs7yHeMefVVeWM6N7w
         VJ2aheYucOnmmbhcPeUoZDpoBdxWYpEvl7huP6Ah6VhtamsD+S7x9IfgQ2bQ+nnJM5RC
         /xSmwkh1+A+38DkndPokRb7f1otaVPGPz80OAQdvlmcAf7IXOO2B5RLV36EKUus1XS3L
         esDl50mPslOuztsObEkFOPhS3Sj6+RP3MQ0U+2N6mgY7CXAKGNpxPornu4RrqSzIv9zT
         /uwIfnT3J+6VNCTvI9Am+CYjJWoH6xwXmwOYlPhPWkL6V8ihynPlNUQ60jLx7dobuuN0
         5agQ==
X-Gm-Message-State: ANhLgQ3SiGk2qG79i0/eKIIrptM9G1MCNRp5jT1q3C6cHocxVSAtq2XP
        XuEH40ptahIgPn9Y27eAC4YUB2eV
X-Google-Smtp-Source: ADFU+vvYJdyk3WGbSLY49KqHn2Rtl+y4apk2nirXHeTkZNZxAweJsm8hXxKXYh2FzcS8gkbwNMyTEg==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr2948032ljh.136.1584553583274;
        Wed, 18 Mar 2020 10:46:23 -0700 (PDT)
Received: from localhost.localdomain (188.146.97.196.nat.umts.dynamic.t-mobile.pl. [188.146.97.196])
        by smtp.gmail.com with ESMTPSA id y184sm4928967lfc.97.2020.03.18.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:46:22 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/compaction.c: Clean code by removing unnecessary assignment
Date:   Wed, 18 Mar 2020 18:45:09 +0100
Message-Id: <20200318174509.15021-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 0 was assigned to variable 'last_migrated_pfn'. But the
variable is not read after that, so the assignment can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/compaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 827d8a2b3164..4576d6c5afb5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2183,7 +2183,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			ret = COMPACT_CONTENDED;
 			putback_movable_pages(&cc->migratepages);
 			cc->nr_migratepages = 0;
-			last_migrated_pfn = 0;
 			goto out;
 		case ISOLATE_NONE:
 			if (update_cached) {
-- 
2.17.1

