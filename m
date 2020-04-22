Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E082C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D51D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550276;
	bh=Q9whGS9I7eP5LIjRdf2IV6LOnzGxAaVCgwyaoGN0xTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2utL3onaBP+fjgMZoxlTV88AVTAWTE+fs7hCizue4Noe2uxjEu5/8gqEktuaVcMyT
	 JcQTonG+lnNhGnNshKtGlBpKZ34+XzkJUQO79jNG9HN+PkFvYT8M79cODh64lQjx34
	 QmB4yKAXSCJ9PGeE5V4rbjCosM3XB5JRRTj4UXNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgDVKLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgDVKLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE632075A;
        Wed, 22 Apr 2020 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550270;
        bh=Q9whGS9I7eP5LIjRdf2IV6LOnzGxAaVCgwyaoGN0xTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlB0jsbPrV9EE5fTgx0w0HwcwueyXucn025jQUxvStIGILw0LeinbyAD49uA6bP1n
         MA1wsuX3HnkftpbxBc0v5gFSEaMuM+aVSkRTfuW9wMQESNdIKlG6kXgQzCXce/VjRC
         H1BbWn0VkAqQxvnrnp0hw1i5gnczj5sRVP/H2vLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 078/199] fs/filesystems.c: downgrade user-reachable WARN_ONCE() to pr_warn_once()
Date:   Wed, 22 Apr 2020 11:56:44 +0200
Message-Id: <20200422095105.929844808@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 26c5d78c976ca298e59a56f6101a97b618ba3539 upstream.

After request_module(), nothing is stopping the module from being
unloaded until someone takes a reference to it via try_get_module().

The WARN_ONCE() in get_fs_type() is thus user-reachable, via userspace
running 'rmmod' concurrently.

Since WARN_ONCE() is for kernel bugs only, not for user-reachable
situations, downgrade this warning to pr_warn_once().

Keep it printed once only, since the intent of this warning is to detect
a bug in modprobe at boot time.  Printing the warning more than once
wouldn't really provide any useful extra information.

Fixes: 41124db869b7 ("fs: warn in case userspace lied about modprobe return")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jessica Yu <jeyu@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: NeilBrown <neilb@suse.com>
Cc: <stable@vger.kernel.org>		[4.13+]
Link: http://lkml.kernel.org/r/20200312202552.241885-3-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/filesystems.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -279,7 +279,9 @@ struct file_system_type *get_fs_type(con
 	fs = __get_fs_type(name, len);
 	if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
 		fs = __get_fs_type(name, len);
-		WARN_ONCE(!fs, "request_module fs-%.*s succeeded, but still no fs?\n", len, name);
+		if (!fs)
+			pr_warn_once("request_module fs-%.*s succeeded, but still no fs?\n",
+				     len, name);
 	}
 
 	if (dot && fs && !(fs->fs_flags & FS_HAS_SUBTYPE)) {


