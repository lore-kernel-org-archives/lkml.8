Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AA5222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846689;
	bh=M4RjzHem3X0FsBjOMuNyScD5wQbgCmaiyLwrIwa61vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S3/zmeV2etEomEDkQpxnsIrS0xuachV3cVoVKCCRvb0v9AOpM2I5xpz+J/7jo5l1F
	 zvSa2eTBcjxZ72c1WtaprLkaskG6lcVEGMf9QB42zP2QzzDveH3H8VtBcqyD8q+AA5
	 Amk256/sxKUgfw/hn4CPoWuSUtEWVhyDpAD4mVm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgCJM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbgCJM6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:58:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C7C92467D;
        Tue, 10 Mar 2020 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845117;
        bh=M4RjzHem3X0FsBjOMuNyScD5wQbgCmaiyLwrIwa61vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vleg5nwaJaHtb3q4upDRark1jhXhH07aODN5MwUnbn3IE8RtcLnufQQ0GKkwE3Lc9
         FFd2ITR35nur5YzptEpCbAYKzQC7AL7M1/CsUvkIirMhDvYqX6N5vTKM3dsI3MdCyB
         KqJ+2X1YSoRjKJ+/G21JDEPGdzfNTJ71clQIqjak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.5 067/189] cifs: dont leak -EAGAIN for stat() during reconnect
Date:   Tue, 10 Mar 2020 13:38:24 +0100
Message-Id: <20200310123646.371404844@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit fc513fac56e1b626ae48a74d7551d9c35c50129e upstream.

If from cifs_revalidate_dentry_attr() the SMB2/QUERY_INFO call fails with an
error, such as STATUS_SESSION_EXPIRED, causing the session to be reconnected
it is possible we will leak -EAGAIN back to the application even for
system calls such as stat() where this is not a valid error.

Fix this by re-trying the operation from within cifs_revalidate_dentry_attr()
if cifs_get_inode_info*() returns -EAGAIN.

This fixes stat() and possibly also other system calls that uses
cifs_revalidate_dentry*().

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2074,6 +2074,7 @@ int cifs_revalidate_dentry_attr(struct d
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = dentry->d_sb;
 	char *full_path = NULL;
+	int count = 0;
 
 	if (inode == NULL)
 		return -ENOENT;
@@ -2095,15 +2096,18 @@ int cifs_revalidate_dentry_attr(struct d
 		 full_path, inode, inode->i_count.counter,
 		 dentry, cifs_get_time(dentry), jiffies);
 
+again:
 	if (cifs_sb_master_tcon(CIFS_SB(sb))->unix_ext)
 		rc = cifs_get_inode_info_unix(&inode, full_path, sb, xid);
 	else
 		rc = cifs_get_inode_info(&inode, full_path, NULL, sb,
 					 xid, NULL);
-
+	if (rc == -EAGAIN && count++ < 10)
+		goto again;
 out:
 	kfree(full_path);
 	free_xid(xid);
+
 	return rc;
 }
 


