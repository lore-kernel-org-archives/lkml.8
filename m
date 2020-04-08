Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62279C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C9020747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDFsVUMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDHBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:40:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDHBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586310018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7b3hN2sSbkSm2D93h3QJ554a9zb0gmfcgA7NY6J8BVs=;
        b=WDFsVUMZ5B67/BNddzXFOD0Ywuv+GyOf9xqeSrhY//XXLxgpeVp/Uco/R/bkuBzeI8DGYa
        EwtnqBp9lizFNBfualesKuzIfFAINSOajMxcY98bUIjJ+ZvlUQPXAt+FoouEAhehlqcMMi
        ToayLY1MFyIohggAMEyaAwb/N92suFs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-PA3XN0rTO0CLDRyS_XR0Fg-1; Tue, 07 Apr 2020 21:40:17 -0400
X-MC-Unique: PA3XN0rTO0CLDRyS_XR0Fg-1
Received: by mail-qt1-f198.google.com with SMTP id f56so4951241qte.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7b3hN2sSbkSm2D93h3QJ554a9zb0gmfcgA7NY6J8BVs=;
        b=YwfSJpkj9jxYqQYklAnDMkEtp8ZxI1/P1bSpWPQh3EeVtNZeWv69YzZxuQf4+xPD87
         XyxEc0cBef3F5XvOasHtJ6HCgij9Ts1r0EWHMOBMlKTEodrNvNz3s5SBZSedAaMDrx8i
         MbjgYm0tG/9gqVgwHDHnIDFcvkUx5El9LJhB1cZylnHwo1aX6b6rF+C1BmMa3NGsDAe5
         bdzEgNBbz1NCajMXS4usX9wh44dHxUFrb4dnLFK/kwZwztPt3j62UeHyKfvNMprH9qwB
         Tl+O+rKHQQ3xuZ2S5PLYFNr9Z8g6yOZ350t/qg6BGpqg4aKJ/0phBaqTKhOXbH/YMM5p
         2uyw==
X-Gm-Message-State: AGi0PuYC7XzDiEC2PWRmzkQ/3l8o5q0+GsHHDako49z5d0C7UkBGJtQI
        9ntpamxRC9XQfrjyycCDFZF0aAijen33ozNaYB4rvV/SHYfKNtZ7Jj+iPL/1GMasYyDTWgwYxAr
        DVeowg92PXobFMpLZl9Aoa9+F
X-Received: by 2002:ac8:27a9:: with SMTP id w38mr5008091qtw.112.1586310016214;
        Tue, 07 Apr 2020 18:40:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypKiDdfbU3ZlDmMw5zsuDQ3egIlmUEykfE0Bx/gD1U+WuGauQrVFK6YiY93u5z4zZQ9aM9zH4A==
X-Received: by 2002:ac8:27a9:: with SMTP id w38mr5008079qtw.112.1586310015979;
        Tue, 07 Apr 2020 18:40:15 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id a186sm18438740qkg.2.2020.04.07.18.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:40:15 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal signal
Date:   Tue,  7 Apr 2020 21:40:09 -0400
Message-Id: <20200408014010.80428-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200408014010.80428-1-peterx@redhat.com>
References: <20200408014010.80428-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lookup_node() uses gup to pin the page and get node information.  It
checks against ret>=0 assuming the page will be filled in.  However
it's also possible that gup will return zero, for example, when the
thread is quickly killed with a fatal signal.  Teach lookup_node() to
gracefully return an error -EFAULT if it happens.

Meanwhile, initialize "page" to NULL to avoid potential risk of
exploiting the pointer.

Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mempolicy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5fb427aed612..c7ca6a808fb1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -897,12 +897,15 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 
 static int lookup_node(struct mm_struct *mm, unsigned long addr)
 {
-	struct page *p;
+	struct page *p = NULL;
 	int err;
 
 	int locked = 1;
 	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err >= 0) {
+	if (err == 0) {
+		/* E.g. GUP interrupted by fatal signal */
+		err = -EFAULT;
+	} else if (err > 0) {
 		err = page_to_nid(p);
 		put_page(p);
 	}
-- 
2.24.1

