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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC293C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987B92074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM88HuWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFEQ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgFEQ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE5C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j189so8682068oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcmmKbmknmeMXy0KOUPlxJaq59XZDcgnJePbYQFVTsI=;
        b=KM88HuWUzZINae47Joh632EAhBimtNH34YkwmJcAbai9ltzgxzg9G2ENhCl/TXF+8x
         IFg3n0VcBaex6oa9p7wdDhcMGf5h9AfPPuINfvJpjXRIMR2sE9vcjWoi2iCB1hvWJ4/g
         8TIv8WHGgdR/noqpNz8V1gbZD6Ar+k0I9sQql8CQ7MmXlcm8WZm/PUMVKZVLKwGQM1kU
         d/Te7AE1Azm3RxN75qsgfoiCLwAxH/+01Puh2qOstvxND2poIj/9YLfmww3Eec4q5/JW
         1ZronuD0XkdFV2vN7qW7tnNMHFv2MZs+wta8R+SlTLxNbTBU0J8+xzcJGnA/Ny6OM6Jb
         unsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcmmKbmknmeMXy0KOUPlxJaq59XZDcgnJePbYQFVTsI=;
        b=WaCbrKoklojIWzvhTj12GkRQG46F3jkLcCEZGqMHu6YOanQlOxCF4A+QKh24TJVlFF
         ooxfJvlfDKEn5eFSp0+pLPSsFmgaSNzh3L5myOR8NOXEQAu0x2jz9fPa86Y+YRKTK6zb
         rGv2AsDQZJrDBKo4C3jSJQFXhmEKV/jgQTcdU+Dp4HRXrzebbUz/ZgM4VV9r4/65c1CF
         e4LVfB+qr3xnZrHSn5D8m/o7xZfVhH0eLlL4clGiGDr65AVzZ8akH39WkbiOGFoPAtAz
         OHmzX+8PWn/XfWiO6uYxGR0/IR4UXzFSibbFa90Nl/7YY6+hsDfLF7p7C16Hxu7X4iai
         uCbg==
X-Gm-Message-State: AOAM531/UrxEXUFvA/DDm/mIGIa7cfuP8aXbu+IpLPKfkmlsbeG8eRsE
        Ybh91epBh+2wgvpKjxxIfkg=
X-Google-Smtp-Source: ABdhPJxrhGPS/fV5k5Uya80pCPs+zfMp2VaVBWORSq2KcEfrxRJMSVwQcbMAyOuebSqh01RlDxFPYg==
X-Received: by 2002:aca:5a84:: with SMTP id o126mr1299840oib.41.1591374479005;
        Fri, 05 Jun 2020 09:27:59 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 12/16] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Fri,  5 Jun 2020 10:26:41 -0600
Message-Id: <20200605162645.289174-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new *filter param to ddebug_parse_flags(), allowing it to
communicate optional filter flags back to its caller: ddebug_change()

Also, ddebug_change doesn't alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2ecabfd3f432..32eb7d9545c7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -146,7 +146,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flagsettings *mods)
+			 const struct flagsettings *mods,
+			 const struct flagsettings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -444,7 +445,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
+
+static int ddebug_parse_flags(const char *str,
+			      struct flagsettings *mods,
+			      struct flagsettings *filter)
 {
 	int op;
 
@@ -476,7 +480,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 mods->flags, mods->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -484,6 +490,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
+	struct flagsettings filter = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -495,7 +502,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &mods)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -504,7 +511,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &mods);
+	nfound = ddebug_change(&query, &mods, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

