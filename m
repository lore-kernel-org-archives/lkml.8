Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B1C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED20208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340553;
	bh=FR43RgaZaK0hs2+jq2BnsmLQUirWJ4wclBUZsQbFpLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEC+U833TaE2UsobYxaFQLVys5q3Kpud/bbSt0zqkLzSfALni+b6hqAr2mmIGrFfE
	 C2zJIHsbdCF5L/0jsUsDQdqL0Hn0EsbV3vWgxm/Z1LSB0u4w5BceZRfIG8EntekmU+
	 5Oi8dpJnDIQ5gXlLQorUNECc/dygn1+tKR1yhzF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgEANmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgEANm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:42:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E42216FD;
        Fri,  1 May 2020 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340546;
        bh=FR43RgaZaK0hs2+jq2BnsmLQUirWJ4wclBUZsQbFpLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZTweV8EKLhXA3UL97rXXaLl9PUjYpWRrXpayek4jwNp4QeA45DBDBgDuq/3rKhqo
         ia+kgiU1Bnom6mbt0fUJVix/c+ikLgdVQPhm3K7hJJgQPUm8Hz1LXPMiDh+D7bQipu
         cqpOMjGo/I+8TLxGaTS/uTtQ+AYPwLMcu7zMEjYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Furtado <paulfurtado91@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Chandan Rajendra <chandanrlinux@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Allison Collins <allison.henderson@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5.6 038/106] xfs: acquire superblock freeze protection on eofblocks scans
Date:   Fri,  1 May 2020 15:23:11 +0200
Message-Id: <20200501131548.426288076@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

commit 4b674b9ac852937af1f8c62f730c325fb6eadcdb upstream.

The filesystem freeze sequence in XFS waits on any background
eofblocks or cowblocks scans to complete before the filesystem is
quiesced. At this point, the freezer has already stopped the
transaction subsystem, however, which means a truncate or cowblock
cancellation in progress is likely blocked in transaction
allocation. This results in a deadlock between freeze and the
associated scanner.

Fix this problem by holding superblock write protection across calls
into the block reapers. Since protection for background scans is
acquired from the workqueue task context, trylock to avoid a similar
deadlock between freeze and blocking on the write lock.

Fixes: d6b636ebb1c9f ("xfs: halt auto-reclamation activities while rebuilding rmap")
Reported-by: Paul Furtado <paulfurtado91@gmail.com>
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Chandan Rajendra <chandanrlinux@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_icache.c |   10 ++++++++++
 fs/xfs/xfs_ioctl.c  |    5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -907,7 +907,12 @@ xfs_eofblocks_worker(
 {
 	struct xfs_mount *mp = container_of(to_delayed_work(work),
 				struct xfs_mount, m_eofblocks_work);
+
+	if (!sb_start_write_trylock(mp->m_super))
+		return;
 	xfs_icache_free_eofblocks(mp, NULL);
+	sb_end_write(mp->m_super);
+
 	xfs_queue_eofblocks(mp);
 }
 
@@ -934,7 +939,12 @@ xfs_cowblocks_worker(
 {
 	struct xfs_mount *mp = container_of(to_delayed_work(work),
 				struct xfs_mount, m_cowblocks_work);
+
+	if (!sb_start_write_trylock(mp->m_super))
+		return;
 	xfs_icache_free_cowblocks(mp, NULL);
+	sb_end_write(mp->m_super);
+
 	xfs_queue_cowblocks(mp);
 }
 
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -2264,7 +2264,10 @@ xfs_file_ioctl(
 		if (error)
 			return error;
 
-		return xfs_icache_free_eofblocks(mp, &keofb);
+		sb_start_write(mp->m_super);
+		error = xfs_icache_free_eofblocks(mp, &keofb);
+		sb_end_write(mp->m_super);
+		return error;
 	}
 
 	default:


