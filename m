Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478EFC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D320575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100304;
	bh=fgAPi6SmobpQ+fTyTrbXH1oguShDvqB2QYogzj2mDg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkI69p56VE2+Vfr43SyEx1IxmJWLxmXtAHCSfx513TcncqaxHGDMlbg77H8Vl6Ahg
	 fv0zYxQEAoyFD5duSnIN8MVW7tuZYRLxNZlTvbvwp6vy4VeSZ4B38vmUsr264h/8jN
	 1deP9OXFM7Ho3w4psKX51m/yXQoBmvldovh1B+fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgD1S3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgD1S3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6751020757;
        Tue, 28 Apr 2020 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098560;
        bh=fgAPi6SmobpQ+fTyTrbXH1oguShDvqB2QYogzj2mDg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXNa5uDRbw0TouwcQZuemhoy8b9FuwmOK++cCw+rL4t4WdIhDTHAH6THzcKeRNX8Z
         /BUPxQrpOc+XTFaebR6i2SFH3KGsRrrPxkI0PwX4grUaZV9L08ek6oxToQGAnGQS/e
         SY+0qKJsx4VTBQulVhAEVRIt0835g4UXnlsnEpPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/131] ceph: return ceph_mdsc_do_request() errors from __get_parent()
Date:   Tue, 28 Apr 2020 20:23:46 +0200
Message-Id: <20200428182226.973973467@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
index 3c59ad180ef0b..4cfe1154d4c72 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -151,6 +151,11 @@ static struct dentry *__get_parent(struct super_block *sb,
 
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



