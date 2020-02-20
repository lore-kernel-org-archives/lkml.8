Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D8DC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1DA206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWSILvtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBTQbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23586 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgBTQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDfp54tv0+rs3nPrDL5Amp10vZ/0yrKVTeej6RtTOAo=;
        b=OWSILvtdtnHADB+etBZzPyUeLuNgU4yIuSc2O8IJHphvdh9u63axeqX5nL2hQ5G9Ta0tjh
        74SaC/aTgnUsbXkNJjQWQhBHOmohBLhk86vuvCPBTk49cyTqHUabeKm4pCU0iSNSC8cezM
        +B0xsdhNKqlWsTljdaOn2VlfWx5+5g8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-I3lsghlSPAG2yy0Rj2wxYA-1; Thu, 20 Feb 2020 11:31:19 -0500
X-MC-Unique: I3lsghlSPAG2yy0Rj2wxYA-1
Received: by mail-qv1-f72.google.com with SMTP id e26so2938020qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDfp54tv0+rs3nPrDL5Amp10vZ/0yrKVTeej6RtTOAo=;
        b=VgCVFkEyOx0ke/2QXv+R3rmENpTHjHSP9lc0pm2QvpoKoIJbKeDPX/YuN86bpcV3Wq
         Hd46N0CHLy9rzRoAdMxBhAwT5QJopAju01ZNWTghzaUiZvvf4GDlV8OjTZZdbo8RHk7/
         Tp1lKTpDbP3enF9l0zl5dSD+WLjQifPI7vXPQRYW/6FGnKFHlLnMzD8ZEXVbjP2miqnP
         ntH6ec7/cpxrSC3Kw8Z+J14SfOufY0AtoREwzgVav5kKxQOiiYcOS7OskFRlvKZ04BrX
         3Hf1Hd8+zrShry2pQz+lbSYck2xryWN4gLKZ+aI+Nab+VbPZ6vQjHmmPN+4JoMTWizQR
         DrqQ==
X-Gm-Message-State: APjAAAXIkekY911rXIqYaSK6tynJOo/7UubzO0k+D9vpJ7Hty96cLarv
        Jp6KLOZWRQdJOGqzu+KClCdMceySUSFqSy/ikS6+hQvIWF6eTaFUxlSj4iexfJFn6rCo3h5Yhsi
        C71avq8tZPA+tT1rtfkN6wAZS
X-Received: by 2002:a37:b103:: with SMTP id a3mr29225534qkf.204.1582216277541;
        Thu, 20 Feb 2020 08:31:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcCHSfvKypdhtj1E5yiG/E6oGopv/63lCwj12vwvMeY43pNKmtOXoZ4aoprcfXGgqr4PQ/zA==
X-Received: by 2002:a37:b103:: with SMTP id a3mr29225413qkf.204.1582216276682;
        Thu, 20 Feb 2020 08:31:16 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:16 -0800 (PST)
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
Subject: [PATCH v6 01/19] userfaultfd: wp: add helper for writeprotect check
Date:   Thu, 20 Feb 2020 11:30:54 -0500
Message-Id: <20200220163112.11409-2-peterx@redhat.com>
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

add helper for writeprotect check. Will use it later.

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
 include/linux/userfaultfd_k.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac9d71e24b81..5dc247af0f2e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -52,6 +52,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_MISSING;
 }
 
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_WP;
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
@@ -96,6 +101,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return false;
-- 
2.24.1

