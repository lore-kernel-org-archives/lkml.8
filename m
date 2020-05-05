Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1A6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031C120746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Srszsciu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgEEVyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:54:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgEEVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588715693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eckl6hH0AbgL49kEhmxA8Bwx9T7n/rxh8xbcvWxSc1I=;
        b=SrszsciusqBtVLr3WpV2orXYYEPGA6qmi+O/eAAWzZLp+Cs3EGekBj2at7uwlg6eYVJdcK
        YpvNzlHnjSxqy/H03vAaHEFcx7P+CcVVTP4BED+eMvkrTSzGaUBK/QWtWhsTz0zyQWlBYY
        KXpdF2PRIgAylrSRsUht41mic1wxmLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-VOYbBK-OMSGNzfOZspF_2Q-1; Tue, 05 May 2020 17:54:49 -0400
X-MC-Unique: VOYbBK-OMSGNzfOZspF_2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADDE2107ACCA;
        Tue,  5 May 2020 21:54:48 +0000 (UTC)
Received: from gimli.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C52770538;
        Tue,  5 May 2020 21:54:45 +0000 (UTC)
Subject: [PATCH v2 1/3] vfio/type1: Support faulting PFNMAP vmas
From:   Alex Williamson <alex.williamson@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com, jgg@ziepe.ca
Date:   Tue, 05 May 2020 15:54:44 -0600
Message-ID: <158871568480.15589.17339878308143043906.stgit@gimli.home>
In-Reply-To: <158871401328.15589.17598154478222071285.stgit@gimli.home>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With conversion to follow_pfn(), DMA mapping a PFNMAP range depends on
the range being faulted into the vma.  Add support to manually provide
that, in the same way as done on KVM with hva_to_pfn_remapped().

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index cc1d64765ce7..4a4cb7cd86b2 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -317,6 +317,32 @@ static int put_pfn(unsigned long pfn, int prot)
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
@@ -339,12 +365,16 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
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
 done:
 	up_read(&mm->mmap_sem);

