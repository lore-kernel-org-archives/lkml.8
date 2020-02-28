Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA8EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199C24697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0ZYSY0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgB1Kre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:47:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgB1Krd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582886852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=00MGnjRDI5JRv7cqaP4rjNmxgXAO4VHyJnftjqTSbpw=;
        b=Y0ZYSY0ZzCDxMtcbq+1SgG/WvUfR4YY+G0icsGY9nfJ3KSLct2qjw5FMNcW8Eik4Kn9WVD
        XcRLMDt6CXi2ikJ1bSWsILaZh1q9ByykEBoLnph+wEDekx6944XEdAf/lKp00rZ7wMK/hl
        Ttk9nhHy2FzIylDJqqs4Ju1aH6J3Hjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-LwESe7lgNf-XGOqzFVLeYQ-1; Fri, 28 Feb 2020 05:47:28 -0500
X-MC-Unique: LwESe7lgNf-XGOqzFVLeYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC7A1100550E;
        Fri, 28 Feb 2020 10:47:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECB1B101D48A;
        Fri, 28 Feb 2020 10:47:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4BA2E17447; Fri, 28 Feb 2020 11:47:23 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thomas_os@shipmail.org, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/shmem: drop pgprot_decrypted()
Date:   Fri, 28 Feb 2020 11:47:23 +0100
Message-Id: <20200228104723.18757-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was added by commit 95cf9264d5f3 ("x86, drm, fbdev: Do not specify
encrypted memory for video mappings"), then it was kept through various
changes.

While vram actually needs decrypted mappings this is not correct for
shmem gem objects which live in main memory not io memory, so remove the
call.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index aad9324dcf4f..df31e5782eed 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -548,7 +548,6 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	if (!shmem->map_cached)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
 	return 0;
-- 
2.18.2

