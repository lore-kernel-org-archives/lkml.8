Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947580;
	bh=dPmGxPGMWMKzHL8mfVbsqBkzs9hF4k9EuDE+oC0Fku4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHWOKsTIzasbbOO+tIxj1it2+UU0yRoBQUpQKw7cR+vyA6uMfFYfG1gNmZNCIo27l
	 LKvJwIohCwU1mXTNqAOjXdc9KN57yIJpYmBJUIrTDAepUkgBKsFJvz76nKR4orIWIl
	 A4CjXb0lNLaTh9/AOEMe6v57DzJUI+ReTD94MnBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbgFWV0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbgFWUSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:18:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1EC2145D;
        Tue, 23 Jun 2020 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943498;
        bh=dPmGxPGMWMKzHL8mfVbsqBkzs9hF4k9EuDE+oC0Fku4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iG8X548d2+rZjB3CqyzKe0RNZvHQGJTmDqGea6VFlgGnLcghY3f+Ky5Jaa9DBs4r6
         1Yad6iiQ4SCvubyRC1+ZlWlz9Qy5jS7Qrd7PrXhNvbQvOiOaVwzQECOvXMym3SRTRm
         EPPwOl7Tw1kupWPs8AA+IpA/J6LIl1jl6LT/GS6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Eric Biggers <ebiggers@google.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.7 416/477] ext4: avoid utf8_strncasecmp() with unstable name
Date:   Tue, 23 Jun 2020 21:56:53 +0200
Message-Id: <20200623195427.187563020@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 2ce3ee931a097e9720310db3f09c01c825a4580c upstream.

If the dentry name passed to ->d_compare() fits in dentry::d_iname, then
it may be concurrently modified by a rename.  This can cause undefined
behavior (possibly out-of-bounds memory accesses or crashes) in
utf8_strncasecmp(), since fs/unicode/ isn't written to handle strings
that may be concurrently modified.

Fix this by first copying the filename to a stack buffer if needed.
This way we get a stable snapshot of the filename.

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Cc: <stable@vger.kernel.org> # v5.2+
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Daniel Rosenberg <drosen@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/20200601200543.59417-1-ebiggers@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/dir.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -675,6 +675,7 @@ static int ext4_d_compare(const struct d
 	struct qstr qstr = {.name = str, .len = len };
 	const struct dentry *parent = READ_ONCE(dentry->d_parent);
 	const struct inode *inode = READ_ONCE(parent->d_inode);
+	char strbuf[DNAME_INLINE_LEN];
 
 	if (!inode || !IS_CASEFOLDED(inode) ||
 	    !EXT4_SB(inode->i_sb)->s_encoding) {
@@ -683,6 +684,21 @@ static int ext4_d_compare(const struct d
 		return memcmp(str, name->name, len);
 	}
 
+	/*
+	 * If the dentry name is stored in-line, then it may be concurrently
+	 * modified by a rename.  If this happens, the VFS will eventually retry
+	 * the lookup, so it doesn't matter what ->d_compare() returns.
+	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 */
+	if (len <= DNAME_INLINE_LEN - 1) {
+		memcpy(strbuf, str, len);
+		strbuf[len] = 0;
+		qstr.name = strbuf;
+		/* prevent compiler from optimizing out the temporary buffer */
+		barrier();
+	}
+
 	return ext4_ci_compare(inode, name, &qstr, false);
 }
 


