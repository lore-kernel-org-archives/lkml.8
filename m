Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CB3214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050081;
	bh=RsUqFbevd0j8uU6mYkKun4A8c/pDL5nw1j9+lNF+rHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=juyvnNd07OBbqXosk7l0O/jC90+V9tGtbbIAlzZRfjzMfstFrooFDe8URuEdzr7zc
	 oO3GGNL+Az5MTxUzhsC8E0SVczazOTGGMPYUHWBY387uyLGPmF+rdOil3cB7G5Yksv
	 qHVyPHageAylcBqI7kmMKLtw8sNRhyvK2iATKZbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502403AbgDPPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441660AbgDPNuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402C62224F;
        Thu, 16 Apr 2020 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044999;
        bh=RsUqFbevd0j8uU6mYkKun4A8c/pDL5nw1j9+lNF+rHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFou7F9fyh9LwR1GwacHs1t8AuXIKxLBvoqcX+xsCNQs2wOI6AbrtGhGkZPaq8jlq
         bYcnXbH9EEUmBSGodUOtpaeCwNOTx1IJfw4midYmSnjTObhVOtd2bDdTPrZ5GC5YZ0
         N010mtmL87XZcggX0w6dxfBvVPRT4Ss7Oul3tdq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 189/232] nfsd: fsnotify on rmdir under nfsd/clients/
Date:   Thu, 16 Apr 2020 15:24:43 +0200
Message-Id: <20200416131338.778162350@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@redhat.com>

commit 69afd267982e733a555fede4e85fe30329ed0588 upstream.

Userspace should be able to monitor nfsd/clients/ to see when clients
come and go, but we're failing to send fsnotify events.

Cc: stable@kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfsctl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1333,6 +1333,7 @@ void nfsd_client_rmdir(struct dentry *de
 	dget(dentry);
 	ret = simple_rmdir(dir, dentry);
 	WARN_ON_ONCE(ret);
+	fsnotify_rmdir(dir, dentry);
 	d_delete(dentry);
 	inode_unlock(dir);
 }


