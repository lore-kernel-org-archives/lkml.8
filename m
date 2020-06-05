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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4FDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FE52074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7BpfVZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgFEQ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgFEQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC4C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a21so8686023oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogR2ypqCeyuNpXapVYdvPx41LxlKjZn6BCE4UH2HTBA=;
        b=B7BpfVZYJxtwZpeWq5ic3kCW/otQzWiqKjeZOnSnX82ueeCdYHuKydT2Fmn4j+drYj
         /tGEx94GUWb5SKCivsq2LYGQckIluWTF6a4loz0cfpdKaboXwJuBMQwndJm6S8jvC/US
         f+siWKwJN0cvXtm1ggk5qn8Dg+kKszc9j3ct7fyLHXqMTwWEkIszTXrg0pPFAfCOUews
         J3aCAdnqp9IQK6PtFWji5gPwNgAMNwk9Trt6pNxgQH8z0YgSwczz1OSHow6xn9/o2T4i
         RCWcwQrD24YdBR3ER3gahE37QUYBLRRdr/rXe6D9wSji9DnZ+tpfctVX1btX7qDNpEBZ
         Z1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogR2ypqCeyuNpXapVYdvPx41LxlKjZn6BCE4UH2HTBA=;
        b=aghvFlNIRWI0ioPMG0JVPlzyJylgrv9qL2OcPl9lhdVvncduuU+U/ipWsatYi+LaPG
         BRqrniIMHkbXFBm4qj+bYo8O8qo02Qu1cRmqzdqaDvz84Wrxdzjn9VwYGq4a28ObF+wX
         ZnDFtQRP/oxFzEt7WnZrQLSUiYhf7y90LTAsbvOAHoR6kUggMBiBVDnkrW2zHkI+NLL8
         5msBJdF0gtgsU3XSgnk6es5TKyzKBBArGPRlEXgLfxAPfS9WpTCZEHZJuxAuu1Cn63Bd
         cAfwDdNKr+TY1Yk01vC1SQmnCmdKZKPiExS/2GoNkacui24q1+uLtas/pvImRxfjhj67
         s8aA==
X-Gm-Message-State: AOAM533GAciu/U9ocAsxBaTOOJhMgkTA/2BsB2GT7Ky0j9/wkDZZB7JL
        kfoTGByUJaTMwAq+aVVV9IA=
X-Google-Smtp-Source: ABdhPJyQBcjlYd1YhCQ18OomNotUDOTOVEKlAKVNC3zouZyvR3qgiXHHB3VCkhoz7qQsjjPe42ij1Q==
X-Received: by 2002:aca:6144:: with SMTP id v65mr2400240oib.33.1591374473971;
        Fri, 05 Jun 2020 09:27:53 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/16] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Fri,  5 Jun 2020 10:26:39 -0600
Message-Id: <20200605162645.289174-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8f250c67acbe..005b8221a9d6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -413,6 +413,26 @@ static int ddebug_parse_query(char *words[], int nwords,
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
@@ -423,7 +443,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -437,19 +457,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
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

