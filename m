Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC0C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFD320575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100115;
	bh=9sDGtt4AzKAVwBWf89jS6ybRmtp4c5IDIplgFw7is60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QeRsiq0x5zM9GTQ61sZ4e9mynFs4Ohil0C+oyrv8a6kU+DmOt2KTUyuzKYy7qrQJV
	 Jo2rBlMffI06A4HFDWHaxzv2NnY1DTzqqVxz900v7L4L68wjEOwNy01OKyTTm6ikHo
	 ClLxpzvKLa1pxjQr4/iRZbHGXkfsHb+fmeWGYXe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgD1SzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgD1Sc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:32:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96072186A;
        Tue, 28 Apr 2020 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098778;
        bh=9sDGtt4AzKAVwBWf89jS6ybRmtp4c5IDIplgFw7is60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sy3ZfqPBA5N0uPrEkduPJx3PmKawUUma27SnRdydWFFdIwM0zDXXDTz7kSE6c3xrL
         gnv7DFV9HwHZStZkuSf0XU9Z1BxNNGn3FFgADmMaKKa2VZqHg2u3NbWZ1jwi0vDFWk
         C6QuFuqJrT1WaNfGysHegje/pMWNLs2wHcAbCLNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/168] ceph: return ceph_mdsc_do_request() errors from __get_parent()
Date:   Tue, 28 Apr 2020 20:23:08 +0200
Message-Id: <20200428182233.502140057@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit c6d50296032f0b97473eb2e274dc7cc5d0173847 ]

Return the error returned by ceph_mdsc_do_request(). Otherwise,
r_target_inode ends up being NULL this ends up returning ENOENT
regardless of the error.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b6bfa94332c30..79dc06881e78e 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -315,6 +315,11 @@ static struct dentry *__get_parent(struct super_block *sb,
 
 	req->r_num_caps = 1;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (err) {
+		ceph_mdsc_put_request(req);
+		return ERR_PTR(err);
+	}
+
 	inode = req->r_target_inode;
 	if (inode)
 		ihold(inode);
-- 
2.20.1



