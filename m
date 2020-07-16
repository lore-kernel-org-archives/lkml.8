Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B2C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F2420578
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594941323;
	bh=If2qeS/EPjtei6CpRVBnMy2vh7n6yjJ46S6AeyHq8O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BUPkh4kvCF8ga2/+VEBm4VeqtwjP4HdDemqfArK+0LdKsw5HCf0k5CX1rAA2opK+T
	 tAViwisMemqq5Z95IT0I16l2SIYeQpyv2TOFO46GHHNZ/L/ZtxvClGdMIUuofWJd2r
	 4wgPH+G5HUasvKSSPxNAsVkR0iBm0AgilGMgTCAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGPXPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgGPXPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:15:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7FE20EDD;
        Thu, 16 Jul 2020 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594940844;
        bh=If2qeS/EPjtei6CpRVBnMy2vh7n6yjJ46S6AeyHq8O0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ohDBoy6wPG1hARBmXbfQN6CKGP0d4yiU+mG7U2NxdVQaRGxDtSR19hVIOjYspmxmX
         XUQGfuHEfx5Fr9dyNrGtEGSbuW7U4dClnGR4OUtP09QFBQg6QqCoezGWEwUBy+yCJ6
         +Q9j8IFISyLQVsfjIW1WFnuzTt5SOk4dmRGGJ3bA=
Date:   Thu, 16 Jul 2020 16:07:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bernd Amend <bernd.amend@gmail.com>
Cc:     phillip@squashfs.org.uk, linux-kernel@vger.kernel.org,
        Stefan Rommel <stefanrommel@gmail.com>
Subject: Re: Regression: squashfs issues since change
 "squashfs: migrate from ll_rw_block usage to BIO"
Message-Id: <20200716160723.474af23e3a362e77bec3fcf7@linux-foundation.org>
In-Reply-To: <CAF31+H5ZB7zn73obrc5svLzgfsTnyYe5TKvr7-6atUOqrRY+2w@mail.gmail.com>
References: <CAF31+H5ZB7zn73obrc5svLzgfsTnyYe5TKvr7-6atUOqrRY+2w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 21:41:07 +0200 Bernd Amend <bernd.amend@gmail.com> wrote:

> Hi,
> 
> With the Linux Kernel version 5.8-rc5/master I am unable to mount some
> squashfs filesystems compressed with "-comp lz4".
> If I try to mount them I get the following error:
> [    1.084246] SQUASHFS error: lz4 decompression failed, data probably corrupt
> [    1.084545] SQUASHFS error: Failed to read block 0x873e1001: -5
> [    1.084761] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
> [    1.084983] SQUASHFS error: Unable to read directory block [873e0fff:1586]
> [    1.122564] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
> [    1.122708] SQUASHFS error: Unable to read directory block [873e0fff:1586]
> [    1.122862] Starting init: /sbin/init exists but couldn't execute
> it (error -5)
> [    1.123027] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
> [    1.123152] SQUASHFS error: Unable to read directory block [873e0fff:1586]
> [    1.123279] Starting init: /etc/init exists but couldn't execute it
> (error -5)
> [    1.123444] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
> [    1.123573] SQUASHFS error: Unable to read directory block [873e0fff:1586]
> [    1.123713] Starting init: /bin/init exists but couldn't execute it
> (error -5)
> [    1.123900] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
> 
> or
> 
> [ 4960.910693] attempt to access beyond end of device
> [ 4960.910695] loop0: rw=2048, want=46, limit=40
> [ 4960.910696] SQUASHFS error: Failed to read block 0x4001: -5
> [ 4960.910697] SQUASHFS error: Unable to read metadata cache entry [3fff]
> [ 4960.910698] SQUASHFS error: Unable to read inode 0x20c5000c
> 
> I bisected the issue to the commit "squashfs: migrate from ll_rw_block
> usage to BIO"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/squashfs?id=93e72b3c612adcaca13d874fcc86c53e6c8da541
> 
> The issue can be reproduced by downloading
> https://theworldsend.eu/demo.squashfs (20K) and the following command
> line.
> # mount demo.squashfs mnt && ls mnt && umount mnt
> 
> The same squashfs can be mounted using Linux <=5.7.8.
> The kernel config is identical to the Arch Linux Kernel configuration,
> build using gcc 9 and 10 on x86_64.

