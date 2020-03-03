Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86312C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EF5214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258297;
	bh=8QwsYUY0hJna66MgiNj66yrm9iHsCOPXJMn/qky6LdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=reKCfo8kY54gexN85M9ab3MFWc2FP7XhlDoxKqsMyg3BjgHI0J4vgPSKUcu3bG4HU
	 bGlRuMYRuU36QTXy1wwJzJajWeGwy+Mu2kIUDxP6ERfJTT9J46zimTExVZRQ5GQ/wH
	 M+Zt4HcRf0dhhMAfyzKrnpggHU8hccPJjs+ENs0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbgCCR6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732433AbgCCR6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:58:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E3520656;
        Tue,  3 Mar 2020 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258286;
        bh=8QwsYUY0hJna66MgiNj66yrm9iHsCOPXJMn/qky6LdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qCytZNA5TBMAR62krVzRKtYPWeQuD4YUbqt7YeGOTsLZxilsizEeunqrtq49cftY
         YcywiZqbGyud+iMIvuLfKAh7z/5vNBP+SoU8tvPlEOauH8ykXzaq+G9SjJhiAxql5/
         s9PGp42JssfyAk5sQQ8d2qSlTRl7H6W8J0lIq9XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5.4 144/152] xfs: clear kernel only flags in XFS_IOC_ATTRMULTI_BY_HANDLE
Date:   Tue,  3 Mar 2020 18:44:02 +0100
Message-Id: <20200303174319.163660188@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 953aa9d136f53e226448dbd801a905c28f8071bf upstream.

Don't allow passing arbitrary flags as they change behavior including
memory allocation that the call stack is not prepared for.

Fixes: ddbca70cc45c ("xfs: allocate xattr buffer on demand")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_attr.h |    7 +++++--
 fs/xfs/xfs_ioctl.c       |    2 ++
 fs/xfs/xfs_ioctl32.c     |    2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -26,7 +26,7 @@ struct xfs_attr_list_context;
  *========================================================================*/
 
 
-#define ATTR_DONTFOLLOW	0x0001	/* -- unused, from IRIX -- */
+#define ATTR_DONTFOLLOW	0x0001	/* -- ignored, from IRIX -- */
 #define ATTR_ROOT	0x0002	/* use attrs in root (trusted) namespace */
 #define ATTR_TRUST	0x0004	/* -- unused, from IRIX -- */
 #define ATTR_SECURE	0x0008	/* use attrs in security namespace */
@@ -37,7 +37,10 @@ struct xfs_attr_list_context;
 #define ATTR_KERNOVAL	0x2000	/* [kernel] get attr size only, not value */
 
 #define ATTR_INCOMPLETE	0x4000	/* [kernel] return INCOMPLETE attr keys */
-#define ATTR_ALLOC	0x8000	/* allocate xattr buffer on demand */
+#define ATTR_ALLOC	0x8000	/* [kernel] allocate xattr buffer on demand */
+
+#define ATTR_KERNEL_FLAGS \
+	(ATTR_KERNOTIME | ATTR_KERNOVAL | ATTR_INCOMPLETE | ATTR_ALLOC)
 
 #define XFS_ATTR_FLAGS \
 	{ ATTR_DONTFOLLOW, 	"DONTFOLLOW" }, \
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -536,6 +536,8 @@ xfs_attrmulti_by_handle(
 
 	error = 0;
 	for (i = 0; i < am_hreq.opcount; i++) {
+		ops[i].am_flags &= ~ATTR_KERNEL_FLAGS;
+
 		ops[i].am_error = strncpy_from_user((char *)attr_name,
 				ops[i].am_attrname, MAXNAMELEN);
 		if (ops[i].am_error == 0 || ops[i].am_error == MAXNAMELEN)
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -450,6 +450,8 @@ xfs_compat_attrmulti_by_handle(
 
 	error = 0;
 	for (i = 0; i < am_hreq.opcount; i++) {
+		ops[i].am_flags &= ~ATTR_KERNEL_FLAGS;
+
 		ops[i].am_error = strncpy_from_user((char *)attr_name,
 				compat_ptr(ops[i].am_attrname),
 				MAXNAMELEN);


