Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3EAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092272074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF0Q6xNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFEQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFEQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:53 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45840C08C5C2;
        Fri,  5 Jun 2020 09:27:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so8075934otp.8;
        Fri, 05 Jun 2020 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaWHgv7G8arGLqeN9f/mRB2aVImrUHIGEHN6Of9KPb8=;
        b=XF0Q6xNJdJiwi7qMy9P3Oc31JAnTkIsZIl1j+uxMq7JiwB8I//GKd2mCa5xT7dSXCb
         cIZshXQ1nqiGvGDA3NgSHD1SN1qy6QUtiKMWrv40FYlCMGEip+3SAlP05J0GK3AGID0m
         ikiPF/Lv88I1iTArJex7I82t2dZXsiT2yeKoRgPSkVVyIPeKdl3ytWMzsU2dZ1F/CblW
         GMcgGhZAUu8ExUJZqrW3g1tQcXs1WhIyb8ktrf8duTedmiQenPFMuA6FuvhZb+LZ+JjD
         UFCQq9GNd+GpNZM+1TZbX4F44QsqQE64DRLcSHwY5U7yUkz2EDBAYTsSJXprzMhaEnF/
         /Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qaWHgv7G8arGLqeN9f/mRB2aVImrUHIGEHN6Of9KPb8=;
        b=IVyNddnrKx/4NWN03aN93LsF+bRcikTessZTEaofJAduuvggwJ7cnMOi9Bk6GCKmhV
         jjAzcfnG/56PznJf5B/rnM1LrvdyKHeNNTQuZLWaaM2ay45w4dEbRoBRl6jFHm43tB4O
         yzpuYFqZyZwo0wx/KroW1V9wBrfoiviUddpuUWcealtdRoIebWRVhDoPKCuLq6C6X8gP
         pURn7BGjzStClJ0xeKG8aNecUpY0IeOE9ShKm36Q3YxElREwrBY2ekD9adbXG0t7PWm0
         /AiYlxxwfxkLWT+1x/D7ZwiWTn4NsGEgyNl6lnVw/P9/+QdFYSZXmKd5QBGK7rCp69s6
         YGkg==
X-Gm-Message-State: AOAM531qry46z1eBI4pUa7VBhkw6yG+b12FWOWoaavyHh1EZMwkJHsnq
        Kz6f4py4dLcXGXD7WDvPK2k=
X-Google-Smtp-Source: ABdhPJxiqYFERsbUoOslSOqfxKe50BVyJLzgdDjZ3ssgdZfjFB6DYbHuWn7UHUzCJJGo7+zXtQCprw==
X-Received: by 2002:a9d:3623:: with SMTP id w32mr8079587otb.91.1591374471607;
        Fri, 05 Jun 2020 09:27:51 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH 09/16] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Fri,  5 Jun 2020 10:26:38 -0600
Message-Id: <20200605162645.289174-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
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
index 2854d418b31b..880d33d1782f 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -159,6 +159,7 @@ func
     of each callsite.  Example::
 
 	func svc_tcp_accept
+	func *recv*		# in rfcomm, bluetooth, ping, tcp
 
 file
     The given string is compared against either the src-root relative
@@ -167,6 +168,9 @@ file
 
 	file svcsock.c
 	file kernel/freezer.c	# ie column 1 of control file
+	file drivers/usb/*	# all callsites under it
+	file inode.c:start_*	# parse :tail as a func (above)
+	file inode.c:1-100	# parse :tail as a line-range (above)
 
 module
     The given string is compared against the module name
@@ -176,6 +180,7 @@ module
 
 	module sunrpc
 	module nfsd
+	module drm*	# both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d43bc3547d3a..8f250c67acbe 100644
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
@@ -373,7 +376,22 @@ static int ddebug_parse_query(char *words[], int nwords,
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
+			} else
+				if (parse_linerange(query, fline))
+					return -EINVAL;
+
 		} else if (!strcmp(words[i], "module")) {
 			rc = check_set(&query->module, words[i+1], "module");
 		} else if (!strcmp(words[i], "format")) {
-- 
2.26.2

