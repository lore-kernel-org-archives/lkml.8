Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60FDC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8F32253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YRs+Hb9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCIUno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:43:44 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.190]:15566 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCIUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:43:43 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id AD065E75618
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 15:18:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOrMj5S5oSl8qBOrMjggzc; Mon, 09 Mar 2020 15:18:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YxdVOLQLPHQl4Tnob3dnblm195MuDbXhF271io02DL0=; b=YRs+Hb9oMWEE+EdHIJ6VZ+Rryx
        DnkktfJxpW4l5N/TXXF5Xdh+VdN7dBbp1UGxeTeITyjwhMM1ko0MjxdkLu9Tm5upubmkCK2BwzY0R
        GEdtZbgFBBuo+yC2DiehQZAVWnpvZOmohKX39q3QKY2IzFr84sTC9XFKTCDBIvQuwckrSv7oDXUjA
        1DXtRTNif4TgAwVNg+JlmMLdt6cCh06GTyB9ndWwcBFLshvTXtTRi8B7/KMFP+mboU+QHDXPg8qi6
        4yuShXXCwFrkIxBXoynZKlZ2VM89AuxqADi4WwSYNxQuJch0drJaB47IlALGuWa3/cYbt7X0Yasgb
        VB0YGjsg==;
Received: from [201.162.168.201] (port=19736 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOrK-000xqo-O9; Mon, 09 Mar 2020 15:18:43 -0500
Date:   Mon, 9 Mar 2020 15:21:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ocfs2: ocfs2_fs.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309202155.GA8432@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOrK-000xqo-O9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:19736
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ocfs2/ocfs2_fs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 0db4a7ec58a2..0dd8c41bafd4 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -470,7 +470,7 @@ struct ocfs2_extent_list {
 	__le16 l_reserved1;
 	__le64 l_reserved2;		/* Pad to
 					   sizeof(ocfs2_extent_rec) */
-/*10*/	struct ocfs2_extent_rec l_recs[0];	/* Extent records */
+/*10*/	struct ocfs2_extent_rec l_recs[];	/* Extent records */
 };
 
 /*
@@ -484,7 +484,7 @@ struct ocfs2_chain_list {
 	__le16 cl_count;		/* Total chains in this list */
 	__le16 cl_next_free_rec;	/* Next unused chain slot */
 	__le64 cl_reserved1;
-/*10*/	struct ocfs2_chain_rec cl_recs[0];	/* Chain records */
+/*10*/	struct ocfs2_chain_rec cl_recs[];	/* Chain records */
 };
 
 /*
@@ -496,7 +496,7 @@ struct ocfs2_truncate_log {
 /*00*/	__le16 tl_count;		/* Total records in this log */
 	__le16 tl_used;			/* Number of records in use */
 	__le32 tl_reserved1;
-/*08*/	struct ocfs2_truncate_rec tl_recs[0];	/* Truncate records */
+/*08*/	struct ocfs2_truncate_rec tl_recs[];	/* Truncate records */
 };
 
 /*
@@ -640,7 +640,7 @@ struct ocfs2_local_alloc
 	__le16 la_size;		/* Size of included bitmap, in bytes */
 	__le16 la_reserved1;
 	__le64 la_reserved2;
-/*10*/	__u8   la_bitmap[0];
+/*10*/	__u8   la_bitmap[];
 };
 
 /*
@@ -653,7 +653,7 @@ struct ocfs2_inline_data
 				 * for data, starting at id_data */
 	__le16	id_reserved0;
 	__le32	id_reserved1;
-	__u8	id_data[0];	/* Start of user data */
+	__u8	id_data[];	/* Start of user data */
 };
 
 /*
@@ -798,7 +798,7 @@ struct ocfs2_dx_entry_list {
 					 * possible in de_entries */
 	__le16		de_num_used;	/* Current number of
 					 * de_entries entries */
-	struct	ocfs2_dx_entry		de_entries[0];	/* Indexed dir entries
+	struct	ocfs2_dx_entry		de_entries[];	/* Indexed dir entries
 							 * in a packed array of
 							 * length de_num_used */
 };
@@ -935,7 +935,7 @@ struct ocfs2_refcount_list {
 	__le16 rl_used;		/* Current number of used records */
 	__le32 rl_reserved2;
 	__le64 rl_reserved1;	/* Pad to sizeof(ocfs2_refcount_record) */
-/*10*/	struct ocfs2_refcount_rec rl_recs[0];	/* Refcount records */
+/*10*/	struct ocfs2_refcount_rec rl_recs[];	/* Refcount records */
 };
 
 
@@ -1021,7 +1021,7 @@ struct ocfs2_xattr_header {
 						    buckets.  A block uses
 						    xb_check and sets
 						    this field to zero.) */
-	struct ocfs2_xattr_entry xh_entries[0]; /* xattr entry list. */
+	struct ocfs2_xattr_entry xh_entries[]; /* xattr entry list. */
 };
 
 /*
@@ -1207,7 +1207,7 @@ struct ocfs2_local_disk_dqinfo {
 /* Header of one chunk of a quota file */
 struct ocfs2_local_disk_chunk {
 	__le32 dqc_free;	/* Number of free entries in the bitmap */
-	__u8 dqc_bitmap[0];	/* Bitmap of entries in the corresponding
+	__u8 dqc_bitmap[];	/* Bitmap of entries in the corresponding
 				 * chunk of quota file */
 };
 
-- 
2.25.0

