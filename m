Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B420CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB722080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599590187;
	bh=cNMG3aGwW2iOudGRfRSdU1ldC+QY0NSEFEw8CW4f2ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejtyQQMwq8jg+lrGpTMM3ndKCwg21MVfdeu36GAhdGYM4KxcPPunWgJ5snBXFF56Q
	 tZGm4i3CWoa6k1RtlsI/VMAKUSGhtpyjqNvF4EKnRvNYbYj8+2D1kZm5dbV054EskU
	 guhYBf46xelZnAU5i3/E8GLmMl19ctjeWgY58rXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgIHSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbgIHQJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA5624178;
        Tue,  8 Sep 2020 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580162;
        bh=cNMG3aGwW2iOudGRfRSdU1ldC+QY0NSEFEw8CW4f2ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0G1Ff9OYUlUkt6Gc8fv6pPW8WxJhRFRAKay8heMSqt/J9+vPLEUbwfjvCgn9HGjZ
         lWv9GllU/+kkrG3ub3WqqsYrm2lQAftb01NpMGt2BKUVvPTCjJszH03Qyc+mFMxCEy
         qQWV9WxQgwt/2c+qMyMLZYxEI5ezBy1jhII5Iad0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Ajay Kaher <akaher@vmware.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/88] vfio/type1: Support faulting PFNMAP vmas
Date:   Tue,  8 Sep 2020 17:25:56 +0200
Message-Id: <20200908152223.885686657@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

commit 41311242221e3482b20bfed10fa4d9db98d87016 upstream.

With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
the range being faulted into the vma.  Add support to manually provide
that, in the same way as done on KVM with hva_to_pfn_remapped().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
[Ajay: Regenerated the patch for v4.19]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 36 ++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 52083b710b87e..05d8553635ee7 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -343,6 +343,32 @@ static int put_pfn(unsigned long pfn, int prot)
 	return 0;
 }
 
+static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
+			    unsigned long vaddr, unsigned long *pfn,
+			    bool write_fault)
+{
+	int ret;
+
+	ret = follow_pfn(vma, vaddr, pfn);
+	if (ret) {
+		bool unlocked = false;
+
+		ret = fixup_user_fault(NULL, mm, vaddr,
+				       FAULT_FLAG_REMOTE |
+				       (write_fault ?  FAULT_FLAG_WRITE : 0),
+				       &unlocked);
+		if (unlocked)
+			return -EAGAIN;
+
+		if (ret)
+			return ret;
+
+		ret = follow_pfn(vma, vaddr, pfn);
+	}
+
+	return ret;
+}
+
 static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 			 int prot, unsigned long *pfn)
 {
@@ -382,12 +408,16 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+retry:
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-		if (!follow_pfn(vma, vaddr, pfn) &&
-		    is_invalid_reserved_pfn(*pfn))
-			ret = 0;
+		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
+		if (ret == -EAGAIN)
+			goto retry;
+
+		if (!ret && !is_invalid_reserved_pfn(*pfn))
+			ret = -EFAULT;
 	}
 
 	up_read(&mm->mmap_sem);
-- 
2.25.1



