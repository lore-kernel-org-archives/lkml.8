Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8C20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865175;
	bh=K+D7iZJvxBljDBeZS49YJgy+ZZwvIV6A4ChR8TLxfQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keig6ZJQoQ2t6StFPmwDaF63QtPjz2Ylq4yLA5FfOxZ9fndaeJEOCheFaBNaXOQ3k
	 xo8dKSBoajfyWLn7AbqzKe7DCmPLdI4RPz1JBb2Q+WO236KHDDuv1Nq1//es3PvKjd
	 Zz9TEd5jPaikNd8hDYQiQRabSNbFfBCF/1RYlTeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbgAXL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389966AbgAXL0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:09 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAD320704;
        Fri, 24 Jan 2020 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865169;
        bh=K+D7iZJvxBljDBeZS49YJgy+ZZwvIV6A4ChR8TLxfQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8A7s+g7HgkvNJxyLGnAlI3pwxlPGQbuOPU9iVjZjQA5oZdjvm9mfeUi96VqhuVhg
         NJ2yjjb86h0nozpF3JE+0EuujqN1Fsd9IV0D2HhdD9xtJPxrinP1a5oEUY0CniOQtA
         AjcYLF2jet24DJZgs3424a7PMV4cn3aRGFVHFQXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 472/639] ceph: fix "ceph.dir.rctime" vxattr value
Date:   Fri, 24 Jan 2020 10:30:42 +0100
Message-Id: <20200124093146.764584528@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit 718807289d4130be1fe13f24f018733116958070 ]

The vxattr value incorrectly places a "09" prefix to the nanoseconds
field, instead of providing it as a zero-pad width specifier after '%'.

Fixes: 3489b42a72a4 ("ceph: fix three bugs, two in ceph_vxattrcb_file_layout()")
Link: https://tracker.ceph.com/issues/39943
Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5e4f3f833e85e..a09ce27ab2204 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -221,7 +221,7 @@ static size_t ceph_vxattrcb_dir_rbytes(struct ceph_inode_info *ci, char *val,
 static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
 				       size_t size)
 {
-	return snprintf(val, size, "%lld.09%ld", ci->i_rctime.tv_sec,
+	return snprintf(val, size, "%lld.%09ld", ci->i_rctime.tv_sec,
 			ci->i_rctime.tv_nsec);
 }
 
-- 
2.20.1



