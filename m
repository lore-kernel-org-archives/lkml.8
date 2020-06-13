Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705452074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyn4QDu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFMP7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFMP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7DC03E96F;
        Sat, 13 Jun 2020 08:58:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n6so9789278otl.0;
        Sat, 13 Jun 2020 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMX4OzWsojlD8s6xTuD1Ig+vMeRlYxFlVf1O2bU8rdo=;
        b=kyn4QDu7hT/mqd4FV3we/LI0R3CAzwL/hWz/PJ61g13FMMjO+1/QEXH2dt9czUI+XI
         PHj5mPHV9IXzGQKIzSqF0vAfIBOb8fui8eC7HYzbkHlRmn56i1i9koMFu4fp/sK6YR+1
         6qhN5Im26ZhWnM1JCcWW9S2w3YBWiCuepk8D6+kQFLUNy//uI/cK0UEfF5dwJ74FjP3u
         E1Yz0J/n1Jys/K/YD8kHGXwPE5CTkdekbfXyuuGgnbvrsYIIz18w+82xUadqaweTe2/4
         Vws+TTop/Ya2pWLAztfEfxj2X5QTaRkbppTBTTPwSyg7jbdmPCnh+VQntaGWNgtDvG7F
         HreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMX4OzWsojlD8s6xTuD1Ig+vMeRlYxFlVf1O2bU8rdo=;
        b=CGiKzAXqkVo/VKCIGABF8z+EYbIgHcw4XZ5YLRb/eDPjvhQ36HGpVihgXuA35FRkyC
         TUpewtD8y6fx6tTKeNDkYGQC4Q55Scof8Lrd3yGB3A76+mQ9jg3Kq5uHDSZNQcnVDIwX
         Mj2Gy3KnpseMqRi14NE/uVDAiUBzLlWYC/oLZ3FxmtLgUT/3JYTYIZG8bSawwIpoGStP
         pQl4BuR0TpSH8ZMaQPEchPjFzxo/dbVyv0rKJxNKn23Qdy2CHzfcozcGGknOJO9YByMM
         Ks/0Y7XMfc6yM3ALqECTw8j3i74P7JN/F59vma3oxGQlxViAlCkIjKE8Esc6pdV+jELa
         CCPg==
X-Gm-Message-State: AOAM532S7erMnQ714VeWY1xoqSNB/xNreNvn8Wt6G1lAUJtp0mtUktC5
        O//67oVwnEMeGawxzKmRx4w=
X-Google-Smtp-Source: ABdhPJw9E4TkmZwriDBLRxZa1zEE21+K9YxITe4jzLeHT/5mlNnP15nq5kJop/LaPhpgDnv5RkqdZw==
X-Received: by 2002:a9d:c29:: with SMTP id 38mr14236212otr.107.1592063901002;
        Sat, 13 Jun 2020 08:58:21 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 15/24] dyndbg: extend ddebug_parse_flags to accept optional leading filter-flags
Date:   Sat, 13 Jun 2020 09:57:29 -0600
Message-Id: <20200613155738.2249399-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change ddebug_parse_flags to accept optional filterflags before OP.
this now sets the parameter added in ~1
---
 .../admin-guide/dynamic-debug-howto.rst       | 18 +++++++----
 lib/dynamic_debug.c                           | 30 ++++++++++---------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6c04aea8f4cd..4f343e6036f5 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -217,13 +217,19 @@ line
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
index 0f393a930fdc..40436270d38a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -441,34 +441,36 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
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

