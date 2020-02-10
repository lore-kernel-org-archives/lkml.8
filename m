Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58695C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4F82051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339038;
	bh=RC5LyErzA5QLiIz6fXV5CAXcGDg3k+bE+UcIo5ET3PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLhUdf9NDzynGl36a8UYBzRsGt/nW4dYKL4IMx3/QuSZFpLIIG41Fg/Mgsjd7z4N8
	 Ng723LJydBOSy9j+0F6MRCFZ2x/WpOlWdJ1dPzF6ltpy83+Gcv5WD/sFORrdzZn3U3
	 wJo2pykUyWZwxDe/k7IgdB7jrLX34S7MBwcaZDO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgBJMoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbgBJMkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:24 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EA42080C;
        Mon, 10 Feb 2020 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338424;
        bh=RC5LyErzA5QLiIz6fXV5CAXcGDg3k+bE+UcIo5ET3PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uy8HT4lpbKmBwtPs9BbF1vVE8ZLGH3tgtxBuxlsabPqn2v52ihyv2f/vLuTxNfvH+
         pFauJgNRa+RNNWEfGyl33VeaQr5ny4hr2ti1vI8r/jqV9TSzK8LuwKy1P999uUbvEi
         anJcuaBibsfpHTZeoIlrKEaeCwkoPtZaE2Kr8HlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.5 145/367] dm thin metadata: use pool locking at end of dm_pool_metadata_close
Date:   Mon, 10 Feb 2020 04:30:58 -0800
Message-Id: <20200210122438.233855200@linuxfoundation.org>
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

From: Mike Snitzer <snitzer@redhat.com>

commit 44d8ebf436399a40fcd10dd31b29d37823d62fcc upstream.

Ensure that the pool is locked during calls to __commit_transaction and
__destroy_persistent_data_objects.  Just being consistent with locking,
but reality is dm_pool_metadata_close is called once pool is being
destroyed so access to pool shouldn't be contended.

Also, use pmd_write_lock_in_core rather than __pmd_write_lock in
dm_pool_commit_metadata and rename __pmd_write_lock to
pmd_write_lock_in_core -- there was no need for the alias.

In addition, verify that the pool is locked in __commit_transaction().

Fixes: 873f258becca ("dm thin metadata: do not write metadata if no changes occurred")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin-metadata.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -387,16 +387,15 @@ static int subtree_equal(void *context,
  * Variant that is used for in-core only changes or code that
  * shouldn't put the pool in service on its own (e.g. commit).
  */
-static inline void __pmd_write_lock(struct dm_pool_metadata *pmd)
+static inline void pmd_write_lock_in_core(struct dm_pool_metadata *pmd)
 	__acquires(pmd->root_lock)
 {
 	down_write(&pmd->root_lock);
 }
-#define pmd_write_lock_in_core(pmd) __pmd_write_lock((pmd))
 
 static inline void pmd_write_lock(struct dm_pool_metadata *pmd)
 {
-	__pmd_write_lock(pmd);
+	pmd_write_lock_in_core(pmd);
 	if (unlikely(!pmd->in_service))
 		pmd->in_service = true;
 }
@@ -831,6 +830,7 @@ static int __commit_transaction(struct d
 	 * We need to know if the thin_disk_superblock exceeds a 512-byte sector.
 	 */
 	BUILD_BUG_ON(sizeof(struct thin_disk_superblock) > 512);
+	BUG_ON(!rwsem_is_locked(&pmd->root_lock));
 
 	if (unlikely(!pmd->in_service))
 		return 0;
@@ -953,6 +953,7 @@ int dm_pool_metadata_close(struct dm_poo
 		return -EBUSY;
 	}
 
+	pmd_write_lock_in_core(pmd);
 	if (!dm_bm_is_read_only(pmd->bm) && !pmd->fail_io) {
 		r = __commit_transaction(pmd);
 		if (r < 0)
@@ -961,6 +962,7 @@ int dm_pool_metadata_close(struct dm_poo
 	}
 	if (!pmd->fail_io)
 		__destroy_persistent_data_objects(pmd);
+	pmd_write_unlock(pmd);
 
 	kfree(pmd);
 	return 0;
@@ -1841,7 +1843,7 @@ int dm_pool_commit_metadata(struct dm_po
 	 * Care is taken to not have commit be what
 	 * triggers putting the thin-pool in-service.
 	 */
-	__pmd_write_lock(pmd);
+	pmd_write_lock_in_core(pmd);
 	if (pmd->fail_io)
 		goto out;
 


