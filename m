Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488AC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859C220760
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgIFONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:13:14 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:38470 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbgIFOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:12:10 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 6 Sep 2020 07:12:04 -0700
Received: from akaher-virtual-machine.eng.vmware.com (unknown [10.197.103.239])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id B392B408D4;
        Sun,  6 Sep 2020 07:12:03 -0700 (PDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <gregkh@linuxfoundation.org>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <peterx@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <srivatsab@vmware.com>, <srivatsa@csail.mit.edu>,
        <vsirnapalli@vmware.com>, <akaher@vmware.com>
Subject: [PATCH v5.4.y 1/3] vfio/type1: Support faulting PFNMAP vmas
Date:   Sun, 6 Sep 2020 19:37:54 +0530
Message-ID: <1599401277-32172-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 41311242221e3482b20bfed10fa4d9db98d87016 upstream.

With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
the range being faulted into the vma.  Add support to manually provide
that, in the same way as done on KVM with hva_to_pfn_remapped().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 drivers/vfio/vfio_iommu_type1.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6cc47af..d679996 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -335,6 +335,32 @@ static int put_pfn(unsigned long pfn, int prot)
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
@@ -377,12 +403,16 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	vaddr = untagged_addr(vaddr);
 
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
2.7.4

