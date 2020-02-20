Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092DC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C42467C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkp6A0Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgBTQbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728970AbgBTQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klS12EpOfCO+92N1kPohJ72pmA2dZr16cCtOmkqqQu0=;
        b=Xkp6A0RoSKsB1r/jiKhgYZNlkV/3gY18zOV2Un5ofNEsyqNs2WJ/y9tWGhNoGZPZwPH2Q0
        2b+ep0OxlXmlXu5/UMwllgs8TFQYaoYpgVV6BNflSsRT5bIulF+TCmIn+QSvScd97oKJ5s
        kdB4ovh6cs2RjvjuTWm0Mdacvv1HvZ4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-9Ljq1ZAeOsCD_Uq2pEcFOQ-1; Thu, 20 Feb 2020 11:31:45 -0500
X-MC-Unique: 9Ljq1ZAeOsCD_Uq2pEcFOQ-1
Received: by mail-qt1-f199.google.com with SMTP id p12so2962883qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klS12EpOfCO+92N1kPohJ72pmA2dZr16cCtOmkqqQu0=;
        b=hP47sbYzx32iGMHUDFMB6A8dOuhl1X7ClqOE/hgORnhrjUIlhKi1o1x92o9R44ySUX
         0wUTtw581ei36Twa85poRkUF9yNhlHHuLhZup5PnTOsWY7oV1ptW0UFrtbS6ivhhUlhk
         pjCqI8txesvExtkHhLi1CqE8fKCfpbxu6xz7MyPmDoZNIPvAtfuHkj6qYqpwFHuK5IYM
         mQqYrf7dpi2CUv6/owdJk4feMhNgUq94hdLCbCSqgW0xW5qANSi+kDhAI4PjxqMT30Oy
         Fm+Xxr1OljQ3sx1Pj5cwVpD97a8s2xL3Fp2xpG8ZpKj2orrLul5r5Fhxx0log0Wyg6eG
         CO3A==
X-Gm-Message-State: APjAAAVE6ffzwETExwG2CZl5wrGjVpxQijDF/Kl/l5Mq3iQcc5W07IWH
        Jv2UXYaV3drx47pC7KZdLQhqZ35oA9WmuHTVK27DX09cfcRd5Cz19o7P+KkBCdTKt/WIbfNruoL
        otHMcrwUAmtYkzvZ9zW2Bs449
X-Received: by 2002:a05:6214:6aa:: with SMTP id s10mr26736223qvz.138.1582216304917;
        Thu, 20 Feb 2020 08:31:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYGpukdNxdfXYm0WZoUSCZUP5BJRRurBSVxU3kXV0jc2iuspd6kbmXRu4C8oT1RGdmpXxezg==
X-Received: by 2002:a05:6214:6aa:: with SMTP id s10mr26736189qvz.138.1582216304590;
        Thu, 20 Feb 2020 08:31:44 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:43 -0800 (PST)
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
Subject: [PATCH v6 16/19] userfaultfd: wp: UFFDIO_REGISTER_MODE_WP documentation update
Date:   Thu, 20 Feb 2020 11:31:09 -0500
Message-Id: <20200220163112.11409-17-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Cracauer <cracauer@cons.org>

Adds documentation about the write protection support.

Signed-off-by: Martin Cracauer <cracauer@cons.org>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: rewrite in rst format; fixups here and there]
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 5048cf661a8a..c30176e67900 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -108,6 +108,57 @@ UFFDIO_COPY. They're atomic as in guaranteeing that nothing can see an
 half copied page since it'll keep userfaulting until the copy has
 finished.
 
+Notes:
+
+- If you requested UFFDIO_REGISTER_MODE_MISSING when registering then
+  you must provide some kind of page in your thread after reading from
+  the uffd.  You must provide either UFFDIO_COPY or UFFDIO_ZEROPAGE.
+  The normal behavior of the OS automatically providing a zero page on
+  an annonymous mmaping is not in place.
+
+- None of the page-delivering ioctls default to the range that you
+  registered with.  You must fill in all fields for the appropriate
+  ioctl struct including the range.
+
+- You get the address of the access that triggered the missing page
+  event out of a struct uffd_msg that you read in the thread from the
+  uffd.  You can supply as many pages as you want with UFFDIO_COPY or
+  UFFDIO_ZEROPAGE.  Keep in mind that unless you used DONTWAKE then
+  the first of any of those IOCTLs wakes up the faulting thread.
+
+- Be sure to test for all errors including (pollfd[0].revents &
+  POLLERR).  This can happen, e.g. when ranges supplied were
+  incorrect.
+
+Write Protect Notifications
+---------------------------
+
+This is equivalent to (but faster than) using mprotect and a SIGSEGV
+signal handler.
+
+Firstly you need to register a range with UFFDIO_REGISTER_MODE_WP.
+Instead of using mprotect(2) you use ioctl(uffd, UFFDIO_WRITEPROTECT,
+struct *uffdio_writeprotect) while mode = UFFDIO_WRITEPROTECT_MODE_WP
+in the struct passed in.  The range does not default to and does not
+have to be identical to the range you registered with.  You can write
+protect as many ranges as you like (inside the registered range).
+Then, in the thread reading from uffd the struct will have
+msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP set. Now you send
+ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect) again
+while pagefault.mode does not have UFFDIO_WRITEPROTECT_MODE_WP set.
+This wakes up the thread which will continue to run with writes. This
+allows you to do the bookkeeping about the write in the uffd reading
+thread before the ioctl.
+
+If you registered with both UFFDIO_REGISTER_MODE_MISSING and
+UFFDIO_REGISTER_MODE_WP then you need to think about the sequence in
+which you supply a page and undo write protect.  Note that there is a
+difference between writes into a WP area and into a !WP area.  The
+former will have UFFD_PAGEFAULT_FLAG_WP set, the latter
+UFFD_PAGEFAULT_FLAG_WRITE.  The latter did not fail on protection but
+you still need to supply a page when UFFDIO_REGISTER_MODE_MISSING was
+used.
+
 QEMU/KVM
 ========
 
-- 
2.24.1

