Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67A2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339931;
	bh=bX7GnoWQ6l6nAAzkQaHSk/xwhKV1gQokzvDLbi/ZR5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I3/DbDbKF2Ncy7TmJyzpL6G4xODXugVB2iNiThbmjlSQyVkyZvn27NDKeltggubLS
	 5pcDopZluYRvHuz+2aZ0R49Kg9h91C371HH1b7hmyo0Nf62xPHsKe5gKnDCC7dmU1q
	 b4wnZQwT8MDUj7GoanYaE77ufUrOGvjdx1ROfpT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgBJNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgBJMkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1562173E;
        Mon, 10 Feb 2020 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338402;
        bh=bX7GnoWQ6l6nAAzkQaHSk/xwhKV1gQokzvDLbi/ZR5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xw2S4PS2s+QODCTK4UEkCfK4XdMYL2OiJb8joDijcIGAV5x3tOK7Ei07dfZ1z+H9w
         TN8De6OpNKunDwWbZow4adRW0VHvfo+OWZdvOcrCpEV+d3ZfTUOsqeQoMHrcoDolm+
         xE7IbsDb0maQuT+FHQevbm7GHtHSDSw3rXmTOgIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5.5 101/367] fscrypt: dont print name of busy file when removing key
Date:   Mon, 10 Feb 2020 04:30:14 -0800
Message-Id: <20200210122433.696258343@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 13a10da94615d81087e718517794f2868a8b3fab upstream.

When an encryption key can't be fully removed due to file(s) protected
by it still being in-use, we shouldn't really print the path to one of
these files to the kernel log, since parts of this path are likely to be
encrypted on-disk, and (depending on how the system is set up) the
confidentiality of this path might be lost by printing it to the log.

This is a trade-off: a single file path often doesn't matter at all,
especially if it's a directory; the kernel log might still be protected
in some way; and I had originally hoped that any "inode(s) still busy"
bugs (which are security weaknesses in their own right) would be quickly
fixed and that to do so it would be super helpful to always know the
file path and not have to run 'find dir -inum $inum' after the fact.

But in practice, these bugs can be hard to fix (e.g. due to asynchronous
process killing that is difficult to eliminate, for performance
reasons), and also not tied to specific files, so knowing a file path
doesn't necessarily help.

So to be safe, for now let's just show the inode number, not the path.
If someone really wants to know a path they can use 'find -inum'.

Fixes: b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
Cc: <stable@vger.kernel.org> # v5.4+
Link: https://lore.kernel.org/r/20200120060732.390362-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/crypto/keyring.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -666,9 +666,6 @@ static int check_for_busy_inodes(struct
 	struct list_head *pos;
 	size_t busy_count = 0;
 	unsigned long ino;
-	struct dentry *dentry;
-	char _path[256];
-	char *path = NULL;
 
 	spin_lock(&mk->mk_decrypted_inodes_lock);
 
@@ -687,22 +684,14 @@ static int check_for_busy_inodes(struct
 					 struct fscrypt_info,
 					 ci_master_key_link)->ci_inode;
 		ino = inode->i_ino;
-		dentry = d_find_alias(inode);
 	}
 	spin_unlock(&mk->mk_decrypted_inodes_lock);
 
-	if (dentry) {
-		path = dentry_path(dentry, _path, sizeof(_path));
-		dput(dentry);
-	}
-	if (IS_ERR_OR_NULL(path))
-		path = "(unknown)";
-
 	fscrypt_warn(NULL,
-		     "%s: %zu inode(s) still busy after removing key with %s %*phN, including ino %lu (%s)",
+		     "%s: %zu inode(s) still busy after removing key with %s %*phN, including ino %lu",
 		     sb->s_id, busy_count, master_key_spec_type(&mk->mk_spec),
 		     master_key_spec_len(&mk->mk_spec), (u8 *)&mk->mk_spec.u,
-		     ino, path);
+		     ino);
 	return -EBUSY;
 }
 


