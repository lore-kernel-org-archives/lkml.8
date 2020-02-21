Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC3C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2C246A9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273485;
	bh=9j8X2m67R4Ml4yEuJzG98wz75DIpMegNzJAmtFU/4bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ArDks3IouW+bdyNfwRX/rg29ppgyR5Nlvdp+tWJDAK/gVKgXh6sRJFAGYGmW6Ru1W
	 k2EsB4GWmHIuE/1sNNhnB3wNdTXqBLe6qPAwAnSZcBkKxN4+rC74xEDEHccM+iMbK2
	 hBV/yMBKz0cknKoPLFpTurwmT9f0wM7MAwKVyqkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbgBUIYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388670AbgBUIYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514B5246A1;
        Fri, 21 Feb 2020 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273473;
        bh=9j8X2m67R4Ml4yEuJzG98wz75DIpMegNzJAmtFU/4bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2N0ZEwfynCz5w5cjaF14f99bq0DqRrbABWx0QNAyChwWJzUMACPO+Cjs2BgG0CttF
         o1bi5YdgYg5oWoSnhrFnz39IEBMSg0acurKqEKiM5vHgvzSZ34m/1I4lwoK8WwpuO9
         /cPYqM2iVcsG10D4ABjdN+xmld/P+irJhjAY+sco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 167/191] cifs: fix NULL dereference in match_prepath
Date:   Fri, 21 Feb 2020 08:42:20 +0100
Message-Id: <20200221072310.707468432@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit fe1292686333d1dadaf84091f585ee903b9ddb84 ]

RHBZ: 1760879

Fix an oops in match_prepath() by making sure that the prepath string is not
NULL before we pass it into strcmp().

This is similar to other checks we make for example in cifs_root_iget()

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 576cf71576da1..6c62ce40608a1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3342,8 +3342,10 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 {
 	struct cifs_sb_info *old = CIFS_SB(sb);
 	struct cifs_sb_info *new = mnt_data->cifs_sb;
-	bool old_set = old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH;
-	bool new_set = new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH;
+	bool old_set = (old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
+		old->prepath;
+	bool new_set = (new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
+		new->prepath;
 
 	if (old_set && new_set && !strcmp(new->prepath, old->prepath))
 		return 1;
-- 
2.20.1



