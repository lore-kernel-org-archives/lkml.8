Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF2A20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135292;
	bh=WsH5rsfravKmuuuiwWQhBWqP7Cck0ZBhMELlT9mviME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t1s9eA0Cy9dUPgBrFKBTwFXXRCDMCOf7IHc+5i32MTIktQaVErpUQKzKB9cbcjNfU
	 uGMF34blOqwrQ8YFE+fVe77dlEkTV7GkNNkxVNSamEG+4XhqePsYlmcufAvul7EF16
	 5nFQuefK0QxTu2OPL9y3laBFQI/d0GcDCtozmvEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGGPVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbgGGPV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0FC2065D;
        Tue,  7 Jul 2020 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135285;
        bh=WsH5rsfravKmuuuiwWQhBWqP7Cck0ZBhMELlT9mviME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w50S3lLebhVKOq4mPCG+18JxxWaR3C6R/4o3T5p2WkgwwTVJRUhWQFY0w82+mI9wQ
         oEo09gzqAhpYPZev/eZ00iCh9ISznDQwgYmn7ZYjOnopLOLoE6IzXOuowyfRhnP2ZI
         5jkRUW6ObWkGYWZ3K5GY2bxrr8weXjiHQ4cbloXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elliott Mitchell <ehem+debian@m5p.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.4 47/65] nfsd: apply umask on fs without ACL support
Date:   Tue,  7 Jul 2020 17:17:26 +0200
Message-Id: <20200707145754.738233143@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@redhat.com>

commit 22cf8419f1319ff87ec759d0ebdff4cbafaee832 upstream.

The server is failing to apply the umask when creating new objects on
filesystems without ACL support.

To reproduce this, you need to use NFSv4.2 and a client and server
recent enough to support umask, and you need to export a filesystem that
lacks ACL support (for example, ext4 with the "noacl" mount option).

Filesystems with ACL support are expected to take care of the umask
themselves (usually by calling posix_acl_create).

For filesystems without ACL support, this is up to the caller of
vfs_create(), vfs_mknod(), or vfs_mkdir().

Reported-by: Elliott Mitchell <ehem+debian@m5p.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Fixes: 47057abde515 ("nfsd: add support for the umask attribute")
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/vfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1184,6 +1184,9 @@ nfsd_create_locked(struct svc_rqst *rqst
 		iap->ia_mode = 0;
 	iap->ia_mode = (iap->ia_mode & S_IALLUGO) | type;
 
+	if (!IS_POSIXACL(dirp))
+		iap->ia_mode &= ~current_umask();
+
 	err = 0;
 	host_err = 0;
 	switch (type) {
@@ -1416,6 +1419,9 @@ do_nfsd_create(struct svc_rqst *rqstp, s
 		goto out;
 	}
 
+	if (!IS_POSIXACL(dirp))
+		iap->ia_mode &= ~current_umask();
+
 	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
 	if (host_err < 0) {
 		fh_drop_write(fhp);


