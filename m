Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A6C54FD2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B7D20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387590;
	bh=dmfp8iJjkzItWWjRKonzZYhBJ02Aif1xYwUp0wvQUfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pJufPsYqJMUH/BOF9dh1PPNX36VF5+BOZ4f4hSU7JCyi18Hr0m0fOwpMlWGHRNkWI
	 RhL60/tAwnrp8tVeYy1Ij+cCSwKdEsEYAjDkSu65BQEnxZrnMvcz4a/sXEXjlv65Ef
	 e9iA3n4mE0+CyzWJ43s7520nK7op2ZEPS3VpMry8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDTMlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgDTMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C8B20736;
        Mon, 20 Apr 2020 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386462;
        bh=dmfp8iJjkzItWWjRKonzZYhBJ02Aif1xYwUp0wvQUfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMi8I1HvtK5RqRuYpPA1SfRtp5+vH+jKxUQwHPUrHCvQWgOepN7SECKv/jEpq1owH
         yedLXnbq/7wxwRepL2ehbcyFIMl02X8MvWKW3CcmN5mAL1iMagF/UHTmohyhi/LHuU
         KzAC8v6tfJ+MeiEb06iAx/jxGS/02bJgcCmm+TBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Josh Triplett <josh@joshtriplett.org>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.5 31/65] ext4: fix incorrect inodes per group in error message
Date:   Mon, 20 Apr 2020 14:38:35 +0200
Message-Id: <20200420121512.931858314@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Triplett <josh@joshtriplett.org>

commit b9c538da4e52a7b79dfcf4cfa487c46125066dfb upstream.

If ext4_fill_super detects an invalid number of inodes per group, the
resulting error message printed the number of blocks per group, rather
than the number of inodes per group. Fix it to print the correct value.

Fixes: cd6bb35bf7f6d ("ext4: use more strict checks for inodes_per_block on mount")
Link: https://lore.kernel.org/r/8be03355983a08e5d4eed480944613454d7e2550.1585434649.git.josh@joshtriplett.org
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4112,7 +4112,7 @@ static int ext4_fill_super(struct super_
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > blocksize * 8) {
 		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
-			 sbi->s_blocks_per_group);
+			 sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /


