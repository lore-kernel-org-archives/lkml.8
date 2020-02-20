Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73768C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FB720658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGCOgway"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBTQDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:03:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53802 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728798AbgBTQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwNlsBs8NIb6Y77atButveT5DrFFM9+Zoa3o5H5cFjw=;
        b=YGCOgwayF1eIniQUiuMWQrwnb7zw4PewZ7uDvVbwX7M1skSHBKDi00aXpPYla5g8E/yFGh
        BiDvsj2244nRors6aALOJ1cJQTeKSVKs5y8K9N6vitjD3wSSEZgaBc+9YOPh+l0L6ze7dH
        BL/PhWdMWF1JpmHNjLr6+P2R5ncheSo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-95rLSdHiNVmGtj-_hRhBNw-1; Thu, 20 Feb 2020 11:03:03 -0500
X-MC-Unique: 95rLSdHiNVmGtj-_hRhBNw-1
Received: by mail-qv1-f70.google.com with SMTP id s5so2855714qvr.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwNlsBs8NIb6Y77atButveT5DrFFM9+Zoa3o5H5cFjw=;
        b=kWtPrmA0tUuAYOipXZ/G1LK05nXfMg01ajl/+JeeEPcfe11ZKFRZ08YB02UVRgDRyz
         OFgfXMBwtj/VPczwqPZRPLrKxdk4riTsLlSNSmrW4FG9Dzs/Bu7QoBK1Fo45LdeXYWi2
         iq/nA7nxJ9xNZ2TbSfR3VLcTnrYsvzifJA7L6LMeUP5FjS8s8bhg0E/U1JeV2PhU7jab
         99qImn2WcAgnWl0Y96EIo3LfR0lFfoAnWjh5zq/M6V0vFX5NMsLS5rYvIzN6sMjxlGq0
         LdcyXlg9JQ1v4CtnvYEs/bcCUhmEZgvkIQ9TZYtVaw0laHhV8/nG0qJK2e2y5bdOpGWw
         WFnw==
X-Gm-Message-State: APjAAAUBqLS4bezDn7nhfc6sSgtNsC+vc3RIMrOJDNFZsGE/yiMepkdw
        qch7gxv+P0xM88dzNAADGqlW3U5fA3ypf18YTllKIsvf2UHs3NW2sEmq7ZoVuaewUN6d5yNjkN1
        oFTKDmIgOBDBs0RC+caFX1T9P
X-Received: by 2002:a37:6343:: with SMTP id x64mr12490176qkb.469.1582214582493;
        Thu, 20 Feb 2020 08:03:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2aPDTTJLSGD106eUq72NgEiCCqnnnqxrNnv6B6KzmA2UMTNOcP0AD9i+lrW6IWJ9nODQY9g==
X-Received: by 2002:a37:6343:: with SMTP id x64mr12490151qkb.469.1582214582267;
        Thu, 20 Feb 2020 08:03:02 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id n123sm1857635qke.58.2020.02.20.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:03:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
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
Subject: [PATCH RESEND v6 16/16] mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path
Date:   Thu, 20 Feb 2020 11:03:00 -0500
Message-Id: <20200220160300.9941-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd fault path was by default killable even if the caller does
not have FAULT_FLAG_KILLABLE.  That makes sense before in that when
with gup we don't have FAULT_FLAG_KILLABLE properly set before.  Now
after previous patch we've got FAULT_FLAG_KILLABLE applied even for
gup code so it should also make sense to let userfaultfd to honor the
FAULT_FLAG_KILLABLE.

Because we're unconditionally setting FAULT_FLAG_KILLABLE in gup code
right now, this patch should have no functional change.  It also
cleaned the code a little bit by introducing some helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index c076d3295958..703c1c3faa6e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -334,6 +334,30 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+/* Should pair with userfaultfd_signal_pending() */
+static inline long userfaultfd_get_blocking_state(unsigned int flags)
+{
+	if (flags & FAULT_FLAG_INTERRUPTIBLE)
+		return TASK_INTERRUPTIBLE;
+
+	if (flags & FAULT_FLAG_KILLABLE)
+		return TASK_KILLABLE;
+
+	return TASK_UNINTERRUPTIBLE;
+}
+
+/* Should pair with userfaultfd_get_blocking_state() */
+static inline bool userfaultfd_signal_pending(unsigned int flags)
+{
+	if (flags & FAULT_FLAG_INTERRUPTIBLE)
+		return signal_pending(current);
+
+	if (flags & FAULT_FLAG_KILLABLE)
+		return fatal_signal_pending(current);
+
+	return false;
+}
+
 /*
  * The locking rules involved in returning VM_FAULT_RETRY depending on
  * FAULT_FLAG_ALLOW_RETRY, FAULT_FLAG_RETRY_NOWAIT and
@@ -355,7 +379,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_ctx *ctx;
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
-	bool must_wait, return_to_userland;
+	bool must_wait;
 	long blocking_state;
 
 	/*
@@ -462,9 +486,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
-	return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
-	blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
-			 TASK_KILLABLE;
+	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
 
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/*
@@ -490,8 +512,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	up_read(&mm->mmap_sem);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released) &&
-		   (return_to_userland ? !signal_pending(current) :
-		    !fatal_signal_pending(current)))) {
+		   !userfaultfd_signal_pending(vmf->flags))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
 		schedule();
 		ret |= VM_FAULT_MAJOR;
@@ -513,8 +534,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 			set_current_state(blocking_state);
 			if (READ_ONCE(uwq.waken) ||
 			    READ_ONCE(ctx->released) ||
-			    (return_to_userland ? signal_pending(current) :
-			     fatal_signal_pending(current)))
+			    userfaultfd_signal_pending(vmf->flags))
 				break;
 			schedule();
 		}
-- 
2.24.1