Thanks.  I queued a reversion patch.  I'll go ahead with this if we are
unable to get this fixed in the next week or so.

Are you able to check that the below fixes things up?

Thanks.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: revert "squashfs: migrate from ll_rw_block usage to BIO"

Revert 93e72b3c612adc ("squashfs: migrate from ll_rw_block usage to BIO")
due to a regression reported by Bernd Amend.

Link: http://lkml.kernel.org/r/CAF31+H5ZB7zn73obrc5svLzgfsTnyYe5TKvr7-6atUOqrRY+2w@mail.gmail.com
Reported-by: Bernd Amend <bernd.amend@gmail.com>
Cc: Philippe Liard <pliard@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/squashfs/block.c                     |  273 ++++++++++------------
 fs/squashfs/decompressor.h              |    5 
 fs/squashfs/decompressor_multi.c        |    9 
 fs/squashfs/decompressor_multi_percpu.c |    6 
 fs/squashfs/decompressor_single.c       |    9 
 fs/squashfs/lz4_wrapper.c               |   17 -
 fs/squashfs/lzo_wrapper.c               |   17 -
 fs/squashfs/squashfs.h                  |    4 
 fs/squashfs/xz_wrapper.c                |   51 +---
 fs/squashfs/zlib_wrapper.c              |   63 ++---
 fs/squashfs/zstd_wrapper.c              |   62 ++--
 11 files changed, 237 insertions(+), 279 deletions(-)

--- a/fs/squashfs/block.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/block.c
@@ -13,7 +13,6 @@
  * datablocks and metadata blocks.
  */
 
-#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
@@ -28,104 +27,45 @@
 #include "page_actor.h"
 
 /*
- * Returns the amount of bytes copied to the page actor.
+ * Read the metadata block length, this is stored in the first two
+ * bytes of the metadata block.
  */
