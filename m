Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC9C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFDB20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609012;
	bh=65fBfyQPv1VaRhQVaGHQ7hfbA9ZUL+AOopUzXpUIHtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfFio0OFzj7/xU5gbOxP6zrdPsnHoRMPAdPy1mNVzMNodf4I7Jk6w/HVW+7HW0J4C
	 1WMalTx8yyKFmYeIodBoU803gRS2Frj8EQEvhkNMVXwfAJmJnKdqudLF4hjtIC9HZv
	 nSSJhob3AGYzdHM7tGZYMjqWkOzk8j8UKze6efzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbgBMPuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387585AbgBMP0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B770B222C2;
        Thu, 13 Feb 2020 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607590;
        bh=65fBfyQPv1VaRhQVaGHQ7hfbA9ZUL+AOopUzXpUIHtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OQ8zSZJiA7/A33G2lhie3bJwwuHwP+vVPULNrEzvnGN37XSwGUdilMZxZNW01sXH
         CXcp9LSDelc4qo0JnU0FWsVjTNWwUqirgYM9xkrOE7D97DvtvCq/6YlOUXK5ppb81P
         t/sSWG2XYVJlDHTjtI3oCZPqvif4xsd8hSkxAe9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 13/52] NFS: Revalidate the file size on a fatal write error
Date:   Thu, 13 Feb 2020 07:20:54 -0800
Message-Id: <20200213151816.368564307@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 0df68ced55443243951d02cc497be31fadf28173 upstream.

If we suffer a fatal error upon writing a file, which causes us to
need to revalidate the entire mapping, then we should also revalidate
the file size.

Fixes: d2ceb7e57086 ("NFS: Don't use page_file_mapping after removing the page")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -240,7 +240,15 @@ out:
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
 static void nfs_set_pageerror(struct address_space *mapping)
 {
+	struct inode *inode = mapping->host;
+
 	nfs_zap_mapping(mapping->host, mapping);
+	/* Force file size revalidation */
+	spin_lock(&inode->i_lock);
+	NFS_I(inode)->cache_validity |= NFS_INO_REVAL_FORCED |
+					NFS_INO_REVAL_PAGECACHE |
+					NFS_INO_INVALID_SIZE;
+	spin_unlock(&inode->i_lock);
 }
 
 /*


