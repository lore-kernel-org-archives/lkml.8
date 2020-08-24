Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F2E207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261160;
	bh=G343O5zXct8Gjh/XR2kSlojFg+A+zPRcw02RL1ptuFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFVnXpvlLQiNIUFixpaKyL122ng4PN1S3jpoFD4GItwmHkD5LYoaR6FFdO4xlNdWo
	 64zqm+KIwtDBRLRp+Vys8y4MQoalnlYHKeJZIePd3IETOycZwO39eeu3E0caYyApQe
	 exk1sfKdr19+d3Jp2LE+VHZ96On0HMqcAdf3Pxao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgHXJZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgHXIxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:53:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F812072D;
        Mon, 24 Aug 2020 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259196;
        bh=G343O5zXct8Gjh/XR2kSlojFg+A+zPRcw02RL1ptuFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlMAtwoefIqpbpA/TUWW2TKq4aFUeMtBLFi+F08Yeb42QkCGihr9dRKU9bevBGfv2
         Digypsykqmkq6Djy7wis29f1WsUq7GOsP7bZX10gHHkIntDtU4mLFlqf8X+sJqLQ74
         lHPwN4gKnTeU4aFSIaApHBExaAUwiAXbs1O5IZjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/50] btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
Date:   Mon, 24 Aug 2020 10:31:10 +0200
Message-Id: <20200824082352.379084187@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit cecc8d9038d164eda61fbcd72520975a554ea63e ]

This label is only executed if compress_file_range fails to create an
inline extent. So move its code in the semantically related inline
extent handling branch. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 57908ee964a20..dc520749f51db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -629,7 +629,14 @@ cont:
 				btrfs_free_reserved_data_space_noquota(inode,
 							       start,
 							       end - start + 1);
-			goto free_pages_out;
+
+			for (i = 0; i < nr_pages; i++) {
+				WARN_ON(pages[i]->mapping);
+				put_page(pages[i]);
+			}
+			kfree(pages);
+
+			return;
 		}
 	}
 
@@ -708,13 +715,6 @@ cleanup_and_bail_uncompressed:
 	*num_added += 1;
 
 	return;
-
-free_pages_out:
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON(pages[i]->mapping);
-		put_page(pages[i]);
-	}
-	kfree(pages);
 }
 
 static void free_async_extent_pages(struct async_extent *async_extent)
-- 
2.25.1