-static int copy_bio_to_actor(struct bio *bio,
-			     struct squashfs_page_actor *actor,
-			     int offset, int req_length)
-{
-	void *actor_addr = squashfs_first_page(actor);
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
-	int copied_bytes = 0;
-	int actor_offset = 0;
-
-	if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all)))
-		return 0;
-
-	while (copied_bytes < req_length) {
-		int bytes_to_copy = min_t(int, bvec->bv_len - offset,
-					  PAGE_SIZE - actor_offset);
-
-		bytes_to_copy = min_t(int, bytes_to_copy,
-				      req_length - copied_bytes);
-		memcpy(actor_addr + actor_offset,
-		       page_address(bvec->bv_page) + bvec->bv_offset + offset,
-		       bytes_to_copy);
-
-		actor_offset += bytes_to_copy;
-		copied_bytes += bytes_to_copy;
-		offset += bytes_to_copy;
-
-		if (actor_offset >= PAGE_SIZE) {
-			actor_addr = squashfs_next_page(actor);
-			if (!actor_addr)
-				break;
-			actor_offset = 0;
-		}
-		if (offset >= bvec->bv_len) {
-			if (!bio_next_segment(bio, &iter_all))
-				break;
-			offset = 0;
-		}
-	}
-	squashfs_finish_page(actor);
-	return copied_bytes;
-}
-
-static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
-			     struct bio **biop, int *block_offset)
+static struct buffer_head *get_block_length(struct super_block *sb,
+			u64 *cur_index, int *offset, int *length)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	const u64 read_start = round_down(index, msblk->devblksize);
-	const sector_t block = read_start >> msblk->devblksize_log2;
-	const u64 read_end = round_up(index + length, msblk->devblksize);
-	const sector_t block_end = read_end >> msblk->devblksize_log2;
-	int offset = read_start - round_down(index, PAGE_SIZE);
-	int total_len = (block_end - block) << msblk->devblksize_log2;
-	const int page_count = DIV_ROUND_UP(total_len + offset, PAGE_SIZE);
-	int error, i;
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_NOIO, page_count);
-	if (!bio)
-		return -ENOMEM;
+	struct buffer_head *bh;
 
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_opf = READ;
-	bio->bi_iter.bi_sector = block * (msblk->devblksize >> SECTOR_SHIFT);
-
-	for (i = 0; i < page_count; ++i) {
-		unsigned int len =
-			min_t(unsigned int, PAGE_SIZE - offset, total_len);
-		struct page *page = alloc_page(GFP_NOIO);
-
-		if (!page) {
-			error = -ENOMEM;
-			goto out_free_bio;
-		}
-		if (!bio_add_page(bio, page, len, offset)) {
-			error = -EIO;
-			goto out_free_bio;
+	bh = sb_bread(sb, *cur_index);
+	if (bh == NULL)
+		return NULL;
+
+	if (msblk->devblksize - *offset == 1) {
+		*length = (unsigned char) bh->b_data[*offset];
+		put_bh(bh);
+		bh = sb_bread(sb, ++(*cur_index));
+		if (bh == NULL)
+			return NULL;
+		*length |= (unsigned char) bh->b_data[0] << 8;
+		*offset = 1;
+	} else {
+		*length = (unsigned char) bh->b_data[*offset] |
+			(unsigned char) bh->b_data[*offset + 1] << 8;
+		*offset += 2;
+
+		if (*offset == msblk->devblksize) {
+			put_bh(bh);
+			bh = sb_bread(sb, ++(*cur_index));
+			if (bh == NULL)
+				return NULL;
+			*offset = 0;
 		}
-		offset = 0;
-		total_len -= len;
 	}
 
-	error = submit_bio_wait(bio);
-	if (error)
-		goto out_free_bio;
-
-	*biop = bio;
-	*block_offset = index & ((1 << msblk->devblksize_log2) - 1);
-	return 0;
-
-out_free_bio:
-	bio_free_pages(bio);
-	bio_put(bio);
-	return error;
+	return bh;
 }
 
+
 /*
  * Read and decompress a metadata block or datablock.  Length is non-zero
  * if a datablock is being read (the size is stored elsewhere in the
@@ -136,88 +76,129 @@ out_free_bio:
  * algorithms).
  */
 int squashfs_read_data(struct super_block *sb, u64 index, int length,
-		       u64 *next_index, struct squashfs_page_actor *output)
+		u64 *next_index, struct squashfs_page_actor *output)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	struct bio *bio = NULL;
-	int compressed;
-	int res;
-	int offset;
+	struct buffer_head **bh;
+	int offset = index & ((1 << msblk->devblksize_log2) - 1);
+	u64 cur_index = index >> msblk->devblksize_log2;
+	int bytes, compressed, b = 0, k = 0, avail, i;
+
+	bh = kcalloc(((output->length + msblk->devblksize - 1)
+		>> msblk->devblksize_log2) + 1, sizeof(*bh), GFP_KERNEL);
+	if (bh == NULL)
+		return -ENOMEM;
 
 	if (length) {
 		/*
 		 * Datablock.
 		 */
+		bytes = -offset;
 		compressed = SQUASHFS_COMPRESSED_BLOCK(length);
 		length = SQUASHFS_COMPRESSED_SIZE_BLOCK(length);
+		if (next_index)
+			*next_index = index + length;
+
 		TRACE("Block @ 0x%llx, %scompressed size %d, src size %d\n",
 			index, compressed ? "" : "un", length, output->length);
+
+		if (length < 0 || length > output->length ||
+				(index + length) > msblk->bytes_used)
+			goto read_failure;
+
+		for (b = 0; bytes < length; b++, cur_index++) {
+			bh[b] = sb_getblk(sb, cur_index);
+			if (bh[b] == NULL)
+				goto block_release;
+			bytes += msblk->devblksize;
+		}
+		ll_rw_block(REQ_OP_READ, 0, b, bh);
 	} else {
 		/*
 		 * Metadata block.
 		 */
-		const u8 *data;
-		struct bvec_iter_all iter_all = {};
-		struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
-
-		if (index + 2 > msblk->bytes_used) {
-			res = -EIO;
-			goto out;
-		}
-		res = squashfs_bio_read(sb, index, 2, &bio, &offset);
-		if (res)
-			goto out;
-
-		if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
-			res = -EIO;
-			goto out_free_bio;
-		}
-		/* Extract the length of the metadata block */
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
-		length = data[offset];
-		if (offset <= bvec->bv_len - 1) {
-			length |= data[offset + 1] << 8;
-		} else {
-			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
-				res = -EIO;
-				goto out_free_bio;
-			}
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
-			length |= data[0] << 8;
-		}
-		bio_free_pages(bio);
-		bio_put(bio);
+		if ((index + 2) > msblk->bytes_used)
+			goto read_failure;
 
