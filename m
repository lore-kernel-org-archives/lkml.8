Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A203020810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590791668;
	bh=sIRfQ3q0FdVrLrcacZUMj2UJNEZ8rAbw9XTInJzIN6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mV45SllV0xiupb0f5Us8FnDIuAb+XKNMuZIoMEtqphDa2XsKEWMQhpakSy0ArSIkX
	 Ieh7WSLW2PpH6FGYcqy3y29J6uRaJ1PlIba8zY4e4DbLNuPupPm/7JejPlX26YsOEf
	 W7xKCg8PEUfnZhmairIdkNN9dJiLNI3AVMnr0Z4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgE2We1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgE2We1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:34:27 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFD9207BC;
        Fri, 29 May 2020 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590791666;
        bh=sIRfQ3q0FdVrLrcacZUMj2UJNEZ8rAbw9XTInJzIN6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa+Q/aSTV9wLSV01WhvK9mJWIvVAIlvy00i+VyPnViUJlguFAKEoIghscwH3zxG0a
         nOvjMznGQrjVCSyYEQ8mwESXT32FPNb8Lfz/FyqVdZqoNozyb+QOTvy60qxKkHpiMd
         LrHRgTQzgwwwzI0B1arUCEYCP2YB0vpUprP47Zv0=
Date:   Fri, 29 May 2020 15:34:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: fix quota_sync failure due to f2fs_lock_op"
Message-ID: <20200529223426.GA249109@google.com>
References: <20200529092947.7890-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529092947.7890-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29, Chao Yu wrote:
> Under heavy fsstress, we may triggle panic while issuing discard,
> because __check_sit_bitmap() detects that discard command may earse
> valid data blocks, the root cause is as below race stack described,
> since we removed lock when flushing quota data, quota data writeback
> may race with write_checkpoint(), so that it causes inconsistency in
> between cached discard entry and segment bitmap.
> 
> - f2fs_write_checkpoint
>  - block_operations
>   - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
>  - f2fs_flush_sit_entries
>   - add_discard_addrs
>    - __set_bit_le(i, (void *)de->discard_map);
> 						- f2fs_write_data_pages
> 						 - f2fs_write_single_data_page
> 						   : inode is quota one, cp_rwsem won't be locked
> 						  - f2fs_do_write_data_page
> 						   - f2fs_allocate_data_block
> 						    - f2fs_wait_discard_bio
> 						      : discard entry has not been added yet.
> 						    - update_sit_entry
>  - f2fs_clear_prefree_segments
>   - f2fs_issue_discard
>   : add discard entry
> 
> This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
> failure due to f2fs_lock_op").
> 
> Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")

The previous patch fixes quota_sync gets EAGAIN all the time.
How about this? It seems this works for fsstress test.

---
 fs/f2fs/segment.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ebbadde6cbced..f67cffc38975e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3095,6 +3095,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	bool put_pin_sem = false;
 
+	/*
+	 * We need to wait for node_write to avoid block allocation during
+	 * checkpoint. This can only happen to quota writes which can cause
+	 * the below discard race condition.
+	 */
+	if (IS_DATASEG(type))
+		down_write(&sbi->node_write);
+
 	if (type == CURSEG_COLD_DATA) {
 		/* GC during CURSEG_COLD_DATA_PINNED allocation */
 		if (down_read_trylock(&sbi->pin_sem)) {
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

