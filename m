Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F42DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E03423F58
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTmXM+GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgFTSIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43697 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgFTSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id j189so11599084oih.10;
        Sat, 20 Jun 2020 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1agMer8C/ub57ZSY/mSuYbhra637qhXpKJjyRETn6zE=;
        b=gTmXM+GMRQ5xBWj7Hgf8s3wyl7XgfSumVrG6yTOB5rdPgFR+at33nMwSXuRFuw1d8F
         Dy2QSLMftz4kEcsuqcDfCMahjn/fHi+9QLU17dvz4A3DtjA/kgjuxtQaztktC5rIn16u
         957oTp3uOVyXdox42EXhR9JsmrzNGgxcNpnqI5gLnYhjYAj97kLTRLjplcgaEkO7w9ZJ
         I3FPgLJGxYSaYqhkQ2Cf2jqEaOv/HMW7f/lskahsuUqaopHkMX6FtNIuqNU2r1/iYkcu
         IvLvchnv7M8L5EDK0VIsh9xMMXYzx0rHaRWBBsHdiOhgQQzfNA/1TgP58/HdzJ9yRzS0
         lFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1agMer8C/ub57ZSY/mSuYbhra637qhXpKJjyRETn6zE=;
        b=BWIRTV8EZ8XtWem/eaaJmJzdJhXp7uo9Hp/3UK/2WJkAK02DlbdMARQeYXpZBpKtvE
         N7QmRTEa1QZGgaUR+ztieiOrK5qOf24HILBGfkLEJIRWoTwigMfH+PhdtolG8mUQMaCm
         J7iwLF2TnPWfOc2id392877xbJ5hRYrN6KAOdwo7/YKwtn9EBnY0DqcFdOI/d2lxV7qw
         wM5St+zzvfXHWsF054O7qxhyfy21n8Q4TFL62MvqysPYGzZ8cl0OdGZvuyfifI1aFXG4
         oDJJNmBY/imsLwSF5VsQa4bbS6PTtlJqJ9IkqOXnG6A+C/yRDRY5l6uqRKDy/v9DD0q7
         jyhg==
X-Gm-Message-State: AOAM530n4B4mzNXUuN2b7lVwC+zRCIHyqhuKZcHCAzkxBVcykwSIQVa4
        hje05seh7V3Y2rlcxVVNwWg=
X-Google-Smtp-Source: ABdhPJzat3znpzex8b/oCxD4TqcBCuhTz9qq0RQSaPOLHtxEKQ/yVfswHtBJIVd0e5aD8K+RNvETMQ==
X-Received: by 2002:aca:7516:: with SMTP id q22mr7060724oic.144.1592676419563;
        Sat, 20 Jun 2020 11:06:59 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:06:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 01/17] dyndbg-docs: eschew file /full/path query in docs
Date:   Sat, 20 Jun 2020 12:06:27 -0600
Message-Id: <20200620180643.887546-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding:
commit 2b6783191da7 ("dynamic_debug: add trim_prefix() to provide source-root relative paths")
commit a73619a845d5 ("kbuild: use -fmacro-prefix-map to make __FILE__ a relative path")

2nd commit broke dynamic-debug's "file $fullpath" query form, but
nobody noticed because 1st commit had trimmed prefixes from
control-file output, so the click-copy-pasting of fullpaths into new
queries had ceased; that query form became unused.

Removing the function is cleanest, but it could be useful in
old-compiler corner cases, where __FILE__ still has /full/path,
and it safely does nothing otherwize.

So instead, quietly deprecate "file /full/path" query form, by
removing all /full/paths examples in the docs.  I skipped adding a
back-compat note.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 1012bd9305e9..57108f64afc8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -70,10 +70,10 @@ statements via::
 
   nullarbor:~ # cat <debugfs>/dynamic_debug/control
   # filename:lineno [module]function flags format
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:323 [svcxprt_rdma]svc_rdma_cleanup =_ "SVCRDMA Module Removed, deregister RPC RDMA transport\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:341 [svcxprt_rdma]svc_rdma_init =_ "\011max_inline       : %d\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:340 [svcxprt_rdma]svc_rdma_init =_ "\011sq_depth         : %d\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:338 [svcxprt_rdma]svc_rdma_init =_ "\011max_requests     : %d\012"
+  net/sunrpc/svc_rdma.c:323 [svcxprt_rdma]svc_rdma_cleanup =_ "SVCRDMA Module Removed, deregister RPC RDMA transport\012"
+  net/sunrpc/svc_rdma.c:341 [svcxprt_rdma]svc_rdma_init =_ "\011max_inline       : %d\012"
+  net/sunrpc/svc_rdma.c:340 [svcxprt_rdma]svc_rdma_init =_ "\011sq_depth         : %d\012"
+  net/sunrpc/svc_rdma.c:338 [svcxprt_rdma]svc_rdma_init =_ "\011max_requests     : %d\012"
   ...
 
 
@@ -93,7 +93,7 @@ the debug statement callsites with any non-default flags::
 
   nullarbor:~ # awk '$3 != "=_"' <debugfs>/dynamic_debug/control
   # filename:lineno [module]function flags format
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svcsock.c:1603 [sunrpc]svc_send p "svc_process: st_sendto returned %d\012"
+  net/sunrpc/svcsock.c:1603 [sunrpc]svc_send p "svc_process: st_sendto returned %d\012"
 
 Command Language Reference
 ==========================
@@ -166,13 +166,12 @@ func
 	func svc_tcp_accept
 
 file
-    The given string is compared against either the full pathname, the
-    src-root relative pathname, or the basename of the source file of
-    each callsite.  Examples::
+    The given string is compared against either the src-root relative
+    pathname, or the basename of the source file of each callsite.
+    Examples::
 
 	file svcsock.c
-	file kernel/freezer.c
-	file /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svcsock.c
+	file kernel/freezer.c	# ie column 1 of control file
 
 module
     The given string is compared against the module name
-- 
2.26.2

