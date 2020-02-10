Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE929C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DEE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340661;
	bh=1DzAot5pnz6EAgy2/0+NZ/dX0aTvnOIMFZW27J9PQvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFoOjvL31NE4ZqO2VvEHA5XOgsgJNqzhD15YjrQSvF7TMuhwB9RIZK8d/E1NGvSt6
	 pacoTAzlXSogoFjnTHMmgVTImVP6MtOQO3eshlLHatQEK/2JDgMuL/jnrhIilpSXRB
	 3wRff7H8llMFmvYed0E67sphNiNouNgqQ7Wi/5nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgBJNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBJMiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:01 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD7A20838;
        Mon, 10 Feb 2020 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338280;
        bh=1DzAot5pnz6EAgy2/0+NZ/dX0aTvnOIMFZW27J9PQvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJBjW7+0EOwlpW2dEZr51yacU3LmsOdwGL/7O5uFVv3xTT7DE+syWyLYW8zuyrICH
         I6dPCKpZyZHry4Qlc1hZSzYFm7aYF+S+g6ubogUmx6C8+bQLc0afj4kznpT3E3wXrD
         WAIhx6cevD5tBX/HEwW1kBxBDbwUw8BOKADLScpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 170/309] ext4: fix race conditions in ->d_compare() and ->d_hash()
Date:   Mon, 10 Feb 2020 04:32:06 -0800
Message-Id: <20200210122422.693501324@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit ec772f01307a2c06ebf6cdd221e6b518a71ddae7 upstream.

Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
->d_parent and ->d_inode can be concurrently modified, and in
particular, ->d_inode may be changed to NULL.  For ext4_d_hash() this
resulted in a reproducible NULL dereference if a lookup is done in a
directory being deleted, e.g. with:

	int main()
	{
		if (fork()) {
			for (;;) {
				mkdir("subdir", 0700);
				rmdir("subdir");
			}
		} else {
			for (;;)
				access("subdir/file", 0);
		}
	}

... or by running the 't_encrypted_d_revalidate' program from xfstests.
Both repros work in any directory on a filesystem with the encoding
feature, even if the directory doesn't actually have the casefold flag.

I couldn't reproduce a crash in ext4_d_compare(), but it appears that a
similar crash is possible there.

Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
falling back to the case sensitive behavior if the inode is NULL.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20200124041234.159740-1-ebiggers@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/dir.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -673,9 +673,11 @@ static int ext4_d_compare(const struct d
 			  const char *str, const struct qstr *name)
 {
 	struct qstr qstr = {.name = str, .len = len };
-	struct inode *inode = dentry->d_parent->d_inode;
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);
 
-	if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {
+	if (!inode || !IS_CASEFOLDED(inode) ||
+	    !EXT4_SB(inode->i_sb)->s_encoding) {
 		if (len != name->len)
 			return -1;
 		return memcmp(str, name->name, len);
@@ -688,10 +690,11 @@ static int ext4_d_hash(const struct dent
 {
 	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
 	const struct unicode_map *um = sbi->s_encoding;
+	const struct inode *inode = READ_ONCE(dentry->d_inode);
 	unsigned char *norm;
 	int len, ret = 0;
 
-	if (!IS_CASEFOLDED(dentry->d_inode) || !um)
+	if (!inode || !IS_CASEFOLDED(inode) || !um)
 		return 0;
 
 	norm = kmalloc(PATH_MAX, GFP_ATOMIC);


