Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200D020789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/FDbTWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFMP6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFMP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:57:58 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CBC03E96F;
        Sat, 13 Jun 2020 08:57:57 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id f2so2542548ooo.5;
        Sat, 13 Jun 2020 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zaffj2Nz/vnXmX7fevh30dBt79KRq76Bn9fr860hq0M=;
        b=p/FDbTWQs8m42qmoasY5uqJrwDl840Cw//yGJAW15073LFJlyWzny6ws0Aj0LoYTag
         WsLvBChChpeSGUEmHV8agBpTtSDhq0xDYJr5tSWTO5q0kmsyJ+iw4T/y9uGLesb4+oOq
         WRpGz/xCfg6X1erhUopEfqFsZ2y5MswrBOa8Nj0CF3R75PKqixaX9DOEKXRVzdA6vWr7
         fslbKOsk/P9AtGbdHZqY+oxEgKzPJgSW9kxS7QTq6uj/8o7xvIo2NBZ+ls+BG0fZ9P5b
         z8oSRT4fUWxxUPPJ+oKkUG/hujr3e9kff2NzW5gdKsXpIxzk+krjMUTZOkJKGcbbCVgI
         qjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zaffj2Nz/vnXmX7fevh30dBt79KRq76Bn9fr860hq0M=;
        b=tSOZ/lFFaNM1U8FcSs2U1Kgzwy/Xdn3yKIF5g7GPeOK9iKA1TDU9diHztne9T199kj
         x8AD47cCHX7GdpRboxSA1Pq/V3hY6RLhbSVWk6dIyqw9MeaHkLdKpWxCoySa3sfmJ3zW
         tx3SVCtxmyR1yLmA8u9b2r7hnh6Pa92Mur22maCQpyyJMbMJ+Nh6045foICUkpZnz0VZ
         HWD+hvF5l7rYW17h6w41Zof1MXuC+13DnqD5M6ZusAzrNH77DzkKjMRuIYWZy4P8Ml+c
         hoawjGDjTCnVRWVh+3CUK5PDa7WMb7BdL4TPUdwdKyqEcFdRu2Izp/HphqLbk1uDJrwT
         55Dg==
X-Gm-Message-State: AOAM5302yJNJWft8L3dFzqFY1DY7ANzeTc30vct89ujVlpcwQ6K14A7B
        d/dknWcR0pHqP3uPIyULTyY=
X-Google-Smtp-Source: ABdhPJym3KksNJ8CMV6i6nnQxlxU5263GVU0RlzAcWxPqILCBCFMLDbH23iVd6/snvWWnXA0395fZQ==
X-Received: by 2002:a4a:ca8b:: with SMTP id x11mr15000065ooq.83.1592063876340;
        Sat, 13 Jun 2020 08:57:56 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:57:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 01/24] dyndbg-docs: eschew file /full/path query in docs
Date:   Sat, 13 Jun 2020 09:57:15 -0600
Message-Id: <20200613155738.2249399-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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

