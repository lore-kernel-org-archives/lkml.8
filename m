Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E959C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4D8222E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPLtU7p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgIHPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgIHPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:14:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0EC0611E2;
        Tue,  8 Sep 2020 06:33:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so5094701pjg.1;
        Tue, 08 Sep 2020 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+6DdVEAHk114MPmsPvfVgelrnLIdaVwBYKUdcVJCimM=;
        b=HPLtU7p7+fZmlpVKGRJgNBrW9pG+Pguf8LaEfIFwclcfVemFqf6hA9KIkFKJbdA5N+
         cnvbL6ax5PILNSwlu6yYTmSXX5MHWydlptjrYmj/nhqNmMKdFK/XDIWD84yQU6bZ2HTr
         eeKLOni7tBf/Id+S5ooNK1z4U4n2Yo+xgTwDf3V9nWDGICmjNZ1NLZFDkBwp/CxKv5Zi
         rSQcp/aQ5m+S0CC2TOjS+6R6cV3WDdHohNaNexMB3SpT84nHcJr9iNKMl3mKOGh4xKw0
         tIR6Fmh3AuWLgCnVNoWVlMLZEbGh06xkPT66Bm9MQUVqOQdYTtql2qSEu593Nvq335Db
         avBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+6DdVEAHk114MPmsPvfVgelrnLIdaVwBYKUdcVJCimM=;
        b=c2qXAb3vUROEAKed+gCjgIRuhZ0Hclur9JOM/y9cgd16qZixIKof66VlZQNjIQdGhX
         151rWneR+2FnHSNMi3/icC5ronPHKYuIS5lTYS/6Fwv/suK67PtWrI7C222nANjpMURz
         8kihN8yLbXgI0H6GaGjyYL0SG8RFZVN1lAKVuxiD2y6FEyfCCprzIEDhOubcbER/oYrX
         35+tgNiryqFJih/1kuHwf6H0xcqn+BPcaJO023y2MIWdTfmbF/nO7HyEdN53s2zp/TBw
         MI35CFznZ1W1SJYDex8qR76bs17h99C3yS8gmp5s1EdG7BuaReGEWoFrL7qD49hc1rqy
         hZ2g==
X-Gm-Message-State: AOAM533YoKWXUqf9f2LhZR9sVN+MDXE/MwEd6wgiwSkHXReze6qrpq8H
        Yjgd3G5Qc4DfQPraaAnN2t4=
X-Google-Smtp-Source: ABdhPJwTXYa4lO4knRCcBa5iPixZ88RGvHy6LjK6qutEkRkK3Nn8SIimQXDpp101uHSY9lceL/4/nQ==
X-Received: by 2002:a17:90a:5216:: with SMTP id v22mr3918168pjh.97.1599572032159;
        Tue, 08 Sep 2020 06:33:52 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id mt8sm1324037pjb.17.2020.09.08.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:33:51 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:33:50 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] cgroup: Remove unnecessary call to strstrip()
Message-ID: <20200908133350.GA22979@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The string buf will be stripped in cgroup_procs_write_start() before it
is converted to int, so remove this unnecessary call to strstrip().

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b6714166106d..90ee7e73eb2e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4772,14 +4772,12 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 {
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
 	ssize_t ret;
 	bool locked;
 
-	buf = strstrip(buf);
-
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
 
 	task = cgroup_procs_write_start(buf, false, &locked);
 	ret = PTR_ERR_OR_ZERO(task);
-- 
2.24.1

