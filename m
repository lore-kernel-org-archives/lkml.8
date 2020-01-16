Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E052D22522
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197775;
	bh=GaxRd32QNh4xzUPFjDuNEJZDlmxG95D33bABRsKWwp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwdH+Wm4AhXT379V9ZXNP0WUbu0/yvR9QlK4wpR89KOL3peDIaO5RfPIx8EYOmoAa
	 5GHWAdJKCbspsOmudBblADgHWnh3w+NYw+iQFZB0RBfBBRZ+TQty/4HxtJwhNyOk9l
	 K7xDgtHVSWZCOaJbK643t6hRVdI9hp5Tp+FrK2JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405476AbgAPRlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393579AbgAPRkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6B624705;
        Thu, 16 Jan 2020 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196403;
        bh=GaxRd32QNh4xzUPFjDuNEJZDlmxG95D33bABRsKWwp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFeTE8LSIpofzbuqAcfTImiKPoge4K+o/tM7hNYfco1QRRC+BTLqmNcJbLk3mefEe
         5q3DcGYDkB6RaaIyiqO72z5Wm67alBvDH9KEB/2md2dP2zm+2ie98r4ZjvftrJusEc
         fniJwUy7QCLJzh1kDBEzAxSlOMduzOADbIulSzug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 179/251] ext4: set error return correctly when ext4_htree_store_dirent fails
Date:   Thu, 16 Jan 2020 12:35:28 -0500
Message-Id: <20200116173641.22137-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 7a14826ede1d714f0bb56de8167c0e519041eeda ]

Currently when the call to ext4_htree_store_dirent fails the error return
variable 'ret' is is not being set to the error code and variable count is
instead, hence the error code is not being returned.  Fix this by assigning
ret to the error return code.

Addresses-Coverity: ("Unused value")
Fixes: 8af0f0822797 ("ext4: fix readdir error in the case of inline_data+dir_index")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9a13f86fed62..4df4d31057b3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1417,7 +1417,7 @@ int htree_inlinedir_to_tree(struct file *dir_file,
 		err = ext4_htree_store_dirent(dir_file, hinfo->hash,
 					      hinfo->minor_hash, de, &tmp_str);
 		if (err) {
-			count = err;
+			ret = err;
 			goto out;
 		}
 		count++;
-- 
2.20.1

