Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A9C433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5C52177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaCc/8ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGSXLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGSXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:43 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC7C0619D2;
        Sun, 19 Jul 2020 16:11:43 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id t6so2834116ooh.4;
        Sun, 19 Jul 2020 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BvIWerpt1N1J7J/QSdmUjjoTnYEWLkB8oSyIDKUj/g=;
        b=gaCc/8jaUsG2/C2rxZZ4PWEfI7WDp7T0J5dazWV1+bn//tpyYedVZNF529TjGwcMSL
         k3aZLf8uVKJ9NUJEHNNk5HI9wi4BULm3cE8RPHusZhhC9/pu+6G67lDQ79UjD0SPC5NK
         w5sQ0jNf6si9A6twMqSZCevge4LtoLAgt/8rt3LZjz2LTGCMmhxR1crjpRPq8NJo1ReP
         AWf4NkCQbwdELi/u+d42xEfVX5dBbMeCHZoCknhpuLgD8QlemiTCJuhA38XxcYpRP8Sp
         evOiAYa2/94SNHYsBcLhvglSUrBU4uM9uLoWv03cIYy7vnoCvOJxN+8/YkS0DPPoy4TF
         Ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BvIWerpt1N1J7J/QSdmUjjoTnYEWLkB8oSyIDKUj/g=;
        b=c7RDgXdWBbJH0HEX+hSmX1N9qtM6faeyCPoKO0kBCPiQl0MLZBLg/wliHGnVT8vo8A
         MO0ABp5sAH10vYkQY2wdG+9thU5ogbZcMW1lDxcINghEVR7YPQ8YZZYxVPb60bx1GeiE
         vHHTr+HdsO8t74yWTOyhbsIU/bebMF1qtrSEY04ae4/MqHOeVxhg1PXmblymMseKk6sU
         haNvUNDW1fMlGR5+Y2Att9v/IRrJ04OQWC0Ul83bVpOSsBpdRxX6XkLXyTG5HtUMBwB2
         iMIk3MKt6dB0cRTLB4xj7B3576FHu8tlGsKey9Si06m1g5HNAxJgi68hYdXQjgiflFaV
         5IsQ==
X-Gm-Message-State: AOAM533ghrr5FASxvrVjM1rU0JG3PM3ODo5NX9/3gxuVjn3LNAOrdJ24
        maEupuHK1JBa1vYV5dN8pO4=
X-Google-Smtp-Source: ABdhPJx+Fof1eL0CpRhYgJe03O1bTLGwjjkQfWSgNeKS5B62bW/JWfpH7Ts5RRD+/F6S0heRKH3TYA==
X-Received: by 2002:a4a:3105:: with SMTP id k5mr17124734ooa.6.1595200302759;
        Sun, 19 Jul 2020 16:11:42 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v5 13/18] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Sun, 19 Jul 2020 17:10:53 -0600
Message-Id: <20200719231058.1586423-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
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
       path/to/file.c:drm_*	# wildcards still work
       path/to/file.c:*_foo	# lead wildcard too

1st 2 examples are treated as line-ranges, 3-5 are treated as func's

Doc these changes, and sprinkle in a few extra wild-card examples and
trailing # explanation texts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst        |  5 +++++
 lib/dynamic_debug.c                            | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

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
index 7a66d5e07f41..7eb963b1bd11 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -359,6 +359,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 {
 	unsigned int i;
 	int rc = 0;
+	char *fline;
 
 	/* check we have an even number of words */
 	if (nwords % 2 != 0) {
@@ -374,7 +375,22 @@ static int ddebug_parse_query(char *words[], int nwords,
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

