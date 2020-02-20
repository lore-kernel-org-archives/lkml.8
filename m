Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E09C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D40C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVF22Jqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBTQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:32:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728937AbgBTQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gp1yBY+tfz3ASfvSkHX3QDXKz8JE+vKM1ZqbokypNuk=;
        b=OVF22Jqoz0C5Ng/ReS9vsZekukg0F+iavkNkEi3LP19/OMpkIclKpuxb9i8BA6Xym6ODRX
        BnRPvwUn0llVNLA8p6Uiw0lkQFzSey674OJyLQY8zLQwRATbMdOyUR9r3er4XttbYExywz
        J1+X0lv5OwuzMb9Z6a9292qXA7ElI5E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-PcaNpfU4NdOhc17bOfpkBA-1; Thu, 20 Feb 2020 11:31:43 -0500
X-MC-Unique: PcaNpfU4NdOhc17bOfpkBA-1
Received: by mail-qt1-f197.google.com with SMTP id x8so2956873qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp1yBY+tfz3ASfvSkHX3QDXKz8JE+vKM1ZqbokypNuk=;
        b=jE1K5A93Loddn4WcRNsHXcaeThTI4Tpy9FPuxioCHF4fAZsHznfrBxFYqnWwd60y+g
         7+w2YigP6IW+KoQdjr9Ro6qXH2RxuRYcq+5uisIFoP+0+o+5impUvQnMIwz6D8MrGO7P
         w74FFwdSiaDN1QwB/gqg6NgZLrqpn0KxsCScSZLTwqwSgHVnQe5xXwFCzlJ+RVklY+B2
         EhWspFKEKS1BOfh4RXlTajOxf8GvTOqBgVs7AVP7g5ViTljmhA0tVgekAQOAu+ZF8R+b
         CU/eeQAGlhOTKvoQBXt15gZrGM20XRPjMZEmhM9XBG+5/VG2Mt34U8fpju79mi5IGZsW
         zajw==
X-Gm-Message-State: APjAAAXUblmZauBQZJsut4qLvO5sTBnRR5Pl0KTUUoPl8weLnsSIKW1+
        6cnLw3rE6Nel2lbfhPsrpLArdmj1GYJjk2uOfmgW93duHRQcACvHlm3a6AwK6qJXnuzr7tXLo83
        VvlGpqXFGqb1S7YvGXuaQPxcV
X-Received: by 2002:a0c:f8c6:: with SMTP id h6mr26863086qvo.239.1582216303200;
        Thu, 20 Feb 2020 08:31:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLQom3vQH0usWmFRQsDeOtxC8SZvueF6+wF3aikKMPHtAIMojm8cCOEtP1dTBilcK23E+sjQ==
X-Received: by 2002:a0c:f8c6:: with SMTP id h6mr26863069qvo.239.1582216302958;
        Thu, 20 Feb 2020 08:31:42 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:42 -0800 (PST)
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
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 15/19] userfaultfd: wp: don't wake up when doing write protect
Date:   Thu, 20 Feb 2020 11:31:08 -0500
Message-Id: <20200220163112.11409-16-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to try to wake up any waiting thread when we're
write-protecting a memory region.  Only wake up when resolving a write
protected page fault.

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 59e9e399fddb..6e878d23547c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1812,6 +1812,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	struct uffdio_writeprotect uffdio_wp;
 	struct uffdio_writeprotect __user *user_uffdio_wp;
 	struct userfaultfd_wake_range range;
+	bool mode_wp, mode_dontwake;
 
 	if (READ_ONCE(ctx->mmap_changing))
 		return -EAGAIN;
@@ -1830,18 +1831,20 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
 			       UFFDIO_WRITEPROTECT_MODE_WP))
 		return -EINVAL;
-	if ((uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP) &&
-	     (uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE))
+
+	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
+	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
+
+	if (mode_wp && mode_dontwake)
 		return -EINVAL;
 
 	ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
-				  uffdio_wp.range.len, uffdio_wp.mode &
-				  UFFDIO_WRITEPROTECT_MODE_WP,
+				  uffdio_wp.range.len, mode_wp,
 				  &ctx->mmap_changing);
 	if (ret)
 		return ret;
 
-	if (!(uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE)) {
+	if (!mode_wp && !mode_dontwake) {
 		range.start = uffdio_wp.range.start;
 		range.len = uffdio_wp.range.len;
 		wake_userfault(ctx, &range);
-- 
2.24.1

