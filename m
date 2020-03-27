Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3724C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969E0206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aFl/tKHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0T6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:58:04 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.104]:27106 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0T6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:58:04 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B24655446A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:58:02 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Hv7CjWj1l8vkBHv7CjMN51; Fri, 27 Mar 2020 14:58:02 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BeuzSJqhbI7Sy5DD0lNgT5zLFB8JnttXuEFOYmqN6kg=; b=aFl/tKHUcDOoccm3ZhoAJyW+Qd
        jnJcRS9T5IDzI0En1j7D1Ughj2qYWI3kNrZR4CrNM9XCU2Jg9ULCFOS11ok/30BuAFmFd6fPu34z0
        /pTZPBje0fYlVqHrHh9Ogcm4pRvOwjcoZE+iLZGoSTajgUsVR8L7cKWY2LFT1qxY11Qj2Q5u1HQ74
        tjS0/iRFCtRt96akXG6e24A1QH7Wn55UypZF2SxAiEoLKcX/CE6UPlYUfRSPHHuobhzESmxxQRVjQ
        kQFJO+JFs5jDLxLEqE0hD6fNlEBl925gCcFT2hBeuf20D4E2qCemI6yNFTUHWlB/KYpXiP3FmK16W
        bSkHll9g==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:45334 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jHv7B-002Xgn-6w; Fri, 27 Mar 2020 14:58:01 -0500
Date:   Fri, 27 Mar 2020 15:01:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] btrfs: inode: Fix uninitialized variable bug
Message-ID: <20200327200135.GA3472@embeddedor>
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
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jHv7B-002Xgn-6w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:45334
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

geom.len is being used without being properly initialized, previously.

Fix this by placing ASSERT(geom.len <= INT_MAX); after geom.len has been
initialized.

Addresses-Coverity-ID: 1491912 ("Uninitialized scalar variable")
Fixes: 1eb52c8bd8d6 ("btrfs: get rid of one layer of bios in direct I/O")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fce94591e092..00ea02268f54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7637,7 +7637,6 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	else
 		async_submit = 1;
 
-	ASSERT(geom.len <= INT_MAX);
 	do {
 		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
 					    start_sector << 9, submit_len,
@@ -7647,6 +7646,8 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 			goto out_err;
 		}
 
+		ASSERT(geom.len <= INT_MAX);
+
 		clone_len = min_t(int, submit_len, geom.len);
 
 		/*
-- 
2.26.0

