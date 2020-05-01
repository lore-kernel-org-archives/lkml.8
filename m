Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C39C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1001F205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340991;
	bh=0u6wEzb76ncdT0z6fHVNlCKNH9+f7uchnCCQjeDtbPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L9xEMXOHDWljRIKAt6JOsq1Wd3V1ZQbFp1GnlIzzqydl5BC5LrRNqF7wd3ynCkrWH
	 W8KnE6w/mfycsuPXOQq1d4e3oyx0AN7sANQeQZ3ZbYU1DetTVLuigCrWl8hv5Y4XUB
	 n7cd/j5OcfqUApYVQ/3KOWpRb7SFcL1FzIzL2iKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgEANtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731329AbgEANkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034D5205C9;
        Fri,  1 May 2020 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340452;
        bh=0u6wEzb76ncdT0z6fHVNlCKNH9+f7uchnCCQjeDtbPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ws2DQa1vZn3xI8OzjJ+TpdwqAsmDiBICibMonZFNM6SxjGlTJErNeEtyg6SjdD0tl
         QxLeNROEanBry2kfR/Nlldo3j/JvV0lTFhjQ55adhpUIS78PKPTAnvcBCjkEu1FJAl
         /azPOPI4OyFnVIl2EuY9ou/UjTrALIYyq7elo/xE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 73/83] ext4: convert BUG_ONs to WARN_ONs in mballoc.c
Date:   Fri,  1 May 2020 15:23:52 +0200
Message-Id: <20200501131541.749303750@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 907ea529fc4c3296701d2bfc8b831dd2a8121a34 ]

If the in-core buddy bitmap gets corrupted (or out of sync with the
block bitmap), issue a WARN_ON and try to recover.  In most cases this
involves skipping trying to allocate out of a particular block group.
We can end up declaring the file system corrupted, which is fair,
since the file system probably should be checked before we proceed any
further.

Link: https://lore.kernel.org/r/20200414035649.293164-1-tytso@mit.edu
Google-Bug-Id: 34811296
Google-Bug-Id: 34639169
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c76ffc259d197..e1782b2e2e2dd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1936,7 +1936,8 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 	int free;
 
 	free = e4b->bd_info->bb_free;
-	BUG_ON(free <= 0);
+	if (WARN_ON(free <= 0))
+		return;
 
 	i = e4b->bd_info->bb_first_free;
 
@@ -1959,7 +1960,8 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 		}
 
 		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
-		BUG_ON(ex.fe_len <= 0);
+		if (WARN_ON(ex.fe_len <= 0))
+			break;
 		if (free < ex.fe_len) {
 			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
 					"%d free clusters as per "
-- 
2.20.1



