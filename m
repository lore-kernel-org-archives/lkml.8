Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA5EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F8F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXfm4H/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgDMQP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:15:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F461C0A3BDC;
        Mon, 13 Apr 2020 09:15:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z9so3970748pjd.2;
        Mon, 13 Apr 2020 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=u4GYYbvmugu6odtFmJakra5ocWDIYsFmnxGy0u/KA6Q=;
        b=SXfm4H/8JXs50kwYd5Wg/n358l2DlMJ/iUNTaTx35duOTQR2NcMiZTx3yhCPZU0IJP
         bezC6enK5Lq+2yxZ41ku3+KK5xZQDecDnbrxTJQQtJSESdvxHG+Mu0xDz+9u081XZr9j
         g03fMikwYddl7rMMQNSr1UDEcadAyUQFk4Lb6x1lrVmw4TP984S2FAbR8qU2uHazQxcg
         R+mbBCBLoXeLrjAWesI8t95byhU17vQxxpO216i2aawrmB6kElH5Y7yNiluQUqWFA1cO
         cIEdDQXMOAMHn7nB3vCs9EknE9ZuAOodrPrlLi0a+yYqnTTPZJyDuOs1JQN7ieAvjB3Y
         3x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=u4GYYbvmugu6odtFmJakra5ocWDIYsFmnxGy0u/KA6Q=;
        b=SSjEoNe6x/l8cFt5iI/zH9cDTKCdRM4WzftKEDdBWpfQR9VN4aTrNb1Q3QmuEYFAr6
         6ubOQ1DH6PmoywblAqXLbqXneaDq9dOZ4dn+m/1ZCnm8LECkm4kwh4VKHDZAI13Jp1vU
         oMafG1hlA7BrgKqo+kjFmMQcdaKd8ulAxdOZnK7hC9iOsvW8hvq3CvbpDzUoqgcNBOsY
         XJsK66CM88yYAW+b1JpZth+zjqmA9WW/EBKgKhWU6YQblRCBL4dqgyG+m+Iso9Mn/usJ
         VOOlTNlymp+2fY6CcnONeW6Uy7vfhxHrKUcS02VKNzTZJx59Wsv0z/p+iXmAcF4sIVCk
         r+AQ==
X-Gm-Message-State: AGi0Publ+CM+3W44TIQc5zZZhHMXuqCbnNErBQxZFZEyA01TuN7aPpRy
        /jblLtkKaNg6XtmaoY7TlhIf4eUY
X-Google-Smtp-Source: APiQypKviJljNgaorxxlGoHxdOcT17MzQq27r2qlk9HeoI/SRh+yKaeq3H7yWUsHxuYgqmenqucqYQ==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr2055152pjb.108.1586794557064;
        Mon, 13 Apr 2020 09:15:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b16sm8902571pfb.71.2020.04.13.09.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 09:15:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] sh: mm: Fix build error
Date:   Mon, 13 Apr 2020 09:15:42 -0700
Message-Id: <20200413161542.78700-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  415 |  if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
      |     ^
arch/sh/mm/init.c:424:1: error: expected expression before '}' token
  424 | }

Obviously never even compile tested.

Fixes: a332976e0184 ("mm/memory_hotplug: add pgprot_t to mhp_params")
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b9de2d4fa57e..8d2a68aea1fc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
+	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
 	/* We only have ZONE_NORMAL, so this is easy.. */
-- 
2.17.1

