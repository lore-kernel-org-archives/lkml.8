Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA1C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69D420780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552330;
	bh=UoxmTXfy6bjZv9139OaXUfWx1bTquwXo0PhsUWbBzp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWYCk1uOO2mgI0g6Ea0ieHcre0Ajq9+YLEYqM53vnz1LDSGYRgmYqsLFTD8oer8Sm
	 4G06CcEsHX2BelAbFaGWkYXjaxBkCiFp/ujenkdErNdvxkGwXXnfUhCFZUFoFvM/4b
	 dLlinDSXh8qagLZyaoM79q9vuJepkBRwNxrtS4b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgDVKR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbgDVKRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124E12076E;
        Wed, 22 Apr 2020 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550625;
        bh=UoxmTXfy6bjZv9139OaXUfWx1bTquwXo0PhsUWbBzp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyzjZfInlNLwtkARowKScW6QRgYiszfuBgwt2Zqg51feqWMC8p9buk+RVhSvy/bTn
         3HSE0rCD7fk/tKmnvEi29BTzEWN0Ql6I7tQUEaKpYyvxYhjuc7xKTtacrfUpalPL52
         baFnkawwKdoj55IxbQYJV5wa7iRjdDVNas1dG1YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 5.4 027/118] afs: Fix afs_d_validate() to set the right directory version
Date:   Wed, 22 Apr 2020 11:56:28 +0200
Message-Id: <20200422095036.339432568@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 40fc81027f892284ce31f8b6de1e497f5b47e71f upstream.

If a dentry's version is somewhere between invalid_before and the current
directory version, we should be setting it forward to the current version,
not backwards to the invalid_before version.  Note that we're only doing
this at all because dentry::d_fsdata isn't large enough on a 32-bit system.

Fix this by using a separate variable for invalid_before so that we don't
accidentally clobber the current dir version.

Fixes: a4ff7401fbfa ("afs: Keep track of invalid-before version for dentry coherency")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/dir.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1032,7 +1032,7 @@ static int afs_d_revalidate(struct dentr
 	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
-	afs_dataversion_t dir_version;
+	afs_dataversion_t dir_version, invalid_before;
 	long de_version;
 	int ret;
 
@@ -1084,8 +1084,8 @@ static int afs_d_revalidate(struct dentr
 	if (de_version == (long)dir_version)
 		goto out_valid_noupdate;
 
-	dir_version = dir->invalid_before;
-	if (de_version - (long)dir_version >= 0)
+	invalid_before = dir->invalid_before;
+	if (de_version - (long)invalid_before >= 0)
 		goto out_valid;
 
 	_debug("dir modified");