+		bh[0] = get_block_length(sb, &cur_index, &offset, &length);
+		if (bh[0] == NULL)
+			goto read_failure;
+		b = 1;
+
+		bytes = msblk->devblksize - offset;
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
-		index += 2;
+		if (next_index)
+			*next_index = index + length + 2;
 
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index,
-		      compressed ? "" : "un", length);
+				compressed ? "" : "un", length);
+
+		if (length < 0 || length > output->length ||
+					(index + length) > msblk->bytes_used)
+			goto block_release;
+
+		for (; bytes < length; b++) {
+			bh[b] = sb_getblk(sb, ++cur_index);
+			if (bh[b] == NULL)
+				goto block_release;
+			bytes += msblk->devblksize;
+		}
+		ll_rw_block(REQ_OP_READ, 0, b - 1, bh + 1);
 	}
-	if (next_index)
-		*next_index = index + length;
 
-	res = squashfs_bio_read(sb, index, length, &bio, &offset);
-	if (res)
-		goto out;
+	for (i = 0; i < b; i++) {
+		wait_on_buffer(bh[i]);
+		if (!buffer_uptodate(bh[i]))
+			goto block_release;
+	}
 
 	if (compressed) {
-		if (!msblk->stream) {
-			res = -EIO;
-			goto out_free_bio;
-		}
-		res = squashfs_decompress(msblk, bio, offset, length, output);
+		if (!msblk->stream)
+			goto read_failure;
+		length = squashfs_decompress(msblk, bh, b, offset, length,
+			output);
+		if (length < 0)
+			goto read_failure;
 	} else {
-		res = copy_bio_to_actor(bio, output, offset, length);
+		/*
+		 * Block is uncompressed.
+		 */
+		int in, pg_offset = 0;
+		void *data = squashfs_first_page(output);
+
+		for (bytes = length; k < b; k++) {
+			in = min(bytes, msblk->devblksize - offset);
+			bytes -= in;
+			while (in) {
+				if (pg_offset == PAGE_SIZE) {
+					data = squashfs_next_page(output);
+					pg_offset = 0;
+				}
+				avail = min_t(int, in, PAGE_SIZE -
+						pg_offset);
+				memcpy(data + pg_offset, bh[k]->b_data + offset,
+						avail);
+				in -= avail;
+				pg_offset += avail;
+				offset += avail;
+			}
+			offset = 0;
+			put_bh(bh[k]);
+		}
+		squashfs_finish_page(output);
 	}
 
-out_free_bio:
-	bio_free_pages(bio);
-	bio_put(bio);
-out:
-	if (res < 0)
-		ERROR("Failed to read block 0x%llx: %d\n", index, res);
+	kfree(bh);
+	return length;
 
-	return res;
+block_release:
+	for (; k < b; k++)
+		put_bh(bh[k]);
+
+read_failure:
+	ERROR("squashfs_read_data failed to read block 0x%llx\n",
+					(unsigned long long) index);
+	kfree(bh);
+	return -EIO;
 }
--- a/fs/squashfs/decompressor.h~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/decompressor.h
@@ -10,14 +10,13 @@
  * decompressor.h
  */
 
-#include <linux/bio.h>
-
 struct squashfs_decompressor {
 	void	*(*init)(struct squashfs_sb_info *, void *);
 	void	*(*comp_opts)(struct squashfs_sb_info *, void *, int);
 	void	(*free)(void *);
 	int	(*decompress)(struct squashfs_sb_info *, void *,
-		struct bio *, int, int, struct squashfs_page_actor *);
+		struct buffer_head **, int, int, int,
+		struct squashfs_page_actor *);
 	int	id;
 	char	*name;
 	int	supported;
