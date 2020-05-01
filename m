Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3188C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C382024954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340133;
	bh=8+Z3bPY/+ATKg0yxbbKyU/p0SR7a96PJKqFB9MHvaBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6qMysMa+gck+adivmPaGkSqQnc2kibVqqmkCOuzA4s5xRdkYiB1Oo41xevIx0scZ
	 pd6dl/hZZL2X1iXR+ttMQV/HKTZ1S+sFWKtLcOH85871ytBGA8nYE6FVdcqe3e3Yxs
	 fCDG8ibk7vzg5QJehq8Z0p5CJRAiuCySL+G5dVV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgEANfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730670AbgEANfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360A7208DB;
        Fri,  1 May 2020 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340121;
        bh=8+Z3bPY/+ATKg0yxbbKyU/p0SR7a96PJKqFB9MHvaBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytYrQA9g+h2XjnLLC1fBi3UyYBmF4nuO8G2U3+KY9KD8uVn8stCmNcG0zPGxreXjI
         1ydjZYIaQczAvSzJCcgmTPybmGEGckZAfXqc3PnoUFvopfsQVcxLM/NDcjRE+FeMo1
         e0S6Pg6JZCAQ3pOlUqUJjjQfB35BHh2ll2JcXuQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Theodore Tso <tytso@mit.edu>, Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 4.14 115/117] ext4: unsigned int compared against zero
Date:   Fri,  1 May 2020 15:22:31 +0200
Message-Id: <20200501131558.583083940@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit fbbbbd2f28aec991f3fbc248df211550fbdfd58c upstream.

There are two cases where u32 variables n and err are being checked
for less than zero error values, the checks is always false because
the variables are not signed. Fix this by making the variables ints.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ashwin H <ashwinh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/block_validity.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -142,7 +142,8 @@ static int ext4_protect_reserved_inode(s
 	struct inode *inode;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_map_blocks map;
-	u32 i = 0, err = 0, num, n;
+	u32 i = 0, num;
+	int err = 0, n;
 
 	if ((ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(sbi->s_es->s_inodes_count)))


