Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09217C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91902081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NR8c5r2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFLHKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3715AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so3718408pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sg9Lm/YutbN5f9zW+xwWCgs+u3zx03mdOZcDLL5rZHc=;
        b=NR8c5r2kPGt+D0zWH9UJWCDD2OEW7VmcBPlOHMIBQUrkGr2OhTIWw3v/sA0WFNp0l8
         oIiWwckAic2yAcXOdvffdq2BnAXDFzUrfjAyhGtO1RkrWvLtaUDvJGqmHnwK89xPw4BT
         R2hLzzQUUinFlUjDgqWv3xAcmzsKa2KRV4ijhNJspVA6jeqMLl4qRP4J6R84fvoO7Lz1
         SqynqQGZqLAn0ljjQ6Ep92AC/MEF0A/XtrgvXND0Hlf3h+MatmYKE5PFso3iSbtHKmaN
         /PqC7EDDJ1MCj0DI4vtRbnB9V7RvxNU43bhjmwj99gXsyea2BpM+xCVxZJkexlIhH9Xk
         dkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sg9Lm/YutbN5f9zW+xwWCgs+u3zx03mdOZcDLL5rZHc=;
        b=h1q1DsidrhskVQYaiM8pD8tQ7i0qgCmsRQyuuQuwmIGlMXOVKcBGaF6slZbzueImHQ
         lXEKUWQfFT8WjXiqxySbPsRpngqidz6a1+voz42emDS8RuOffODnlvgCkOH7fQZNhZ7s
         SikCmGIETxXuqxvM5BgMUeohyP+7m7+DHw9YE8gLibYjkaJq9mym7sZmfvRvsb+/5CJ0
         V5jmO2gkQii1AyZosWrFX0pwZCM0aW92vMHg6TawFJqxh/g3xfEydTVlyGXjPsexmqio
         FpKkwaQDiqrnQ0vmjylFdBGR3/Qj62VjiD4/7xS6OkVdzPb5GBB0M82coGCjjyNpA0e9
         S+oA==
X-Gm-Message-State: AOAM5327TTXRl1qaKLnlSiH9q2RBQj2LBuIgJDtcUZ65d5rbJK7Ioni1
        sfuxC9iSNAkxfYMx8ciMXxVBOQ==
X-Google-Smtp-Source: ABdhPJw5olV/JxsKv5JjihxwMCdrSsnylXvH/fyL7TAdlyOQFSWFNE+nFZeLa7jXucofV5WiDoQU9g==
X-Received: by 2002:aa7:85da:: with SMTP id z26mr10312343pfn.13.1591945812666;
        Fri, 12 Jun 2020 00:10:12 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:12 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] ptrace: Use regset_size() for dynamic regset
Date:   Fri, 12 Jun 2020 15:09:50 +0800
Message-Id: <8dbfdc77d4fac81a113ae2572ff9d01d9f155bfb.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses regset_size() instead of using regset->n and regset->size
directly. In this case, it will call the get_size() ported by arch
dynamically to support dynamic regset size case.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..946b2c4ec4fa 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -888,7 +888,7 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 
 	regset_no = regset - view->regsets;
 	kiov->iov_len = min(kiov->iov_len,
-			    (__kernel_size_t) (regset->n * regset->size));
+			    (__kernel_size_t) regset_size(task, regset));
 
 	if (req == PTRACE_GETREGSET)
 		return copy_regset_to_user(task, view, regset_no, 0,
-- 
2.27.0

