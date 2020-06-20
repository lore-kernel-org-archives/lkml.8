Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B8D2409B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm0B7xTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgFTSIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:25 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33377 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgFTSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:20 -0400
Received: by mail-oo1-f66.google.com with SMTP id v1so2555304ooh.0;
        Sat, 20 Jun 2020 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdkZKVR16MdSVQoBLIpL51nmGbmD1+v/7iGjqOOjmME=;
        b=Sm0B7xTEdMDFvNpMIuZt3DK4xjSYn8ijFEgeUS578wy+DmIOau/VW+b2JyHld9SZKn
         WMBqE8p1nGDb8+4bglCBH01qeyr2MHtiDF63nQi0G4u4utYSYly9QITq9byrdHP407wh
         YWqRCWmKxpqSEPBg8eXAVbx+ZYz6fAGNwazU3SJjfi337H81NRFr0vtZCtOlz7viaVMl
         UtOKwNwkCORTTcAeLk3skwmSTOOllFSdM/KDI9B0pDSbW6ZDyZrUQBctYzrTEFR88xoX
         801DLm5ROlSNL4+IpE60nIuv5sms1N8pqVzZp53Yary3BxGMlwGJezY+KgN6O80ezFwU
         4w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdkZKVR16MdSVQoBLIpL51nmGbmD1+v/7iGjqOOjmME=;
        b=uLGM9kmyyG2qSnY+5c7xpAVJyLc0YhHTtxNqeXXkQyECqBFdsDGs2fjiCKxP1Lzq+v
         xx4FoA1etrB3T7L0pIYKHE2N2YoNqzU/bW3499zMCNle0JJr0YNh1H9kGtrovgB2VWXA
         Rjn+UAfG4hTc19x4TXrYOZVzkQzjgQeTr19PEr3gkw1ftxlhvCRVLPi4A/YYiDNHaujj
         0Pp0+nBtOoG/0Yw6o+TRfIQSQ7HwThP627RkHnR3CB3N2VUh0NTBCUyQJqWgruTEPYDf
         WWw00P9AobdkBg253baGa/5Ddbz3wPD74m6gFYv4EvT4rE6PBMD9PzMeq+FE5VVy9KBb
         laQQ==
X-Gm-Message-State: AOAM532Y7tzdRXTMcB84+JccrEjol+5sq7lupWDCeFO1v0+STa2xrQb+
        ehXLJUQCAAIryehXqZopu+l888xC/Tc=
X-Google-Smtp-Source: ABdhPJwhRhyj4fQ2b4QcFcyuswM716X7TmErGLM+FmD38DgVy90BFLzmpgJVfLH3Hpdtw7NEFI3CJQ==
X-Received: by 2002:a4a:1184:: with SMTP id 126mr8320290ooc.76.1592676439066;
        Sat, 20 Jun 2020 11:07:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 13/17] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Sat, 20 Jun 2020 12:06:39 -0600
Message-Id: <20200620180643.887546-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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

