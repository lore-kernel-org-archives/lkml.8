Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D3207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stMH7ZQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFMP6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgFMP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:14 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2DC03E96F;
        Sat, 13 Jun 2020 08:58:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b18so9739653oti.1;
        Sat, 13 Jun 2020 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpQIJRk2qWyZDDehOJEtWSvlP1WLsO6Po+kjK7phh7o=;
        b=stMH7ZQM1vDy/r5xMxYXERsQnYN3Nhk0ziLRmYDW6gWPu/dI3CRrL2SwUdjIYlmYYY
         +e9MMPcWIi7FNIIwRLejLprkTqjQ9CtAq0udjoF+Y57WrDrNfuceq9iVOP8KgMMNQAnE
         zNjR6AWJdKSLJbq+pN7qAJQsh4lO7zeOjsaz5hC8aWogThMZDZ+DgSTKUupwsuZDg7o/
         IhxMXX76P4ew2PJWAaGn9sN6NCXPVfIBlrzXTz9z//eiufx8c6LUL/Tk8mouibYq5hVr
         FDoQEuKNA9PxHWf3xAGBoPeZP+Lszdrop6k+2Mj2wmSQ8EeqZtxSSS2P3LZNodIXsyxH
         Sl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpQIJRk2qWyZDDehOJEtWSvlP1WLsO6Po+kjK7phh7o=;
        b=FtxSWjV4MYJALNgK6zPYwFg89KzIIMDO7POavbziKkiu6NwaQ4FhJP9mUpqLQybFfr
         +1ZDXdbcMr7T5mTIdsTjH9r4mBr8nSXJ3bs2ugLXZyuS7BjsY8pN7ldmnTjHtpcyhcdY
         55aYORCCcswoSDO3rJNwKwsvtUV/ui/oRNec5nJ69JxNT5MZxGLjWnOkAv0c1tKyjA7/
         HQqDbkYOfXe5mHoXLwfWuutGfSL76QAjj8VI1ubv0SkjTl+9j2MfKvrrZL5Fak2qXuSe
         pmdDWxLPTveoE666dS1VtRdm84E07gZkJkXIpZvqrslpNPqb/bLK02cxHDLDjgbO5K+P
         5vwA==
X-Gm-Message-State: AOAM5308iFA0Wp+03uG7Y3dFoHnshuWyueMuTtPG+b/7KVAyYmNurgZA
        47P69lr1eeTjMcJ5Mn5bKi/rStIA+is=
X-Google-Smtp-Source: ABdhPJxiZ9RQM3asA+3HyN8dxfhGppTll8oax5X7kud3HIFAEKBxNuWsFHbu//ourRxlBif21hTn7w==
X-Received: by 2002:a05:6830:1f4a:: with SMTP id u10mr825604oth.125.1592063893177;
        Sat, 13 Jun 2020 08:58:13 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 11/24] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Sat, 13 Jun 2020 09:57:25 -0600
Message-Id: <20200613155738.2249399-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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
index f87a7bef4204..784c075c7db9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -322,6 +322,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
+	vpr_info("parsed line %d-%d\n", query->first_lineno,
+		 query->last_lineno);
 	return 0;
 }
 
@@ -358,6 +360,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 {
 	unsigned int i;
 	int rc = 0;
+	char *fline;
 
 	/* check we have an even number of words */
 	if (nwords % 2 != 0) {
@@ -374,7 +377,22 @@ static int ddebug_parse_query(char *words[], int nwords,
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

