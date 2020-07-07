Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA33C20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135526;
	bh=2kAUGIU5XmBNAS6FEhoBElVdyYajeVA3nMMV/x7qI/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4ljcaRao8gdtrH64ypDnfgfaQ/A2CpBJXHXCCS86Uu8w9dvCkwqKWD6yt6xy79fx
	 2udYHPT+QhMYnuCpkoLU2uF+9vperHz3VckTNgWDr4znE7hW0/CwJqAkhB2br50trF
	 NaiBn2CBY/yLYVWXmQ90rO244Qh94GoZW04KSHl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgGGPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbgGGPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:25:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111E42078D;
        Tue,  7 Jul 2020 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135517;
        bh=2kAUGIU5XmBNAS6FEhoBElVdyYajeVA3nMMV/x7qI/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j64qSQ4nQhQRKZRTFgNi8HE94QpflpIKhsK6dPQzvXz5pDnNrIunZogA+M5GhmH6G
         Z1CtuVcnS/KWhk/m761nq08mXgLzcTCKNzvVIszUVFSYPjIkni04AHBZm8yAse5Ahq
         8Qk6KYyY2lX5uW5evph3UpiDvipPxgQWiIsgDnGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 073/112] nfsd: fix nfsdfs inode reference count leak
Date:   Tue,  7 Jul 2020 17:17:18 +0200
Message-Id: <20200707145804.472306222@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@redhat.com>

[ Upstream commit bf2654017e0268cc83dc88d56f0e67ff4406631d ]

I don't understand this code well, but  I'm seeing a warning about a
still-referenced inode on unmount, and every other similar filesystem
does a dput() here.

Fixes: e8a79fb14f6b ("nfsd: add nfsd/clients directory")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9b22d857549c3..f298aad41070f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1335,6 +1335,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
 	WARN_ON_ONCE(ret);
 	fsnotify_rmdir(dir, dentry);
 	d_delete(dentry);
+	dput(dentry);
 	inode_unlock(dir);
 }
 
-- 
2.25.1



