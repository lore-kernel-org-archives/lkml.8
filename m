Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CBC11D29
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EC52192A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBXI5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:57:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:37373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgBXI5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:57:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 00:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; 
   d="scan'208";a="231068883"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 00:57:28 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     zhenyuw@linux.intel.com
Cc:     alex.williamson@redhat.com, intel-gvt-dev@lists.freedesktop.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, kevin.tian@intel.com, peterx@redhat.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v3 5/7] drm/i915/gvt: subsitute kvm_read/write_guest with vfio_dma_rw
Date:   Mon, 24 Feb 2020 03:48:05 -0500
Message-Id: <20200224084805.31898-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224084350.31574-1-yan.y.zhao@intel.com>
References: <20200224084350.31574-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a device model, it is better to read/write guest memory using vfio
interface, so that vfio is able to maintain dirty info of device IOVAs.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ed4c79cc3e09..3d6362fd94e7 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1979,33 +1979,13 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
 			void *buf, unsigned long len, bool write)
 {
 	struct kvmgt_guest_info *info;
-	struct kvm *kvm;
-	int idx, ret;
-	bool kthread = current->mm == NULL;
 
 	if (!handle_valid(handle))
 		return -ESRCH;
 
 	info = (struct kvmgt_guest_info *)handle;
-	kvm = info->kvm;
-
-	if (kthread) {
-		if (!mmget_not_zero(kvm->mm))
-			return -EFAULT;
-		use_mm(kvm->mm);
-	}
 
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = write ? kvm_write_guest(kvm, gpa, buf, len) :
-		      kvm_read_guest(kvm, gpa, buf, len);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	if (kthread) {
-		unuse_mm(kvm->mm);
-		mmput(kvm->mm);
-	}
-
-	return ret;
+	return vfio_dma_rw(info->vgpu->vdev.vfio_group, gpa, buf, len, write);
 }
 
 static int kvmgt_read_gpa(unsigned long handle, unsigned long gpa,
-- 
2.17.1

