Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CCC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B2218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="drwxqqCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBEMyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:54:31 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:28557 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgBEMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:54:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C37E73F662;
        Wed,  5 Feb 2020 13:54:25 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=drwxqqCg;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DvNTlY3S9B5b; Wed,  5 Feb 2020 13:54:24 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E1E993F69D;
        Wed,  5 Feb 2020 13:54:23 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2C244360650;
        Wed,  5 Feb 2020 13:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580907259; bh=7RTXkWnj5mZm0IhsDkuABaTTBLVC5bfs5YBoJDZLqyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drwxqqCgTU4T+uABhtEERWwGz9R7yX5x198sEyyIWV1DbjIBDCRGlqgVYU6NQTOBb
         Ln2pOmhCwoezWBr1CxDkHbTLu4isOREjimG9iixOaWny8sxAxcuyg6ausFvOk1BOah
         Esuo/TZWUSBRh4Gj94kzfK0STb7SkigX/ad8b2Sw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v3 9/9] drm/vmwgfx: Hook up the helpers to align buffer objects
Date:   Wed,  5 Feb 2020 13:53:53 +0100
Message-Id: <20200205125353.2760-10-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200205125353.2760-1-thomas_os@shipmail.org>
References: <20200205125353.2760-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Start using the helpers that align buffer object user-space addresses and
buffer object vram addresses to huge page boundaries.
This is to improve the chances of allowing huge page-table entries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
---
 drivers/gpu/drm/drm_file.c                 |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        | 13 +++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c |  2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 40fae356d202..1df2fca608c3 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -932,3 +932,4 @@ unsigned long drm_get_unmapped_area(struct file *file,
 	return current->mm->get_unmapped_area(file, uaddr, len, pgoff, flags);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+EXPORT_SYMBOL_GPL(drm_get_unmapped_area);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index e962048f65d2..5452cabb4a2e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1215,6 +1215,18 @@ static void vmw_remove(struct pci_dev *pdev)
 	drm_put_dev(dev);
 }
 
+static unsigned long
+vmw_get_unmapped_area(struct file *file, unsigned long uaddr,
+		      unsigned long len, unsigned long pgoff,
+		      unsigned long flags)
+{
+	struct drm_file *file_priv = file->private_data;
+	struct vmw_private *dev_priv = vmw_priv(file_priv->minor->dev);
+
+	return drm_get_unmapped_area(file, uaddr, len, pgoff, flags,
+				     &dev_priv->vma_manager);
+}
+
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr)
 {
@@ -1386,6 +1398,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 	.compat_ioctl = vmw_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.get_unmapped_area = vmw_get_unmapped_area,
 };
 
 static struct drm_driver driver = {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 06267184aa0a..9ea145cffa3d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -929,6 +929,7 @@ extern int vmw_mmap(struct file *filp, struct vm_area_struct *vma);
 
 extern void vmw_validation_mem_init_ttm(struct vmw_private *dev_priv,
 					size_t gran);
+
 /**
  * TTM buffer object driver - vmwgfx_ttm_buffer.c
  */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index d8ea3dd10af0..34c721ab3ff3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -754,7 +754,7 @@ static int vmw_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 		break;
 	case TTM_PL_VRAM:
 		/* "On-card" video ram */
-		man->func = &ttm_bo_manager_func;
+		man->func = &vmw_thp_func;
 		man->gpu_offset = 0;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_FLAG_CACHED;
-- 
2.21.1

