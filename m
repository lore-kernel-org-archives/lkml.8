Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7052074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEsnFpin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgFEQ2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgFEQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:28:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4FC08C5C2;
        Fri,  5 Jun 2020 09:28:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s13so8060479otd.7;
        Fri, 05 Jun 2020 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oUceEEdytDmHRfTQhpFS2WzwHNKr0aNr163SQEkf6I=;
        b=CEsnFpinX3I865NmQLP7DvnIRAXAajmqoLq7xpAt6Juh7IUg6VVtWPPj7H4g+PR4Do
         zYvLbji+muIZH7rhoCmpKQo2c0ii8SzNNatqcpilhq54x6h7f3qVj73agHUfPvO6WgTW
         BjVRWV9sPgC0M+eRgqecJBTmXWOaXS0R138y/bUx4ZyBvj3G0YflFpHjeIYEWwLwTvHq
         jXQaYa0O0kkKYhUQTjQv0B1xDWcliPrmskQmaOOC8YQdeTwUdX0Xa5TciwlzbO1+6Xsj
         k7Fs85FuLwLRSnsQuC/BzEF+BZI53ktAR8UbydJG8dAJksY/Bw4EtTC5Sh71cVcvvzxl
         WWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oUceEEdytDmHRfTQhpFS2WzwHNKr0aNr163SQEkf6I=;
        b=OhPNjzzW/ti6wSI3LHAa8yCIk+/Al0/Woq+yCO12wCqAjSE431S8ZJDDv8L26awzuk
         wcvIEf+akBiHwtgJQON0KrmXqo2JEPQ4Pl6HgT6YM4N+44RuhOMycDw1lQ/bQ/zAQSvl
         vvzBMwcftgtCSz/0oPzMzZJR9VLp1g+l7Arl+E7O53yMUtb3jW0jpGheenNiXOFd+O2r
         mBvHbVB+yamjmjrz/h7Zs5kCOdfdY+6Gs5VeQLq1JD2Pk/OzlbojSLDa9mX+BZNabe/h
         ns0GnzwXnJW9m0stj4tF8FRNrjfhAOu/efIbvJoj/LxiTsBPdvPvYpuA3SM8iOOfUJfr
         KO3Q==
X-Gm-Message-State: AOAM533CUfsdyeqKdaPvDusdSPsAU0ov63y4qKsnlEGjHSfSULYUFvIK
        +JxWe0XdP0DPye6ANNENr9g=
X-Google-Smtp-Source: ABdhPJwbInfd1k/guqnCfu8qXaqvZZYTk7PGs9wTxq3qjLt4wKsMNeOHD88XRQY+ITEYKw5lGyjVtw==
X-Received: by 2002:a9d:6044:: with SMTP id v4mr5705327otj.157.1591374483421;
        Fri, 05 Jun 2020 09:28:03 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:28:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH 13/16] dyndbg: extend ddebug_parse_flags to accept optional leading filter-flags
Date:   Fri,  5 Jun 2020 10:26:42 -0600
Message-Id: <20200605162645.289174-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change ddebug_parse_flags to accept optional filterflags before OP.
this now sets the parameter added in ~1

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 18 +++++++----
 lib/dynamic_debug.c                           | 30 ++++++++++---------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 880d33d1782f..250ab30e2080 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -212,13 +212,19 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
-The flags specification comprises a change operation followed
-by one or more flag characters.  The change operation is one
-of the characters::
+Flags Specification::
 
-  -    remove the given flags
-  +    add the given flags
-  =    set the flags to the given flags
+  flagspec	::= filterflags? OP modflags
+  filterflags	::= flagset
+  modflags	::= flagset
+  flagset	::= ([pfmltu_] | [PFMLTU_])+	# also cant have pP etc
+  OP		::= [-+=]
+
+OP: modify callsites per following flagset::
+
+  -    remove the following flags
+  +    add the following flags
+  =    set the flags to the following flags
 
 The flags are::
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 32eb7d9545c7..90061833ef3f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -440,34 +440,36 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 }
 
 /*
- * Parse `str' as a flags specification, format [-+=][p]+.
- * Sets up *maskp and *flagsp to be used when changing the
- * flags fields of matched _ddebug's.  Returns 0 on success
- * or <0 on error.
+ * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
+ * Fills flagsettings provided.  Returns 0 on success or <0 on error.
  */
-
 static int ddebug_parse_flags(const char *str,
 			      struct flagsettings *mods,
 			      struct flagsettings *filter)
 {
 	int op;
+	char *opp = strpbrk(str, "-+=");
 
-	switch (*str) {
-	case '+':
-	case '-':
-	case '=':
-		op = *str++;
-		break;
-	default:
-		pr_err("bad flag-op %c, at start of %s\n", *str, str);
+	if (!opp) {
+		pr_err("no OP given in %s\n", str);
 		return -EINVAL;
 	}
+	op = *opp;
 	vpr_info("op='%c'\n", op);
 
+	if (opp != str) {
+		/* filterflags precedes OP, grab it */
+		*opp++ = '\0';
+		if (ddebug_read_flags(str, filter))
+			return -EINVAL;
+		str = opp;
+	} else
+		str++;
+
 	if (ddebug_read_flags(str, mods))
 		return -EINVAL;
 
-	/* calculate final flags, mask based upon op */
+	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
 	case '=':
 		mods->mask = 0;
-- 
2.26.2

