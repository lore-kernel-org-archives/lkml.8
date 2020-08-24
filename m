Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8842821741
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259386;
	bh=2sFzfDN1X4rft1xo87I6/mJAix3xrEMTqSG8tIKT3is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BJdh0eSrps+54S2oHPbsNfZ1D8eKiTnEx9HZwj5b868YRI/7weVqG45p93OA6HyG+
	 VqTHJP5K+sPTnIK1hLUT9Vgcy+z6ggX7fswfAYrKwhYnpVDRFfb+D5DL60g1S1/h4a
	 U/MtmgiA0WLhoFrQgUdzbaTYhIoU30mJEV84m89E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgHXI4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbgHXIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB4A2072D;
        Mon, 24 Aug 2020 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259342;
        bh=2sFzfDN1X4rft1xo87I6/mJAix3xrEMTqSG8tIKT3is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTs/sfWQD16nTQS5cIoMWbHW3yhJgsiPWIVC+HtlFfNyjLXMhRTfivVF+xS+b5JYh
         tx+CeuIiLI4ObHRPsZ5mYiuHdWgcOuOItYtTD6Uos5CKf8XMdZXx1mOgD81pAKRJxh
         0rI+iz8i6QUOdOvBZI6G7zgW213irj8V77CwbZkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/71] btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
Date:   Mon, 24 Aug 2020 10:30:58 +0200
Message-Id: <20200824082356.249587938@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
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
index 1656ef0e959f0..8507192cd6449 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -628,7 +628,14 @@ cont:
 						     PAGE_SET_WRITEBACK |
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
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
 
@@ -706,13 +713,6 @@ cleanup_and_bail_uncompressed:
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



