Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E18C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7B3207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Ogr/HPvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHVKKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgHVKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 06:10:21 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED723C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:10:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so675466pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTwiu9c1dVqpH8z4QGfR72DEW+cRDJ+GfuJCtpJxMEw=;
        b=Ogr/HPvI/gVs+V8fnXwDUp/AKQz0V9TGjm6DrCrXiDg3sqW5ggBdbzCyW0POVq66bk
         7FKILXEUXAqg4Qc1+1PjYd2/Uy3YPyd3UVyd1sZfTxl8qkyavcknMHGklolPqbgsqelX
         QRq6IQBM+lWC219TSqmX0uBMCjm9jdD3xzBHeiNvDzC99Z0tCVGlfg/n2CzEUarcnt1R
         FVMlQv90nTs+rIT5NeH21H5lcMGJic9UFNvsN6/DIlFqV7tDkT2w69He78FmIrvu0nlw
         kpIbgwKpBYB6Ez7Q9wZepT+hMNGvEkU6fbJHOVBzktbRNj43DuaD4zta7+7QG/oXX85+
         oEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTwiu9c1dVqpH8z4QGfR72DEW+cRDJ+GfuJCtpJxMEw=;
        b=pk1T7llsxMV6g0W5TT94Y4zFO/uZL4ZUyv9F829wRNLef1LrK2dlFzHVVFj/N1Ne7t
         MR9Xbi3OAA/MZFKNGNtwLddsPCcLYZrENh7SvMfYNd3+FwmjOumqEIkYWdtE1p8+tPmR
         6hpWWsLJyFlswKfWlN7NEtIGQqXfoqTUuq0p9inxGKDpHd/8M7DkAjthcjYnWuZCS/Wz
         1yd6L8YHruoeeqLObAb9nqV36JTnxOP3hYYC9MX4M4cKXuf//r4NYg/IV2exPRRfptOU
         RnkQlQzyLxTCFurHsQ0lLIl7jkqCHFk1EU5EAnahAf5j/Kj1ECJUVsA1F/4ovhPHQhrp
         IkHQ==
X-Gm-Message-State: AOAM530CDYJNbTcmdyHKjriZ0sIRs4mM3vR31081PQ2YCjHfecgC2ZX1
        r3czUF2jupHjdnKTwykiIjfxeaECLXDhAQ==
X-Google-Smtp-Source: ABdhPJz1Nyoq7K1LYUmzhQrvEDHk58cg6VncDVuE4QSzOeMLZav7EVHW/Q3U+6yTYoAFboPkraM2JQ==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr5865792pjb.226.1598091020358;
        Sat, 22 Aug 2020 03:10:20 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id c17sm5013201pfp.214.2020.08.22.03.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2020 03:10:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     keescook@chromium.org, mhiramat@kernel.org, rostedt@goodmis.org,
        alex.popov@linux.com, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] stackleak: Fix a race between stack erasing sysctl handlers
Date:   Sat, 22 Aug 2020 18:08:40 +0800
Message-Id: <20200822100840.62293-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the assignment of `table->data` and write value
to the pointer of `table->data` in the __do_proc_doulongvec_minmax().
Fix this by duplicating the `table`, and only update the duplicate of
it.

Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/stackleak.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index a8fc9ae1d03d..fd95b87478ff 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
 	int prev_state = state;
+	struct ctl_table dup_table = *table;
 
-	table->data = &state;
-	table->maxlen = sizeof(int);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	/*
+	 * In order to avoid races with __do_proc_doulongvec_minmax(), we
+	 * can duplicate the @table and alter the duplicate of it.
+	 */
+	dup_table.data = &state;
+	dup_table.maxlen = sizeof(int);
+	ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
 	state = !!state;
 	if (ret || !write || state == prev_state)
 		return ret;
-- 
2.11.0

