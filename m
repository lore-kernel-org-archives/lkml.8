Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C9C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDFB21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550801;
	bh=7/2xM7iTblevfBuLRF/P0S9IMmXYULbyCxH1xaA5ZyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MsdXE1z9xmG/TGerBB7fRe3S5PaLN1VqsJHUPHJGx0Wji6t9VnMA++3LMEmWN79xT
	 jjSmfEsz8Rfc48HBurwdGkJHUyzzEawGW4z210UqKDIpOl2nO2fOmS5EcnbrYjX6c8
	 jSE6OwdX8Io69CcHH9e4GQOa9IrMZ24HiwZ1//nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBLXkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:40:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41320 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgBLXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:39:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so2025296pgf.8;
        Wed, 12 Feb 2020 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FaTihNB0iO6aVJlFQnliVUDjcHxSy/v5NwxGrH8kEI=;
        b=qEAmDJpjHq1/SDf6Xx5QnzwOEfkQzfaAAuSuJ0sR01YF0yYlVoCLxLOOwV+QGxC1A6
         At4V57OeHDRLTUEM5vf09xAy2F5SvJ+57jVcDXKUcwcDgz1ol2m6zScXLJG7OoSu3BWF
         AsNMxbhzRVlrb5IdNChiSE0Z5R7G10ipo2dnSqTIuSy26l/Yc2Wca1lHimE+eQw7dL3a
         EFrmpjflcH51ALHlyIJ+xp3f9nuMS3HRz/Nsr/RFsucD8oolwMZuMwHYxV+TxNob5BwB
         ZmiX8UPIf3vovj+TMAhkkQCfjW1LXhJX+AyqoPTtIQCxX3ctHrDxmuSA3VhkddJQeDAj
         Gz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5FaTihNB0iO6aVJlFQnliVUDjcHxSy/v5NwxGrH8kEI=;
        b=VdradbErrPzbylSeAPBr+j8TMxU/tKjwcaArh8RfaCpGe0ioaY3ad/mtDW84znNqXk
         6QqoiTlSgyVldSMPOBi1aM7u3lwoGouPJVlIN4K5nLJ4ZadoJp8L5qsht8sGDfLNcy9c
         R9C/xpzNULJUR+IqSUP3G5E10Pk1DYgdBNOR+ZHGlK6tqUnpRof+bS0ounobYq0K9uP5
         D8xegNoOxWkB6fvcA0hkwb9u9hN7Hk0HZIIshEVifpY8fFMBppGifxO1YgwIMD8fMQRw
         smeQ9rnc3+gDu2za/+dDDzITMHw8iLTftqlOB24rQZ3074B1Qm9SWWZquyAqlZYKP0qZ
         YyYA==
X-Gm-Message-State: APjAAAUrRfaThIqwSW1ZcyBjjo33toHBE9DGA7Av/pPYFvFunRKsBRxH
        rOo23DTXy5Ijv5vtqWLPjFg=
X-Google-Smtp-Source: APXvYqwUgswxPMoz82nKSTevATYCfitBRedBrE6cghsT9OKRaDZWTkOVO5apq4PKzc/j/CtkDUG47w==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr15003128pga.223.1581550797747;
        Wed, 12 Feb 2020 15:39:57 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:39:56 -0800 (PST)
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
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v4 3/8] mm: validate mm in do_madvise
Date:   Wed, 12 Feb 2020 15:39:41 -0800
Message-Id: <20200212233946.246210-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg pointed out mm could be nulllified right after mm_access succeeds.
This patch validates it before the using.

Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8611f1d39289..bb04c7897eb9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1073,7 +1073,11 @@ int do_madvise(struct task_struct *task, unsigned long start,
 	int write;
 	size_t len;
 	struct blk_plug plug;
-	struct mm_struct *mm = task->mm;
+	struct mm_struct *mm = READ_ONCE(task->mm);
+
+	/* task can exit and nullify its ->mm right after mm_access() */
+	if (!mm)
+		return -ESRCH;
 
 	start = untagged_addr(start);
 
-- 
2.25.0.225.g125e21ebc7-goog

