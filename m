Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337C3208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860222;
	bh=xVseHo3iC0VmKQwVQd9GVtUh9UlSz4Qgxs9CZ+LjUdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpbr9nAno7PA2afipfNG4Z3hqcsG5Q5v5V+CLJAbgr8zVUPebt+2l1kHZVx9FLrPc
	 G1336pg1/1d+pBkpDl6Q2auo4wUldWtnyOKQZu05Sm5OfGheh1t/OSYcV/waK7KRSh
	 5mNyTL9XCs61LYFw26xYtolREnX+Jp8iq1kmbkBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389050AbgAXKDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbgAXKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:03:38 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609C2214DB;
        Fri, 24 Jan 2020 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860218;
        bh=xVseHo3iC0VmKQwVQd9GVtUh9UlSz4Qgxs9CZ+LjUdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrejZw9osSZIrYGb+nNANWUvsyjbYjlcPy3CqFlVHSwAdkzCBQbSgRriSzzhjFSbn
         4+X+4nbzvD/Fo+fuM+6ftkRZEgl4/XxglZGqQlN/LjFWVBubZ6+aI0jDggD2F1ZDEo
         ztwBfxBgp1NWhFjuA/70t/FVD0yPVPDUYjupR/5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 269/343] ext4: set error return correctly when ext4_htree_store_dirent fails
Date:   Fri, 24 Jan 2020 10:31:27 +0100
Message-Id: <20200124092955.347763301@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 137c752ab9853..6064bcb8572b3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1425,7 +1425,7 @@ int htree_inlinedir_to_tree(struct file *dir_file,
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



