Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B98620781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSicE/N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMILd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:11:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:11:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2421947pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=wAiLcnSB5sATjldGL+GyGneCafWikkuMCjLyf4n50Cg=;
        b=lSicE/N4STsmjew96O7TymkPh4k9iZ9jODJlSEHdEQ2HibL9sD7rfPSZXJCJkV+4Gl
         p6HYCEtiyViP6+QP67IevMsutWM/sfkjLxD4DSU5handoBJGFHBDtrwA09fJKlBcsc2k
         JAlNFbat2xw2PRlm7tDXiFWDUKNWVsUp5dIdqZSGTnkrJUOJQdRj3l0AEdsxTwqvEhRb
         0gqe5Ncyg4HOm4PlLXkd6mC2Er3cFn8qGuv4Q0MdGL32GiERhFDf2LBK0kBr8OyuXap4
         iAuetOSfBijbQ1AWM2Ep3F08fx0grAUJB8oupyYnnn6a6B7YqqL+dUT6+Mxl5d2lBkNQ
         KGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wAiLcnSB5sATjldGL+GyGneCafWikkuMCjLyf4n50Cg=;
        b=gb9e4TjP7OFc+cam7E1E4m8y4sruWsbN23V9/nGxvWxZgchNwQDVwl3QCwQcQPyiym
         J9qsIqyQ6gf3imXzjjKm6GADkXqq358XYrnfTE9mcWNVgzJ7Nt0LO5MgYUrOX+beYZWC
         UJo6tXDjf09rGfPZG9Hff8gC18/PmoIVlhs6okjGn8HpJr29L7kENjH/u7W8N8gYK1Qf
         wSLTFdT8AAetPBxFC4OEVh/M8zP+lY7fiARnPTVfvAXlAbzKaG6aQq1rjaLTvMZ+ts97
         lUL9wrey8xh+h9LlbtnXmEzZ6lIYF9rU8c4zemsE6GlanxVQMxUNChCuQ09QqODH53RC
         lvQw==
X-Gm-Message-State: AOAM533Nc6D/ubTA97Rn3XvvzicG5mTYXqq+9mK70KN1qWtbympaULwi
        X4dGDhkCb0w/ZjXXt5luRMx519vN3Js=
X-Google-Smtp-Source: ABdhPJyAzMYh/Gg9GkOIskWcpnu6269XaG/I3Z0yIn7KO/JvVuFusQIWhcDQnBmjVsNj1KBsU5rAhw==
X-Received: by 2002:a63:1b12:: with SMTP id b18mr2683225pgb.21.1597306291260;
        Thu, 13 Aug 2020 01:11:31 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 205sm4801139pfy.9.2020.08.13.01.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 01:11:30 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm : using bdi->ra_pages instead of ra->ra_pages within readahead
Date:   Thu, 13 Aug 2020 16:11:22 +0800
Message-Id: <1597306282-29927-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file->f_ra->ra_pages will remain the initialized value since it opend, which may
be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
echo xxx > /sys/block/dm/queue/read_ahead_kb).So having readahead use
bdi->ra_pages.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577..259dcfd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2499,8 +2499,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
-	ra->async_size = ra->ra_pages / 4;
+	ra->size = inode_to_bdi(mapping->host)->ra_pages;
+	ra->async_size = ra->size / 4;
 	ra_submit(ra, mapping, file);
 	return fpin;
 }
-- 
1.9.1

