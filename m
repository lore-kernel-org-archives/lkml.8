Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E33C11D0E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5135B24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKwB8Z4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBTPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:54:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbgBTPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuXFXQMyc7fgJvuGyXbyHcTTw4JLf36BXSP5cKDpRYA=;
        b=HKwB8Z4Amz+AP7Nhv7/GN1Wo1CL8qHoxPmsDzpAeXJca54v2VJJHg9CjqW20P7+ewuEr22
        h2kntuDJzMDcVt2G7QlLhKEnlR+T087b3r/P9D5JTSpl2Hx23mxbac4nzxRDXpRFLXmq3H
        cDFoT1RWbHsdksDOw/SGKNhHJMtDeAw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-aWMs0fuUNu2z9WHga-IVTQ-1; Thu, 20 Feb 2020 10:54:01 -0500
X-MC-Unique: aWMs0fuUNu2z9WHga-IVTQ-1
Received: by mail-qt1-f200.google.com with SMTP id x8so2863287qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuXFXQMyc7fgJvuGyXbyHcTTw4JLf36BXSP5cKDpRYA=;
        b=cmR3a00Rwf1lQbQLCKapAf1BqbH3tobKBO2KgdKjqbjtk74M0/yATl7UX2jSQhQ81A
         ZtBFA8C5wEI5PqcJePSk3CYZZ2K/NK4PUMJ8k8N+G1VpnuOMXt4SgyI6x39Mj2/BcwKJ
         xyygFRtQyEi+YR0rHRhvdglHrHl/Kzgvtx9NPjMUNNlo5xiBT+anIzVzJ+9BFXnADYsC
         ScevrlAXYE4wHkYVha+uWPP56fvKVSM5CrtfVM9PJHoT1UuElCTHbz9qaWxykdso5y3G
         rlmDx9mypQv/BJ4jPovB5z37Zzm0mwkv4E/kyPvg3jnW/VhlYt+HVY4l9FrYFRIAOEsg
         hg2g==
X-Gm-Message-State: APjAAAU8hxKT4NvHbrqTEA0q0QNCliPmFHd2844dihGQD9EiiGyKnd1T
        KxdNNHvJ0aCpCHPrtHbDIQxSz2bUto0AFrPOIOr8/zaTDEw581PxooUU4v4XUs9/m4gKv9RkMnW
        rspZm2IbR7c1yrXT8mtlUyEGV
X-Received: by 2002:a37:b243:: with SMTP id b64mr30229651qkf.164.1582214040818;
        Thu, 20 Feb 2020 07:54:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOpnl2xacnwHQN84MUWW8xiECJGKgV8PkqrlFanjY7RRrr5hucN1qNxpFi65Q4ia+dNtkpeQ==
X-Received: by 2002:a37:b243:: with SMTP id b64mr30229632qkf.164.1582214040609;
        Thu, 20 Feb 2020 07:54:00 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id h20sm1807430qkk.64.2020.02.20.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:53:59 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH RESEND v6 02/16] mm/gup: Fix __get_user_pages() on fault retry of hugetlb
Date:   Thu, 20 Feb 2020 10:53:39 -0500
Message-Id: <20200220155353.8676-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: <20200220155353.8676-1-peterx@redhat.com>
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

