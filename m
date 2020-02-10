Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA0C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339615;
	bh=OCXjpcJpebivRUQpaM+0Km+GDYQ/m8mDsaaF8Z1eFUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjZiiuHf2F3IR/WQDDrXyxJ2hdEQEl7gyE2PLvnhdBOgwdiBrxVA2umjVQfmTFfbo
	 rZ/QJca2FRII4pEXSCNgY7S8FB+yu0mWmKY6I73z/DrZyLSc+M5/2DcrQHjGciBMN/
	 ZZ/Y5lVxPfUBiYBl5BgRk/Xom287eOB3Y2Ym1s94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBJNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbgBJMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E6B2468F;
        Mon, 10 Feb 2020 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338462;
        bh=OCXjpcJpebivRUQpaM+0Km+GDYQ/m8mDsaaF8Z1eFUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrBblcVBunTNLSvF2B2udssEK8UhgramC7dntri0yhvNi2H+bp2o06t2RNydxOth4
         lHRLq+QJx67odrYSuuOdAuGTmX/6Fx5yuuYc9vuOBZ5ypyeaYLHMGDzhq28+XJRPww
         O4vJSIQwFSnh2cCjxn5pBJvZE8/eJnR0efN+JDdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@cs.helsinki.fi>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.5 220/367] xen/gntdev: Do not use mm notifiers with autotranslating guests
Date:   Mon, 10 Feb 2020 04:32:13 -0800
Message-Id: <20200210122444.421413856@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 9293724192a73f49c722e9685d45649c6df67dfe upstream.

Commit d3eeb1d77c5d ("xen/gntdev: use mmu_interval_notifier_insert")
missed a test for use_ptemod when calling mmu_interval_read_begin(). Fix
that.

Fixes: d3eeb1d77c5d ("xen/gntdev: use mmu_interval_notifier_insert")
CC: stable@vger.kernel.org # 5.5
Reported-by: Ilpo Järvinen <ilpo.jarvinen@cs.helsinki.fi>
Tested-by: Ilpo Järvinen <ilpo.jarvinen@cs.helsinki.fi>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/gntdev.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1006,19 +1006,19 @@ static int gntdev_mmap(struct file *flip
 	}
 	mutex_unlock(&priv->lock);
 
-	/*
-	 * gntdev takes the address of the PTE in find_grant_ptes() and passes
-	 * it to the hypervisor in gntdev_map_grant_pages(). The purpose of
-	 * the notifier is to prevent the hypervisor pointer to the PTE from
-	 * going stale.
-	 *
-	 * Since this vma's mappings can't be touched without the mmap_sem,
-	 * and we are holding it now, there is no need for the notifier_range
-	 * locking pattern.
-	 */
-	mmu_interval_read_begin(&map->notifier);
-
 	if (use_ptemod) {
+		/*
+		 * gntdev takes the address of the PTE in find_grant_ptes() and
+		 * passes it to the hypervisor in gntdev_map_grant_pages(). The
+		 * purpose of the notifier is to prevent the hypervisor pointer
+		 * to the PTE from going stale.
+		 *
+		 * Since this vma's mappings can't be touched without the
+		 * mmap_sem, and we are holding it now, there is no need for
+		 * the notifier_range locking pattern.
+		 */
+		mmu_interval_read_begin(&map->notifier);
+
 		map->pages_vm_start = vma->vm_start;
 		err = apply_to_page_range(vma->vm_mm, vma->vm_start,
 					  vma->vm_end - vma->vm_start,


