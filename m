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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E3921556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNglAxY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFQQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFQQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:35 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE8C06174E;
        Wed, 17 Jun 2020 09:26:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s13so2092377otd.7;
        Wed, 17 Jun 2020 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtbCt4lXWAsz7/FyFOawXtgiyr7YGkyvVZTRxQCf5d4=;
        b=pNglAxY2ycX605y2jzji57ed8Op7lxOb3lc1yCuCT7cwDvqYUDmz1x84j76wEkz/+U
         0LeQyM0X9mM5lvWeFfJ7WjPrItNKfJiBlHFgTThb10kw+vs6EQFAzI0UZxQcVhcba1lE
         0zJ4Stp5KThf+bflvsmxK4NWDDAV/BVNiFRp4QIwbSgPsUaMrSS9B9OqBmFzOzvkp2SI
         aK5eOOksrf6YBFZOOhN4z/hzQE4H2182N/0AOf0UNffepyi9uWgy2XszKC4R+vqyrtqF
         cBldMZgbzvdQN/qJcf9DLpoR44jMuI54PHPiO1z249i/IXengOo1jponEi3ESwXsle/N
         zUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtbCt4lXWAsz7/FyFOawXtgiyr7YGkyvVZTRxQCf5d4=;
        b=fBCOS++ekdTKc0kOGznfVlLfKnPvNclWz9Z9uMQmo2d9fODqUuBo5Yv5uE+0i1ecAC
         /zKQXAgN5o6V3S8OltQjsBr4jSfWJOO8weRJrg346Z3WTdZekwFAmIjefa9uAOPg7bDY
         hyHGir45hE/0oP7Q7pWjX8zq5YrCFokVvBRoCuVrFQZfnu7vvD67bktDptsG156Fn3VV
         +JlcoUOMloSOf54RXTG36gq9geKzAlPC2/dc/jdfpj83uSvrhAZW8PDK8scdVfAkCOQ6
         02y4Ibhy7L6AT2tJwyrFaqZeEYHGpn2EQvDSNntGICkxJYcXtQ67QWmnEI3IvCrZtb6t
         ihCA==
X-Gm-Message-State: AOAM530sefpQ71uPYCPBtwCkMCmvn+2GFrkXqLw2/HaXgRNxpIfMnTMY
        aqDjJ3AEBZ0jv5CfgZOYV0c=
X-Google-Smtp-Source: ABdhPJwHlRqkjC8/GZ7Wa363TGIpU8xB0IfHK5jXMv5FOhQjohFvR7XgirJIbCmqx/x4X2H8BPcrUA==
X-Received: by 2002:a05:6830:1218:: with SMTP id r24mr5323482otp.247.1592411194459;
        Wed, 17 Jun 2020 09:26:34 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 19/21] dyndbg: extend ddebug_parse_flags to accept optional leading filter-flags
Date:   Wed, 17 Jun 2020 10:25:34 -0600
Message-Id: <20200617162536.611386-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ddebug_parse_flags to accept optional filterflags before the
required operator [-+=].  Read the flags into the filter_flags
parameter added in the previous patch.  So this now supplies the
filterflags to ddebug_exec_query.

filterflags work like query terms, they constrain what callsites get
matched before theyre modified.  So like a query, they can be empty.

Filterflags let you read callsite's flagstate, including results of
previous modifications, and require that certain flags are set, before
modifying the callsite further.

So you can build up sets of callsites by marking them with a
particular flagstate, for example 'fmlt', then enable that set in a
batch.

  echo fmlt+p >control

Naturally you can use almost any combo of flags you want for marking,
and can mark several different sets with different patterns.  And then
you can activate them in a bunch:

  echo 'ft+p; mt+p; lt+p;' >control

You just can't prohibit true flags.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 18 ++++++++----
 lib/dynamic_debug.c                           | 29 ++++++++++---------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e5a8def45f3f..e1ea0c307fcf 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -218,13 +218,19 @@ line
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
index 0fcc688789f4..cf3379b40483 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -452,33 +452,36 @@ static int ddebug_read_flags(const char *str, struct flag_settings *modifiers)
 }
 
 /*
- * Parse `str' as a flags specification, format [-+=][p]+.
- * Sets up *maskp and *flagsp to be used when changing the
- * flags fields of matched _ddebug's.  Returns 0 on success
- * or <0 on error.
+ * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
+ * Fills flagsettings provided.  Returns 0 on success or <0 on error.
  */
 static int ddebug_parse_flags(const char *str,
 			      struct flag_settings *modifiers,
 			      struct flag_settings *filter)
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
 	if (ddebug_read_flags(str, modifiers))
 		return -EINVAL;
 
-	/* calculate final flags, mask based upon op */
+	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
 	case '=':
 		/* modifiers->flags already set */
-- 
2.26.2

