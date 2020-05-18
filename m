Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B224720671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825879;
	bh=2ryGPdVbWJ5MM7YlAGgwROaXtOaGyj/WH4egXmiCPf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvhB86rzz9hRVog1JTk6eOqPowr69c25Q8VS6a42C5sKJJ2R5pZZQd4xxCBshz2Q3
	 3hORY48eJ5rZZ4caXykh5EBl+XrBkFdbzhhn+mzxAEbavLY61wugU2kER4ZyaABrk4
	 jS95aslTAuoOrTxprhTgu1sPW82mkp58m29DaMIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbgERSR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgERR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1034F207C4;
        Mon, 18 May 2020 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824597;
        bh=2ryGPdVbWJ5MM7YlAGgwROaXtOaGyj/WH4egXmiCPf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqJ3VpcAScKGD74KVrArpksuiq/GQruO9oZYyyzMSeUz7nfysBrJSDB5mzUpnkTUg
         E2CI77PM1SYYHU8h9a3tvlYORKaEJX7iUw3hBfo2dVcsoILCYHYLGP4kgYkn9nZght
         A4WU83QBCO6bA7LkfL+0gpT8H7KxyDhwqd6ipc7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/147] NFS: Fix fscache super_cookie index_key from changing after umount
Date:   Mon, 18 May 2020 19:36:37 +0200
Message-Id: <20200518173523.120685777@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

[ Upstream commit d9bfced1fbcb35b28d8fbed4e785d2807055ed2b ]

Commit 402cb8dda949 ("fscache: Attach the index key and aux data to
the cookie") added the index_key and index_key_len parameters to
fscache_acquire_cookie(), and updated the callers in the NFS client.
One of the callers was inside nfs_fscache_get_super_cookie()
and was changed to use the full struct nfs_fscache_key as the
index_key.  However, a couple members of this structure contain
pointers and thus will change each time the same NFS share is
remounted.  Since index_key is used for fscache_cookie->key_hash
and this subsequently is used to compare cookies, the effectiveness
of fscache with NFS is reduced to the point at which a umount
occurs.   Any subsequent remount of the same share will cause a
unique NFS super_block index_key and key_hash to be generated for
the same data, rendering any prior fscache data unable to be
found.  A simple reproducer demonstrates the problem.

1. Mount share with 'fsc', create a file, drop page cache
systemctl start cachefilesd
mount -o vers=3,fsc 127.0.0.1:/export /mnt
dd if=/dev/zero of=/mnt/file1.bin bs=4096 count=1
echo 3 > /proc/sys/vm/drop_caches

2. Read file into page cache and fscache, then unmount
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1
umount /mnt

3. Remount and re-read which should come from fscache
mount -o vers=3,fsc 127.0.0.1:/export /mnt
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1

4. Check for READ ops in mountstats - there should be none
grep READ: /proc/self/mountstats

Looking at the history and the removed function, nfs_super_get_key(),
we should only use nfs_fscache_key.key plus any uniquifier, for
the fscache index_key.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/fscache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index a6dcc2151e779..3184063322d48 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -188,7 +188,8 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 	/* create a cache index for looking up filehandles */
 	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
 					       &nfs_fscache_super_index_def,
-					       key, sizeof(*key) + ulen,
+					       &key->key,
+					       sizeof(key->key) + ulen,
 					       NULL, 0,
 					       nfss, 0, true);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
-- 
2.20.1



