Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC39C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303D124673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lLfi6cyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:02:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34779 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:02:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so535740pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gaq6NM5o+UM+pFOLAVDFZv0/RMH6toB+rITqZIOsMYE=;
        b=lLfi6cyMIxFEgNuwaGXNFp+Ts5Y/KtKR4ejCootJgO0ckrc0gRvgZ7nZudfZhjQoBI
         Q+Knj9pxcd3wq4LHf974POD/1Hnc1WLhh+kb4jKuK0df5rwk2iv1uTnor3Qx5iHTuPG0
         6K4HnlgfXU5h6k7AIRjJaZLVQOz6UOuRrMgB8+OAD6HMboRGS5lIdf7dZ6Ucih5+R7Yl
         Rog2cqFxxqxQHrPhjPpD2KCEN9OsLng7bSpIYqsSPDMDkmsISBpLWbLW2+0qZvzT1V07
         z5vq1ehXDwR3+F8rgzV7zl1I6T57sNXV+zO+rlE6KPJkoXVN3bBVWhpnq9CEo2lp5Kyv
         f3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gaq6NM5o+UM+pFOLAVDFZv0/RMH6toB+rITqZIOsMYE=;
        b=P2UUelsZHqNY/bvDy0gM1Csddmw62xD5ZzUV9d3rHrjodGA5OTMpf5MUkxQo5S52Q4
         8JrhBqYp/l6BMFvTUoVrmJ/VfH7wMKmzibNWghyu5U7osHdhi46b4R0wYTTIBLnNDO6S
         5ULLMaP5z5Vxb1Tp6axWEomX6xAL85xRDBxQ+WFKqMuB6da8NIJfJ3Si8ZlP10eFRfdL
         52WIBCmZbKA7dYdTNChaUUghfzTa8LiYhb7QtdOAuFxfHhiJffMkm6jB3IOoO+dM0LCL
         lQi36GaF1as4b38uhQgBpbRj9vxGVT2N+oVQcXBXcHiX+x0OboKZ4x0Hry0dPrkD/WBR
         dXIg==
X-Gm-Message-State: APjAAAVdLwzyD0ycRcHa/RV1K4UtWWQoy03rHB/8zn9xN2osY5357Xvz
        4LxNkKzcCZABpNcVTCHc1Me3sKCGs7o=
X-Google-Smtp-Source: APXvYqzL9QHxtjM0arkcSibiR2+WuYV6t3I4blhYPV4i/x7bknHVO47R8L1k55I3DTecqOfiHbMLSg==
X-Received: by 2002:a63:ba19:: with SMTP id k25mr30971648pgf.333.1582138921637;
        Wed, 19 Feb 2020 11:02:01 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2001:420:c0c8:1007::7a1])
        by smtp.gmail.com with ESMTPSA id q12sm345195pfh.158.2020.02.19.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:02:00 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     cgroups@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Serge Hallyn <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] cgroup1: don't call release_agent when it is ""
Date:   Wed, 19 Feb 2020 12:01:29 -0700
Message-Id: <20200219190129.6899-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older (and maybe current) versions of systemd set release_agent to "" when
shutting down, but do not set notify_on_release to 0.

Since 64e90a8acb85 ("Introduce STATIC_USERMODEHELPER to mediate
call_usermodehelper()"), we filter out such calls when the user mode helper
path is "". However, when used in conjunction with an actual (i.e. non "")
STATIC_USERMODEHELPER, the path is never "", so the real usermode helper
will be called with argv[0] == "".

Let's avoid this by not invoking the release_agent when it is "".

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index be1a1c83cdd1..b3626c3c6f92 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -782,7 +782,7 @@ void cgroup1_release_agent(struct work_struct *work)
 
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
 	agentbuf = kstrdup(cgrp->root->release_agent_path, GFP_KERNEL);
-	if (!pathbuf || !agentbuf)
+	if (!pathbuf || !agentbuf || !strlen(agentbuf))
 		goto out;
 
 	spin_lock_irq(&css_set_lock);
-- 
2.20.1

