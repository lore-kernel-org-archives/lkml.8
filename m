Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D18C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7772075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096778;
	bh=5z15zI3/T6HQEd0E/ow7TCeuC7Za8Ty+Of0kwIHX7t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VApxbSt+3Ztd142y8iLE1kmN/j103fzQoLNTxWhg+4GjEUtrtO8E/PZM57k2tasyI
	 jzE8jYjRpQ7AtQ6CUIE2NMZsdkBrLrRb1WxzlP79AYquZICkJghglSz6RgCt9A1mAi
	 Ky9dK/q55QLpH58nLTY7q8IxC9guP9Yb4BiGJAf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgG3IM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgG3IMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201732075F;
        Thu, 30 Jul 2020 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096757;
        bh=5z15zI3/T6HQEd0E/ow7TCeuC7Za8Ty+Of0kwIHX7t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2GuDaEmMTx9Cgv9sH+pNHybde7K3Z8ox+QEnt2ubyZPUzNyFB0cH4V/dhjGK7nqUL
         8CxTCxM/13HvHMvd2yE8e6mc2fuM1YLy/Xx8t+iujdZ1oPxFEZfWi8Vppf01vVwq26
         vVfQL4ZF0HnHtuWim61hdLYK/M0AGfoKP9ZfzXaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 49/54] xfs: set format back to extents if xfs_bmap_extents_to_btree
Date:   Thu, 30 Jul 2020 10:05:28 +0200
Message-Id: <20200730074423.544960348@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074421.203879987@linuxfoundation.org>
References: <20200730074421.203879987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

commit 2c4306f719b083d17df2963bc761777576b8ad1b upstream.

If xfs_bmap_extents_to_btree fails in a mode where we call
xfs_iroot_realloc(-1) to de-allocate the root, set the
format back to extents.

Otherwise we can assume we can dereference ifp->if_broot
based on the XFS_DINODE_FMT_BTREE format, and crash.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199423
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
[iwamatsu: backported to 4.4.y]
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_bmap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -793,6 +793,8 @@ xfs_bmap_extents_to_btree(
 	*logflagsp = 0;
 	if ((error = xfs_alloc_vextent(&args))) {
 		xfs_iroot_realloc(ip, -1, whichfork);
+		ASSERT(ifp->if_broot == NULL);
+		XFS_IFORK_FMT_SET(ip, whichfork, XFS_DINODE_FMT_EXTENTS);
 		xfs_btree_del_cursor(cur, XFS_BTREE_ERROR);
 		return error;
 	}


