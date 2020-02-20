Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A6C11D0F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB997208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4KzPIoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728967AbgBTQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCLmK6K1NgL3nrWqPb3p85maMdkxaAlDWymzo3h3N08=;
        b=M4KzPIoB9i0wEw4yWTbU5lVb9DWYTklMe4G3LebiS7j0+3xWD455V/o2PgSozQamCyrufO
        jXVg5AEwaYAF3+7Kn7tTZV+J0lvnI6Pca6ENYzB6Zt94/RB1hRCRs4fMkLN6THTyh0g61N
        qLnZ8rJ5hR2Ye4WTh+l2C0hG/0NrcYg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-gxtmgJq4PlSMdhc2YldMQw-1; Thu, 20 Feb 2020 11:31:43 -0500
X-MC-Unique: gxtmgJq4PlSMdhc2YldMQw-1
Received: by mail-qk1-f198.google.com with SMTP id n126so3085979qkc.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCLmK6K1NgL3nrWqPb3p85maMdkxaAlDWymzo3h3N08=;
        b=hh5w2jSBuEL1pI4TGtfK8OLTz9gtuey9snGDsRYi8/JMGihw9XvpHFdwjtyLdOH4Lo
         5jdC0Pi3YUv+Iu/hXmETPFsPibAXB6xKTTAX9ok+vEniOeDISxgvzbwD1O1V97due+zq
         lGsmLHyd45WFUpa3pQOFZHlTdU9jcJ6aagBQlHtbOk04gKQ8/uSA8wS5caJJM8I+BeeL
         KWeVegkTLFu/K5Nhd0RUQMZOGy+bKatZfJQnPyFq5YCzrVG+YK+3Pb18+MW+Fbntz03O
         sOhKgqrc3Ify6Tq3b9zGqXeJz4WQstwRrSjGSYQVHZo2mHk+DxiG9uvrSFpNZt8758kx
         HDCg==
X-Gm-Message-State: APjAAAUvvOIFjol21YkmfKvRITFxi2jnkocQN7JcfahpFJ7dPfSoxgl/
        4NIWx61aPciBsxekg9Wj6YWPrhkRGfesb+a7nfD9eL2XX19ClLYSY4RdD6TapE/oiIkBq7tV5h1
        ZkMcQj1bPUhLiezdsEvUgp2So
X-Received: by 2002:a0c:e34e:: with SMTP id a14mr26210383qvm.73.1582216303207;
        Thu, 20 Feb 2020 08:31:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEOgl/OCo5Ejpgix15Gg5M58u7eEegLyFWm9DkD2Td7iZ5RTq3zAj7ZVmxA0kyjv6PuleKIg==
X-Received: by 2002:a0c:e34e:: with SMTP id a14mr26210199qvm.73.1582216301496;
        Thu, 20 Feb 2020 08:31:41 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH v6 14/19] userfaultfd: wp: enabled write protection in userfaultfd API
Date:   Thu, 20 Feb 2020 11:31:07 -0500
Message-Id: <20200220163112.11409-15-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Now it's safe to enable write protection in userfaultfd API

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Pavel Emelyanov <xemul@parallels.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/uapi/linux/userfaultfd.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 95c4a160e5f8..e7e98bde221f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -19,7 +19,8 @@
  * means the userland is reading).
  */
 #define UFFD_API ((__u64)0xAA)
-#define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |		\
+#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
+			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
 			   UFFD_FEATURE_EVENT_REMOVE |	\
 			   UFFD_FEATURE_EVENT_UNMAP |		\
@@ -34,7 +35,8 @@
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
-	 (__u64)1 << _UFFDIO_ZEROPAGE)
+	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY)
-- 
2.24.1

