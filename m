Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F6C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056366;
	bh=1lHGm+w8hQp6p/rbjhDZdkWSNoYGCVTZVEp77iVz9Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQ06itT6gwV8dzL7AZ8U03kWfL8krFogA5L9rFNZ12hgzZE39qhBuc1n4XHyF0aHB
	 lAHqiCSgypzeL9/0F7xwk6sXQrmH7z5AhM8bOf5lHvzldqE+csA0FInUkBVjnumZhI
	 Ti0Vi0pA8wwcYctJIeYSsG0CDOyPT3+wqxxHqMyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgBRUA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgBRUAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98DE24125;
        Tue, 18 Feb 2020 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056053;
        bh=1lHGm+w8hQp6p/rbjhDZdkWSNoYGCVTZVEp77iVz9Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UexNbJ+plZfX92XzIAF07aVZVBcFE+ljKf2RBisJ+btFaXk1dnXAVIvkxLjz0CrJB
         mBNtriURY5N0nOFX7FOuoyO8cOCw7zInY0cqQj8k8yRL+V1VhBAm+yDiF49Ae0Acvm
         R/5mGNdvIEnQHiG50cIfZpTNLZ4l7emahp0A8Lls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.5 17/80] ext4: fix support for inode sizes > 1024 bytes
Date:   Tue, 18 Feb 2020 20:54:38 +0100
Message-Id: <20200218190433.881962959@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 4f97a68192bd33b9963b400759cef0ca5963af00 upstream.

A recent commit, 9803387c55f7 ("ext4: validate the
debug_want_extra_isize mount option at parse time"), moved mount-time
checks around.  One of those changes moved the inode size check before
the blocksize variable was set to the blocksize of the file system.
After 9803387c55f7 was set to the minimum allowable blocksize, which
in practice on most systems would be 1024 bytes.  This cuased file
systems with inode sizes larger than 1024 bytes to be rejected with a
message:

EXT4-fs (sdXX): unsupported inode size: 4096

Fixes: 9803387c55f7 ("ext4: validate the debug_want_extra_isize mount option at parse time")
Link: https://lore.kernel.org/r/20200206225252.GA3673@mit.edu
Reported-by: Herbert Poetzl <herbert@13thfloor.at>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3768,6 +3768,15 @@ static int ext4_fill_super(struct super_
 	 */
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
+	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
+	if (blocksize < EXT4_MIN_BLOCK_SIZE ||
+	    blocksize > EXT4_MAX_BLOCK_SIZE) {
+		ext4_msg(sb, KERN_ERR,
+		       "Unsupported filesystem blocksize %d (%d log_block_size)",
+			 blocksize, le32_to_cpu(es->s_log_block_size));
+		goto failed_mount;
+	}
+
 	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
 		sbi->s_first_ino = EXT4_GOOD_OLD_FIRST_INO;
@@ -3785,6 +3794,7 @@ static int ext4_fill_super(struct super_
 			ext4_msg(sb, KERN_ERR,
 			       "unsupported inode size: %d",
 			       sbi->s_inode_size);
+			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
 			goto failed_mount;
 		}
 		/*
@@ -3988,14 +3998,6 @@ static int ext4_fill_super(struct super_
 	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
 		goto failed_mount;
 
-	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
-	if (blocksize < EXT4_MIN_BLOCK_SIZE ||
-	    blocksize > EXT4_MAX_BLOCK_SIZE) {
-		ext4_msg(sb, KERN_ERR,
-		       "Unsupported filesystem blocksize %d (%d log_block_size)",
-			 blocksize, le32_to_cpu(es->s_log_block_size));
-		goto failed_mount;
-	}
 	if (le32_to_cpu(es->s_log_block_size) >
 	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
 		ext4_msg(sb, KERN_ERR,


