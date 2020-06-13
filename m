Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFC0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B220789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJUE1vpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFMP60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFMP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:15 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF0C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b8so11768973oic.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgB7qRhcim9hj4b+i7yJ6m+MlQ2rNYPgnUpllIUFGBg=;
        b=HJUE1vpoW/6n1TE3qIq5KRr7aQzkq/F30JupsdL6NqUGqU9MajcuLlC1Xd3ZdbtsX4
         WuzZqv5HgHZ2Uk2PCT0QaT5BeCrAshOOievq3l1tO1KC2O71Io9qSPbzBVoi/jdgPb50
         mDVh4ktUY4DyYxsgkKJVY23waydPUloouy4ejADmWA952nauYJ1tMFBn/aM9uGEGwNzt
         yyU82dk1N3CVc8qWw1cI1wXliaBvzGd7dWbgP/KTskEwseg6VOub7B2O4JZ6dxWrrQO2
         vx7iVuCgnZR+NRfHR91bPHrl/0ryXfXEOwwWyBTBktKS6mZRnXHS31CVg6Bin19j80Td
         K0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgB7qRhcim9hj4b+i7yJ6m+MlQ2rNYPgnUpllIUFGBg=;
        b=oj3s01hfxAPJAhCx8gLdySpaGaSty1jNX4hYOCXSiNBEaoLv3ksrv/i27JIa8OoxpS
         9yOR7R7Yt/NClNWt9Qz290cI+DBnmumP0iskveNfzM3FeRSW0ewAx6unknRNeZ0y7YkX
         tZj38DXUKuRAXyZq3L3vmLPYmSOIXZtWmcIui8gsxUM5vxCmJEu91Tk/+qcKqp/xkXaM
         yBzOwLW2n7ZT/Dy2tQJS5iesNlaZkY7N35pKbVAS9QYWRWldWFQB29l9SKf1PBlPcfWk
         90tewdlUejA+AOzO+mnKqxhhl2TwcCLFNJSDfkO6oJMd/mXmCu7/ybYSxZkpq581j2hM
         FMLg==
X-Gm-Message-State: AOAM531GKGp3ILHSafmh50ubamrD1sj5qRCChQS0izpr+DtkaiXvRrxq
        3oN6YZAI48VuqQYEdP7jum51Ks/l+tY=
X-Google-Smtp-Source: ABdhPJz9dWdSWwAhxB2dCBqo0mlL68cg/JzNFFsSAGWEicYjXRoMVaRW7x0WkA2/hZeMCM5TaM4+JQ==
X-Received: by 2002:aca:5a05:: with SMTP id o5mr3025360oib.138.1592063894355;
        Sat, 13 Jun 2020 08:58:14 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 12/24] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Sat, 13 Jun 2020 09:57:26 -0600
Message-Id: <20200613155738.2249399-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ddebug_parse_flags accepts [+-=][pflmt_]+ as flag-spec
strings.  If we allow [pflmt_]*[+-=][pflmt_]+ instead, the (new) 1st
flagset can be used as a filter to select callsites, before applying
changes in the 2nd flagset.  1st step is to split out the flags-reader
so we can use it again.

The point of this is to allow user to compose an arbitrary set of
changes, by marking callsites with [fmlt] flags, and then to
activate that composed set in a single query.

 #> echo '=_' > control			# clear all flags
 #> echo 'module usb* +fmlt' > control	# build the marked set, repeat
 #> echo 'fmlt+p' > control		# activate
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 784c075c7db9..93c627e9c094 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -414,6 +414,26 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
+static int ddebug_read_flags(const char *str, unsigned int *flags)
+{
+	int i;
+
+	for (; *str ; ++str) {
+		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
+			if (*str == opt_array[i].opt_char) {
+				*flags |= opt_array[i].flag;
+				break;
+			}
+		}
+		if (i < 0) {
+			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			return -EINVAL;
+		}
+	}
+	vpr_info("flags=0x%x\n", *flags);
+	return 0;
+}
+
 /*
  * Parse `str' as a flags specification, format [-+=][p]+.
  * Sets up *maskp and *flagsp to be used when changing the
@@ -424,7 +444,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -438,19 +458,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	for (; *str ; ++str) {
-		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
-			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
-				break;
-			}
-		}
-		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
-			return -EINVAL;
-		}
-	}
-	vpr_info("flags=0x%x\n", flags);
+	if (ddebug_read_flags(str, &flags))
+		return -EINVAL;
 
 	/* calculate final *flagsp, *maskp according to mask and op */
 	switch (op) {
-- 
2.26.2

