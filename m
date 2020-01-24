Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF22C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63020208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859140;
	bh=Al7dob067UuC/vr6Pcu7T93wYJXmJZTIrO1OFP3TziI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wJ0Uwqb30WgiuNHmVTt19cQDwm9/P88X3LDEs0PGeIZNwWrmn8seNdus3rnaakFTg
	 8c2fymcAiG5JB9Q+9es1Fq2q5vtSPPh8CiR8nu4sUYGyCKaCW7sqzOhnfQuS8/oDxH
	 Qobgh0HHcGnCcrsmHmlTpHvv6QD5SjQBfIjx2o/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbgAXJpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732804AbgAXJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:42:49 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19C120718;
        Fri, 24 Jan 2020 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858968;
        bh=Al7dob067UuC/vr6Pcu7T93wYJXmJZTIrO1OFP3TziI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrjOOI2g2tpKTFrVlj95LP9x1cD1FuyBRIedt7ElXqWpu2eJYLiOLx1o9cO8V5Gmf
         nl32tqcFdMQOCGvWixpKBmFkXn+5HM0yspMGw/YZvMaWcSPGeod+EW/hF5suCsOrNO
         UeRYbgmLr9C0zd9tOBAx7HbhDQKolQpQ+6wWTESM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/102] afs: Remove set but not used variables before, after
Date:   Fri, 24 Jan 2020 10:31:33 +0100
Message-Id: <20200124092820.580997462@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 51590df4f3306cb1f43dca54e3ccdd121ab89594 ]

Fixes gcc '-Wunused-but-set-variable' warning:

fs/afs/dir_edit.c: In function afs_set_contig_bits:
fs/afs/dir_edit.c:75:20: warning: variable after set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_set_contig_bits:
fs/afs/dir_edit.c:75:12: warning: variable before set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_clear_contig_bits:
fs/afs/dir_edit.c:100:20: warning: variable after set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_clear_contig_bits:
fs/afs/dir_edit.c:100:12: warning: variable before set but not used [-Wunused-but-set-variable]

They are never used since commit 63a4681ff39c.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir_edit.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index d4fbe5f85f1b2..b108528bf010d 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -68,13 +68,11 @@ static int afs_find_contig_bits(union afs_xdr_dir_block *block, unsigned int nr_
 static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 				int bit, unsigned int nr_slots)
 {
-	u64 mask, before, after;
+	u64 mask;
 
 	mask = (1 << nr_slots) - 1;
 	mask <<= bit;
 
-	before = *(u64 *)block->hdr.bitmap;
-
 	block->hdr.bitmap[0] |= (u8)(mask >> 0 * 8);
 	block->hdr.bitmap[1] |= (u8)(mask >> 1 * 8);
 	block->hdr.bitmap[2] |= (u8)(mask >> 2 * 8);
@@ -83,8 +81,6 @@ static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 	block->hdr.bitmap[5] |= (u8)(mask >> 5 * 8);
 	block->hdr.bitmap[6] |= (u8)(mask >> 6 * 8);
 	block->hdr.bitmap[7] |= (u8)(mask >> 7 * 8);
-
-	after = *(u64 *)block->hdr.bitmap;
 }
 
 /*
@@ -93,13 +89,11 @@ static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 				  int bit, unsigned int nr_slots)
 {
-	u64 mask, before, after;
+	u64 mask;
 
 	mask = (1 << nr_slots) - 1;
 	mask <<= bit;
 
-	before = *(u64 *)block->hdr.bitmap;
-
 	block->hdr.bitmap[0] &= ~(u8)(mask >> 0 * 8);
 	block->hdr.bitmap[1] &= ~(u8)(mask >> 1 * 8);
 	block->hdr.bitmap[2] &= ~(u8)(mask >> 2 * 8);
@@ -108,8 +102,6 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 	block->hdr.bitmap[5] &= ~(u8)(mask >> 5 * 8);
 	block->hdr.bitmap[6] &= ~(u8)(mask >> 6 * 8);
 	block->hdr.bitmap[7] &= ~(u8)(mask >> 7 * 8);
-
-	after = *(u64 *)block->hdr.bitmap;
 }
 
 /*
-- 
2.20.1



