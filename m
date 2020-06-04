Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0692420829
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PHtn+4sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgFDPEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgFDPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:04:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DABC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:03:59 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so6301315qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bm9LXKRTRAn4ksM+zTELl5Ncxt58Msz6smAUvbLwlQg=;
        b=PHtn+4sW9oeaaN0KqpSdfnAiSgGTHt2Z0UKpbIriHyOnPUd/JHuaYZWpEdpsIaFaRv
         YvPtCcDdD0ZUErBQIlaSncoBZYl91ggI8sYHqzw9bR/TZvqy6AN1xRyhmdNp28tW459k
         zc/ltDhaD7rxGMkMOSnh0JlRrzZf55P5fXoANCNcFe4PK35L1PIIi9SpADQrXNR7/ghu
         MRG8AChv3Sipl7YoDkSMO58dnI5vaMxvWgOk5kcvZCaGXGfX1ivy5tr2caHeF+hJbc9g
         4QqkF2HCIZX77Q4uhgsSWHmxgVDjsPrrSuqruV5LzG4O1WK1yxB7R9xOKCdHrDOgU+UW
         UL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bm9LXKRTRAn4ksM+zTELl5Ncxt58Msz6smAUvbLwlQg=;
        b=n5syVOTzdwXaRB7ZE/w32zM+DVp4TulIV1tOQvbtZt5Vy4AGa16orZHT8gPhf2WqVq
         jO8mWKloVzTEsqoBB/vxJOAGPf8YOO86zVFM8hT4piUfNh2LWpl2AfbjLoi+cSghdVSN
         hOvY4VlFOvKgKqgd5vH5gT9qFFZ83DPvsyPTDzGcf0nDFsfiRAF5e9EHBow0L4wWpQco
         2e1MQQcwN+I5mJTT3RuXFONKM0o6Ep0YqvwxrzPdbI/BMVpaGVF5zf6UrP38yOGWXDlj
         c2z8zI7XcFjSnaJUxXLc3PQdV6GCzU419B3ZmT98tmJ5JIm/+rCOVMBanoTiKXItFICP
         PNhg==
X-Gm-Message-State: AOAM532rl0beKh4m/eYVwSK7bj6ZtkWrEd7LC8k0Yf/drUBAZ18JvmcQ
        EopuIXr4XPH8la4vHTHkov9IEg==
X-Google-Smtp-Source: ABdhPJxpiSlyIl8wDEUjWVCyb1O6lDkKyM6ZF/D0TVbA/KKrBsj4VNmpQA2CqhuZBuHgzP9j4gjV6g==
X-Received: by 2002:a37:607:: with SMTP id 7mr4857940qkg.385.1591283038460;
        Thu, 04 Jun 2020 08:03:58 -0700 (PDT)
Received: from ovpn-112-233.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 205sm4560403qkh.94.2020.06.04.08.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 08:03:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org
Cc:     mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] fork: silence a false postive warning in __mmdrop
Date:   Thu,  4 Jun 2020 11:03:44 -0400
Message-Id: <20200604150344.1796-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit bf2c59fce407 ("sched/core: Fix illegal RCU from
offline CPUs") delayed,

idle->active_mm = &init_mm;

into finish_cpu() instead of idle_task_exit() which results in a false
positive warning that was originally designed in the commit 3eda69c92d47
("kernel/fork.c: detect early free of a live mm").

 WARNING: CPU: 127 PID: 72976 at kernel/fork.c:697
 __mmdrop+0x230/0x2c0
 do_exit+0x424/0xfa0
 Call Trace:
 do_exit+0x424/0xfa0
 do_group_exit+0x64/0xd0
 sys_exit_group+0x24/0x30
 system_call_exception+0x108/0x1d0
 system_call_common+0xf0/0x278

Fixes: bf2c59fce407 ("sched/core: Fix illegal RCU from offline CPUs")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/fork.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..5334efd2a680 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -694,7 +694,6 @@ void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
-	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
-- 
2.21.0 (Apple Git-122.2)

