Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE52C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDC9208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055731;
	bh=Wj+RQiMF4N/W2DnvCyurilLMP/PbjLwa2tX/gYzI2wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3zGTKIbWt34R2TT09EnUrbf5CxltFuiJsk9e5l2EctPlyG0GJ6C1RiXWsU0eh/6S
	 cl/y+3WpPVBUp0GxlaKkHmFEKRi7LsFiV2CDETq5f3zJ25hzmU9cDVLa+aeXTDdeOq
	 3yTqTsaQfadsl/CK/Ng+ayimLbjKLOlqCsEsbTXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCXNP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgCXNP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:15:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94FDC206F6;
        Tue, 24 Mar 2020 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055727;
        bh=Wj+RQiMF4N/W2DnvCyurilLMP/PbjLwa2tX/gYzI2wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKzYr3fRBFd0v61MoRrmR0C7xlusW/agQlKcqVV+RdeeW3qx3OnKnNMX5KsvyIAL3
         jEwWtY2+nzwgce1FJEPT6fD+dDhpJ2OhvnKVobNgCms0c9ctvs0oYrqt7uidww2q52
         tCKzoQzUxb4qH7BJs2icNHoWhIf1x1a5HxfAvmi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 010/102] cifs: fix potential mismatch of UNC paths
Date:   Tue, 24 Mar 2020 14:10:02 +0100
Message-Id: <20200324130807.607238608@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara (SUSE) <pc@cjr.nz>

[ Upstream commit 154255233830e1e4dd0d99ac929a5dce588c0b81 ]

Ensure that full_path is an UNC path that contains '\\' as delimiter,
which is required by cifs_build_devname().

The build_path_from_dentry_optional_prefix() function may return a
path with '/' as delimiter when using SMB1 UNIX extensions, for
example.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_dfs_ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index 606f26d862dc1..cc3ada12848d9 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -324,6 +324,8 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 	if (full_path == NULL)
 		goto cdda_exit;
 
+	convert_delimiter(full_path, '\\');
+
 	cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
 
 	if (!cifs_sb_master_tlink(cifs_sb)) {
-- 
2.20.1



