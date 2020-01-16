Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8E6C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AD92081E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579219215;
	bh=G0283Q8hMHKKF9racdanh0IQ0iAR8ib1BlB2aq6qRVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pEIO6tCLlYpQJiOeAVqXjdliuOHxtH+HGOyc4trZ7HlwcaKgiA8MaMz+gbOjxcBfk
	 w9TJ4fMWCQbnttwc4q/+bFl9Vq8ZrjVynC09M6sUzNpJkHtFf7PebtgGV4rEgyzjSJ
	 /CqOZner2Nx9Xka5bzNQZ7/91DWqJyFZzcDycWB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgAQAAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:00:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45917 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAQAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:00:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so10708471pgk.12;
        Thu, 16 Jan 2020 16:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1DNUZeta8kOxobeAib3DAPo7bHpJ+/lYiSVOVvzyGQ=;
        b=WJ92vaxECeagQOoGBDEDdM7YktShjAd3nesXf6/7YuFwM6gwIC9ZFcYHpMBycQy7jx
         OUb6ZmuMxApgyI70xP3UPmBYhUswrWydKD2x2V87vtcno4GaGsDWfeYRUlk/N5fgDIbI
         Zpm4x36fZlEVZWG12IdYFGTH0OLNz/OfQ3SWxDGyROi46G2CMokgMt4TVXtHGhSu2a7y
         lPGaSXSNCIfzqj1NK3+8UKA2pg00tSRYeWh7byCutkbIiE46Q6cY6a3euF71NbDf4DSQ
         d5h/tvIqpEZB647toINcAtPUuBQBxyxOhSKaowiq4YWzqkb1MEwB/HMFrjPvrazpX9FZ
         q7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H1DNUZeta8kOxobeAib3DAPo7bHpJ+/lYiSVOVvzyGQ=;
        b=YB3vamL2SwdLc9txdNCPuc7ojLm53EgVmKwGUviOxlfMwUmBl6JT3vl1G7M4eimeyk
         t/k27WsVD2ydru9mBjXO4v9njulm6UcXsXCHijgQp4hQM5yxHZ2aZ0wKq10Ir//cu5FO
         6rjDFPA+oCPIGH3pIfTfy5LeYUadz8UKmF7RHkt9nSZtSnjfzHSX9iVI/QDrrwqY8hNJ
         y8vjOBdwAk8Cf0lnbA6uBVKqj/19l48wuDJwIjhNGlUV0e2FALfjaD0IUjqxZ/b23GiG
         lk7VwE3rYxf4lBvC6t4ERZoBe76c7iI2bKw/FpFUy+KhjFGrKK/NcsEKSM9FUj8jsdeT
         MSmw==
X-Gm-Message-State: APjAAAXGrzz58nUKA1UWT9CCxJ5wkxKhDKtTPhFnUfBzQ+G7K+aE7B6m
        LFiPbBJCannZSkUgkoiIF8Y=
X-Google-Smtp-Source: APXvYqyPinp8CvGNRE9v8A54LMeUYeFi996WEC2tsK78EEm8vsNaHuPQ0nYWHFxnY7x2K4aNEz4mKQ==
X-Received: by 2002:a63:1447:: with SMTP id 7mr41679802pgu.22.1579219209212;
        Thu, 16 Jan 2020 16:00:09 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z4sm26584885pfn.42.2020.01.16.16.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:00:07 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Minchan Kim <minchan@google.com>
Subject: [PATCH v2 3/5] mm/madvise: employ mmget_still_valid for write lock
Date:   Thu, 16 Jan 2020 15:59:51 -0800
Message-Id: <20200116235953.163318-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200116235953.163318-1-minchan@kernel.org>
References: <20200116235953.163318-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@redhat.com>

Do the very same trick as we already do since 04f5866e41fb. KSM hints
will require locking mmap_sem for write since they modify vm_flags, so
for remote KSM hinting this additional check is needed.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 59b5cc99ef61..84cffd0900f1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1059,6 +1059,8 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm))
+			goto skip_mm;
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1109,6 +1111,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else
-- 
2.25.0.rc1.283.g88dfdc4193-goog