--- a/fs/squashfs/decompressor_multi.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/decompressor_multi.c
@@ -6,7 +6,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/cpumask.h>
@@ -180,15 +180,14 @@ wait:
 }
 
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
-			int offset, int length,
-			struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
+	int b, int offset, int length, struct squashfs_page_actor *output)
 {
 	int res;
 	struct squashfs_stream *stream = msblk->stream;
 	struct decomp_stream *decomp_stream = get_decomp_stream(msblk, stream);
 	res = msblk->decompressor->decompress(msblk, decomp_stream->stream,
-		bio, offset, length, output);
+		bh, b, offset, length, output);
 	put_decomp_stream(decomp_stream, stream);
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
--- a/fs/squashfs/decompressor_multi_percpu.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/decompressor_multi_percpu.c
@@ -75,8 +75,8 @@ void squashfs_decompressor_destroy(struc
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
-	int offset, int length, struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
+	int b, int offset, int length, struct squashfs_page_actor *output)
 {
 	struct squashfs_stream *stream;
 	int res;
@@ -84,7 +84,7 @@ int squashfs_decompress(struct squashfs_
 	local_lock(&msblk->stream->lock);
 	stream = this_cpu_ptr(msblk->stream);
 
-	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
 					      offset, length, output);
 
 	local_unlock(&msblk->stream->lock);
--- a/fs/squashfs/decompressor_single.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/decompressor_single.c
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -59,15 +59,14 @@ void squashfs_decompressor_destroy(struc
 	}
 }
 
-int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
-			int offset, int length,
-			struct squashfs_page_actor *output)
+int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
+	int b, int offset, int length, struct squashfs_page_actor *output)
 {
 	int res;
 	struct squashfs_stream *stream = msblk->stream;
 
 	mutex_lock(&stream->mutex);
-	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
 		offset, length, output);
 	mutex_unlock(&stream->mutex);
 
--- a/fs/squashfs/lz4_wrapper.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/lz4_wrapper.c
@@ -4,7 +4,7 @@
  * Phillip Lougher <phillip@squashfs.org.uk>
  */
 
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -89,23 +89,20 @@ static void lz4_free(void *strm)
 
 
 static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct bio *bio, int offset, int length,
+	struct buffer_head **bh, int b, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 	struct squashfs_lz4 *stream = strm;
 	void *buff = stream->input, *data;
-	int bytes = length, res;
+	int avail, i, bytes = length, res;
 
