Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 01:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA4C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 01:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGgYDeIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHNBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 21:30:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:30:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z20so3459590plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=E05mkCqzXxrSsimqBbaoP3O/M0O9dQBUk8zaG5pF28Y=;
        b=tGgYDeILxzeZgEplMAMIclLaIGMqeG9VZ1gaOPf4CISzJaXUJoa25zj/V4opuoBoQx
         QIIrmdYNoKirdiD9xKafJWUJNZKx/EWdm8v/wVZCr8hqyEIB5JFG8sw9vI3zHK3eaTvZ
         i5uQIkrgq7B6ChUy1zPK6CiRQTUctvUL/eNUvubMgY5WbeFATBuQ/ZDopXtZG0XIw7OS
         bKm64zx+RtZ5rdxbAaSaeHLTMidEYj8yzxHln4DNGcH+Qo0BKFd/MI5iJZSQJzIm/wVf
         65PwYrv8ECwADSOqYlyEIDKDsVwi3AO6MZon78UId5jiCmeMzUdePVrOlDATWQr4sD/5
         bgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=E05mkCqzXxrSsimqBbaoP3O/M0O9dQBUk8zaG5pF28Y=;
        b=hVMuYdoBhRf2PHorJ/u1yFlH7j6M/mJOP8qCX8ZHcUzpsRLXD01JwRHR3Cs+2/qLXz
         kx/9Zb8b+3zqI4N2LLwNGdSnwk4h2vZcxqHDmZsLlhcTmuzMVpuKRMYs+i4p5mss2bwS
         cMh0ir4wSJwzha8Al6HmLPUkp4Hyw0CygQBoZvnVa8tmylBZiM8UECAokWm7NZJ2AEtO
         yraak2SS3iYh5Y2SJ8iFcjkZbHUGxUZ7fwPcHp4jZi2N4DvExDUz7KFiP5b20K05dqit
         8WCb7HMH9DfYKNcsjDT3uanjoCs5ma7Djk1bkYm8LoZDNw4v2VOb2HD0zkNLNVf6Q41j
         soFg==
X-Gm-Message-State: AOAM532K7LLCZnurk4ZmU0oiGCYZKBd2tmudsz097JOhl7ch9+qOUfu3
        83IpIDdg4Pu0rSfVy8gZI8dyOYHfi2I=
X-Google-Smtp-Source: ABdhPJwB0uG7rEidLNItw2kLQW5Ky+a0fQhuoWyBq9WMhF5fu2gziV9lR4WxbhmjaiSo+C427KKnpA==
X-Received: by 2002:a17:90b:1985:: with SMTP id mv5mr334455pjb.43.1597368619205;
        Thu, 13 Aug 2020 18:30:19 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u1sm6398306pgf.69.2020.08.13.18.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:30:18 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm : update ra->ra_pages if it's NOT equal to bdi->ra_pages
Date:   Fri, 14 Aug 2020 09:30:11 +0800
Message-Id: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file->f_ra->ra_pages will remain the initialized value since it opend, which may
be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
updated value when sync read.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577..5c2d7cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2470,6 +2470,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	pgoff_t offset = vmf->pgoff;
 
+	if (ra->ra_pages != inode_to_bdi(mapping->host)->ra_pages)
+		ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-- 
1.9.1

