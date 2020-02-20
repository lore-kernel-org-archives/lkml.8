Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE70C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64066208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMTYwlRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgBTQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:32:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55083 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728986AbgBTQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IU1fgxlkB6a/1caEc9OlPp7STKLZ6FpW39zfFVLVvVg=;
        b=jMTYwlRbEv44wFBo6ZMZ4mvdZRFmjMUyEgtYnPMPl8hXTpe45rHWfOpMHxsjm1BsvPsWeX
        TA/eI3Z0jmTqCwzR658W9SJHi+5RIPahzJbH9JpZqoFQ2UZNPHx5gPFE3DbRxWzO9+4GFF
        WYFy9/H2W5ULsdrg2a2KqOne4NkhEBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-lzIGG0NbMC6gymwn-YvE6w-1; Thu, 20 Feb 2020 11:31:50 -0500
X-MC-Unique: lzIGG0NbMC6gymwn-YvE6w-1
Received: by mail-qv1-f72.google.com with SMTP id p3so2938273qvt.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IU1fgxlkB6a/1caEc9OlPp7STKLZ6FpW39zfFVLVvVg=;
        b=qjBL/bGUd2iJf6kQJOxfnnPxdJGVTZsq8zFMD5glQUx1V6ENDvemgxhbKyYTJimhBT
         rYAl81UEQ0OdvFXy7Ol+s8/jha3qVktvj/M2/4ZXBimjnfWqt2KCouBg+/Qb/Jfl+JCx
         MCAyDyKkyGU7QPUVyyRnCi4Ds7uXnK6siRIO30VoCjYEdQcUn0AFXcMRjuQjPMsgEr9y
         QEL7HNmZPBmR11OGmAiBTGZ4KO2VnP01KdrUgSOpdYrQcY53l+e4dqwTioFW6xpLNy/s
         3x6RyL3kkdxZmsbvYlKM1mYjOq9NdRrTaLs//0ONn4hFnRRMgF1XkR1m6g2WasEnfgM7
         xEFQ==
X-Gm-Message-State: APjAAAVrysH5ZcDtJvziemNyG6fxVvpuV4+rEiwlF3vLW/2vPSHWeQPU
        41oTqX1jb0jcSp44n5Ql3tOfflNTb6yD4CXSJKb63ZhhvgCa5riXxo9/wh7KHfwFGKx4wnJyUQD
        6TCPUDmwr2L43tOhDDDegyP8j
X-Received: by 2002:a05:6214:450:: with SMTP id cc16mr26380449qvb.175.1582216306769;
        Thu, 20 Feb 2020 08:31:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMg51Khw0k2HZsVu+5Fdow6BayCSYLtWlERq1D239QTNW+33WWT4KycPEAwP+32tQ5qNarog==
X-Received: by 2002:a05:6214:450:: with SMTP id cc16mr26380415qvb.175.1582216306483;
        Thu, 20 Feb 2020 08:31:46 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:45 -0800 (PST)
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
Subject: [PATCH v6 17/19] userfaultfd: wp: declare _UFFDIO_WRITEPROTECT conditionally
Date:   Thu, 20 Feb 2020 11:31:10 -0500
Message-Id: <20200220163112.11409-18-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only declare _UFFDIO_WRITEPROTECT if the user specified
UFFDIO_REGISTER_MODE_WP and if all the checks passed.  Then when the
user registers regions with shmem/hugetlbfs we won't expose the new
ioctl to them.  Even with complete anonymous memory range, we'll only
expose the new WP ioctl bit if the register mode has MODE_WP.

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6e878d23547c..e39fdec8a0b0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1495,14 +1495,24 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	up_write(&mm->mmap_sem);
 	mmput(mm);
 	if (!ret) {
+		__u64 ioctls_out;
+
+		ioctls_out = basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
+		    UFFD_API_RANGE_IOCTLS;
+
+		/*
+		 * Declare the WP ioctl only if the WP mode is
+		 * specified and all checks passed with the range
+		 */
+		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
+			ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
+
 		/*
 		 * Now that we scanned all vmas we can already tell
 		 * userland which ioctls methods are guaranteed to
 		 * succeed on this range.
 		 */
-		if (put_user(basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
-			     UFFD_API_RANGE_IOCTLS,
-			     &user_uffdio_register->ioctls))
+		if (put_user(ioctls_out, &user_uffdio_register->ioctls))
 			ret = -EFAULT;
 	}
 out:
-- 
2.24.1

