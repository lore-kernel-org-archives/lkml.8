Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA0C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837A20772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmUQdBDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZHCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:02:47 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33261 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:02:46 -0400
Received: by mail-pg1-f201.google.com with SMTP id 33so4028161pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nanV+r4IHUqeQck6GgJYnAFKZtppjERc1ou3yY6xyBw=;
        b=LmUQdBDejAspO3PcKB4zLsQohmBqVwbHT1UyMB4iIUpqCUBTZzktu8nyeHvZTaA0hk
         oNcJc8OCZPgCQYxD8S3se5Z/E7sNU55V4gpf3s1nQW25tLvnWaQ5YBqve2cWOWHkS+aG
         Em39wZpEZR5j1YccH3IFocIDstDiIZLbDk7eMXJUGSDMqexG99DNX0yEYA/xi7i/czs6
         +u8luaxJgpwJI+KkhuaQPzaMEAqA1PhH4+MznL3LfX/vUMVivuDTeZRIkYG/5h/hHDE0
         n1Bo5gVT9ckfPbuTfj2cHU1u9W78Rm7Wa7GKt3guIrHNQSg85+W+CKfC2WIxiTHhwdag
         /yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nanV+r4IHUqeQck6GgJYnAFKZtppjERc1ou3yY6xyBw=;
        b=G+Jr0+lq/gCBNuuMAXPcsqLyCItxTIm8Wj9zVm0KUnh6g9IEEtUCWfMHkykZU5YRA9
         MBr7c7qjHGVZzOfsexw6ERYLo3SQMI3V+RjrE9yZpBLiSPGcec1JwcQfgHdSs96cND+i
         wPyoUm7wMtbZ9erXmQrOpvQ0ThuIwgBahWdUTTO34SHXkL5U5iJqUj75VjFpM6Za18/b
         Z5RmXrM1oQMhPbHnF33P0tH+rX2BTc8IhVuGmSiqfK8Pwgj51FlJkoDGs1fPCXwW3RXt
         BmHXMpH99pTXJs49XS3SW2gDdSkWgOKETgss1If+5DUw6PHovowRGQ0GMhJFO56/R9BY
         2XEw==
X-Gm-Message-State: ANhLgQ3t4z7q+WeYbDRi4IRcLT6C9AGdd0kIp6iWFIQ2GjGmZrG+/hRZ
        xdbbFKTINkwPxRFGDmRSFgVMA4ljcKc=
X-Google-Smtp-Source: ADFU+vvuAUqsuHn1JjDrf5Rb1rHNy26IhDPkLLb/EupUwsNN9p2UUhFu44cCHrPhifWwqyRof5N9SY1oKWs=
X-Received: by 2002:a63:1517:: with SMTP id v23mr6799206pgl.89.1585206163502;
 Thu, 26 Mar 2020 00:02:43 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:02:30 -0700
In-Reply-To: <20200326070236.235835-1-walken@google.com>
Message-Id: <20200326070236.235835-3-walken@google.com>
Mime-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 2/8] MMU notifier: use the new mmap locking API
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/mmu_notifier.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..2f462710a1a4 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
@@ -277,9 +278,9 @@ mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
 {
 	struct mmu_notifier *ret;
 
-	down_write(&mm->mmap_sem);
+	mmap_write_lock(mm);
 	ret = mmu_notifier_get_locked(ops, mm);
-	up_write(&mm->mmap_sem);
+	mmap_write_unlock(mm);
 	return ret;
 }
 void mmu_notifier_put(struct mmu_notifier *subscription);
-- 
2.25.1.696.g5e7596f4ac-goog

