Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724DDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F220789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl+z6fqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFMP6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgFMP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FFC08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v13so9757078otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfxcDoKXVRozj3fbz6wlrCLjQwfm6vOI61pB+sPfysk=;
        b=Bl+z6fqUM78VHCJnQiHtfiV3SQ5cIEDe201Lhgrs8CLBNZn7ivjkIPmuZ5oBmHlA5p
         4mUAsQzcUUC/nR64mtLS8+Hdi7IfdwJiuw/43RMj8Sbm51xEhSHpjCUF3YaqkvL+UH2w
         D5NHVmrJAv4Wi/81QD3usP1RlW/MC5JhZ1ZTJ3Q+8d5Li+IP5DRXuOVxVwxdXVjT+1ff
         kHK86HwtlCA8AYu6n18NAsaQohWLyZqQha6UeS8zd0HW5/rmP1cbDJLnHL+QOtyNHbmg
         TySC/FH6hqGoQm+alatBzvPQ0wanG1ssYfvCqtAN+gXEWUjCs73xg2MlouN3POzwTcZL
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfxcDoKXVRozj3fbz6wlrCLjQwfm6vOI61pB+sPfysk=;
        b=A1zJcGusZjMPj9PX0H4KSPNjzqLKBUYomtfoQ93tgH0Ib6jvjfsXa5Re5XUHIvwDC+
         VkIvk78NdBNKHcVHCUIE+lQGYL7ukyhHlVI0DZffr9Q0bUTsCpYtKqcQtkqWF4ABGc7D
         SYk+1N3zkZdEljmL3++aqkcN1NYcAhkMOKct/g2jZVC3+oMPQ+HW93K5fluLkuuMIqVi
         CO2MxdN2llZrJ9YySfWBc828rrKxTeDupADNDT+2HpSWpyGbpTBH/0E1rxSPM8xkvoXM
         kWwAPYKtvoCbRkmti/IcQ85HCrRR8Es/l7Zh3LiWGYLxq471QsG29HZrjNIK8d027Gpv
         tjag==
X-Gm-Message-State: AOAM533Az1oMN1j6FLSJYMICNqpe5bUalD5DOQnt0vX1Qwx9X55yqnwT
        UDBvPV9loi6xVKXmpUN0TbeqifMJYIc=
X-Google-Smtp-Source: ABdhPJz/iv1I8SHJLrt4i/Mm+BT6pAmK/QL13eV4KPsqyX/s3247JZhoreQgs8jaaxRJ6WHsJWXHow==
X-Received: by 2002:a9d:8ac:: with SMTP id 41mr14789552otf.210.1592063890364;
        Sat, 13 Jun 2020 08:58:10 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 10/24] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Sat, 13 Jun 2020 09:57:24 -0600
Message-Id: <20200613155738.2249399-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the code-block reusable to later handle "file foo.c:101-200" etc.
This should be a 90%+ code-move, with minimal adaptations; reindent,
and scafolding.
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 20b712652ee4..f87a7bef4204 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -292,6 +292,39 @@ static inline int parse_lineno(const char *str, unsigned int *val)
 	return 0;
 }
 
+static int parse_linerange(struct ddebug_query *query, const char *first)
+{
+	char *last = strchr(first, '-');
+
+	if (query->first_lineno || query->last_lineno) {
+		pr_err("match-spec: line used 2x\n");
+		return -EINVAL;
+	}
+	if (last)
+		*last++ = '\0';
+	if (parse_lineno(first, &query->first_lineno) < 0)
+		return -EINVAL;
+	if (last) {
+		/* range <first>-<last> */
+		if (parse_lineno(last, &query->last_lineno) < 0)
+			return -EINVAL;
+
+		/* special case for last lineno not specified */
+		if (query->last_lineno == 0)
+			query->last_lineno = UINT_MAX;
+
+		if (query->last_lineno < query->first_lineno) {
+			pr_err("last-line:%d < 1st-line:%d\n",
+			       query->last_lineno,
+			       query->first_lineno);
+			return -EINVAL;
+		}
+	} else {
+		query->last_lineno = query->first_lineno;
+	}
+	return 0;
+}
+
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -350,34 +383,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 							    UNESCAPE_SPECIAL);
 			rc = check_set(&query->format, words[i+1], "format");
 		} else if (!strcmp(words[i], "line")) {
-			char *first = words[i+1];
-			char *last = strchr(first, '-');
-			if (query->first_lineno || query->last_lineno) {
-				pr_err("match-spec: line used 2x\n");
-				return -EINVAL;
-			}
-			if (last)
-				*last++ = '\0';
-			if (parse_lineno(first, &query->first_lineno) < 0)
+			if (parse_linerange(query, words[i+1]))
 				return -EINVAL;
-			if (last) {
-				/* range <first>-<last> */
-				if (parse_lineno(last, &query->last_lineno) < 0)
-					return -EINVAL;
-
-				/* special case for last lineno not specified */
-				if (query->last_lineno == 0)
-					query->last_lineno = UINT_MAX;
-
-				if (query->last_lineno < query->first_lineno) {
-					pr_err("last-line:%d < 1st-line:%d\n",
-						query->last_lineno,
-						query->first_lineno);
-					return -EINVAL;
-				}
-			} else {
-				query->last_lineno = query->first_lineno;
-			}
 		} else {
 			pr_err("unknown keyword \"%s\"\n", words[i]);
 			return -EINVAL;
-- 
2.26.2