-	while (bio_next_segment(bio, &iter_all)) {
-		int avail = min(bytes, ((int)bvec->bv_len) - offset);
-
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
-		memcpy(buff, data + offset, avail);
+	for (i = 0; i < b; i++) {
+		avail = min(bytes, msblk->devblksize - offset);
+		memcpy(buff, bh[i]->b_data + offset, avail);
 		buff += avail;
 		bytes -= avail;
 		offset = 0;
+		put_bh(bh[i]);
 	}
 
 	res = LZ4_decompress_safe(stream->input, stream->output,
--- a/fs/squashfs/lzo_wrapper.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/lzo_wrapper.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/mutex.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/lzo.h>
@@ -63,24 +63,21 @@ static void lzo_free(void *strm)
 
 
 static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct bio *bio, int offset, int length,
+	struct buffer_head **bh, int b, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 	struct squashfs_lzo *stream = strm;
 	void *buff = stream->input, *data;
-	int bytes = length, res;
+	int avail, i, bytes = length, res;
 	size_t out_len = output->length;
 
-	while (bio_next_segment(bio, &iter_all)) {
-		int avail = min(bytes, ((int)bvec->bv_len) - offset);
-
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
-		memcpy(buff, data + offset, avail);
+	for (i = 0; i < b; i++) {
+		avail = min(bytes, msblk->devblksize - offset);
+		memcpy(buff, bh[i]->b_data + offset, avail);
 		buff += avail;
 		bytes -= avail;
 		offset = 0;
+		put_bh(bh[i]);
 	}
 
 	res = lzo1x_decompress_safe(stream->input, (size_t)length,
--- a/fs/squashfs/squashfs.h~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/squashfs.h
@@ -40,8 +40,8 @@ extern void *squashfs_decompressor_setup
 /* decompressor_xxx.c */
 extern void *squashfs_decompressor_create(struct squashfs_sb_info *, void *);
 extern void squashfs_decompressor_destroy(struct squashfs_sb_info *);
-extern int squashfs_decompress(struct squashfs_sb_info *, struct bio *,
-				int, int, struct squashfs_page_actor *);
+extern int squashfs_decompress(struct squashfs_sb_info *, struct buffer_head **,
+	int, int, int, struct squashfs_page_actor *);
 extern int squashfs_max_decompressors(void);
 
 /* export.c */
--- a/fs/squashfs/xz_wrapper.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/xz_wrapper.c
@@ -10,7 +10,7 @@
 
 
 #include <linux/mutex.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/xz.h>
 #include <linux/bitops.h>
@@ -117,12 +117,11 @@ static void squashfs_xz_free(void *strm)
 
 
 static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct bio *bio, int offset, int length,
+	struct buffer_head **bh, int b, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
-	int total = 0, error = 0;
+	enum xz_ret xz_err;
+	int avail, total = 0, k = 0;
 	struct squashfs_xz *stream = strm;
 
 	xz_dec_reset(stream->state);
@@ -132,23 +131,11 @@ static int squashfs_xz_uncompress(struct
 	stream->buf.out_size = PAGE_SIZE;
 	stream->buf.out = squashfs_first_page(output);
 
-	for (;;) {
-		enum xz_ret xz_err;
-
-		if (stream->buf.in_pos == stream->buf.in_size) {
-			const void *data;
-			int avail;
-
-			if (!bio_next_segment(bio, &iter_all)) {
-				/* XZ_STREAM_END must be reached. */
-				error = -EIO;
-				break;
-			}
-
-			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+	do {
+		if (stream->buf.in_pos == stream->buf.in_size && k < b) {
+			avail = min(length, msblk->devblksize - offset);
 			length -= avail;
-			stream->buf.in = data + offset;
+			stream->buf.in = bh[k]->b_data + offset;
 			stream->buf.in_size = avail;
 			stream->buf.in_pos = 0;
 			offset = 0;
@@ -163,17 +150,23 @@ static int squashfs_xz_uncompress(struct
 		}
 
 		xz_err = xz_dec_run(stream->state, &stream->buf);
-		if (xz_err == XZ_STREAM_END)
-			break;
-		if (xz_err != XZ_OK) {
-			error = -EIO;
-			break;
-		}
-	}
+
+		if (stream->buf.in_pos == stream->buf.in_size && k < b)
+			put_bh(bh[k++]);
+	} while (xz_err == XZ_OK);
 
 	squashfs_finish_page(output);
 
-	return error ? error : total + stream->buf.out_pos;
+	if (xz_err != XZ_STREAM_END || k < b)
+		goto out;
+
+	return total + stream->buf.out_pos;
+
+out:
+	for (; k < b; k++)
+		put_bh(bh[k]);
+
+	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_xz_comp_ops = {
--- a/fs/squashfs/zlib_wrapper.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/zlib_wrapper.c
@@ -10,7 +10,7 @@
 
 
 #include <linux/mutex.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/zlib.h>
 #include <linux/vmalloc.h>
@@ -50,35 +50,21 @@ static void zlib_free(void *strm)
 
 
 static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct bio *bio, int offset, int length,
+	struct buffer_head **bh, int b, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
-	int zlib_init = 0, error = 0;
+	int zlib_err, zlib_init = 0, k = 0;
 	z_stream *stream = strm;
 
 	stream->avail_out = PAGE_SIZE;
 	stream->next_out = squashfs_first_page(output);
 	stream->avail_in = 0;
 
-	for (;;) {
-		int zlib_err;
-
-		if (stream->avail_in == 0) {
-			const void *data;
-			int avail;
-
-			if (!bio_next_segment(bio, &iter_all)) {
-				/* Z_STREAM_END must be reached. */
-				error = -EIO;
-				break;
-			}
-
-			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+	do {
+		if (stream->avail_in == 0 && k < b) {
+			int avail = min(length, msblk->devblksize - offset);
 			length -= avail;
-			stream->next_in = data + offset;
+			stream->next_in = bh[k]->b_data + offset;
 			stream->avail_in = avail;
 			offset = 0;
 		}
@@ -92,28 +78,37 @@ static int zlib_uncompress(struct squash
 		if (!zlib_init) {
 			zlib_err = zlib_inflateInit(stream);
 			if (zlib_err != Z_OK) {
-				error = -EIO;
-				break;
+				squashfs_finish_page(output);
+				goto out;
 			}
 			zlib_init = 1;
 		}
 
 		zlib_err = zlib_inflate(stream, Z_SYNC_FLUSH);
-		if (zlib_err == Z_STREAM_END)
-			break;
-		if (zlib_err != Z_OK) {
-			error = -EIO;
-			break;
-		}
-	}
+
+		if (stream->avail_in == 0 && k < b)
+			put_bh(bh[k++]);
+	} while (zlib_err == Z_OK);
 
 	squashfs_finish_page(output);
 
-	if (!error)
-		if (zlib_inflateEnd(stream) != Z_OK)
-			error = -EIO;
+	if (zlib_err != Z_STREAM_END)
+		goto out;
+
+	zlib_err = zlib_inflateEnd(stream);
+	if (zlib_err != Z_OK)
+		goto out;
+
+	if (k < b)
+		goto out;
+
+	return stream->total_out;
+
+out:
+	for (; k < b; k++)
+		put_bh(bh[k]);
 
-	return error ? error : stream->total_out;
+	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_zlib_comp_ops = {
--- a/fs/squashfs/zstd_wrapper.c~revert-squashfs-migrate-from-ll_rw_block-usage-to-bio
+++ a/fs/squashfs/zstd_wrapper.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/mutex.h>
-#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/zstd.h>
 #include <linux/vmalloc.h>
@@ -59,44 +59,33 @@ static void zstd_free(void *strm)
 
 
 static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
-	struct bio *bio, int offset, int length,
+	struct buffer_head **bh, int b, int offset, int length,
 	struct squashfs_page_actor *output)
 {
 	struct workspace *wksp = strm;
 	ZSTD_DStream *stream;
 	size_t total_out = 0;
-	int error = 0;
+	size_t zstd_err;
+	int k = 0;
 	ZSTD_inBuffer in_buf = { NULL, 0, 0 };
 	ZSTD_outBuffer out_buf = { NULL, 0, 0 };
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 
 	stream = ZSTD_initDStream(wksp->window_size, wksp->mem, wksp->mem_size);
 
 	if (!stream) {
 		ERROR("Failed to initialize zstd decompressor\n");
-		return -EIO;
+		goto out;
 	}
 
 	out_buf.size = PAGE_SIZE;
 	out_buf.dst = squashfs_first_page(output);
 
-	for (;;) {
-		size_t zstd_err;
+	do {
+		if (in_buf.pos == in_buf.size && k < b) {
+			int avail = min(length, msblk->devblksize - offset);
 
-		if (in_buf.pos == in_buf.size) {
-			const void *data;
-			int avail;
-
-			if (!bio_next_segment(bio, &iter_all)) {
-				error = -EIO;
-				break;
-			}
-
-			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
 			length -= avail;
-			in_buf.src = data + offset;
+			in_buf.src = bh[k]->b_data + offset;
 			in_buf.size = avail;
 			in_buf.pos = 0;
 			offset = 0;
@@ -108,8 +97,8 @@ static int zstd_uncompress(struct squash
 				/* Shouldn't run out of pages
 				 * before stream is done.
 				 */
-				error = -EIO;
-				break;
+				squashfs_finish_page(output);
+				goto out;
 			}
 			out_buf.pos = 0;
 			out_buf.size = PAGE_SIZE;
@@ -118,20 +107,29 @@ static int zstd_uncompress(struct squash
 		total_out -= out_buf.pos;
 		zstd_err = ZSTD_decompressStream(stream, &out_buf, &in_buf);
 		total_out += out_buf.pos; /* add the additional data produced */
-		if (zstd_err == 0)
-			break;
 
-		if (ZSTD_isError(zstd_err)) {
-			ERROR("zstd decompression error: %d\n",
-					(int)ZSTD_getErrorCode(zstd_err));
-			error = -EIO;
-			break;
-		}
-	}
+		if (in_buf.pos == in_buf.size && k < b)
+			put_bh(bh[k++]);
+	} while (zstd_err != 0 && !ZSTD_isError(zstd_err));
 
 	squashfs_finish_page(output);
 
-	return error ? error : total_out;
+	if (ZSTD_isError(zstd_err)) {
+		ERROR("zstd decompression error: %d\n",
+				(int)ZSTD_getErrorCode(zstd_err));
+		goto out;
+	}
+
+	if (k < b)
+		goto out;
+
+	return (int)total_out;
+
+out:
+	for (; k < b; k++)
+		put_bh(bh[k]);
+
+	return -EIO;
 }
 
 const struct squashfs_decompressor squashfs_zstd_comp_ops = {
_

