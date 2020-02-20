Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEEAC11D0D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342D24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3xLM1L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgBTOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:54:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728105AbgBTOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuXFXQMyc7fgJvuGyXbyHcTTw4JLf36BXSP5cKDpRYA=;
        b=d3xLM1L5jeZHw0pTujOceNnvl2lCWi4L+H1BVVn2o32fprBKdg007jvvFM7w2HvrAtfj7o
        ucV0yGGCecIVlgUbiR5Bxip9SWStSiUpkQU4qTfSk3jdQ/ZGpetIspN0e1EZJwE4xkkrAh
        dk9SHRc1J9kqG+v3PpzxmAqZLrALfGs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-xYH1JFdyNbqPIZxQhMkpIA-1; Thu, 20 Feb 2020 09:54:40 -0500
X-MC-Unique: xYH1JFdyNbqPIZxQhMkpIA-1
Received: by mail-qt1-f198.google.com with SMTP id r30so2718307qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuXFXQMyc7fgJvuGyXbyHcTTw4JLf36BXSP5cKDpRYA=;
        b=QQ4Rnt143qDfhNjJVzzYZmawZkYjcvEHq0fpcBySdQwHqbZAmVnpb/Z7Nid9lNEEKG
         /rPUzs4Kpst/d2yf9FL7huu4/XNigQC/aEeiw8uLsZ0Z6rJ7mI0xpQ+XEeZoB2e5Bxwy
         9npOsKsbl6O856nHaa0uXpNQ99NY4du1ZpEbipyGFmjcW26iHS81px1CpZM4V8T7H+l7
         abEEtB0VkasFlC3x9nKJtUSXX6RfEvHykPOAmZg1XzYrAL6hxKio6nzdYzHdAII3lqrc
         vnJfINjvfrcVTr7eEHEvTxZWilMFVLpyfgpzBp4owAjzf50ULrDT9LK+DZs4mKR5MH/E
         74kA==
X-Gm-Message-State: APjAAAVC9x49AecIZyvpZzhmKyj482zSvwJvlwxXg7eXuUswgkjKRvsO
        Q3DjwlZYYwbathHkjYF71ukbRRacmTthTb3VJJC8qbDK7OiLWeqHX4lE9cDDeHQKmK36Ndc4GHy
        N4unPS7nSoccWQ37lnYupmuev
X-Received: by 2002:aed:2344:: with SMTP id i4mr27122896qtc.136.1582210479970;
        Thu, 20 Feb 2020 06:54:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwOVehITbq/u1z2q7iTC6ia0QK/vAUkzyQy3GbFT+OSQxJLwuoeMqLraCRelgvzUEVbAWpxQ==
X-Received: by 2002:aed:2344:: with SMTP id i4mr27122858qtc.136.1582210479693;
        Thu, 20 Feb 2020 06:54:39 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id v82sm1725109qka.51.2020.02.20.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:54:38 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v6 02/16] mm/gup: Fix __get_user_pages() on fault retry of hugetlb
Date:   Thu, 20 Feb 2020 09:54:18 -0500
Message-Id: <20200220145432.4561-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com>
References: <20200220145432.4561-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When follow_hugetlb_page() returns with *locked==0, it means we've got
a VM_FAULT_RETRY within the fauling process and we've released the
mmap_sem.  When that happens, we should stop and bail out.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 1b4411bd0042..76cb420c0fb7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -849,6 +849,16 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
 						gup_flags, locked);
+				if (locked && *locked == 0) {
+					/*
+					 * We've got a VM_FAULT_RETRY
+					 * and we've lost mmap_sem.
+					 * We must stop here.
+					 */
+					BUG_ON(gup_flags & FOLL_NOWAIT);
+					BUG_ON(ret != 0);
+					goto out;
+				}
 				continue;
 			}
 		}
-- 
2.24.1

