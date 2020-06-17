Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0345C21534
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbtvu4xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFQQ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgFQQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81735C06174E;
        Wed, 17 Jun 2020 09:26:19 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d67so2289987oig.6;
        Wed, 17 Jun 2020 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdkZKVR16MdSVQoBLIpL51nmGbmD1+v/7iGjqOOjmME=;
        b=Dbtvu4xLzqPGcKfLMjUwQN4Gpb6HMSfY5tu1ARyHNMcGaez4cOxIsNnwXf2tgShq/J
         RM60ruOCD3AvM7RyihbPeCNX1rl6JSZUKWIVHaNlkl9e9bk3Gwh4zd/VXC3SDRPHNYTK
         nezaf11htO8ELBzUyGQl67u8vZI0wL6OX27t0Uu+oUb6WIy/eweVWHvCqd2oOcfV/dPX
         vvNgcO76EVZmuGuQG1t/gBDxGsjKYZUlYn90YxGIulT82K6mIliaj9Epa+gDibz0tRT/
         J8K1AHlpipHFid4rMFoc6UC8mG++Z28YE6tRPUw0Y59kfZxK0X3K4MoYc8nCb/+n6swT
         aewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdkZKVR16MdSVQoBLIpL51nmGbmD1+v/7iGjqOOjmME=;
        b=eJN/ds+8+9xyAaXXrLova8iD933CmmGOFhUlwZG1Ovwj+071qSet53eqvpkICxpEHB
         0Pl8lbMwMi4kzNteh1gEEEXaI3/QXLe04t/NtbvBCfbl716GmHgYZphgyNwwpTI42LFu
         QDRcUVL8YqD2wd6rJg28jy0cp56xJSejX52RJ9jvZgKtglwskK88zEC4LdkN0bH59b6S
         XWOQLBF85oPEMbVAQtIvKFd0fgmqo0BpQjdRbh7oUWs1SNgV5/iL7S3ndKz4xL1Wgd5u
         IOk8bj2aDKarJSeuj2PU36ZnGUxFi5qcOCq2Jl7QKKEO3Ekt1+TmOFh1JRcMc7xz1rEa
         aeOA==
X-Gm-Message-State: AOAM530blsZDYEMrHy9Ak0a9xaMY136SYKGKH4T39t6yq3pVSuXIMj5F
        ZuV7TeBSnkJ9qwu1py8ltCA=
X-Google-Smtp-Source: ABdhPJztQ+bknChtbESszSkftZkjZaxn/m4Y7o2pLnYH60MsTa6VRoauNVY0nWOBMSSmz29H9t7dtQ==
X-Received: by 2002:a54:4889:: with SMTP id r9mr8214025oic.107.1592411178874;
        Wed, 17 Jun 2020 09:26:18 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 13/21] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Wed, 17 Jun 2020 10:25:26 -0600
Message-Id: <20200617162536.611386-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept these additional query forms:

   echo "file $filestr +_" > control

       path/to/file.c:100	# as from control, column 1
       path/to/file.c:1-100	# or any legal line-range
       path/to/file.c:func_A	# as from an editor/browser
       path/to/file.c:drm_\*	# wildcards still work
       path/to/file.c:*_foo	# lead wildcard too

1st 2 examples are treated as line-ranges, 3,4 are treated as func's

Doc these changes, and sprinkle in a few extra wild-card examples and
trailing # explanation texts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  5 +++++
 lib/dynamic_debug.c                           | 20 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 1423af580bed..6c04aea8f4cd 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -164,6 +164,7 @@ func
     of each callsite.  Example::
 
 	func svc_tcp_accept
+	func *recv*		# in rfcomm, bluetooth, ping, tcp
 
 file
     The given string is compared against either the src-root relative
@@ -172,6 +173,9 @@ file
 
 	file svcsock.c
 	file kernel/freezer.c	# ie column 1 of control file
+	file drivers/usb/*	# all callsites under it
+	file inode.c:start_*	# parse :tail as a func (above)
+	file inode.c:1-100	# parse :tail as a line-range (above)
 
 module
     The given string is compared against the module name
@@ -181,6 +185,7 @@ module
 
 	module sunrpc
 	module nfsd
+	module drm*	# both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ae6e523fdecd..7eb963b1bd11 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -321,6 +321,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
+	vpr_info("parsed line %d-%d\n", query->first_lineno,
+		 query->last_lineno);
 	return 0;
 }
 
@@ -357,6 +359,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 {
 	unsigned int i;
 	int rc = 0;
+	char *fline;
 
 	/* check we have an even number of words */
 	if (nwords % 2 != 0) {
@@ -372,7 +375,22 @@ static int ddebug_parse_query(char *words[], int nwords,
 		if (!strcmp(words[i], "func")) {
 			rc = check_set(&query->function, words[i+1], "func");
 		} else if (!strcmp(words[i], "file")) {
-			rc = check_set(&query->filename, words[i+1], "file");
+			if (check_set(&query->filename, words[i+1], "file"))
+				return -EINVAL;
+
+			/* tail :$info is function or line-range */
+			fline = strchr(query->filename, ':');
+			if (!fline)
+				break;
+			*fline++ = '\0';
+			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
+				/* take as function name */
+				if (check_set(&query->function, fline, "func"))
+					return -EINVAL;
+			} else {
+				if (parse_linerange(query, fline))
+					return -EINVAL;
+			}
 		} else if (!strcmp(words[i], "module")) {
 			rc = check_set(&query->module, words[i+1], "module");
 		} else if (!strcmp(words[i], "format")) {
-- 
2.26.2

