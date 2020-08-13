Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F3F20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="YqAyRutn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMXlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:41:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C80EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:41:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so3530968pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNFaF9Cs3zWjUt9HSYNd3IiEMGEapz2J+4l77dIbrwo=;
        b=YqAyRutnch7+HUjZuopyDsiGfCywjczK9n7Y36NbctjUu+vKatqfahA/LreTvE5GWy
         jEaSQg0hkkqfoOh+4OP2I2bOYRwtjgbrQ/Rjz96FHaVhfLHbg0Akdly3BHhXIH8T3FAN
         2OBMDl60WBBGrqHM2DPvcl/ZxoR3kkxSBO+WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNFaF9Cs3zWjUt9HSYNd3IiEMGEapz2J+4l77dIbrwo=;
        b=GXSejSvZj5stL/RFnW0ohnSCqiHcRn2XLEi/ameAB5W11+mh3imCtNbxtNuChc4iay
         QKDqaVamim8fnvTHs4F7sf8QIRlBy7sK2Npb0sMXTTaOr1vXP30wGs1CW61scjbTA5pM
         wJxnAXq3COQ/tMvUlIz6kShlhfMWTGsZOVds9X/qa9bFU5uO7lcf+3madsjf77Zo7Nhb
         4YahoLBhGgMLp4tLS4biydWemMNBGYc2wsrisFWtKHlCcogCnWO8L+dCdvy29jmBRAix
         EEru/9RUis04EelfR5YQ4qFOf2d9YC5O+CvNzr3PfUQ9YpwRwojkefjKLujCiVbpfXcp
         1zcw==
X-Gm-Message-State: AOAM533bncg8SJLRdTUCQEQPV/LAhxWpqMn09eE6xefxPLa+Ag1otLx3
        aOjJRgx49ni2nBLESoCdxNboXQ==
X-Google-Smtp-Source: ABdhPJynsUbEReqNAmxYQBBQqGDLPisu8l4W6L65z9vkH//QubpuHH8fiKiN7JZht+DiFf8FYCNLOA==
X-Received: by 2002:a17:90b:c90:: with SMTP id o16mr39974pjz.79.1597362074860;
        Thu, 13 Aug 2020 16:41:14 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-c1ec-6af7-db57-0688.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:c1ec:6af7:db57:688])
        by smtp.gmail.com with ESMTPSA id n10sm6329937pgf.7.2020.08.13.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:41:14 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David.Laight@ACULAB.COM, hch@infradead.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2] fs/select.c: batch user writes in do_sys_poll
Date:   Fri, 14 Aug 2020 09:41:10 +1000
Message-Id: <20200813234110.2156475-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When returning results to userspace, do_sys_poll repeatedly calls
put_user() - once per fd that it's watching.

This means that on architectures that support some form of
kernel-to-userspace access protection, we end up enabling and disabling
access once for each file descripter we're watching. This is inefficent
and we can improve things. We could do careful batching of the opening
and closing of the access window, or we could just copy the entire walk
entries structure. While that copies more data, it potentially does so
more efficiently, and the overhead is much less than the lock/unlock
overhead.

Unscientific benchmarking with the poll2_threads microbenchmark from
will-it-scale, run as `./poll2_threads -t 1 -s 15`:

  - Bare-metal Power9 with KUAP: ~49% speed-up
  - VM on amd64 laptop with SMAP: ~25% speed-up

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: Use copy_to_user instead of put_user, thanks Christoph Hellwig.
---
 fs/select.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 7aef49552d4c..52118cdddf77 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1012,12 +1012,10 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	poll_freewait(&table);
 
 	for (walk = head; walk; walk = walk->next) {
-		struct pollfd *fds = walk->entries;
-		int j;
-
-		for (j = 0; j < walk->len; j++, ufds++)
-			if (__put_user(fds[j].revents, &ufds->revents))
-				goto out_fds;
+		if (copy_to_user(ufds, walk->entries,
+				 sizeof(struct pollfd) * walk->len))
+			goto out_fds;
+		ufds += walk->len;
   	}
 
 	err = fdcount;
-- 
2.25.1

