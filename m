Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3B6207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222907;
	bh=jFBkBZpR37Xa506YkLZCDaF6CQW7L2QeG0BSlqy/7Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GqjYe1RRXrclLqdlhR6lTqhjxEYh3SCYThT1vA84zECIDCZyZnR7L4I+iniOQsY1j
	 j9WMvGMjaIe22Ekku+OPzCulfiUhtRuyLDgZh3fhg0JOs0/5DiKpSqDJuRHOBiC9cG
	 BdzzPeBPQXJOmTMiOnF4Rj7TAlFkObDHrVLS4hqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgA1Os0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgA1OCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:02:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA8024695;
        Tue, 28 Jan 2020 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220154;
        bh=jFBkBZpR37Xa506YkLZCDaF6CQW7L2QeG0BSlqy/7Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QFGBWnViUzI8nRODgViJUaF6nLzTpw6pnJDKAIe+DpTLoyQ3BUuEb/CObgtGti9Q
         UuRg2KxQJUzblwm87YL808+aKk9IN83bXHevd/QI/KvyzdzRPGL4FK/xKkMHL6Uf36
         r9V7WLztZDMFAOG5c4XylOimKN/dmaWo1qC43264=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.4 037/104] ceph: hold extra reference to r_parent over life of request
Date:   Tue, 28 Jan 2020 14:59:58 +0100
Message-Id: <20200128135822.575355015@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 9c1c2b35f1d94de8325344c2777d7ee67492db3b upstream.

Currently, we just assume that it will stick around by virtue of the
submitter's reference, but later patches will allow the syscall to
return early and we can't rely on that reference at that point.

While I'm not aware of any reports of it, Xiubo pointed out that this
may fix a use-after-free.  If the wait for a reply times out or is
canceled via signal, and then the reply comes in after the syscall
returns, the client can end up trying to access r_parent without a
reference.

Take an extra reference to the inode when setting r_parent and release
it when releasing the request.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -708,8 +708,10 @@ void ceph_mdsc_release_request(struct kr
 		/* avoid calling iput_final() in mds dispatch threads */
 		ceph_async_iput(req->r_inode);
 	}
-	if (req->r_parent)
+	if (req->r_parent) {
 		ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
+		ceph_async_iput(req->r_parent);
+	}
 	ceph_async_iput(req->r_target_inode);
 	if (req->r_dentry)
 		dput(req->r_dentry);
@@ -2670,8 +2672,10 @@ int ceph_mdsc_submit_request(struct ceph
 	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
 	if (req->r_inode)
 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
-	if (req->r_parent)
+	if (req->r_parent) {
 		ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
+		ihold(req->r_parent);
+	}
 	if (req->r_old_dentry_dir)
 		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
 				  CEPH_CAP_PIN);


