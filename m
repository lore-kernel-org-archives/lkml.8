Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3EC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8B42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864091;
	bh=1GskCnw+liBqG1ez3LCZngD9cZHudWsp/1IJW8+1NJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZrQonhiahU/LYx8/y2Q2t8jWyhCiyTJvXYU9EjDT3lrn9xg9tbCU/TGc4o2VuHER
	 iTWVGedXGxXDnldZaObUiZN+u4UhujGxlmHz6lLq6wAOXW4k0Ymo+MvZCZlLy59Y1k
	 HYy8MsV9QMiNnBnablFkMnfEZSI8RgT38ZZlpfXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgAXLIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389598AbgAXLIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:06 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE652071A;
        Fri, 24 Jan 2020 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864085;
        bh=1GskCnw+liBqG1ez3LCZngD9cZHudWsp/1IJW8+1NJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fouFs6KO2Al3uc7zqIPtslWJluVFoRfiRhHKCE0UebKEjaXLXE2my4DWPjjuP2con
         7epo2LlCQ6zwa1YVxCO2NY62/zXneg9eR29o6sAu5mz4NgV0kVCNV87s7E4OxQvFgq
         M6rms4bxNI3GhLR4Dyg9rmFEDxsiZyiYkx+L6xUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Julien Grall <julien.grall@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 168/639] drm/xen-front: Fix mmap attributes for display buffers
Date:   Fri, 24 Jan 2020 10:25:38 +0100
Message-Id: <20200124093108.206814201@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit 24ded292a5c2ed476f01c77fee65f8320552cd27 ]

When GEM backing storage is allocated those are normal pages,
so there is no point using pgprot_writecombine while mmaping.
This fixes mismatch of buffer pages' memory attributes between
the frontend and backend which may cause screen artifacts.

Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Suggested-by: Julien Grall <julien.grall@arm.com>
Acked-by: Julien Grall <julien.grall@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190129150422.19867-1-andr2000@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index c85bfe7571cbf..802662839e7ed 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -236,8 +236,14 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_flags |= VM_MIXEDMAP;
 	vma->vm_pgoff = 0;
-	vma->vm_page_prot =
-			pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	/*
+	 * According to Xen on ARM ABI (xen/include/public/arch-arm.h):
+	 * all memory which is shared with other entities in the system
+	 * (including the hypervisor and other guests) must reside in memory
+	 * which is mapped as Normal Inner Write-Back Outer Write-Back
+	 * Inner-Shareable.
+	 */
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	/*
 	 * vm_operations_struct.fault handler will be called if CPU access
@@ -283,8 +289,9 @@ void *xen_drm_front_gem_prime_vmap(struct drm_gem_object *gem_obj)
 	if (!xen_obj->pages)
 		return NULL;
 
+	/* Please see comment in gem_mmap_obj on mapping and attributes. */
 	return vmap(xen_obj->pages, xen_obj->num_pages,
-		    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+		    VM_MAP, PAGE_KERNEL);
 }
 
 void xen_drm_front_gem_prime_vunmap(struct drm_gem_object *gem_obj,
-- 
2.20.1



