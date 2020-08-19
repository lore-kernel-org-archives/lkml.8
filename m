Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A824C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5903F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FauIvQqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHSWWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbgHSWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3r9Ws0y/w/73f6Yi8dzj7Ayu3FnCAIQyynyIBB67ZrI=;
        b=FauIvQqxwLl6KKJZPBnTk5vbaXMJffvizGtzIsTc9+r+yNTO9xlo+rN2MzUtkfMhHTdmuh
        lISXtBYlSLoyF8cCDrMHLEV/drAIvC61S2XM1lXDpHC52ALNU7ExoE2OgCZGzZNPfYOEzZ
        2n+3oNfaEY1v7qiXkvJDnPHsHk2xsKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-GglbAcrKMWOfk_Pf1lgtbQ-1; Wed, 19 Aug 2020 18:21:06 -0400
X-MC-Unique: GglbAcrKMWOfk_Pf1lgtbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929921007475;
        Wed, 19 Aug 2020 22:21:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4C575C70C;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1BEEC2256EC; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v3 14/18] fuse,dax: add DAX mmap support
Date:   Wed, 19 Aug 2020 18:19:52 -0400
Message-Id: <20200819221956.845195-15-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add DAX mmap() support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/file.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 99457d0b14b9..f1ad8b95b546 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2841,10 +2841,15 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
 	.page_mkwrite	= fuse_page_mkwrite,
 };
 
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 
+	/* DAX mmap is superior to direct_io mmap */
+	if (IS_DAX(file_inode(file)))
+		return fuse_dax_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
@@ -2863,9 +2868,63 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
+				   enum page_entry_size pe_size, bool write)
+{
+	vm_fault_t ret;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct super_block *sb = inode->i_sb;
+	pfn_t pfn;
+
+	if (write)
+		sb_start_pagefault(sb);
+
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+
+	if (ret & VM_FAULT_NEEDDSYNC)
+		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+
+	if (write)
+		sb_end_pagefault(sb);
+
+	return ret;
+}
+
+static vm_fault_t fuse_dax_fault(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE,
+				vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_huge_fault(struct vm_fault *vmf,
+			       enum page_entry_size pe_size)
+{
+	return __fuse_dax_fault(vmf, pe_size, vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_page_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static vm_fault_t fuse_dax_pfn_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static const struct vm_operations_struct fuse_dax_vm_ops = {
+	.fault		= fuse_dax_fault,
+	.huge_fault	= fuse_dax_huge_fault,
+	.page_mkwrite	= fuse_dax_page_mkwrite,
+	.pfn_mkwrite	= fuse_dax_pfn_mkwrite,
+};
+
 static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return -EINVAL; /* TODO */
+	file_accessed(file);
+	vma->vm_ops = &fuse_dax_vm_ops;
+	vma->vm_flags |= VM_MIXEDMAP | VM_HUGEPAGE;
+	return 0;
 }
 
 static int convert_fuse_file_lock(struct fuse_conn *fc,
@@ -3938,6 +3997,7 @@ static const struct file_operations fuse_file_operations = {
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
 	.lock		= fuse_file_lock,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.flock		= fuse_file_flock,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-- 
2.25.4

