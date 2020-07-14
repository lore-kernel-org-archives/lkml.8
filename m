Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E886C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2AE2240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753736;
	bh=3logLcMQQOo83B8CEm+7SX7oSisRfIO2V1PiVpYBb2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QoRh2C0+nfyqfVjzQlu//7HBi5jS2tYP3dFDsoBZrms2KQ0NnxeAiPwWdIc5Kj5T2
	 3KyGc/+i+Yai2dvHu4sjB2cwDtMFpmYVGswmOm66fd16Z6GQt2VIgmc8qWon7PaKBN
	 BnRaX6MGgNagXVsnCJqkv3PUKnODbnrB82aslot0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgGNStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbgGNSt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA377222E9;
        Tue, 14 Jul 2020 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752568;
        bh=3logLcMQQOo83B8CEm+7SX7oSisRfIO2V1PiVpYBb2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqTCCTorVHWkeOhISefvAbFzgUzV3hKL2IdadVz3l3YBOmphXT+ApENVXkYjTQLND
         lxjrwj3+g71PB/8fj//FmUx2bEFQsTEjCNGT1Qp75/TGrbvcIpOT6YGMAsxVppY73l
         2l+v72PRsw7iJsFZf8VxpyMY216eGPBzhG4nJL6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/109] cifs: update ctime and mtime during truncate
Date:   Tue, 14 Jul 2020 20:43:30 +0200
Message-Id: <20200714184106.829713172@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

[ Upstream commit 5618303d8516f8ac5ecfe53ee8e8bc9a40eaf066 ]

As the man description of the truncate, if the size changed,
then the st_ctime and st_mtime fields should be updated. But
in cifs, we doesn't do it.

It lead the xfstests generic/313 failed.

So, add the ATTR_MTIME|ATTR_CTIME flags on attrs when change
the file size

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 6045b48682752..5ae458505f630 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2270,6 +2270,15 @@ set_size_out:
 	if (rc == 0) {
 		cifsInode->server_eof = attrs->ia_size;
 		cifs_setsize(inode, attrs->ia_size);
+
+		/*
+		 * The man page of truncate says if the size changed,
+		 * then the st_ctime and st_mtime fields for the file
+		 * are updated.
+		 */
+		attrs->ia_ctime = attrs->ia_mtime = current_time(inode);
+		attrs->ia_valid |= ATTR_CTIME | ATTR_MTIME;
+
 		cifs_truncate_page(inode->i_mapping, inode->i_size);
 	}
 
-- 
2.25.1



