Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66FC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9363A206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584044777;
	bh=bWBPGbnoq1gsV/od0+q6ePbfuTyl4bo3BQ9ZHQN2Upw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0IwAqUI5zmfCyhOVVhwZ+NI9olCtSO+5uCAWf028PCwSMsJX0iGC5B5WM7LXyTWi
	 Dda6+/ChzEKla9di8+9yNGso+9rXGQTt8+sR5V8G8lg9v7CsoEg+AD3td7hQeZEWwj
	 H0Iy5sW8dLAwKzVjXTcQypIxiQMDujJxfc36KbrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCLU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:26:10 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD8520736;
        Thu, 12 Mar 2020 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584044769;
        bh=bWBPGbnoq1gsV/od0+q6ePbfuTyl4bo3BQ9ZHQN2Upw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2j95iuZlCEFaWRaEES+nsFFRHHgvudlOwgmRy1zfqIk81m67Ep+sWQNAIQtNCahiX
         Wk7OkDM40aphur5j636uscEEnij9ORNzHLqKW4PeWo56DbbFFLiNgd/6lZ/GX+eWZe
         S8pvEV0o6H+m0GF4XtW5gX+Cs58SLdfRlDyI7+RE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/4] fs/filesystems.c: downgrade user-reachable WARN_ONCE() to pr_warn_once()
Date:   Thu, 12 Mar 2020 13:25:50 -0700
Message-Id: <20200312202552.241885-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312202552.241885-1-ebiggers@kernel.org>
References: <20200312202552.241885-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After request_module(), nothing is stopping the module from being
unloaded until someone takes a reference to it via try_get_module().

The WARN_ONCE() in get_fs_type() is thus user-reachable, via userspace
running 'rmmod' concurrently.

Since WARN_ONCE() is for kernel bugs only, not for user-reachable
situations, downgrade this warning to pr_warn_once().

Cc: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/filesystems.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 77bf5f95362da..90b8d879fbaf3 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -272,7 +272,9 @@ struct file_system_type *get_fs_type(const char *name)
 	fs = __get_fs_type(name, len);
 	if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
 		fs = __get_fs_type(name, len);
-		WARN_ONCE(!fs, "request_module fs-%.*s succeeded, but still no fs?\n", len, name);
+		if (!fs)
+			pr_warn_once("request_module fs-%.*s succeeded, but still no fs?\n",
+				     len, name);
 	}
 
 	if (dot && fs && !(fs->fs_flags & FS_HAS_SUBTYPE)) {
-- 
2.25.1

