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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5497F21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPkdbl9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgFQQ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgFQQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:08 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC9C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:07 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n70so2093384ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=hPkdbl9soeVEWE9R/q4Kl0iyd8h9OuLS1u7SD95691y6SJWNFSJjOaTBOzexZkB8Pn
         s+WNf58kRxHdUyfPKsUufvjEl8QuRbrBQvpQnzVhsBC2lwS1b4WxOGOlMAcTS0TDIolH
         M3ezaB4yBJuqg2lfsjDWZ9Ym7Fg1XIpvHZHSgq/F0+0L8yP0MT+J2O6B3mjEC0fygK4w
         m9UL7JoEY4uGRIe1+R2StPFHcAg8q6Ww8KLsmjiXZ9o1jAwdH4xsVzoSRcKyZn+l48ca
         xBlDdphZVog8bjNEsxFvEa1mdRXRanHE5CvqxYA6nZ1QvE110eU6vD3+2RwTK+1JF66W
         Fddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=cKVhHXpSVaOLGYkWayqMQWRBnfTUOJoESDTb0yaENvArDSz5BEcd4bWCzUwpXo3hJW
         J/ok9yX6X+FaRNtqRYDBT/FezsXFvoVNM3p7DRUQ/lhWBIqodFIKxK3UxZq1/IlGo9mZ
         fWh+llNMqr29IK/+2FRCNPYY4qnbqxBSilwPBUgpQVI7pWIuytUFD251UvsomuUtMQgf
         G8rzfaERNd2RfAtQ3p2VTofZWVk2ri56XjEySls++S5hoXcd8aK6zwNORquPwaSifww9
         7lR4j7NvTH8JPF6d3okLAHywZSQ+vX0qxjcx4JSwT6BkNKdszmVJc/8svkJ6bhT1iojN
         HU+Q==
X-Gm-Message-State: AOAM530UB8tF2lz2PW3dfQjSFq/xwZL31Jr73P9sVJBOKgNm3yCwgd0O
        mK7d9cKEt1lMQ/FKa46Qr3Q=
X-Google-Smtp-Source: ABdhPJwlO5fFQpzB8wnKazUnHZVIRyOuac8PL9+jVfP5geBAcdW5sYdwhPAo7UPngnlxao8zJovhYQ==
X-Received: by 2002:a05:6830:1512:: with SMTP id k18mr7562648otp.37.1592411166434;
        Wed, 17 Jun 2020 09:26:06 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:05 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 06/21] dyndbg: fix overcounting of ram used by dyndbg
Date:   Wed, 17 Jun 2020 10:25:19 -0600
Message-Id: <20200617162536.611386-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66c0bdf06ce7..9b2445507988 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1017,7 +1017,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1033,9 +1032,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1052,9 +1048,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2

