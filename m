Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41E72071C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgD3Vdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:33:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgD3Vdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:33:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpUEO-1iplaj2mCa-00pvQZ; Thu, 30 Apr 2020 23:33:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, Bob Copeland <me@bobcopeland.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-karma-devel@lists.sourceforge.net
Subject: [PATCH 11/15] omfs: avoid gcc-10 stringop-overflow warning
Date:   Thu, 30 Apr 2020 23:30:53 +0200
Message-Id: <20200430213101.135134-12-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430213101.135134-1-arnd@arndb.de>
References: <20200430213101.135134-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+XaRPp7CfnZLZHQoG9KIZwKOhoXML5HT3OMDT+We9eFTOHl/MTa
 IQ1PuZBMq2cX47pExs/skvs5u6D2ZyNzv8l4dWO+94IWDT5VoeuzE+AzFnRtjtJynitNvsp
 AP+Ws1jGG7IWExBBTTSklFLhUYqW+J8UbX+Bk+zztYSY5iFcP7pwuW8M4A32XFbGKiqbvx0
 vPhzUS91KVLo3cnojKbTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:63DZ90Mcukc=:NhBphJT0hHhxTJWL41gHwf
 dY7o0UaxL66NyWsLABtXl/iMz51Df9L3LwCB1O/ZuzHh7Gawk1Nqi/P6StwNMJh4nVRk6Z7aX
 xjf0/AAD1Bf+FBt5NkDgBpobKwkfWSzKzBmLIJrASVK/rE8bQplnoUbcRnT6Bl++FJEv9TB4V
 2ahN1zcsNWeUhUHwqea0GNichUMsxdBqx1GjWddfQ1qdUpmryUwqpGMYjmadRXpPBMluQZZaT
 QikAobFixmsiCiqrfXlVk32X3tg7jrCgNrF9CKOHpVYwawItj340hUwrvGMjcJzvr3y8tS/WT
 mrzOLh/DMVvktcyn/2XTkGzjsV+u9rGPqlgZSgZTEnW6oph5ZCUN1ykuTDcq8uvl19qY1PAQw
 Spi6dg+nDDTPmkvOkC78mquAaqmmaDqwAIT7CifiswPyiHrBWkVySVQNOUAJHz5+gBJy4RMd6
 Rf0ehNtYUwrP/RvimsG6wEBMi4ini6bzNPXy3rXIHdRJ3/KJI9GBa+dMvjdUUPu3y17BGDoC9
 sdMrV+YKB3HVT2kJppRfDYkveC0VdX6AcLTL+Iehh4OJDitadlcMnlNj55vI3wdK/z2fxr+DG
 a3oB0nUtw0UsTP6nya76PgOKKU4RbxnvZe3wrEv54mOn0PQdD9JtVIO1ASGPHnDitTZZNu8/p
 KxjHOTajkj1TpZhY0A0F2rzMftN/v4SKZGvp85G83d2FBJK4hteZ8mJ9FdGzWqxMOZhhvxCFK
 1VmiXcwu5xRe4fpcgh6ZT76Y22NflToqhSiSEma6B+65SVpMmXpLyOtEAqMhdruHY84NS29Fv
 u/ao5xy5Q2KXHT1FaW47fTpLXLjJ4nUiqmXlTAYwAuWIyXVQgU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 correctly points out a memcpy beyond the end of the structure
it gets copied into:

fs/omfs/file.c: In function 'omfs_grow_extent':
cc1: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
In file included from fs/omfs/omfs.h:8,
                 from fs/omfs/file.c:11:
fs/omfs/omfs_fs.h:80:27: note: at offset 0 to object 'e_entry' with size 16 declared here
   80 |  struct omfs_extent_entry e_entry; /* start of extent entries */
      |                           ^~~~~~~

This is not a bug however, as the file system layout contains an array
of extent entries instead of just a single one that was part of the
structure definition.

Changing the definition to use a c99 flexible array member makes
makes the code match the actual layout, which avoids the warning and
an odd '+1' in the calculation of the number of extent entries.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/omfs/file.c    | 12 ++++++------
 fs/omfs/omfs_fs.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index d7b5f09d298c..94344386c6ff 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
 {
 	return (sbi->s_sys_blocksize - offset -
 		sizeof(struct omfs_extent)) /
-		sizeof(struct omfs_extent_entry) + 1;
+		sizeof(struct omfs_extent_entry);
 }
 
 void omfs_make_empty_table(struct buffer_head *bh, int offset)
@@ -24,8 +24,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 	oe->e_next = ~cpu_to_be64(0ULL);
 	oe->e_extent_count = cpu_to_be32(1),
 	oe->e_fill = cpu_to_be32(0x22),
-	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
-	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
 }
 
 int omfs_shrink_inode(struct inode *inode)
@@ -68,7 +68,7 @@ int omfs_shrink_inode(struct inode *inode)
 
 		last = next;
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		/* ignore last entry as it is the terminator */
 		for (; extent_count > 1; extent_count--) {
@@ -117,7 +117,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 			u64 *ret_block)
 {
 	struct omfs_extent_entry *terminator;
-	struct omfs_extent_entry *entry = &oe->e_entry;
+	struct omfs_extent_entry *entry = oe->e_entry;
 	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
 	u32 extent_count = be32_to_cpu(oe->e_extent_count);
 	u64 new_block = 0;
@@ -245,7 +245,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 
 		extent_count = be32_to_cpu(oe->e_extent_count);
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		if (extent_count > max_extents)
 			goto out_brelse;
diff --git a/fs/omfs/omfs_fs.h b/fs/omfs/omfs_fs.h
index caecb3d5a344..1ff6b9e41297 100644
--- a/fs/omfs/omfs_fs.h
+++ b/fs/omfs/omfs_fs.h
@@ -77,7 +77,7 @@ struct omfs_extent {
 	__be64 e_next;			/* next extent table location */
 	__be32 e_extent_count;		/* total # extents in this table */
 	__be32 e_fill;
-	struct omfs_extent_entry e_entry;	/* start of extent entries */
+	struct omfs_extent_entry e_entry[];	/* start of extent entries */
 };
 
 #endif
-- 
2.26.0

