Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C03C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D89206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jULXY/Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgBTQb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728245AbgBTQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0Q4v7uJDYavZUf8Hlp8Jd5LPvHFjkbI0A9qHDGmMac=;
        b=jULXY/IruMgCNrQ2w1Sq+jHw+u4FVaP3E8ZMxRFvBLx66xAYro1/eR9XuGTtexI9JjZhZq
        BJcNtmo3JFDrvQwFcXxSvigqX2VOpuLF8Bknekkiol9LXMF0FoUI+hPhLTaQD5KudI6tyd
        8pntrDgsuYjWEa7BnoSzkqHT6/l0Nng=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-PGr_BsVPOzK2u46IJ1YNKA-1; Thu, 20 Feb 2020 11:31:22 -0500
X-MC-Unique: PGr_BsVPOzK2u46IJ1YNKA-1
Received: by mail-qt1-f200.google.com with SMTP id u40so2979311qtk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0Q4v7uJDYavZUf8Hlp8Jd5LPvHFjkbI0A9qHDGmMac=;
        b=dhANWbIShZyIc0nCszGQoB0GqztEaMfusy8PM0SIGQ2c43pM5USMt0dd7HMhszNL/a
         h2bErmbdNm0rwTVrjopvWgQG2mrtdtc7jGeJ4tnrshkgGqJDRO8V7onOsQrbV3Gl3ydE
         PnooBuGhyTqVI/cPCgRyWITs5GY6orkhLK96jW8BcGxTnwS8gZhrF/hy4iCdeB2W5Mow
         NDcM1XxYquW+VSOtExoZ45zwdipJkj2WOM9YblirNx/Lt3EjJe2fBwAAr79p/KTizGwv
         GfZ56iWDYzeTHeTJ5zRNxHh4f+Twka5DqKtGEIN6vW0MH8egKXpURXfP1Sx36TIwOXZX
         gVCw==
X-Gm-Message-State: APjAAAUJxvEgFhv6aeRG64wCuiBhaF/9r544OI4hXO6Y4YZKU4tMzNOs
        H+OOhp9Im0aLlBQmiHtdhKmCD6CZYUlZ8qlkYwACqEpJeyjZL2khix8sCrUQKB2OtZ1lIs7X6Jl
        Xz2nfdCr1lZTXJWUZiukyZbcW
X-Received: by 2002:a05:620a:14ac:: with SMTP id x12mr29253243qkj.83.1582216282155;
        Thu, 20 Feb 2020 08:31:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzx3IkiiiVgVAaTh7a4kw6Mc673lSAsZGzglgZZcPuUu32OVy7fqunSXnxNaPdoptMpBsIIA==
X-Received: by 2002:a05:620a:14ac:: with SMTP id x12mr29253209qkj.83.1582216281942;
        Thu, 20 Feb 2020 08:31:21 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:21 -0800 (PST)
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
Subject: [PATCH v6 04/19] userfaultfd: wp: userfaultfd_pte/huge_pmd_wp() helpers
Date:   Thu, 20 Feb 2020 11:30:57 -0500
Message-Id: <20200220163112.11409-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

Implement helpers methods to invoke userfaultfd wp faults more
selectively: not only when a wp fault triggers on a vma with
vma->vm_flags VM_UFFD_WP set, but only if the _PAGE_UFFD_WP bit is set
in the pagetable too.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 5dc247af0f2e..7b91b76aac58 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -14,6 +14,8 @@
 #include <linux/userfaultfd.h> /* linux/include/uapi/linux/userfaultfd.h */
 
 #include <linux/fcntl.h>
+#include <linux/mm.h>
+#include <asm-generic/pgtable_uffd.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -57,6 +59,18 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
+static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
+				      pte_t pte)
+{
+	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
+}
+
+static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
+					   pmd_t pmd)
+{
+	return userfaultfd_wp(vma) && pmd_uffd_wp(pmd);
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
@@ -106,6 +120,19 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
+				      pte_t pte)
+{
+	return false;
+}
+
+static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
+					   pmd_t pmd)
+{
+	return false;
+}
+
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return false;
-- 
2.24.1

