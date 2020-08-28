Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E3320848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="AzTa+G5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgH1DTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgH1DTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:19:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44883C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:19:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so4792310pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rquQ8wDF13kuQATC5YYw+dEo0yOaMMMchDgnI+iOso0=;
        b=AzTa+G5R6IdGurzzZWnNFoLZm2hiJ9IgYqhvoL0VcGsg7QxxeNMbbfyaHVacCzgXYF
         W+XXTMpllFfQIHsttRKcFToWcwilx2XHDyw7b+wydGIaWq9ZH/8zh56Sy+Kfuf6zauhi
         alo5eLMVmqYYoVG5qwlhfnBlGtUZJZRikJfSh2ilLIRGbRJ4/sEUMNebeC9TtDqGAU/e
         B1JovEd86mjoD5es4+Yd0v3CsFaroPOB4DlgKX4gyMVrIcwcOajsv2BKl+OB56z9FmoG
         pv9zEPwSY99cmu0/Uh5sgZzVy9jzKXDEBs/UT1q66lq97IKN3/fwsMsZBbCdVTJ+aFQD
         xUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rquQ8wDF13kuQATC5YYw+dEo0yOaMMMchDgnI+iOso0=;
        b=hzV9ME51oD2mOwBRIpJWlM01tuIqRafYcgOq7V5qw2OkwxhiCvwOy9Xb4Z9Ho44hIT
         N5juGZXNO31ocRVF+DIm/XSa8j/Gxz/+L7lXq/Bw2rw4d6VzUFFNzq9CmKGes2By7cbD
         Iw3BIDQy8SESurmDLYwwCTFe7sqEs9bdvjq72qGfQZdm57Xj92TqvLEz5xgD8MspfKZ3
         ExN220KXCLrqXFsELHqtUf2gq+5m9zx5Q47sM98c5lxaHyB9+fAxiuneA4AcPZ/2xALk
         E/NNoeoJme4YqTwyqEhHoo8l91TKaSOc9L/3RFkCoMyKS2e6wa6Zou8sYBVzIYZyeFZn
         qhtQ==
X-Gm-Message-State: AOAM53335vhmJXo76twJA17zJwhYrToJh3SYUFTRp31z7K0I4XfiE3eW
        fTr+GVZuh57GMHSdjofX/QiOrc5u0xR8Sx1V
X-Google-Smtp-Source: ABdhPJxGr+6JMkMbKKM7uaO5Xejh8aJ5GXOFdmUUjkBYxm2K/NqMxGwAez7uXc1L8O90ogjuzP3sFA==
X-Received: by 2002:a62:a203:: with SMTP id m3mr19057061pff.86.1598584786857;
        Thu, 27 Aug 2020 20:19:46 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 135sm4475756pfy.61.2020.08.27.20.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 20:19:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     keescook@chromium.org, mhiramat@kernel.org, rostedt@goodmis.org,
        alex.popov@linux.com, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] stackleak: Fix a race between stack erasing sysctl handlers
Date:   Fri, 28 Aug 2020 11:19:28 +0800
Message-Id: <20200828031928.43584-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the assignment of `table->data` and write value
to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
the other thread.

    CPU0:                                 CPU1:
                                          proc_sys_write
    stack_erasing_sysctl                    proc_sys_call_handler
      table->data = &state;                   stack_erasing_sysctl
                                                table->data = &state;
      proc_doulongvec_minmax
        do_proc_doulongvec_minmax             sysctl_head_finish
          __do_proc_doulongvec_minmax           unuse_table
            i = table->data;
            *i = val;  // corrupt CPU1's stack

Fix this by duplicating the `table`, and only update the duplicate of
it.

Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
changelogs in v2:
 1. Add more details about how the race happened to the commit message.

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

