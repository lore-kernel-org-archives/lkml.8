Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40632C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D2F208A7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590803369;
	bh=BIqHsLS0l8dGN8SLFgIgF41GvrgmvFj89GJ0W/GH6AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brjwpuiHPHZhwFB1TTBnPpZD9AUsEbSGvhPfOicUiHJ1ATyQA8B6t/Zh5qnMsHr1M
	 /8awWEJxRN9aI4rP2Blm0yytIcf7UTMnCSwtANHDseGO1vXbda7Xnz5USKmxeQ2HE/
	 8stKI9Dozu2kYXH9im/ZObvQxBszvO8Ft5mcD4WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgE3Bt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgE3Bt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:49:27 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DBE2075A;
        Sat, 30 May 2020 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590803367;
        bh=BIqHsLS0l8dGN8SLFgIgF41GvrgmvFj89GJ0W/GH6AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgFhjOA2Tg/cDAaLjTfNaZqzCG2tESxAefx1PLDVuEm3NQSd5SWvnA7gwlEPA4J9E
         6u8M83SyAx6okIHexmh9qmllwAUBM37YDlX/Ag5b5b9WHN7vB+equLefOWuCQeYZkr
         76YCSaWzFbP/Oeb7WML8UZHghJnGO5pgS3mb6uGo=
Date:   Fri, 29 May 2020 18:49:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: fix quota_sync failure due to f2fs_lock_op"
Message-ID: <20200530014926.GA39950@google.com>
References: <20200529092947.7890-1-yuchao0@huawei.com>
 <20200529223426.GA249109@google.com>
 <96ba756e-a354-1ee8-689e-211f63c294e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ba756e-a354-1ee8-689e-211f63c294e6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30, Chao Yu wrote:
> On 2020/5/30 6:34, Jaegeuk Kim wrote:
> > On 05/29, Chao Yu wrote:
> >> Under heavy fsstress, we may triggle panic while issuing discard,
> >> because __check_sit_bitmap() detects that discard command may earse
> >> valid data blocks, the root cause is as below race stack described,
> >> since we removed lock when flushing quota data, quota data writeback
> >> may race with write_checkpoint(), so that it causes inconsistency in
> >> between cached discard entry and segment bitmap.
> >>
> >> - f2fs_write_checkpoint
> >>  - block_operations
> >>   - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
> >>  - f2fs_flush_sit_entries
> >>   - add_discard_addrs
> >>    - __set_bit_le(i, (void *)de->discard_map);
> >> 						- f2fs_write_data_pages
> >> 						 - f2fs_write_single_data_page
> >> 						   : inode is quota one, cp_rwsem won't be locked
> >> 						  - f2fs_do_write_data_page
> >> 						   - f2fs_allocate_data_block
> >> 						    - f2fs_wait_discard_bio
> >> 						      : discard entry has not been added yet.
> >> 						    - update_sit_entry
> >>  - f2fs_clear_prefree_segments
> >>   - f2fs_issue_discard
> >>   : add discard entry
> >>
> >> This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
> >> failure due to f2fs_lock_op").
> >>
> >> Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")
> > 
> > The previous patch fixes quota_sync gets EAGAIN all the time.
> > How about this? It seems this works for fsstress test.
> > 

Then this?

---
 fs/f2fs/segment.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ebbadde6cbced..ed11dcf2d69ed 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3107,6 +3107,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		type = CURSEG_COLD_DATA;
 	}
 
+	/*
+	 * We need to wait for node_write to avoid block allocation during
+	 * checkpoint. This can only happen to quota writes which can cause
+	 * the below discard race condition.
+	 */
+	if (IS_DATASEG(type))
+		down_write(&sbi->node_write);
+
 	down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -3174,6 +3182,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	if (put_pin_sem)
 		up_read(&sbi->pin_sem);
+
+	if (IS_DATASEG(type))
+		up_write(&sbi->node_write);
 }
 
 static void update_device_state(struct f2fs_io_info *fio)
-- 
2.27.0.rc0.183.gde8f92d652-goog

