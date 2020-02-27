Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AFC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9EC2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwjv1Nwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgB0Qw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:52:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43797 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgB0Qw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:52:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so92557pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jKuXW28lW9AH6MJSzQGV9UYY4yuB4lYRJ5J1zMaBeWg=;
        b=Uwjv1NwaKf76fG5FRij7JXauaQPfpbqstkQhD/y5gCIJM6+3Cw2YhM+OrFS3ynXgxr
         WspiJo1JoinDIE6Au8mqyzdu8VXgUHtqtuTHNlwTCGljExacZRMykTw1nwOpw6R2XOHs
         oKFHWKiAOovd3i38eULme3pkRf5JSULidWYjg3VoPXqKzAOsop2n68cuhH1WEdhjzGv/
         s4/gFcdyiyzNBtKoZ3AgsB6300ZKv5+HfyMngVZvwbVyDES/1Ved72HBw7CZfls8mWWF
         pXQMFjw/JnnOKYKVFt6wVF93c8P0aUyM+NsA0pAqJsbN4Pp0IosMvNDRvDHXXIulZ6/D
         LV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jKuXW28lW9AH6MJSzQGV9UYY4yuB4lYRJ5J1zMaBeWg=;
        b=LNczg4d492pOb5enw25xJaCUzQDf/Snu9PCLUz4yZAEBVuNHG5WxXPNibYWSuUB78Y
         VxmaykgFgGggp0MlVOWpqq7m/O6n9ym61twKr8pS8EAjS8MQFjy8KS9fFBU96J15Y9bJ
         jGgvGVM98szdHCFPHamAmcKPgXAODsMT5BAUPmZEOIFkSsD1uEag/xsblEmjg7hdtTrj
         BVF/h9RZ6LMwYGjN9IVzS7iDUDfVPEhxz6/YCkhs7E8xxBZ/WlhBJ8vzIRR83ubONF3+
         yQU7vGqFADLhPeJO889YYQ1p6hpFHfFIQILFWtqW10H3UfCBwyLf9BhMAZnspbr7/rXH
         qlgg==
X-Gm-Message-State: APjAAAVDci7FTrVHCxMguXzqcQRWRcRA/SdAhmw7uiZCLDeYZ8RRPnr6
        0wzUTzzMUcO9kBrbGLWgGi0=
X-Google-Smtp-Source: APXvYqzp79FySyqRZxGCCbLGFXVfMt6BS37hDZ0bUxPVRWjZiXDe0YNQLFU6f3/Z9wL5KtrtDhihjw==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr273591pga.167.1582822347390;
        Thu, 27 Feb 2020 08:52:27 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id 28sm7247498pgl.42.2020.02.27.08.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:52:26 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     elver@google.com
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] kcsan: Fix a typo in a comment
Date:   Fri, 28 Feb 2020 00:52:22 +0800
Message-Id: <1582822342-26871-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might clean it up.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/kcsan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 065615d..4b8b846 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 };
 
 /*
- * Helper macros to index into adjacent slots slots, starting from address slot
+ * Helper macros to index into adjacent slots, starting from address slot
  * itself, followed by the right and left slots.
  *
  * The purpose is 2-fold:
-- 
1.8.3.1

